//
//  ChatSettingHeader.m
//  Lcwl
//
//  Created by mac on 2018/12/1.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "TradeHBItemView.h"
#import "TradeCell.h"
#import "MXSeparatorLine.h"
#import "HBLevelModel.h"
static NSInteger topPadding = 10;
static NSInteger padding = 10;
static NSInteger height = 30;
static NSInteger leftPadding = 15;
@interface  TradeHBItemView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray* dataArray;

@property (nonatomic) NSIndexPath  *selectIndex;

@property (nonatomic) NSInteger  column;

@end

@implementation TradeHBItemView

- (instancetype)initWithFrame:(CGRect)frame column:(NSInteger) column{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.column = column;
        self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.collectionView];
    [self layoutsubviews];
}

-(void)layoutsubviews{
    @weakify(self)
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
}

// 要先设置表头大小
//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
//    return size;
//}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 200);
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TradeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TradeCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    NSString* text = self.dataArray[indexPath.row];
//    [cell reload:text state:NormalButtonType];
//    HBLevelModel* model = self.dataArray[indexPath.section][indexPath.row];
//    NSString* str =  [NSString stringWithFormat:@"%@",model.amount];
//    if ([model.status isEqualToString:@"1"]) {
//        [cell reload:str state:UnableButtonType];
//    }else{
        if (indexPath.section == _selectIndex.section && indexPath.row == _selectIndex.row) {
            [cell reload:text state:SelectedButtonType];
        }else{
            [cell reload:text state:NormalButtonType];
        }
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath* path = _selectIndex;
    TradeCell * cell = (TradeCell*)[collectionView cellForItemAtIndexPath:path];
    NSString* str = self.dataArray[_selectIndex.row];
    [cell reload:str state:NormalButtonType];
    
    NSString* str1 =  self.dataArray[indexPath.row];
    TradeCell * cell1 = (TradeCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell1 reload:str1 state:SelectedButtonType];
    self.selectIndex = indexPath;
    if (self.selectedBlock) {
        self.selectedBlock(self.dataArray[indexPath.row]);
    }
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

-(void)configData:(NSArray*)dataArray{
    self.dataArray = dataArray;
    [self.collectionView reloadData];
    return;
    NSMutableArray* tmpArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i=0; i<3; i++) {
        [tmpArray addObject:[[NSMutableArray alloc]initWithCapacity:10]];
    }
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HBLevelModel* model = (HBLevelModel*)obj;
        NSMutableArray* tmp = nil;
        if ([model.level isEqualToString:@"1"]) {
           tmp = tmpArray[0];
        }else if([model.level isEqualToString:@"2"]) {
            tmp = tmpArray[1];
        }else if([model.level isEqualToString:@"3"]) {
            tmp = tmpArray[2];
        }
//        else if([model.level isEqualToString:@"3"]) {
//            tmp = tmpArray[3];
//        }else if([model.level isEqualToString:@"4"]) {
//            tmp = tmpArray[4];
//        }
        [tmp addObject:model];
    }];
    self.dataArray = tmpArray;
    [self.collectionView reloadData];
}

-(NSInteger)getHeight{
    __block int tmpHeight = 0;
    __block int outHeight = height;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* tmpArray = (NSArray*)obj;
        tmpHeight+=(tmpArray.count/_column*outHeight+(tmpArray.count/_column-1)*padding);
        tmpHeight+=(tmpArray.count%_column>0?(padding+outHeight):0);
        tmpHeight+=44;
    }];
    return tmpHeight+16+topPadding+20;
}

@end
