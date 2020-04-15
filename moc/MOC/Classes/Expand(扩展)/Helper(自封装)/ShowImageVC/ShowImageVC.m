//
//  ShowImageVC.m
//  Lcwl
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import "ShowImageVC.h"
#import "UIImage+Utils.h"
#import "UINavigationBar+Alpha.h"

@interface ShowImageVC ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIScrollView *bgView;
@end

@implementation ShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.bgView = [[UIScrollView alloc] init];
    [self.view addSubview:self.bgView];
    AdjustTableBehavior(self.bgView);
    self.view.backgroundColor = [UIColor clearColor];
    
    if(self.type == ShowTypePush) {
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"#2127C3"];
    } else {
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.view addGestureRecognizer:tap];
    }
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.imageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.imageView];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",LcwlServerRoot,@"system/appImg/getSysAppImgByType"];
    [MXNet Post:^(MXNet *net) {
        net.apiUrl(url).params(@{@"type":[NSString stringWithFormat:@"0%ld",self.showImageType]})
        .finish(^(id data) {
            NSDictionary *tempDic = (NSDictionary*)data;
            if ([tempDic[@"success"] boolValue]) {
                @weakify(self)
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:[tempDic valueForKey:@"data"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    @strongify(self)
                    CGFloat imageH = [image scaleHeightForScreenWidth];
                    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        //make.top.left.equalTo(@(0));
                        if(imageH <= SCREEN_HEIGHT) {
                            make.center.equalTo(self.bgView);
                        } else {
                            //make.top.left.right.equalTo(self.view);
                            //make.bottom.equalTo(self.view).offset(imageH-SCREEN_HEIGHT);
                            make.centerX.equalTo(self.bgView);
                            make.centerY.equalTo(@((imageH-SCREEN_HEIGHT)/2));
                        }
                        
                        make.width.equalTo(@(SCREEN_WIDTH));
                        make.height.equalTo(@(imageH));
                    }];
                    self.bgView.contentSize = CGSizeMake(SCREEN_WIDTH, imageH);
                    [self.view layoutIfNeeded];
                }];
            }
        }).failure(^(id error) {
            
        })
        .execute();
    }];
}

- (void)tap {
    [self.view removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar barReset];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = YES;
    //[self.navigationController.navigationBar setNavBarCurrentColor:[UIColor gameBackgroundColor] titleTextColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor clearColor],
                                                                      NSFontAttributeName : [UIFont font19]
                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self setNavBarLeftBtnImg:@"public_white_back"];

}

@end
