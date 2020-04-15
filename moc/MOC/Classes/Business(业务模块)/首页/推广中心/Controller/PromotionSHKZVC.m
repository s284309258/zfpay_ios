//
//  PromotionYWKZVC.m
//  XZF
//
//  Created by mac on 2020/3/7.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "PromotionSHKZVC.h"
#import "NSObject+Home.h"
#import "AppImgModel.h"
#import "QNManager.h"
#import "PromotionItemCell.h"
#import "ShareOverlayer.h"
#import "ShareManager.h"
static NSInteger padding = 10;
static NSString* identifier = @"identifier";
@interface PromotionSHKZVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout* layout;

@property (nonatomic, strong) NSMutableArray* dataArray;

@end

@implementation PromotionSHKZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
    }];
}

-(void)setupData{
    self.dataArray = [NSMutableArray new];
    @weakify(self)
    [self getAppImgList:@{@"img_type":@"03"} completion:^(id array, NSString *error) {
        @strongify(self)
        if (array) {
            self.dataArray = array;
            [self.collectionView reloadData];
        }
    }];
}

-(UICollectionViewFlowLayout*)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
//        [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        CGFloat width = (SCREEN_WIDTH - 3*padding)/2;
        [_layout setItemSize:CGSizeMake( width,width*1.5)];
        [_layout setMinimumInteritemSpacing:padding];
        [_layout setMinimumLineSpacing:padding];
    }
    return _layout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
//        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[PromotionItemCell class] forCellWithReuseIdentifier:identifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PromotionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    AppImgModel* model = self.dataArray[indexPath.row];
    [cell reloadImg:model.img_url];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     AppImgModel* model = self.dataArray[indexPath.row];
    NSString* url = model.img_url;
    if (![url hasPrefix:@"http:"]) {
        url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,url];
    }
    [ShareOverlayer showOverLayer:AppUserModel.qr_code_url share:^(id data) {
        NSString* tmp = AppUserModel.qr_code_url;
        [ShareManager shareToWeChatPlatform2:@"中掌柜" content:@"中掌柜" image:url url:tmp vc:
        self];
    } save:^(id data) {
        if (data) {
            UIImageWriteToSavedPhotosAlbum(data, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    } imgArray:@[url]];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [NotifyHelper showMessageWithMakeText:msg];
}
@end

