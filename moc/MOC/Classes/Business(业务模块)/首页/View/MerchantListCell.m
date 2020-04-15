//
//  FenRunDetailCell.m
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "MerchantListCell.h"
static NSInteger padding = 15;
static NSInteger height = 24;
@interface MerchantListCell()

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *desc;

@property (nonatomic, strong) UILabel *mTitle;

@property (nonatomic, strong) UILabel *mDesc;

@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation MerchantListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self layout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.mTitle];
    [self addSubview:self.mDesc];
    [self addSubview:self.editBtn];
}

-(void)layout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.left.top.equalTo(self).offset(padding);
        make.bottom.equalTo(self).offset(-padding);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.title);
        make.right.equalTo(@(-padding));
        make.bottom.equalTo(self.title);
    }];

}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor moPlaceHolder];
        [_title setFont:[UIFont font14]];
        _title.numberOfLines = 0;
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.textColor = [UIColor moBlack];
        [_desc setFont:[UIFont font14]];
        _desc.numberOfLines = 0;
    }
    return _desc;
}

-(UILabel*)mTitle{
    if (!_mTitle) {
        _mTitle = [UILabel new];
        _mTitle.textColor = [UIColor moPlaceHolder];
        [_mTitle setFont:[UIFont font14]];
        _mTitle.numberOfLines = 0;
    }
    return _mTitle;
}

-(UILabel*)mDesc{
    if (!_mDesc) {
        _mDesc = [UILabel new];
        _mDesc.textColor = [UIColor moBlack];
        [_mDesc setFont:[UIFont font14]];
        _mDesc.numberOfLines = 0;
    }
    return _mDesc;
}

-(UIButton*)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@"编辑_商家"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(void)edit:(id)sender{
    !self.nameAndTel?:self.nameAndTel();
}

-(void)reload:(NSString* )title desc:(NSString* )desc {
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.width.equalTo(self.mas_width).multipliedBy(0.5);
          make.centerY.equalTo(self);
          make.left.equalTo(self).offset(padding);
      }];
      [self.desc mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.width.equalTo(self.mas_width).multipliedBy(0.5);
           make.centerY.equalTo(self);
          make.right.equalTo(self).offset(-padding);
      }];
    NSMutableAttributedString* attrTitle = [[NSMutableAttributedString alloc]initWithString:title];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [attrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrTitle.length)];
    self.title.attributedText = attrTitle;
    
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    NSMutableAttributedString* attrDesc = [[NSMutableAttributedString alloc]initWithString:desc];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    [attrDesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrDesc.length)];
    self.desc.attributedText = attrDesc;
    
    self.mTitle.hidden = YES;
    self.mDesc.hidden = YES;
    self.editBtn.hidden = YES;
}

-(void)reload:(NSString* )title desc:(NSString* )desc mTitle:(NSString*)mTitle mDesc:(NSString*)mDesc{
    [self resetLayout];
    NSMutableAttributedString* attrTitle = [[NSMutableAttributedString alloc]initWithString:title];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [attrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrTitle.length)];
    self.title.attributedText = attrTitle;
    
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    NSMutableAttributedString* attrDesc = [[NSMutableAttributedString alloc]initWithString:desc];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    [attrDesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrDesc.length)];
    self.desc.attributedText = attrDesc;
    
    attrTitle = [[NSMutableAttributedString alloc]initWithString:mTitle];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [attrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrTitle.length)];
    self.mTitle.attributedText = attrTitle;
    
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    attrDesc = [[NSMutableAttributedString alloc]initWithString:mDesc];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    [attrDesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrDesc.length)];
    self.mDesc.attributedText = attrDesc;
    
    
}


-(void)resetLayout{
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.left.top.equalTo(self).offset(padding);
    }];
    [self.mTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.title);
        make.top.equalTo(self.title.mas_bottom);
        make.left.equalTo(self.title);
        make.bottom.equalTo(self).offset(-padding);
    }];
    [self.mDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.mTitle);
        make.right.equalTo(self).offset(-padding-40);
        make.bottom.equalTo(self.mTitle);
    }];
    [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mDesc);
    }];
}
@end
