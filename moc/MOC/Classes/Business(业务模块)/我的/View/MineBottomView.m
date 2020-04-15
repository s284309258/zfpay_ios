//
//  ChatSettingHeader.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "MineBottomView.h"
#import "MineBottomCell.h"

@interface  MineBottomView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray* data;

@property (nonatomic) NSInteger height;

@property (nonatomic) NSInteger width;

@end
@implementation MineBottomView

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num height:(int)height imgWidth:(int)width{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = @[];
        self.backgroundColor = [UIColor colorWithHexString:@"#F3F4F6"];
        self.nums = num;
        self.height = height;
        self.width = width;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CGFloat width = (SCREEN_WIDTH) / self.nums-1;
        [layout setItemSize:CGSizeMake(width, self.height)];
        [layout setMinimumInteritemSpacing:1];
        [layout setMinimumLineSpacing:1];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[MineBottomCell class] forCellWithReuseIdentifier:@"MineBottomCell"];
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
    MineBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineBottomCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    id object = self.data[indexPath.row];
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary* obj = (NSDictionary*)object;
        [cell reloadImg:obj[@"image"] name:obj[@"text"]];
        cell.iconWidth = self.width;
    }
    return cell;
}

- (void)reloadData:(NSArray*)data{
    self.nums = data.count;
    self.data = data;
    CGRect rect = self.frame;
    rect.size.height = self.data.count/self.nums*((SCREEN_WIDTH) / self.nums)+(self.data.count%self.nums>0?(SCREEN_WIDTH) / self.nums:0);
    self.frame = rect;
    [self.collectionView reloadData];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(@(indexPath.row));
    }
}

@end
