//
//  BaseSTDTableViewVC.h
//  BOB
//  全力打造一个功能丰富的Tableview ViewController，使其使用者只需专注业务即可
//  Created by mac on 2019/6/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseViewController.h"
#import "LYEmptyBaseView.h"
#import "UITableView+STDTableView.h"
#import "BaseSTDTableViewCell.h"

/// 请求方式
typedef NS_ENUM(NSInteger , HTTPRequestMethod) {
    HTTPRequestMethodGet = 0,
    HTTPRequestMethodPost,
    HTTPRequestMethodHead,
    HTTPRequestMethodPut,
    HTTPRequestMethodDelete,
    HTTPRequestMethodPatch
};

/// 分页类型：按页数和last id
//typedef NS_ENUM(NSInteger , HTTPRequestPageType) {
//    HTTPRequestPageTypePageNum = 0,
//    HTTPRequestPageTypeLastId,
//};

NS_ASSUME_NONNULL_BEGIN

@interface BaseSTDTableViewVC : BaseViewController<UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSString * pageNum;

@property (strong, nonatomic) NSMutableArray * dataSource;

@property (copy, nonatomic, nullable) NSString *last_id;

- (void)configTableView:(UITableView *)tableView;
- (void)setupTableViewDataSource;

#pragma mark - 展示数据为空的各种页面
/**
 构造方法 - 创建emptyView
 
 @param image       占位图片
 @param titleStr    标题
 @param detailStr   详细描述
 @param btnTitleStr 按钮的名称
 @param target      响应的对象
 @param action      按钮点击事件
 */
- (void)showEmptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                                  target:(id)target
                                  action:(SEL)action;

/**
 构造方法 - 创建emptyView
 
 @param image          占位图片
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 */
- (void)showEmptyActionViewWithImage:(UIImage *)image
                                titleStr:(NSString *)titleStr
                               detailStr:(NSString *)detailStr
                             btnTitleStr:(NSString *)btnTitleStr
                           btnClickBlock:(LYActionTapBlock)btnClickBlock;

/**
 构造方法 - 创建emptyView
 
 @param imageStr    占位图片名称
 @param titleStr    标题
 @param detailStr   详细描述
 @param btnTitleStr 按钮的名称
 @param target      响应的对象
 @param action      按钮点击事件
 */
- (void)showEmptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                                     target:(id)target
                                     action:(SEL)action;

/**
 构造方法 - 创建emptyView
 
 @param imageStr       占位图片名称
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 */
- (void)showEmptyActionViewWithImageStr:(NSString *)imageStr
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                              btnClickBlock:(LYActionTapBlock)btnClickBlock;

/**
 构造方法 - 创建emptyView
 
 @param image         占位图片
 @param titleStr      占位描述
 @param detailStr     详细描述
 */
- (void)showEmptyViewWithImage:(UIImage *)image
                          titleStr:(NSString *)titleStr
                         detailStr:(NSString *)detailStr;

/**
 构造方法 - 创建emptyView
 
 @param imageStr      占位图片名称
 @param titleStr      占位描述
 @param detailStr     详细描述
 */
- (void)showEmptyViewWithImageStr:(NSString *)imageStr
                             titleStr:(NSString *)titleStr
                            detailStr:(NSString *)detailStr;

/**
 构造方法 - 创建一个自定义的emptyView
 
 @param customView 自定义view
 */
- (void)showEmptyViewWithCustomView:(UIView *)customView;
@end

NS_ASSUME_NONNULL_END
