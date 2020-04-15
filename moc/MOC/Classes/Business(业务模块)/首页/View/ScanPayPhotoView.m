//
//  ScanPayPhotoView.m
//  XZF
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ScanPayPhotoView.h"
#import "ScanPayPhotoCell.h"
#import "PhotoBrowser.h"
static NSInteger padding = 15;
static NSInteger width = 140;
static NSInteger height = 90;
static NSString* identifier = @"ScanPayPhotoCell";
@interface ScanPayPhotoView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) UILabel* desc;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray* dataArray;

@property (nonatomic, strong) NSMutableArray* valueArray;



@end
@implementation ScanPayPhotoView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    self.dataArray = @[];
    self.valueArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    [self addSubview:self.desc];
    [self addSubview:self.collectionView];
}

-(void)layout{
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self);
    }];
   
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desc.mas_bottom).offset(25);
        make.bottom.equalTo(self);
        make.left.equalTo(@((SCREEN_WIDTH-2*width)/3));
        make.right.equalTo(@(-(SCREEN_WIDTH-2*width)/3));
        make.centerX.equalTo(self);
    }];
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.textColor = [UIColor moPlaceHolder];
        _desc.font = [UIFont font12];
        _desc.text = @"请按照下面指示拍摄对应的照片，保持上传图片内容清晰可见";
    }
    return _desc;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(width, height+30)];
        [layout setMinimumInteritemSpacing:padding];
        [layout setMinimumLineSpacing:padding];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[ScanPayPhotoCell class] forCellWithReuseIdentifier:@"ScanPayPhotoCell0"];
        [_collectionView registerClass:[ScanPayPhotoCell class] forCellWithReuseIdentifier:@"ScanPayPhotoCell1"];
        [_collectionView registerClass:[ScanPayPhotoCell class] forCellWithReuseIdentifier:@"ScanPayPhotoCell2"];
        [_collectionView registerClass:[ScanPayPhotoCell class] forCellWithReuseIdentifier:@"ScanPayPhotoCell3"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* text = [NSString stringWithFormat:@"%@%d",identifier,indexPath.row];
    ScanPayPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:text forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell reload:self.valueArray[indexPath.row] title:self.dataArray[indexPath.row]];
    cell.block = ^(id data) {
        if (self.block) {
            self.block(indexPath);
        }
    };
    return cell;
}

-(void)configData:(NSArray*)dataArray value:(NSArray*)valueArray{
    self.dataArray = dataArray;
    self.valueArray = valueArray;
    [self.collectionView reloadData];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}
@end
