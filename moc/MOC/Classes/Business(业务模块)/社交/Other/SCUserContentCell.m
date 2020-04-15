//
//  SCUserContentCell.m
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "SCUserContentCell.h"
#import "UIView+SingleLineView.h"
#import "UIButton+WebCache.h"
#import "NSMutableAttributedString+Attributes.h"

@interface SCUserContentCell ()
@property (weak, nonatomic) IBOutlet UIButton *headBnt;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreBnt;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) SocialDetailListModel *curModel;
@end

@implementation SCUserContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headBnt.clipsToBounds = YES;
    self.headBnt.layer.cornerRadius = 20;
    
    self.nameLbl.textColor = [UIColor moBlue];
    self.timeLbl.textColor = [UIColor moTextGray];
    [self.contentView addCellBottomSingleLine:[UIColor moLineLight]];
    
    [self layout];
}

- (void)layout {
    [self.headBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@40);
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headBnt.mas_right).offset(15);
        make.top.equalTo(self.headBnt);
        make.right.equalTo(self.moreBnt.mas_left).offset(-10);
    }];
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
        make.top.equalTo(self.nameLbl.mas_bottom).offset(5);
        make.right.equalTo(self.moreBnt.mas_left).offset(-10);
    }];
    
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl);
        make.top.equalTo(self.contentLbl.mas_bottom).offset(5);
        make.right.equalTo(self.moreBnt.mas_left).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.moreBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.nameLbl.mas_top);
        make.width.height.equalTo(@22);
    }];
}

- (void)configUI:(SocialDetailListModel *)model indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.curModel = model;
    
    self.nameLbl.text = model.user_name;
    self.timeLbl.text = model.cre_date;
    self.moreBnt.tag = indexPath.row;
    [self.headBnt sd_setImageWithURL:[NSURL URLWithString:model.user_head_photo] forState:UIControlStateNormal];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:model.content ?: @""];
    if(model.comment_id > 0) {
        
        att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@：%@",model.comment_user_name ?: @"",model.content ?: @""]];
        [att addFont:[UIFont systemFontOfSize:14] substring:att.string];
        [att addColor:[UIColor blackColor] substring:@"回复"];
        [att addColor:[UIColor moBlue] substring:model.comment_user_name ?: @""];
        [att addColor:[UIColor blackColor] substring:model.content ?: @""];
    }
    self.contentLbl.attributedText = att;
}

- (IBAction)moreBntClick:(UIButton *)sender {
    Block_Exec(self.block,@(self.indexPath.row));
}

- (IBAction)hedBntClick:(UIButton *)sender {
    Block_Exec(self.block,$str(@"%ld",self.curModel.user_id));
}

- (void)hideMoreBnt:(BOOL)hidden {
    self.moreBnt.hidden = hidden;
}

@end
