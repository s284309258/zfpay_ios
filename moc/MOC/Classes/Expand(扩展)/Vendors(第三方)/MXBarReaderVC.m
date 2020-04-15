//
//  MXBarReaderVC.m
//  Moxian
//
//  Created by liuxz on 13-11-15.
//  Copyright (c) 2013年 Moxian. All rights reserved.
//

#import "MXBarReaderVC.h"
#import "ZBarSDK.h"
#import "UINavigationBar+Alpha.h"
#import "MBReleaseButton.h"
#import "MBImagePicker.h"
#import "MXBackButton.h"
#import "UIImage+Color.h"
#import "NSObject+CapacityAuthorize.h"
#import "MXBarReaderHelper.h"

@interface MXBarReaderVC ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate, ZBarReaderViewDelegate, UIImagePickerControllerDelegate, ZBarReaderDelegate>{
    // 移动线
    UIImageView *moveLineView;
    int moveLineY;
    
    NSTimer *moveTimer;
    
    BOOL isNewQRCode;
    
}

@property (nonatomic, strong) UIView *readerView7;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) ZBarReaderView *readerView;

// 底部工具栏
@property (nonatomic, strong) UIView *bottomToolView;
// 相册
@property (nonatomic, strong) MBReleaseButton *photoBtn;
// 闪光灯
@property (nonatomic, strong) MBReleaseButton *flashBtn;

// 选取框
@property (nonatomic, strong) UIImageView *hbImageview;

// 相册图片选择
@property (nonatomic, strong) MBImagePicker *imagePicker;

// 提示框
@property (nonatomic, strong) UIView *indicatorGroup;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *indicatorLbl;

// 提示语
@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic,strong) AVCaptureSession * captureSession;
@property (nonatomic,strong) AVCaptureDevice * captureDevice;
@property (nonatomic,assign) id<MXBarReaderDelegate> delegate;
@property (retain, nonatomic) MXButton *flashButton;
@property (nonatomic,strong) UIView *activeReaderView;
@property (nonatomic, strong) ZBarReaderController *reader;

//扫描后处理
@property (nonatomic, strong) MXBarReaderHelper *barHelper;

@property (nonatomic, assign) BOOL handlerFinish;

@end

@implementation MXBarReaderVC
@synthesize delegate;
@synthesize flashButton;

#pragma mark - Lift Cycle

- (void)dealloc
{
    [self stopTimer];
}

- (id)init {
    self = [super init];
    if(self){
        [self captureDevice];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShowBackButton = YES;
//    self.title = MXLang(@"Talk_Sweep", @"扫一扫");
    [self setNavBarTitle:@"扫一扫" color:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor blackColor];
    [self.backBut setImage:[UIImage imageNamed:@"public_white_back"] forState:UIControlStateNormal];
    
    if (IOS6_Later) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    isNewQRCode = NO;
    if (IOS6_Later) {
        self.readerView7 = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.readerView7];
        [self.readerView7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        isNewQRCode = [self openCaptureDevice:self.readerView7];
    }
    
    if (isNewQRCode) {
        if (self.readerView) {
            [self.readerView removeFromSuperview];
            self.readerView = nil;
        }
        
        [self makeReadView:self.readerView7];
        self.activeReaderView = self.readerView7 ;
        
    }else {
        if (self.readerView7) {
            [self.readerView7 removeFromSuperview];
            self.readerView7 = nil;
        }
        
        self.readerView = [[ZBarReaderView alloc]init];
        [self.view addSubview:self.readerView];
        self.readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.readerView.readerDelegate = self;
        //关闭闪光灯
        self.readerView.torchMode = 0;
        
        //        self.showsZBarControls = false; //0401
        self.readerView.zoom = 1.5;
        self.readerView.readerDelegate = self;
        self.readerView.allowsPinchZoom = YES;
        
        
#if	TARGET_IPHONE_SIMULATOR // 模拟器中没有闪光灯

        
#else
        //添加闪光灯 //0401 如果此deviceInput=nil,有可能设置权限没开
        AVCaptureDeviceInput * deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_captureDevice error:nil];
        if (deviceInput) {
            [self.captureSession addInput:deviceInput];
        }
        
 
        
#endif
        
        //        self.supportedOrientationsMask = ZBarOrientationMaskAll;
        //        ZBarImageScanner *scanner = self.scanner;
        //        [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
        [self makeReadView:self.readerView];
        
        self.activeReaderView = self.readerView ;
        
        
        //扫描区域
        CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(self.readerView.frame) - 126, 200, 200);
        //扫描区域计算
        self.readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:self.readerView.bounds];
    }
    
    
    [self changeLanguageInterface];
    AddChangeLanguageNotificationCenter(changeLanguageInterface);
 
    _barHelper = [[MXBarReaderHelper alloc]initWithBarReaderVC:self];
   
}



- (void)starTimer {
    if (moveTimer == nil) {
        // 定时
        moveTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startToMove) userInfo:nil repeats:YES];
        [moveTimer fire];
        
    }else {
        [moveTimer fire];
    }
    
}
- (void)stopTimer {
    if (moveTimer) {
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

// 移动
- (void)startToMove {
    
    moveLineY += 1;
    
    if (moveLineY > CGRectGetMaxY(_hbImageview.frame) - 5) {
        moveLineY = CGRectGetMinY(_hbImageview.frame) + 5;
    }
    
    moveLineView.frame=CGRectMake(moveLineView.frame.origin.x, moveLineY, moveLineView.frame.size.width, moveLineView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.view==nil) {
        [self viewDidLoad];
    }
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    self.activeReaderView.frame = self.view.frame;
    
    [self CloseTorchMode];
    
    if ([self isAuthorizedCameraStatus]) {
        //self.handlerFinish = YES;
        [self startReader];
    }
    [self.navigationController.navigationBar barReset];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setNavBarCurrentColor:[UIColor blackColor] titleTextColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setNavBarCurrentColor:[[UIColor blackColor] colorWithAlphaComponent:.5] titleTextColor:[UIColor whiteColor]];
}

- (void)backAction:(id)sender {
    self.handlerFinish = NO;
    [self stopReader];
    [super backAction:sender];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self CloseTorchMode];
    [self stopReader];
    [self.navigationController.navigationBar barReset];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    moveLineView.frame = CGRectMake(moveLineView.frame.origin.x,
                                    CGRectGetMinY(_hbImageview.frame)+20,
                                    moveLineView.frame.size.width,
                                    moveLineView.frame.size.height);
    
}

//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (self.sweepType) {
//        case AddFriendTypes:
//        {
//            [self hideView:NO];
//            [self startReader];
//            break;
//        }
//            
//        default:
//            break;
//    }
//}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    CGImageRef photo = image.CGImage;
    ZBarSymbol *symbol = (ZBarSymbol *)[self.reader scanImage:photo];
    for (symbol in results)
    {
        break;
    }
    
    [self stopReading:symbol.data];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ZBarReaderDelegate
- (void)readerControllerDidFailToRead: (ZBarReaderController*) reader
                            withRetry: (BOOL) retry
{
    [NotifyHelper showMessageWithMakeText:MXLang(@"Talk_QRCode_Photo_Error", @"二维码图片错误")];
}

- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}

- (void)makeReadView:(UIView *)readView {
    
    //独立出来后添加的高度变化
    float addHeight = 0;
    if (IOS6_Later) {
        addHeight = 20.0f;
    }
    //添加扫描的背景图
    UIImage *scanImg;
    CGRect bgRect = CGRectZero;
    
    scanImg = [UIImage imageNamed:@"pick_bg"];
    bgRect = CGRectMake(5, 100+64, SCREEN_WIDTH-10, SCREEN_WIDTH);
    
    
    _hbImageview = [[UIImageView alloc] initWithImage:scanImg];
    [_hbImageview setFrame:bgRect];
    [self.view addSubview:_hbImageview];
    
    // 移动的线条
    moveLineView = [[UIImageView alloc] initWithFrame:CGRectMake(readView.frame.size.width/2 - 240/2, 180 , 240, 1)];
    moveLineView.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:moveLineView];
    
    _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 13+addHeight, 200, 21)];
    _labTitle.tag = 1001;
    _labTitle.numberOfLines = 2;
    _labTitle.backgroundColor = [UIColor clearColor];
    _labTitle.textColor = [UIColor whiteColor];
    _labTitle.textAlignment = NSTextAlignmentCenter;
    _labTitle.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.hbImageview.mas_top).offset(-20);
    }];
    
    [_hbImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(_labTitle.mas_bottom).offset(20);
        make.center.equalTo(self.view);
        make.width.and.height.mas_equalTo(252);
        //make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.bottomToolView];
    
    [self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(80);
    }];
    
    [self.hbImageview addSubview:self.indicatorGroup];
    [self.indicatorGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hbImageview).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    if (self.navigationController) {
        if (IOS6_Later) {
            flashButton = [[MXButton alloc]initWithFrame:CGRectMake(270, 33, 22, 22)];
        }else{
            
            flashButton = [[MXButton alloc]initWithFrame:CGRectMake(270, 13, 22, 22)];
        }
        flashButton.imagePositionStyle=MX_IMAGE_POSITION_RIGHT;
        [flashButton setBackgroundImage:  [UIImage imageNamed:@"reader_input1"] forState:UIControlStateNormal];
        [flashButton setBackgroundImage:  [UIImage imageNamed:@"reader_input2"] forState:UIControlStateHighlighted];
        
        [flashButton addTarget:self action:@selector(TurnONorOff:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:flashButton];
        
        // }
    }
   
    [self.view layoutIfNeeded];
    moveLineY = CGRectGetMinY(_hbImageview.frame) + 5;
    
}

- (BOOL)openCaptureDevice:(UIView *)toView {
    
    //    CaptureSession 这是个捕获会话，也就是说你可以用这个对象从输入设备捕获数据流。
    //    AVCaptureVideoPreviewLayer 可以通过输出设备展示被捕获的数据流。
    //    首先我们应该判断当前设备是否有捕获数据流的设备。
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    
    if (!input) {
        //    如上，如果捕获到错误，直接返回。
        return NO;
    }
    
    //    初始化一个CaptureSession对象
    //    设置会话的输入设备
    [self.captureSession addInput:input];
    
    
    //    对应输出
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    [_captureSession addOutput:captureMetadataOutput];
    
    
    
    //    创建一个队列
    
    dispatch_queue_t dispatchQueue;
    
    dispatchQueue = dispatch_queue_create("myQueue",NULL);
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //    降捕获的数据流展现出来
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    [_videoPreviewLayer setFrame:toView.layer.bounds];
    
    [toView.layer addSublayer:_videoPreviewLayer];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [self stopTimer];
    moveTimer = nil;
    moveLineView = nil;
    [super didReceiveMemoryWarning];
}

- (void)changeLanguageInterface
{
    self.labTitle.text = MXLang(@"Talk_Sweep_Title", @"将二维码对准取景框\n   即自动扫描");
}

- (void)stopReader {
    if (isNewQRCode) {
        if ([_captureSession isRunning]) {
            [_captureSession stopRunning];
        }
        
        [self.videoPreviewLayer removeFromSuperlayer];
    } else {
        [self.readerView stop];
    }
    [self stopTimer];
}

- (void)startReader {
    self.handlerFinish = YES;
    if(isNewQRCode){
        if (![_captureSession isRunning]) {
            [self starTimer];
            [self.readerView7.layer addSublayer:self.videoPreviewLayer];
            [_captureSession startRunning];
        }
    } else {
        [self starTimer];
        [self.readerView performSelector:@selector(start) withObject:nil afterDelay:0.0];
    }
}

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image {
    
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    [self stopReader];
    
    if (symbols.count>0) {
        sleep(2); // 最少延迟2秒钟,在二维码本来就在摄像头下时,可以自动页面退出 延迟2秒
        //isMovingFromParentViewController,isMovingToParentViewController,isBeingPresented,isBeingDismissed
        if (![[self presentedViewController] isBeingDismissed])
        {
            __block NSString *str = [self readerToStringWith:symbol];
          
            if (self.delegate && [self.delegate respondsToSelector:@selector(readerText:readerVC:)]) {
                
                [self.delegate readerText:str readerVC:self];
            }
        }
    }
}

- (NSString *)readerToStringWith:(ZBarSymbol *)symbol {
    NSString *str = symbol.data;
    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
        
    {
        str = [NSString stringWithCString:[symbol.data cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }
    
    return str;
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    //    判断是否有数据，是否是二维码数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects safeObjectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] && self.handlerFinish) {
            //获得扫描的数据，并结束扫描
            self.handlerFinish = NO;
            MLog(@"二维码数据");
            [self performSelectorOnMainThread:@selector(stopReading:)withObject:metadataObj.stringValue waitUntilDone:NO];
        }
    }
}

#pragma mark - 扫描到数据，请求接口
- (void)stopReading:(NSString *)qrCode {
    [self stopReader];
    
    [_barHelper dealWithReadingData:qrCode];
    
    if (![[self presentedViewController] isBeingDismissed])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(readerText:readerVC:)]) {
            [self.delegate readerText:qrCode readerVC:self];
        }
    }
}

#pragma mark 闪光灯
-(AVCaptureSession *)captureSession
{
    if(_captureSession == nil)
    {
        _captureSession = [[AVCaptureSession alloc] init];
        
    }
    return _captureSession;
    
}

-(AVCaptureDevice *)captureDevice
{
    if(_captureDevice == nil)
    {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        [self.captureSession beginConfiguration];
        [_captureDevice lockForConfiguration:nil];
        
        if (IOS6_Later && [_captureDevice isRampingVideoZoom]) {
            //    captureDevice.videoZoomFactor = 1.5;
            _captureDevice.videoZoomFactor = 2.0;
        }
        
        if ([_captureDevice hasTorch]) {
            self.captureDevice.torchMode = AVCaptureTorchModeOff ;
            self.captureDevice.flashMode = AVCaptureFlashModeOff;
        }
        
        [_captureDevice unlockForConfiguration];
        [_captureSession commitConfiguration];
    }
    return _captureDevice;
}

//闪光灯关闭
- (void)CloseTorchMode{
    
}

#pragma mark 退出
- (IBAction)Back:(id)sender{//0409
    [self CloseTorchMode];
    //    [self stopReader];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 开灯关灯
- (IBAction)TurnONorOff:(id)sender{
    //    ExchangeGiftCodeVC* exchangeVC = [[ExchangeGiftCodeVC alloc]initWithNibName:@"ExchangeGiftCodeVC" bundle:nil];
    //    exchangeVC.vc = delegate;
    //    [self.navigationController pushViewController:exchangeVC animated:YES];
    //    [exchangeVC release];
}



#pragma mark - Pravite Mothod
- (void)flashOn:(BOOL)open
{
    [self.captureDevice lockForConfiguration:nil];
    self.captureDevice.torchMode = open ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
    [self.captureDevice unlockForConfiguration];
}

- (void)hideView:(BOOL)hide
{
    self.bottomToolView.hidden = hide;
    moveLineView.hidden        = hide;
    self.labTitle.hidden       = hide;
    self.indicatorGroup.hidden = !hide;
    self.indicatorLbl.hidden   = !hide;
    self.indicatorView.hidden  = !hide;
    if (hide) {
        [self.indicatorView startAnimating];
    } else {
        [self.indicatorView stopAnimating];
    }
}

#pragma mark - 扫一扫关注
- (void)addFriendWithID:(NSString *)uId
{
    if (![uId isKindOfClass:[NSString class]]) {
        return;
    }
    
    
    NSArray *tempArray=[uId componentsSeparatedByString:@":"];
    if (tempArray && tempArray.count > 1) {
        
        
    } else {
        [self hideView:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MXLang(@"Talk_No_People", @"查无此人") message:MXLang(@"Talk_Sweep_Again", @"扫描出错,再试试呗~") delegate:self cancelButtonTitle:nil otherButtonTitles:MXLang(@"PersonalCenter_info_tag_ok_41", @"确定"), nil];
        [alert show];
    }
}

#pragma mark - - (UIView *)bottomToolView
- (UIView *)bottomToolView
{
    if (!_bottomToolView) {
        _bottomToolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80)];
        [_bottomToolView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.8f]];
        
        [_bottomToolView addSubview:self.photoBtn];
        [_bottomToolView addSubview:self.flashBtn];
        
        UIView *superView = _bottomToolView;
        [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(superView.mas_left).offset(60);
            make.centerY.mas_equalTo(superView.mas_centerY);
            make.height.mas_equalTo(60);
        }];
        
        [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(superView.mas_right).offset(-60);
            make.centerY.mas_equalTo(superView.mas_centerY);
            make.height.mas_equalTo(60);
        }];
    }
    
    return _bottomToolView;
}

- (MBReleaseButton *)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [[MBReleaseButton alloc] initWithFrame:CGRectZero logoOffset:11 titleYOffset:11];
        [_photoBtn configureTitle:MXLang(@"Talk_chatview_bottom_toolbar_moreview_8", @"相册") icon:@"localPhoto"];
        @weakify(self)
        _photoBtn.releaseAction = ^(UIButton *sender) {
            @strongify(self)
            [self showImagePicker];
        };
    }
    
    return _photoBtn;
}

- (MBReleaseButton *)flashBtn
{
    if (!_flashBtn) {
        _flashBtn = [[MBReleaseButton alloc] initWithFrame:CGRectZero logoOffset:13 titleYOffset:13];
        [_flashBtn configureTitle:MXLang(@"Talk_Flash", @"开灯") icon:@"flash"];
        @weakify(self)
        _flashBtn.releaseAction = ^(UIButton *sender) {
            @strongify(self)
            sender.selected = !sender.selected;
            if (IOS6_Later && self.captureDevice.hasTorch) {
                [self flashOn:sender.selected];
            }
        };
    }
    
    return _flashBtn;
}

- (void)showImagePicker
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        [MXAlertViewHelper showAlertViewWithMessage:MXLang(@"Talk_Photo_Auth", @"请在设置-隐私-相册中打开相册访问权限")];
        return;
    }
    
    [self stopReader];
    
    self.reader = [[ZBarReaderController alloc] init];
    _reader.readerDelegate = self;
    _reader.showsHelpOnFail = NO;
    if([ZBarReaderController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        _reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [_reader.scanner setSymbology: ZBAR_I25
                           config: ZBAR_CFG_ENABLE
                               to: 0];
    [self presentViewController:_reader animated:YES completion:nil];
}

#pragma mark UI - 提示框
- (UIView *)indicatorGroup
{
    if (!_indicatorGroup) {
        _indicatorGroup = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorGroup.backgroundColor = RGB(117, 117, 117);
        _indicatorGroup.hidden = YES;
        
        [_indicatorGroup addSubview:self.indicatorView];
        [_indicatorGroup addSubview:self.indicatorLbl];
        
        UIView *superView = _indicatorGroup;
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(superView.mas_centerX);
            make.centerY.mas_equalTo(superView.mas_centerY).offset(-50);
        }];
        
        [self.indicatorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(superView.mas_centerX);
            make.top.mas_equalTo(self.indicatorView.mas_bottom).offset(30);
        }];
    }
    
    return _indicatorGroup;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.hidden = YES;
    }
    
    return _indicatorView;
}

- (UILabel *)indicatorLbl
{
    if (!_indicatorLbl) {
        _indicatorLbl               = [[UILabel alloc] initWithFrame:CGRectZero];
        _indicatorLbl.text          = MXLang(@"Talk_Handling", @"正在处理");
        _indicatorLbl.font          = [UIFont font17];
        _indicatorLbl.textColor     = [UIColor whiteColor];
        _indicatorLbl.textAlignment = NSTextAlignmentCenter;
        _indicatorLbl.hidden        = YES;
    }
    
    return _indicatorLbl;
}

@end
