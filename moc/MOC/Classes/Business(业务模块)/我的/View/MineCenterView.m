//
//  ChatSettingHeader.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "MineCenterView.h"
#import "MineCenterCell.h"

@interface  MineCenterView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray* data;

@end
@implementation MineCenterView

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = @[];
        self.backgroundColor = [UIColor clearColor];
        self.nums = num;
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
        CGFloat width = (SCREEN_WIDTH) / self.nums;
        [layout setItemSize:CGSizeMake(width, 200.0/3.0)];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[MineCenterCell class] forCellWithReuseIdentifier:@"MineCenterCell"];
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
    MineCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineCenterCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    id object = self.data[indexPath.row];
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary* obj = (NSDictionary*)object;
        [cell reloadTitle:obj[@"value"] name:obj[@"text"]];
    }
    return cell;
}

- (void)reloadData:(NSArray*)data{
    self.nums = data.count;
    self.data = data;
    CGRect rect = self.frame;
    rect.size.height = 200;
    self.frame = rect;
    [self.collectionView reloadData];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(@(indexPath.row));
    }
}

@end
