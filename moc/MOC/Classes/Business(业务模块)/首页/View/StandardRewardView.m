//
//  StandardRewardView.m
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "StandardRewardView.h"
#import "PolicyModel.h"
@class StandardRewardCell;
static NSString* identifier = @"cell";
@interface StandardRewardView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray* data;

@end
@implementation StandardRewardView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[StandardRewardCell class] forCellWithReuseIdentifier:identifier];
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
    StandardRewardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    PolicyModel* model = self.data[indexPath.row];
    [cell reload:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     PolicyModel* model = self.data[indexPath.row];
    if (model.state == EnableTakeReward) {
        !self.click?:self.click(model);
    }
}

- (void)reloadData:(NSArray*)data layout:(UICollectionViewFlowLayout*)layout{
    [self.collectionView setCollectionViewLayout:layout];
    self.data = data;
    [self.collectionView reloadData];
}

@end

@interface StandardRewardCell() 

@property (nonatomic,strong) UIButton* btn;

@end


@implementation StandardRewardCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.layer.cornerRadius = 12;
        _btn.backgroundColor = [UIColor moGreen];
        _btn.titleLabel.font = [UIFont font11];
        _btn.layer.borderWidth = .5;
        _btn.layer.shadowOpacity = 1;
        _btn.layer.shadowRadius = 5;
        _btn.layer.shadowOffset = CGSizeMake(0, 2);
        _btn.enabled = NO;
    }
    return _btn;
}

-(void)reload:(PolicyModel*)model{
    [self setData:model];
    [self setShadow:model];
   
}

-(void)setData:(PolicyModel*)model{
    NSString* content = @"";
    float quantity = [model.policy_quantity floatValue]/10000;
   if (model.state == EnableTakeReward) {
       content = [NSString stringWithFormat:@"%.2lf万|领取",quantity];
   }else if(model.state == UnEnableTakeReward){
       content = [NSString stringWithFormat:@"%.2lf万|领取",quantity];
      
   }else if(model.state == TakeRewarded){
       content = [NSString stringWithFormat:@"%.2lf万|已领",quantity];
   }
   [_btn setTitle:content forState:UIControlStateNormal];
}

-(void)setShadow:(PolicyModel*)model{
    if (model.state == EnableTakeReward) {
        _btn.layer.shadowColor = [UIColor grayColor].CGColor;
        [_btn setBackgroundColor:[UIColor colorWithHexString:@"#20CC9AFF"]];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.layer.borderColor = [UIColor clearColor].CGColor;
    }else{
        _btn.layer.shadowColor = [UIColor clearColor].CGColor;
        if (model.state == UnEnableTakeReward) {
            [_btn setBackgroundColor:[UIColor whiteColor]];
            _btn.layer.borderColor = [UIColor grayColor].CGColor;
            [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [_btn setBackgroundColor:[UIColor grayColor]];
            _btn.layer.borderColor = [UIColor grayColor].CGColor;
            [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}


@end
