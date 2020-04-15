//
//  PhotoBrowser.m
//  Lcwl
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "PhotoBrowser.h"
#import "ZLCollectionCell.h"
#import "ZLPhotoManager.h"
#import "ZLPhotoBrowser.h"
#import "ZLShowBigImgViewController.h"
#import "ZLThumbnailViewController.h"
#import "ZLNoAuthorityViewController.h"
#import "ToastUtils.h"
#import "ZLEditViewController.h"
#import "ZLEditVideoController.h"
#import "ZLCustomCamera.h"
#import "ZLDefine.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoManager.h"

@interface PhotoBrowser ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, weak) UIViewController *showInVC;
@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property (nonatomic, strong) NSArray *arrDataSources;
@property(nonatomic, copy) SelectMediaBlock block;

@property (nonatomic, strong) NSMutableArray<ZLPhotoModel *> *arrSelectedModels;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

/**相册框架配置，默认为 [ZLPhotoConfiguration defaultPhotoConfiguration]*/
@property (nonatomic, strong, readonly) ZLPhotoConfiguration *configuration;


@end

@implementation PhotoBrowser

+ (instancetype)shared {
    static dispatch_once_t pred;
    static PhotoBrowser *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

-(id)init
{
    if (self=[super init]) {
        _configuration = [ZLPhotoConfiguration defaultPhotoConfiguration];
    }
    return self;
}

- (void)reset {
    self.lastSelectPhotos = nil;
    self.lastSelectAssets = nil;
    self.arrDataSources = nil;
    self.block = nil;
}

//选择单张图片-带编辑
- (void)showPhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block {
    self.block = block;
    ZLPhotoActionSheet *a = [self getParam:showInVC];
    [a showPhotoLibrary];
}

//选择头像图片-带编辑，剪裁1:1
- (void)showSelectSinglePhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block {
    self.block = block;
    ZLPhotoActionSheet *actionSheet = [self getParam:showInVC];
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    actionSheet.configuration.useSystemCamera = YES;
//    //是否保存编辑后的图片
    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    actionSheet.configuration.clipRatios = @[GetClipRatio(1, 1)];
    actionSheet.configuration.mustClipImage = YES;
    [actionSheet showPhotoLibrary];
}

//选择朋友圈背景-带编辑，剪裁
- (void)showSelectSocialContactPhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock)block {
    self.block = block;
    ZLPhotoActionSheet *actionSheet = [self getParam:showInVC];
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    //是否保存编辑后的图片
    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    actionSheet.configuration.clipRatios = @[GetClipRatio(15, 8),GetClipRatio(4, 3),GetClipRatio(3, 2),GetClipRatio(1, 1)];
    actionSheet.configuration.mustClipImage = YES;
    [actionSheet showPhotoLibrary];
}

- (ZLPhotoActionSheet *)dynamicPreviewParam {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    //以下参数为自定义参数，均可不设置，有默认值
    actionSheet.configuration.sortAscending = NO;
    actionSheet.configuration.allowSelectImage = YES;
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.allowSelectLivePhoto = NO;
    
    actionSheet.configuration.allowEditImage = YES;
    
    actionSheet.configuration.allowMixSelect = NO;
    
    //设置相册内部显示拍照按钮
    actionSheet.configuration.allowTakePhotoInLibrary = YES;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = YES;
    //设置照片最大预览数
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = 9;
    //设置允许选择的视频最大时长
    actionSheet.configuration.maxVideoDuration = 15;
    //设置照片cell弧度
    actionSheet.configuration.cellCornerRadio = 0;
    //单选模式是否显示选择按钮
    actionSheet.configuration.showSelectBtn = NO;
    //是否在选择图片后直接进入编辑界面
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    //是否保存编辑后的图片
    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    //actionSheet.configuration.clipRatios = @[GetClipRatio(1, 1)];
    //是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = YES;
    //是否允许框架解析图片
    actionSheet.configuration.shouldAnialysisAsset = YES;
    //框架语言
    actionSheet.configuration.languageType = ZLLanguageChineseSimplified;
    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    actionSheet.configuration.useSystemCamera = NO;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //actionSheet.configuration.maxVideoDuration = 5;
    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    actionSheet.configuration.navBarColor = [UIColor whiteColor];
    
    
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
//    actionSheet.sender = showInVC;
//    //记录上次选择的图片
//    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        strongSelf.lastSelectAssets = assets.mutableCopy;
        strongSelf.lastSelectPhotos = images.mutableCopy;
        Block_Exec(weakSelf.block,images,assets,isOriginal);
    }];
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    return actionSheet;
}

//根据照片数组预览
- (void)dynamicPreviewSelectPhotos:(UIViewController *)showInVC didSelectItemAtIndex:(NSInteger)index completion:(SelectMediaBlock)block {
    if(self.lastSelectAssets.count == 0) {
        return;
    }
    
    self.block = block;
    
    ZLPhotoActionSheet *actionSheet = [self dynamicPreviewParam];
    
    actionSheet.sender = showInVC;
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    [actionSheet previewSelectedPhotos:self.lastSelectPhotos assets:self.lastSelectAssets index:index isOriginal:NO];
}

//发朋友圈模块照片/视频选择入口
- (void)dynamicShowPhotoLibrary:(UIViewController *)showInVC allowSelectVideo:(BOOL)allow lastSelectAssets:(nullable NSMutableArray<PHAsset *>*)assets completion:(SelectMediaBlock)block {
    self.block = block;
    if(assets) {
        self.lastSelectAssets = assets;
    }
    ZLPhotoActionSheet *actionSheet = [self dynamicPreviewParam];
    actionSheet.configuration.allowSelectVideo = allow;
    actionSheet.configuration.allowSelectGif = allow;
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    actionSheet.sender = showInVC;
    [actionSheet showPhotoLibrary];
}

#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
- (ZLPhotoActionSheet *)getParam:(UIViewController *)showInVC
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    //以下参数为自定义参数，均可不设置，有默认值
    actionSheet.configuration.sortAscending = NO;
    actionSheet.configuration.allowSelectImage = YES;
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.configuration.allowSelectVideo = YES;
    actionSheet.configuration.allowSelectLivePhoto = NO;
    actionSheet.configuration.allowForceTouch = YES;
    actionSheet.configuration.allowEditImage = YES;
    actionSheet.configuration.allowEditVideo = NO;
    actionSheet.configuration.allowSlideSelect = YES;
    actionSheet.configuration.allowMixSelect = NO;
    actionSheet.configuration.allowDragSelect = YES;
    //设置相册内部显示拍照按钮
    actionSheet.configuration.allowTakePhotoInLibrary = YES;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = YES;
    //设置照片最大预览数
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = 1;
    //设置允许选择的视频最大时长
    actionSheet.configuration.maxVideoDuration = 15;
    //设置照片cell弧度
    actionSheet.configuration.cellCornerRadio = 0;
    //单选模式是否显示选择按钮
    //    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    actionSheet.configuration.editAfterSelectThumbnailImage = NO;
    //是否保存编辑后的图片
        actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
    //是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = YES;
    //颜色，状态栏样式
    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    actionSheet.configuration.shouldAnialysisAsset = YES;
    //框架语言
    actionSheet.configuration.languageType = ZLLanguageChineseSimplified;
    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //    actionSheet.configuration.maxVideoDuration = 5;
    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    actionSheet.configuration.navBarColor = [UIColor whiteColor];
    
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = showInVC;
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = nil;
    
    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        Block_Exec(weakSelf.block,images,assets,isOriginal);
//        strongSelf.arrDataSources = images;
//        strongSelf.isOriginal = isOriginal;
//        strongSelf.lastSelectAssets = assets.mutableCopy;
//        strongSelf.lastSelectPhotos = images.mutableCopy;
//        [strongSelf.collectionView reloadData];
//        NSLog(@"image:%@", images);
//        //解析图片
//        if (!strongSelf.allowAnialysisAssetSwitch.isOn) {
//            [strongSelf anialysisAssets:assets original:isOriginal];
//        }
    }];
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    
    return actionSheet;
}

- (void)anialysisAssets:(NSArray<PHAsset *> *)assets original:(BOOL)original
{
    ZLProgressHUD *hud = [[ZLProgressHUD alloc] init];
    //该hud自动15s消失，请使用自己项目中的hud控件
    [hud show];
    
    zl_weakify(self);
    [ZLPhotoManager anialysisAssets:assets original:original completion:^(NSArray<UIImage *> *images) {
        zl_strongify(weakSelf);
        [hud hide];
        strongSelf.arrDataSources = images;
        strongSelf.lastSelectPhotos = images.mutableCopy;
        NSLog(@"%@", images);
    }];
}
//---------------------相机---------------------begin
- (void)camera:(UIViewController *)showInVC completion:(void(^)(UIImage * image)) block {
    if (![ZLPhotoManager haveCameraAuthority]) {
        NSString *message = [NSString stringWithFormat:GetLocalLanguageTextValue(ZLPhotoBrowserNoCameraAuthorityText), kAPPName];
        ShowAlert(message, showInVC);

        return;
    }
    if (!self.configuration.allowSelectImage &&
        !self.configuration.allowRecordVideo) {
        ShowAlert(@"allowSelectImage与allowRecordVideo不能同时为NO", showInVC);
        return;
    }
    if (![ZLPhotoManager haveMicrophoneAuthority]) {
        NSString *message = [NSString stringWithFormat:GetLocalLanguageTextValue(ZLPhotoBrowserNoMicrophoneAuthorityText), kAPPName];
        ShowAlert(message, showInVC);
        return;
    }
    ZLCustomCamera *camera = [[ZLCustomCamera alloc] init];
    camera.allowTakePhoto = self.configuration.allowSelectImage;
    camera.allowRecordVideo = self.configuration.allowSelectVideo && self.configuration.allowRecordVideo;
    camera.sessionPreset = self.configuration.sessionPreset;
    camera.videoType = self.configuration.exportVideoType;
    camera.circleProgressColor = self.configuration.bottomBtnsNormalTitleColor;
    camera.maxRecordDuration = self.configuration.maxRecordDuration;
    camera.allowRecordVideo = NO;
    zl_weakify(self);
    camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        zl_strongify(weakSelf);
        block(image);
    };
    [showInVC showDetailViewController:camera sender:nil];
}

//---------------------相机---------------------end

//---------------------相册选择图片------------------------begin
- (void)showThumbnailPhotoLibrary:(UIViewController *)showInVC completion:(SelectMediaBlock) block {
    self.showInVC = showInVC;
    self.block = block;
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                [self pushThumbnailViewController];
            } else {
                [self showNoAuthorityVC];
            }
        });
    }];
    
    
  
}

#pragma mark - 显示无权限视图
- (void)showNoAuthorityVC
{
    //无相册访问权限
    ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
    [self.showInVC showDetailViewController:[self getImageNavWithRootVC:nvc] sender:nil];
}

-(void)pushThumbnailViewController{
    ZLPhotoActionSheet *actionSheet = [self dynamicPreviewParam];
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    actionSheet.sender = self.showInVC;
    [actionSheet showPhotoLibrary];
    
//    ZLPhotoBrowser *photoBrowser = [[ZLPhotoBrowser alloc] initWithStyle:UITableViewStylePlain];
//    ZLImageNavigationController *nav = [self getImageNavWithRootVC:photoBrowser];
//    ZLThumbnailViewController *tvc = [[ZLThumbnailViewController alloc] init];
//    [nav pushViewController:tvc animated:YES];
//
//    [self.showInVC.navigationController showDetailViewController:nav sender:nil];
}

- (NSMutableArray<ZLPhotoModel *> *)arrSelectedModels
{
    if (!_arrSelectedModels) {
        _arrSelectedModels = [NSMutableArray array];
    }
    return _arrSelectedModels;
}

- (ZLImageNavigationController *)getImageNavWithRootVC:(UIViewController *)rootVC
{
    
    ZLImageNavigationController *nav = [[ZLImageNavigationController alloc] initWithRootViewController:rootVC];
    zl_weakify(self);
    __weak typeof(ZLImageNavigationController *) weakNav = nav;
    [nav setCallSelectImageBlock:^{
                zl_strongify(weakSelf);
                strongSelf.isSelectOriginalPhoto = weakNav.isSelectOriginalPhoto;
                [strongSelf.arrSelectedModels removeAllObjects];
                [strongSelf.arrSelectedModels addObjectsFromArray:weakNav.arrSelectedModels];
                [strongSelf requestSelPhotos:weakNav data:strongSelf.arrSelectedModels hideAfterCallBack:YES];
    }];
    
    [nav setCallSelectClipImageBlock:^(UIImage *image, PHAsset *asset){
        //        zl_strongify(weakSelf);
        //        if (strongSelf.selectImageBlock) {
        //            strongSelf.selectImageBlock(@[image], @[asset], NO);
        //        }
        //        [weakNav dismissViewControllerAnimated:YES completion:nil];
        //        [strongSelf hide];
    }];
    
    [nav setCancelBlock:^{
        //        zl_strongify(weakSelf);
        //        if (strongSelf.cancleBlock) strongSelf.cancleBlock();
        //        [strongSelf hide];
    }];
    
    nav.isSelectOriginalPhoto = NO;
    nav.previousStatusBarStyle = UIStatusBarStyleDefault;
    nav.configuration = [ZLPhotoConfiguration defaultPhotoConfiguration];
    [nav.arrSelectedModels removeAllObjects];
    [nav.arrSelectedModels addObjectsFromArray:[[NSArray alloc]init]];
    
    return nav;
}

#pragma mark - 请求所选择图片、回调
- (void)requestSelPhotos:(UIViewController *)vc data:(NSArray<ZLPhotoModel *> *)data hideAfterCallBack:(BOOL)hide
{
    ZLProgressHUD *hud = [[ZLProgressHUD alloc] init];
    [hud show];

    __block NSMutableArray *photos = [NSMutableArray arrayWithCapacity:data.count];
    __block NSMutableArray *assets = [NSMutableArray arrayWithCapacity:data.count];
    for (int i = 0; i < data.count; i++) {
        [photos addObject:@""];
        [assets addObject:@""];
    }
    
    zl_weakify(self);
    for (int i = 0; i < data.count; i++) {
        ZLPhotoModel *model = data[i];
        [ZLPhotoManager requestSelectedImageForAsset:model isOriginal:self.isSelectOriginalPhoto allowSelectGif:self.configuration.allowSelectGif completion:^(UIImage *image, NSDictionary *info) {
            if ([[info objectForKey:PHImageResultIsDegradedKey] boolValue]) return;
            
            zl_strongify(weakSelf);
            if (image) {
                [photos replaceObjectAtIndex:i withObject:[ZLPhotoManager scaleImage:image original:strongSelf->_isSelectOriginalPhoto]];
                [assets replaceObjectAtIndex:i withObject:model.asset];
            }
            
            for (id obj in photos) {
                if ([obj isKindOfClass:[NSString class]]) return;
            }
            
            [hud hide];
            if (strongSelf.selectImageBlock) {
                strongSelf.selectImageBlock(photos, assets, strongSelf.isSelectOriginalPhoto);
                [strongSelf.arrSelectedModels removeAllObjects];
            }
            
            [self.showInVC dismissViewControllerAnimated:YES completion:nil];
            
        }];
    }
}

//---------------------相册选择图片------------------------end
@end
