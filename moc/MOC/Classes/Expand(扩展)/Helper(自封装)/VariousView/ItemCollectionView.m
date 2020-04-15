//
//  ChatSettingHeader.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "ItemCollectionView.h"
#import "ItemCollectionCell.h"
#import "ItemModel.h"
#import "NSObject+Home.h"
#import "ApplyMPosVC.h"
#import "IIViewDeckController.h"
#import "SelectOverlayer.h"
static NSInteger itemHeight = 90;

@interface  ItemCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, strong) NSArray* data;

@property (nonatomic, strong) UICollectionViewFlowLayout* layout;

@end
@implementation ItemCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeNotification:) name:@"BadgeNotification" object:nil];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setupData{
    
    UIFont* tmpFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    CGSize size = CGSizeMake(30, 30);
    ItemModel* item1 = [[ItemModel alloc]init];
    item1.image = @"传统POS";
    item1.imageSize = size;
    item1.text = Lang(@"商户进件");
    item1.font = tmpFont;
    item1.textColor = [UIColor moBlack];
    item1.block = ^() {
//        [MXRouter openURL:@"lcwl://ApplyCTPosVC"];
        [SelectOverlayer showOverLayer:^(id data) {
            if (data) {
                [MXRouter openURL:data];
            }
        }];
    };
    
    ItemModel* item2 = [[ItemModel alloc]init];
    item2.image = @"MPOS";
    item2.imageSize = size;
    item2.text = Lang(@"MPOS");
    item2.font = tmpFont;
    item2.textColor = [UIColor moBlack];
    item2.block = ^() {
        ApplyMPosVC* vc = [[ApplyMPosVC alloc]init];
        IIViewDeckController* deck = [[IIViewDeckController alloc] initWithCenterViewController:vc rightViewController:nil];
        UIButton    * customBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [customBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [customBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        customBtn.enabled = NO;
        [customBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
        deck.navigationItem.leftBarButtonItem = barItem ;
        [[MXRouter sharedInstance].getTopNavigationController pushViewController:deck animated:YES];
    };
    
    ItemModel* item3 = [[ItemModel alloc]init];
    item3.image = @"线上活动";
    item3.imageSize = size;
    item3.text =  Lang(@"线上活动");
    item3.font = tmpFont;
    item3.textColor = [UIColor moBlack];
    item3.block = ^() {
        [MXRouter openURL:@"lcwl://OnlineActivitiesManagerVC"];
    };
    
    ItemModel* item4 = [[ItemModel alloc]init];
    item4.image = @"机具管理";
    item4.imageSize = size;
    item4.text =  Lang(@"机具管理");
    item4.font = tmpFont;
    item4.textColor = [UIColor moBlack];
    item4.block = ^() {
        [MXRouter openURL:@"lcwl://MachineManageVC"];
    };
    
    ItemModel* item5 = [[ItemModel alloc]init];
    item5.image = @"费率申请";
    item5.imageSize = size;
    item5.text =  Lang(@"费率申请");
    item5.font = tmpFont;
    item5.textColor = [UIColor moBlack];
    item5.block = ^() {
        [MXRouter openURL:@"lcwl://ApplyRateManageVC"];
        [self updateNewsReadFlag:@{@"news_type":@"applyRateFlag",@"read_flag":@"1"} completion:^(BOOL success, NSString *error) {
           if (success) {
               [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"applyRateFlag"];
               [[NSUserDefaults standardUserDefaults]synchronize];
           }
       }];
    };
    
    ItemModel* item6 = [[ItemModel alloc]init];
    item6.image = @"推广中心";
    item6.imageSize = size;
    item6.text =  Lang(@"推广中心");
    item6.font = tmpFont;
    item6.textColor = [UIColor moBlack];
//    @weakify(self)
    item6.block = ^() {
//        @strongify(self)
//        !self.block?:self.block(@"推广中心");
        [MXRouter openURL:@"lcwl://PromotionCenterVC"];
        [self updateNewsReadFlag:@{@"news_type":@"appImgFlag",@"read_flag":@"1"} completion:^(BOOL success, NSString *error) {
             if (success) {
                 [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"appImgFlag"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
         }];
        
    };
    
    ItemModel* item7 = [[ItemModel alloc]init];
    item7.image = @"商户查询";
    item7.imageSize = size;
    item7.text =  Lang(@"商户查询");
    item7.font = tmpFont;
    item7.textColor = [UIColor moBlack];
    item7.block = ^() {
       [MXRouter openURL:@"lcwl://MerchantQueryVC"];
    };
    
    ItemModel* item8 = [[ItemModel alloc]init];
    item8.image = @"钱柜学院";
    item8.imageSize = size;
    item8.text =  Lang(@"钱柜学院");
    item8.font = tmpFont;
    item8.textColor = [UIColor moBlack];
    item8.block = ^() {
        [MXRouter openURL:@"lcwl://WalletStudyVC"];
        [self updateNewsReadFlag:@{@"news_type":@"collegeFlag",@"read_flag":@"1"} completion:^(BOOL success, NSString *error) {
            if (success) {
                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"collegeFlag"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
        }];
    };
    self.data = @[item1,item2,item3,item4,item5,item6,item7,item8];
}

-(void)backAction:(id)sender{
    [[MXRouter sharedInstance].getTopNavigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)badgeNotification:(NSNotification *)noti {
    NSString* collegeFlag =  [[NSUserDefaults standardUserDefaults]objectForKey:@"collegeFlag"];
    ItemModel* item8 = [self.data lastObject];
    item8.hasPoint = [@"0" isEqualToString:collegeFlag];
    
    NSString* appImgFlag =  [[NSUserDefaults standardUserDefaults]objectForKey:@"appImgFlag"];
    ItemModel* item3 = [self.data objectAtIndex:self.data.count-3];
    item3.hasPoint = [@"0" isEqualToString:appImgFlag];
    
    NSString* applyRateFlag =  [[NSUserDefaults standardUserDefaults]objectForKey:@"applyRateFlag"];
    ItemModel* item5 = [self.data objectAtIndex:self.data.count-4];
    item5.hasPoint = [@"0" isEqualToString:applyRateFlag];
    

    [self reloadData];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[ItemCollectionCell class] forCellWithReuseIdentifier:@"ItemCollectionCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionCell" forIndexPath:indexPath];
    cell.nameLbl.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    ItemModel* object = self.data[indexPath.row];
//    [cell reloadImg:object.image name:object.text imageSize:object.imageSize];
    [cell reloadData:object];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemModel* model = self.data[indexPath.row];
    if (model.block) {
        model.block();
    }
}

-(int)viewHeight{
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    if (layout && !CGRectEqualToRect(self.bounds, CGRectZero)) {
        int column = (self.frame.size.width/layout.itemSize.width);
        return  layout.itemSize.height*((self.data.count/column)+(self.data.count%column?1:0));
    }
    return 0;
}

-(UICollectionViewFlowLayout*)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CGFloat width = SCREEN_WIDTH / 4;
        [_layout setItemSize:CGSizeMake( width, itemHeight)];
        [_layout setMinimumInteritemSpacing:0];
        [_layout setMinimumLineSpacing:0];
    }
    return _layout;
}

- (void)reloadData{
     [self.collectionView reloadData];
}

- (void)reloadData:(NSArray*)data layout:(UICollectionViewFlowLayout*)layout{
    [self.collectionView setCollectionViewLayout:layout];
    self.data = data;
    [self.collectionView reloadData];
}

@end
