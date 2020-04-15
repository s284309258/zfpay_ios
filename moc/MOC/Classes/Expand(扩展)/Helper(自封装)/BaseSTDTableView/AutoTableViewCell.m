//
//  AutoTableViewCell.m
//  BOB
//
//  Created by mac on 2019/7/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AutoTableViewCell.h"

@implementation AutoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
}

- (void)setupCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
        withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority
              verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    CGSize size = [super systemLayoutSizeFittingSize:targetSize
                       withHorizontalFittingPriority:horizontalFittingPriority
                             verticalFittingPriority:verticalFittingPriority];
    CGFloat detailHeight = CGRectGetHeight(self.detailTextLabel.frame);
    if (detailHeight) { // if no detailTextLabel (or UITableViewCellStyleDefault) then no adjustment necessary
        // Determine UITableViewCellStyle by looking at textLabel vs detailTextLabel layout
        if (CGRectGetMinX(self.detailTextLabel.frame) > CGRectGetMinX(self.textLabel.frame)) {
            // detailTextLabel right of textLabel means UITableViewCellStyleValue1 or UITableViewCellStyleValue2
            if (CGRectGetHeight(self.detailTextLabel.frame) > CGRectGetHeight(self.textLabel.frame)) {
                // If detailTextLabel is taller than textLabel then add difference to cell height
                size.height += CGRectGetHeight(self.detailTextLabel.frame) - CGRectGetHeight(self.textLabel.frame);
            }
        } else {
            // Otherwise UITableViewCellStyleSubtitle, in which case add detailTextLabel height to cell height
            size.height += CGRectGetHeight(self.detailTextLabel.frame);
        }
    }
    return size;
}

- (void)loadContent {
    BaseSTDCellModel *model = (BaseSTDCellModel *)self.data;
    self.textLabel.numberOfLines = model.textNumberOfLines;
    self.textLabel.font = model.textFont ?: self.textLabel.font;
    self.textLabel.textColor = model.textColor ?: self.textLabel.textColor;
    if([model.text isKindOfClass:[NSString class]]) {
        self.textLabel.text = model.text;
        self.textLabel.textColor = model.textColor ?: [UIColor blackColor];
    } else if([model.text isKindOfClass:[NSMutableAttributedString class]]) {
        self.textLabel.attributedText = model.text;
    }

    self.detailTextLabel.numberOfLines = model.detailTextNumberOfLines;
    self.detailTextLabel.font = model.detailTextFont ?: self.detailTextLabel.font;
    self.detailTextLabel.textColor = model.detailTextColor ?: self.detailTextLabel.textColor;
    if([model.detailText isKindOfClass:[NSString class]]) {
        self.detailTextLabel.text = model.detailText;
        self.detailTextLabel.textColor = model.textColor ?: [UIColor blackColor];
    } else if([model.detailText isKindOfClass:[NSMutableAttributedString class]]) {
        self.detailTextLabel.attributedText = model.detailText;
    }
    
}

@end
