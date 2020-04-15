//
//  MJPhotoBrowser.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SDWebImageManager+MJ.h"
#import "MJPhotoView.h"
//#import "MJPhotoToolbar.h"
#import "MXMoToolbarProtocol.h"

#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface MJPhotoBrowser () <MJPhotoViewDelegate>
{
    // 滚动的view
	UIScrollView *_photoScrollView;
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;
    // 工具条
    // 一开始的状态栏
    BOOL _statusBarHiddenInited;
}

@property (nonatomic, assign) Class toolbarClass;
@property (nonatomic, strong) UIView <MXMoToolbarProtocol>* toolbar;
@property (nonatomic, strong) UILabel *indexLabel;

@end

@implementation MJPhotoBrowser

#pragma mark - Lifecycle
- (void)loadView
{
    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    self.view = [[UIView alloc] init];
    self.view.frame = [UIScreen mainScreen].bounds;
	self.view.backgroundColor = [UIColor blackColor];
}

- (instancetype)initWithToolbarClass:(Class)cls
{
    self = [super init];
    if (self) {
        _toolbarClass = cls;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIScrollView
    [self createScrollView];
    
    [self createScrollIndexLabel];
    
    // 2.创建工具条
    [self createToolbar];
    CGFloat backBtnHeight = 44;
    CGFloat backBtnWidth = 60;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0,20 + backBtnHeight/2 - backBtnHeight/2, backBtnWidth, backBtnHeight);
    [backButton setImage:[UIImage imageNamed:@"public_white_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"public_white_back"] forState:UIControlStateHighlighted];
    backButton.userInteractionEnabled = NO;
//    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];

    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
}


- (void)backAction:(id)sender{
//    currentPhotoIndex
}

#pragma mark - 私有方法
#pragma mark 创建工具条
- (void)createToolbar
{
    CGFloat barHeight = 44;
    CGFloat barY = self.view.frame.size.height - barHeight;
//    self.toolbar = [[self.toolbarClass alloc] init];
    _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    if ([_toolbar respondsToSelector:@selector(setPhotos:)]) {
        _toolbar.photos = _photos;
    }
    [self.view addSubview:_toolbar];
    
    
    [self updateTollbarState];
}

//add by yangjiale 2016/10/18
#pragma mark - 创建滚动索引

- (void)createScrollIndexLabel {
    [self.view addSubview:self.indexLabel];
}

- (void)updateScrollIndexLabel {
//    self.indexLabel.text = (self.photos.count > 1)?[NSString stringWithFormat:MXLang(@"", @"%@/%@"),@(_currentPhotoIndex + 1),@(self.photos.count)]:@"";
    
    // 交互提出的修改，一张时也要显示数字
     self.indexLabel.text = [NSString stringWithFormat:MXLang(@"", @"%@/%@"),@(_currentPhotoIndex + 1),@(self.photos.count)];
    
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60)/2, 20, 60, 44)];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont font17];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLabel;
}
//end

#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
	_photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
	_photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_photoScrollView.pagingEnabled = YES;
	_photoScrollView.delegate = self;
	_photoScrollView.showsHorizontalScrollIndicator = NO;
	_photoScrollView.showsVerticalScrollIndicator = NO;
	_photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
	[self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (photos.count > 1) {
        _visiblePhotoViews = [NSMutableSet set];
        _reusablePhotoViews = [NSMutableSet set];
    }
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
    //fly 修改contentSize 2015.10.20
//    _photoScrollView.contentSize = CGSizeMake(self.view.width * photos.count, 0);
}

#pragma mark 设置选中的图片
- (void)setCurrentPhotoIndex:(NSInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.firstShow = i == currentPhotoIndex;
    }
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - MJPhotoView代理
- (void)photoViewSingleTap:(MJPhotoView *)photoView
{
    //将当期图片浏览器销毁
    [UIApplication sharedApplication].statusBarHidden = _statusBarHiddenInited;
    self.view.backgroundColor = [UIColor clearColor];
    
    // 移除工具条
    [_toolbar removeFromSuperview];
}

- (void)photoViewDidEndZoom:(MJPhotoView *)photoView
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)photoViewImageFinishLoad:(MJPhotoView *)photoView
{
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark 显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        [self updateScrollIndexLabel];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
	int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = (int)_photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = (int)_photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (MJPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:(int)index];
		}
	}
    
    //add by yangjiale 2016/10/18
    [self updateScrollIndexLabel];
    //end
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(NSInteger)index
{
    MJPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[MJPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    MJPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
    
}

- (void)removePhotoAtIndex:(NSUInteger)index{
    if ([self.photos count] <= 1) {
        return;
    }
    NSMutableArray* newPhotos = [NSMutableArray arrayWithArray:self.photos];
    if(index < newPhotos.count)
        [newPhotos removeObjectAtIndex:index];
    self.photos = newPhotos;
    
    [_visiblePhotoViews removeAllObjects];
    [_reusablePhotoViews removeAllObjects];
    for (UIView* subView in [_photoScrollView subviews]) {
        [subView removeFromSuperview];
    }
    _photoScrollView.contentSize = CGSizeMake((self.view.width + 2 * kPadding) * newPhotos.count, 0);
    [self showPhotos];
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(NSInteger)index
{
    if (index > 0) {
        MJPhoto *photo = _photos[index - 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        MJPhoto *photo = _photos[index + 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (MJPhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
           return YES;
        }
    }
	return  NO;
}

#pragma mark 循环利用某个view
- (MJPhotoView *)dequeueReusablePhotoView
{
    MJPhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

- (MJPhotoView *)dequeuePhotoViewAtIndex:(NSUInteger)index;
{
    return (MJPhotoView *)[_photoScrollView viewWithTag:kPhotoViewTagOffset + index];
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateTollbarState];
    [self updateScrollIndexLabel];
}
@end
