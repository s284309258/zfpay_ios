//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@class MJPhotoView;

@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSInteger currentPhotoIndex;

/**
 *  初始化方法
 *
 *  @param cls 底部工具栏
 *
 *  @return 实例
 */
- (instancetype)initWithToolbarClass:(Class)cls;

// 显示
- (void)show;


- (void)showPhotos;
- (void)showPhotoViewAtIndex:(NSInteger)index;
- (MJPhotoView *)dequeuePhotoViewAtIndex:(NSUInteger)index;
- (void)removePhotoAtIndex:(NSUInteger)index;

@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end