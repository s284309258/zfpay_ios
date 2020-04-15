//
//  ChatSettingHeader.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "TradeItemView.h"
#import "TradeCell.h"
#import "MXSeparatorLine.h"
#import "HBLevelModel.h"
static NSInteger topPadding = 10;
static NSInteger padding = 10;
static NSInteger height = 35;
static NSInteger leftPadding = 15;
@interface  TradeItemView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *iconImg;

@property (nonatomic, strong) NSArray* dataArray;

@property (nonatomic) NSInteger  selectIndex;

@property (nonatomic) NSInteger  column;

@property (nonatomic, strong) MXSeparatorLine* line;

@end

@implementation TradeItemView

- (instancetype)initWithFrame:(CGRect)frame column:(NSInteger) column{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.column = column;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    [self addSubview:self.iconImg];
    [self addSubview:self.lbl];
    [self addSubview:self.collectionView];
    [self layoutsubviews];
}

-(void)layoutsubviews{
    @weakify(self)
    [self.iconImg  mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self).offset(leftPadding);
        make.top.equalTo(self).offset(topPadding);
        make.height.width.equalTo(@(16));
    }];
    [self.lbl  mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.centerY.equalTo(self.iconImg.mas_centerY);
        make.height.equalTo(@(20));
    }];
    [self.line  mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.iconImg.mas_bottom).offset(topPadding);
        make.height.equalTo(@(0.5));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(leftPadding);
        make.right.equalTo(self.mas_right).offset(-leftPadding);
        make.top.equalTo(self.line.mas_bottom).offset(topPadding);
//        float tmpHeight = (height+padding)*(self.dataArray.count/4+(self.dataArray.count%4>0?1:0));
//        make.height.equalTo(@(tmpHeight));
        make.bottom.equalTo(self);
    }];
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImg.image = [UIImage imageNamed:@"icon_wanttobuy"];
    }
    return _iconImg;
}

- (UILabel *)lbl
{
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbl.font = [UIFont font14];
        _lbl.text = Lang(@"选择求购红贝数量");
        _lbl.textColor = [UIColor moBlueColor];
    }
    return _lbl;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CGFloat width = (SCREEN_WIDTH-2*leftPadding-(_column-1)*padding)/_column;
        [layout setItemSize:CGSizeMake(width, height)];
        [layout setMinimumInteritemSpacing:padding];
        [layout setMinimumLineSpacing: padding];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[TradeCell class] forCellWithReuseIdentifier:@"TradeCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)config:(UICollectionViewFlowLayout *)layout{
    self.collectionView.collectionViewLayout = layout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TradeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TradeCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    HBLevelModel* model = self.dataArray[indexPath.row];
    NSString* str =  [NSString stringWithFormat:@"%@%@",model.amount,Lang(@"个")];
    if ([model.status isEqualToString:@"1"]) {
          [cell reload:str state:UnableButtonType];
    }else{
        if (indexPath.row == _selectIndex) {
            [cell reload:str state:SelectedButtonType];
        }else{
            [cell reload:str state:NormalButtonType];
        }
    }
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath* path = [NSIndexPath indexPathForRow:_selectIndex inSection:0];
    TradeCell * cell = (TradeCell*)[collectionView cellForItemAtIndexPath:path];
    HBLevelModel* model = self.dataArray[_selectIndex];
     NSString* str =  [NSString stringWithFormat:@"%@%@",model.amount,Lang(@"个")];
    [cell reload:str state:NormalButtonType];
    
    HBLevelModel* model1 = self.dataArray[indexPath.row];
     NSString* str1 =  [NSString stringWithFormat:@"%@%@",model1.amount,Lang(@"个")];
    TradeCell * cell1 = (TradeCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell1 reload:str1 state:SelectedButtonType];
    self.selectIndex = indexPath.row;
    if (self.selectedBlock) {
        self.selectedBlock(self.dataArray[indexPath.row]);
    }
}

//-(void)returnYajin:(id)sender{
////    if ([AppUserModel.depositStatus isEqualToString:@"0"]) {
////        [NotifyHelper showMessageWithMakeText:@"未缴纳押金"];
////        return;
////    }
//    if (self.block) {
//        self.block(nil);
//    }
//}


-(void)configData:(NSArray*)dataArray{
    self.dataArray = dataArray;
    [self.collectionView reloadData];
}

-(NSInteger)getHeight{
    return (height+padding)*(self.dataArray.count/_column+(self.dataArray.count%_column>0?1:0))+3*topPadding+16;
}

@end
