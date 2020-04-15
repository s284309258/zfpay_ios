//
//  YYLabel+YYLabel_Ext.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/21.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "YYLabel+YYLabel_Ext.h"
#import <YYKit/YYKit.h>

@implementation YYLabel (YYLabel_Ext)
- (void)configStyleBottomSubtitle:(NSString *)title subTitle:(NSString *)subTitle  preferredMaxWidth:(CGFloat)width {
    NSString *content = [StringUtil isEmpty:subTitle] ? title : [NSString stringWithFormat:@"%@\n%@",title,subTitle];
    NSMutableAttributedString *titleInfo = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSRange range = [content rangeOfString:title];
    if(range.location != NSNotFound) {
        [titleInfo setFont:[UIFont systemFontOfSize:14] range:range];
        [titleInfo setColor:[UIColor blackColor] range:range];
    }
    
    range = [content rangeOfString:subTitle];
    if(range.location != NSNotFound) {
        [titleInfo setFont:[UIFont systemFontOfSize:12] range:range];
        [titleInfo setColor:[UIColor moTextGray] range:range];
    }
    
    titleInfo.lineSpacing = 4;
    self.numberOfLines = 0;
    self.preferredMaxLayoutWidth = width;
    self.backgroundColor = [UIColor whiteColor];
    self.attributedText = titleInfo;
}
@end
