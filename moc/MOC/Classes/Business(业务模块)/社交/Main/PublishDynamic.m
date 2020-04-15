//
//  PublishDynamic.m
//  Lcwl
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "PublishDynamic.h"
#import "MQImageDragView.h"
#import "PhotoBrowser.h"
#import "UIView+Frame.h"
#import <Photos/Photos.h>
#import "QNManager.h"
#import "SCRequestHelper.h"
//#import "RegionAnnotation.h"
#import "WBStatusHelper.h"
#import "NSMutableAttributedString+Attributes.h"
#import "UITextView+Placeholder.h"

static NSString *const XG_WeChatPlaceHoldString = @"分享点点滴滴...";

@interface PublishDynamic ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MQImageDragViewDelegate>
@property (nonatomic,strong) UITextView *send_TextView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *footerView;
@property (nonatomic,strong) MQImageDragView *dragView;
//转发
@property (nonatomic,strong) UIView *transferView;
@property (nonatomic,strong) UIImageView *transferImgView;
@property (nonatomic,strong) UILabel *transferLbl;

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *jurisdiction;
@property (nonatomic,copy) NSString *open_type;
@end

@implementation PublishDynamic

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.jurisdiction = @"公开";
    self.open_type = @"1";
    
    [self.headerView addSubview:self.send_TextView];
    
    if(self.type == PublishDynamicTypeBySelf) {
        if(self.photosArr.count > 0) {
            self.dragView = [[MQImageDragView alloc] initWithFrame:CGRectMake(15, self.send_TextView.height, SCREEN_WIDTH-30, 0)];
            self.dragView.backgroundColor = [UIColor whiteColor];
            self.dragView.kMarginLRTB = 2;
            self.dragView.kMarginB = 4;
            self.dragView.kMaxCount = 9;
            self.dragView.kCountInRow = 3;
            self.dragView.dragViewDelegete = self;
            [self.headerView addSubview:self.dragView];
        }
    } else {
        self.transferView.frame = CGRectMake(15, self.send_TextView.height, SCREEN_WIDTH-30, 80);
        [self.headerView addSubview:self.transferView];
    }
    
    
    for(UIImage *image in self.photosArr) {
        [self.dragView addImage:image];
    }
    
//    [self.view addSubview:self.footerView];
//    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.right.equalTo(@-10);
//        make.bottom.equalTo(self.view).offset(-20);
//    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    //self.tableView.tableFooterView = self.footerView;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
        //make.bottom.equalTo(self.footerView.mas_top);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutHeader];
    
    [self configTransferView];
}

- (void)dealloc {
    [[PhotoBrowser shared] reset];
}

- (void)layoutHeader {
    if(self.type == PublishDynamicTypeBySelf) {
        if(self.photosArr.count > 0) {
            self.dragView.height = [self.dragView getHeightThatFit];
            self.headerView.height = self.dragView.maxY;
        }
    } else {
        self.headerView.height = self.transferView.maxY;
    }

    self.tableView.tableHeaderView = self.headerView;
    [self.tableView reloadData];
}

- (void)configTransferView {
    if(self.model == nil) {
        return;
    }
    
    if(self.model.circle_link.length > 0) {
        NSURL *url = [NSURL URLWithString:[[self.model.circle_link componentsSeparatedByString:@","] firstObject]];
        if(url) {
            [_transferImgView sd_setImageWithURL:url];
        }
    } else {
        _transferImgView.hidden = YES;
        [_transferLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
        }];
    }
    
    
    NSString *name = self.model.user.name;
    NSString *content = self.model.text;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",name,content]];
    [attStr addFont:[UIFont systemFontOfSize:16] substring:name];
    [attStr addFont:[UIFont systemFontOfSize:14] substring:content];
    [attStr addColor:[UIColor moBlue] substring:name];
    [attStr addColor:[UIColor moTextGray] substring:content];
    //[attStr setLineSpacing:2 substring:name alignment:NSTextAlignmentLeft];
    
    [self.headerView layoutIfNeeded];
    
    _transferLbl.preferredMaxLayoutWidth = _transferLbl.width;
    _transferLbl.attributedText = attStr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self setNavBarRightBtnWithTitle:@"发布" andImageName:nil];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    barBtnItem.tintColor = [UIColor moBlack];
    self.navigationItem.leftBarButtonItem = barBtnItem;
    [self.navBarRightBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
}

- (void)navBarRightBtnAction:(id)sender {
//    if(![WBStatusHelper hasPermission:self]) {
//        return;
//    }
    
    if(self.type == PublishDynamicTypeBySelf) {
        if(self.send_TextView.text.length == 0 && self.curSelectAssets.count == 0) {
            return;
        }
    }
    
    [self.view endEditing:YES];
    
    @weakify(self)
    if(self.type == PublishDynamicTypeBySelf) {
        if(self.curSelectVideo) { //选择了视频
            [NotifyHelper showHUD];
            [[QNManager shared] uploadVideo:[self.curSelectAssets firstObject] completion:^(id data) {
                @strongify(self)
                [self publish:@"" imageType:nil url:data sendId:nil];
            }];
        } else if(self.curSelectAssets.count > 0) { //选择了图片
            [NotifyHelper showHUD];
            [[QNManager shared] uploadImages:self.curSelectImages assets:self.curSelectAssets completion:^(id data) {
                @strongify(self)
                [self publish:@"" imageType:nil url:[data componentsJoinedByString:@","] sendId:nil];
            }];
        } else { //纯文本
            [NotifyHelper showHUD];
            [self publish:@"" imageType:nil url:nil sendId:nil];
        }
    } else {
        [NotifyHelper showHUD];
        [self publish:@"" imageType:nil url:nil sendId:self.model.circle_id];
    }
    
}

- (void)publish:(NSString *)image_size imageType:(NSString *)imageType url:(NSString *)url sendId:(NSString *)sendId {
    //解析图片视频尺寸
    NSString *imageSize = nil;
    NSString *image_type = nil;
    for(PHAsset *asset in self.curSelectAssets) {
        NSString *separator = image_type ? @"," : @"";
        NSString *size = [NSString stringWithFormat:@"%lux%lu",(unsigned long)asset.pixelWidth,(unsigned long)asset.pixelHeight];
        imageSize = [NSString stringWithFormat:@"%@%@%@",imageSize ?: @"",separator,size];
        NSString *infoItem = nil;
        NSString *filename = [asset valueForKey:@"filename"];
        NSString *ext = [[filename pathExtension] lowercaseString];
        NSString *type = @"0"; //0:静态图 1:动态图 2:视频
        if([ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"] || [ext isEqualToString:@"png"]) {
            type = @"0";
        } else if([ext isEqualToString:@"gif"]) {
            type = @"1";
        } else if([ext isEqualToString:@"mp4"] || [ext isEqualToString:@"mov"]) {
            type = @"2";
        }
        infoItem = [NSString stringWithFormat:@"%@|%@|%@",type,size,ext];
        
        image_type = [NSString stringWithFormat:@"%@%@%@",image_type ?: @"",separator,infoItem];
    }
    
    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithCapacity:1];
    [muParam setValue:self.send_TextView.text forKey:@"content"];
    [muParam setValue:url forKey:@"link"];
    [muParam setValue:(sendId ? @"01" : @"00") forKey:@"send_type"];
    [muParam setValue:imageSize forKey:@"image_size"];
    [muParam setValue:self.open_type forKey:@"open_type"];
    [muParam setValue:self.address forKey:@"user_addr"];
    [muParam setValue:self.model.circle_id forKey:@"send_id"];
    [muParam setValue:@"03" forKey:@"message_type"];//可以不传
    [muParam setValue:image_type forKey:@"image_type"];
    [muParam setValue:[@(self.model.user.userID) description] forKey:@"circle_user_id"];
    //[NotifyHelper showHUD];
    @weakify(self)
    [SCRequestHelper circleAddNew:muParam completion:^(id data) {
        [NotifyHelper hideHUD];
        @strongify(self)
        if([[data valueForKey:@"success"] boolValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishCircleSuccess" object:[data valueForKey:@"data"]];
            Block_Exec(self.block,data);
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            if([[data valueForKey:@"code"] integerValue] == 99) {
                [WBStatusHelper showDisableAlert:self];
                return;
            }
            [NotifyHelper showMessageWithMakeText:[data valueForKey:@"msg"]];
        }
    }];
}

- (void)backAction {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if(indexPath.row == 0) {
        cell.textLabel.text = @"所在位置";
        cell.detailTextLabel.text = self.address ?: @"";
        cell.imageView.image = [UIImage imageNamed:@"bima_publish_location_icon_12x15_"];
    } else if(indexPath.row == 1) {
        cell.textLabel.text = @"谁可以查看";
        cell.detailTextLabel.text = self.jurisdiction;
        cell.imageView.image = [UIImage imageNamed:@"bima_publish_privacy_icon_15x12_"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1) {
        [MXRouter openURL:@"lcwl://WhoCanSeeMyInfoVC" parameters:@{@"type": @(1),@"value": self.jurisdiction ?: @"",@"block":^(NSString *open_type) {
            self.open_type = open_type;
            if([open_type integerValue] == 1) {
                self.jurisdiction = @"所有人";
            } else if([open_type integerValue] == 2) {
                self.jurisdiction = @"仅好友";
            } else {
                self.jurisdiction = @"仅自己";
            }
            [tableView reloadData];
        }}];
    } else {
        __weak typeof(self) weakSelf = self;
        [MXRouter openURL:@"lcwl://LocationShareVC" parameters:@{@"delegate":weakSelf}];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITextView *)send_TextView{
    if(!_send_TextView){
        _send_TextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 200)];
        _send_TextView.delegate = self;
        _send_TextView.font = [UIFont systemFontOfSize:16.f];
        _send_TextView.textColor = [UIColor blackColor];
        _send_TextView.placeholder = XG_WeChatPlaceHoldString;
    }
    return _send_TextView;
}
#pragma mark - textField delegate
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:XG_WeChatPlaceHoldString] ) {
//        textView.text = XG_WeChatPlaceHoldString;
//        textView.textColor = [UIColor grayColor];
//    }
//    return YES;
//}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    if (!textView.text || textView.text.length == 0 ) {
//        textView.text = @"";
//        textView.textColor = [UIColor lightGrayColor];
//    }
//    return YES;
//}

- (void)updateDragView:(NSArray *)images assets:(NSArray *)assets {
    if([images isKindOfClass:[NSArray class]]) {
        [self.dragView removeAll];
        
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAsset *asset = [assets safeObjectAtIndex:idx];
            self.curSelectVideo = NO;
            if(asset.mediaType == PHAssetMediaTypeVideo) {
                self.dragView.kMaxCount = 1;
                self.curSelectVideo = YES;
            } else if([obj isKindOfClass:[UIImage class]]) {
                self.dragView.kMaxCount = 9;
            }
            
            [self.dragView addImage:obj];
        }];
        
        [self layoutHeader];
        
        self.curSelectAssets = [NSMutableArray arrayWithArray:assets];
        self.curSelectImages = [NSMutableArray arrayWithArray:images];
    }
}

#pragma mark - delegate
- (void)imageDragViewAddButtonClicked {
    NSLog(@"imageDragView---点击了添加按钮");
    //int randomNum = arc4random()%3+1;
    //[self.cell.dragView addImage:[UIImage imageNamed:[NSString stringWithFormat:@"buttton_image%d",randomNum]]];
    
    @weakify(self)
    [[PhotoBrowser shared] dynamicShowPhotoLibrary:self allowSelectVideo:YES lastSelectAssets:self.curSelectAssets completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
        @strongify(self)
        [self updateDragView:images assets:assets];
    }];
    //刷新frame
    
}

- (void)imageDragViewDeleteButtonClickedAtIndex:(NSInteger)index{
    NSLog(@"imageDragView---删除了%ld",index);
    
    //刷新frame
    [self.curSelectAssets safeRemoveObjectAtIndex:index];
    [self.curSelectImages safeRemoveObjectAtIndex:index];
    [self.tableView reloadData];
}

- (void)imageDragViewButtonClickedAtIndex:(NSInteger)index{
    NSLog(@"imageDragView---点击了%ld",index);
    [[PhotoBrowser shared] dynamicPreviewSelectPhotos:self didSelectItemAtIndex:index completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
        [self updateDragView:images assets:assets];
    }];
}

- (void)imageDragViewDidMoveButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    NSLog(@"imageDragView---移动：从%ld至%ld",fromIndex,toIndex);
    [self.curSelectAssets exchangeObjectAtIndex:toIndex withObjectAtIndex:fromIndex];
    [self.curSelectImages exchangeObjectAtIndex:toIndex withObjectAtIndex:fromIndex];
}

//- (void)sendCurrentLocation:(RegionAnnotation *)poiAnnotation {
//    self.address = poiAnnotation.city;
//    [self.tableView reloadData];
//}

-(void)sendCurrentLocation:(CLLocationCoordinate2D)coordinate2D andAddress:(NSString*)address {
    self.address = address;
    [self.tableView reloadData];
}

- (void)copyTip {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"";
    [NotifyHelper showMessageWithMakeText:@"复制成功"];
}

- (UIView *)headerView {
    if(!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self.dragView getHeightThatFit]+200)];
    }
    return _headerView;
}

- (UILabel *)footerView {
    if(!_footerView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 200)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor moTextGray];
        label.backgroundColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@""];
        [att setLineSpacing:5 substring:att.string alignment:NSTextAlignmentLeft];
        //[label sizeToFit];
        label.attributedText = att;
        _footerView = label;
        label.userInteractionEnabled = YES;
        //[_footerView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyTip)];
        [_footerView addGestureRecognizer:tap];
    }
    return _footerView;
}

- (UIView *)transferView {
    if(!_transferView) {
        _transferView = [[UIView alloc] init];
        _transferView.backgroundColor = BackGroundColor;
        _transferView.layer.cornerRadius = 4;
        _transferView.clipsToBounds = YES;
        _transferView.layer.borderWidth = 0.5;
        _transferView.layer.borderColor = [UIColor moLineLight].CGColor;
        
        _transferImgView = [[UIImageView alloc] init];
        _transferImgView.layer.cornerRadius = 4;
        _transferImgView.clipsToBounds = YES;
        _transferImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_transferView addSubview:_transferImgView];
        @weakify(self);
        [_transferImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(@(10));
            make.top.equalTo(@(10));
            make.bottom.equalTo(@(-10));
            make.width.equalTo(self.transferImgView.mas_height);
            make.centerY.equalTo(self.transferView);
        }];
        
        _transferLbl = [[UILabel alloc] init];
        _transferLbl.numberOfLines = 0;
        [_transferView addSubview:_transferLbl];
        [_transferLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.transferImgView.mas_right).offset(10);
            make.right.equalTo(self.transferView.mas_right).offset(-10);
            make.top.bottom.equalTo(self.transferImgView);
        }];
    }
    return _transferView;
}
@end
