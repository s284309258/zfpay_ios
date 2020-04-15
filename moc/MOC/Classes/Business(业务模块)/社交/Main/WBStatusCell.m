//
//  WBFeedCell.m
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "WBStatusCell.h"
#import "YYControl.h"
#import "UIView+Utils.h"
#import "SJPlayView.h"
#import <YYKit/YYKitMacro.h>

@implementation WBStatusTitleView
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellTitleHeight;
    }
    self = [super initWithFrame:frame];
    _titleLabel = [YYLabel new];
    _titleLabel.size = CGSizeMake(kScreenWidth - 100, self.height);
    _titleLabel.left = kWBCellPadding;
    _titleLabel.displaysAsynchronously = YES;
    _titleLabel.ignoreCommonProperties = YES;
    _titleLabel.fadeOnHighlight = NO;
    _titleLabel.fadeOnAsynchronouslyDisplay = NO;
    [self addSubview:_titleLabel];
    
    CALayer *line = [CALayer layer];
    line.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    line.bottom = self.height;
    line.backgroundColor = kWBCellLineColor.CGColor;
    [self.layer addSublayer:line];
    self.exclusiveTouch = YES;
    return self;
}
@end


@implementation WBStatusProfileView {
    BOOL _trackingTouch;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    @weakify(self);
    
    _avatarView = [UIImageView new];
    _avatarView.size = CGSizeMake(36, 36);
    _avatarView.origin = CGPointMake(kWBCellLeftPadding, kWBCellTopPadding);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.clipsToBounds = YES;
    _avatarView.layer.cornerRadius = 5;
    _avatarView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self addSubview:_avatarView];
    
#if 0
    CALayer *avatarBorder = [CALayer layer];
    avatarBorder.frame = _avatarView.bounds;
    avatarBorder.borderWidth = CGFloatFromPixel(1);
    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    avatarBorder.cornerRadius = _avatarView.height / 2;
    avatarBorder.shouldRasterize = YES;
    avatarBorder.rasterizationScale = kScreenScale;
    [_avatarView.layer addSublayer:avatarBorder];
#endif
    
//    _avatarBadgeView = [UIImageView new];
//    _avatarBadgeView.size = CGSizeMake(14, 14);
//    _avatarBadgeView.center = CGPointMake(_avatarView.right - 6, _avatarView.bottom - 6);
//    _avatarBadgeView.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:_avatarBadgeView];
    
    _nameLabel = [YYLabel new];
    _nameLabel.size = CGSizeMake(kWBCellNameWidth, 16);
    _nameLabel.left = _avatarView.right + kWBCellNamePaddingLeft;
    _nameLabel.top = kWBCellTopPadding + 2.5;
    _nameLabel.displaysAsynchronously = YES;
    _nameLabel.ignoreCommonProperties = YES;
    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
    _nameLabel.fadeOnHighlight = NO;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:_nameLabel];
    
    _sourceLabel = [YYLabel new];
    _sourceLabel.frame = _nameLabel.frame;
    _sourceLabel.centerY = 47;
    _sourceLabel.displaysAsynchronously = YES;
    _sourceLabel.ignoreCommonProperties = YES;
    _sourceLabel.fadeOnAsynchronouslyDisplay = NO;
    _sourceLabel.fadeOnHighlight = NO;
    _sourceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [self addSubview:_sourceLabel];
    
//    _addressLabel = [YYLabel new];
//    _addressLabel.frame = _nameLabel.frame;
//    _addressLabel.height = 20;
//    _addressLabel.centerY = 25;
//    _addressLabel.displaysAsynchronously = YES;
//    _addressLabel.ignoreCommonProperties = YES;
//    _addressLabel.fadeOnAsynchronouslyDisplay = NO;
//    _addressLabel.fadeOnHighlight = NO;
//    _addressLabel.backgroundColor = UIColorHex(EEF0F1);
//    _addressLabel.clipsToBounds = YES;
//    _addressLabel.textAlignment = NSTextAlignmentCenter;
//    _addressLabel.layer.cornerRadius = 4;
//    [self addSubview:_addressLabel];
    
    return self;
}

- (void)setVerifyType:(WBUserVerifyType)verifyType {
    _verifyType = verifyType;
    switch (verifyType) {
        case WBUserVerifyTypeStandard: {
            _avatarBadgeView.hidden = NO;
            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_vip"];
        } break;
        case WBUserVerifyTypeClub: {
            _avatarBadgeView.hidden = NO;
            _avatarBadgeView.image = [WBStatusHelper imageNamed:@"avatar_grassroot"];
        } break;
        default: {
            _avatarBadgeView.hidden = YES;
        } break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:_avatarView];
    if (CGRectContainsPoint(_avatarView.bounds, p)) {
        _trackingTouch = YES;
    }
    p = [t locationInView:_nameLabel];
    if (CGRectContainsPoint(_nameLabel.bounds, p) && _nameLabel.textLayout.textBoundingRect.size.width > p.x) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesEnded:touches withEvent:event];
    } else {
        if ([_cell.delegate respondsToSelector:@selector(cell:didClickUser:)]) {
            [_cell.delegate cell:_cell didClickUser:_cell.statusView.layout.status.user];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end


@implementation WBStatusCardView {
    BOOL _isRetweet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0){
        frame.size.width = kScreenWidth;
        frame.origin.x = kWBCellPadding;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    _imageView = [UIImageView new];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _badgeImageView = [UIImageView new];
    _badgeImageView.clipsToBounds = YES;
    _badgeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _label = [YYLabel new];
    _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _label.numberOfLines = 3;
    _label.ignoreCommonProperties = YES;
    _label.displaysAsynchronously = YES;
    _label.fadeOnAsynchronouslyDisplay = NO;
    _label.fadeOnHighlight = NO;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    @weakify(self)
    [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        WBStatusCell *cell = self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
            [cell.delegate cellDidClickVideoPlay:cell];
        }
    }];
    
//    _sjPlayView = [SJPlayView new];
//    _sjPlayView.tag = 101;
//    _sjPlayView.hidden = YES;
//    [self addSubview:_sjPlayView];
    
    [self addSubview:_imageView];
    [self addSubview:_badgeImageView];
    [self addSubview:_label];
    //[self addSubview:_sjPlayView];
    [self addSubview:_button];
    self.backgroundColor = [UIColor whiteColor];//kWBCellInnerViewColor;
    //self.layer.borderWidth = CGFloatFromPixel(1);
    //self.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.070].CGColor;
    return self;
}

- (void)setWithLayout:(WBStatusLayout *)layout isRetweet:(BOOL)isRetweet {
    WBPageInfo *pageInfo = isRetweet ? layout.status.retweetedStatus.pageInfo : layout.status.pageInfo;
    if (!pageInfo) return;
    self.height = isRetweet ? layout.retweetCardHeight : layout.cardHeight;
    
    /*
     badge: 25,25 左上角 (42)
     image: 70,70 方形
     100, 70 矩形
     btn:  60,70
     
     lineheight 20
     padding 10
     */
    
    //_sjPlayView.hidden = YES;
    _isRetweet = isRetweet;
    switch (isRetweet ? layout.retweetCardType : layout.cardType) {
        case WBStatusCardTypeNone: {
            
        } break;
        case WBStatusCardTypeNormal: {
            self.width = kWBCellContentWidth;
            if (pageInfo.typeIcon) {
                _badgeImageView.hidden = NO;
                _badgeImageView.frame = CGRectMake(0, 0, 25, 25);
                [_badgeImageView setImageWithURL:pageInfo.typeIcon placeholder:nil];
            } else {
                _badgeImageView.hidden = YES;
            }
            if (pageInfo.pagePic) {
                _imageView.hidden = NO;
                if (pageInfo.typeIcon) {
                    _imageView.frame = CGRectMake(0, 0, 100, 70);
                } else {
                    _imageView.frame = CGRectMake(0, 0, 70, 70);
                }
                [_imageView setImageWithURL:pageInfo.pagePic placeholder:nil];
            } else {
                _imageView.hidden = YES;
            }
            _label.hidden = NO;
            _label.frame = isRetweet ? layout.retweetCardTextRect : layout.cardTextRect;
            _label.textLayout = isRetweet ? layout.retweetCardTextLayout : layout.cardTextLayout;
            WBButtonLink *button = pageInfo.buttons.firstObject;
            if (button.pic && button.name) {
                _button.hidden = NO;
                _button.size = CGSizeMake(60, 70);
                _button.top = 0;
                _button.right = self.width;
                [_button setTitle:button.name forState:UIControlStateNormal];
                [_button setImageWithURL:button.pic forState:UIControlStateNormal placeholder:nil];
            } else {
                _button.hidden = YES;
            }
        }break;
        case WBStatusCardTypeVideo: {
            self.width = self.height;
            _badgeImageView.hidden = YES;
            _label.hidden = YES;
            //_sjPlayView.hidden = NO;
            _imageView.frame = self.bounds;
            //_sjPlayView.frame = self.bounds;
            [_imageView setImageWithURL:pageInfo.pagePic options:kNilOptions];
            _button.hidden = NO;
            _button.frame = self.bounds;
            [_button setTitle:nil forState:UIControlStateNormal];
            [_button cancelImageRequestForState:UIControlStateNormal];
            [_button setImage:[WBStatusHelper imageNamed:@"multimedia_videocard_play"] forState:UIControlStateNormal];
            
        } break;
        default: {
            
        } break;
    }
    
    self.backgroundColor = isRetweet ? [UIColor whiteColor] : kWBCellInnerViewColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = kWBCellInnerViewHighlightColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = _isRetweet ? [UIColor whiteColor] : kWBCellInnerViewColor;
    if ([_cell.delegate respondsToSelector:@selector(cellDidClickCard:)]) {
        [_cell.delegate cellDidClickCard:_cell];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = _isRetweet ? [UIColor whiteColor] : kWBCellInnerViewColor;
}

@end


@implementation WBStatusToolbarView
- (instancetype)initWithFrame:(CGRect)frame type:(ToolbarType)type {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellToolbarHeight;
    }
    
    self = [super initWithFrame:frame];
    self.type = type;
    [self initUI];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellToolbarHeight;
    }
    self = [super initWithFrame:frame];
    [self initUI];
    return self;
}

- (void)initUI {
    self.exclusiveTouch = YES;
    
    CGFloat toolbarBntWidth = 45;
    
    BOOL listType = self.type == ToolbarTypeList;
    
    _timeLabel = [YYLabel new];
    _timeLabel.left = kWBCellPadding;
    _timeLabel.userInteractionEnabled = NO;
    _timeLabel.height = self.height;
    _timeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _timeLabel.displaysAsynchronously = YES;
    _timeLabel.ignoreCommonProperties = YES;
    _timeLabel.fadeOnHighlight = NO;
    _timeLabel.fadeOnAsynchronouslyDisplay = NO;
    _timeLabel.ignoreCommonProperties = NO;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithHexString:@"#A0A0A0"];
    
    _repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _repostButton.exclusiveTouch = YES;
    if(listType) {
        _repostButton.size = CGSizeMake(25/*CGFloatPixelRound(self.width / 3.0)*/, self.height);
        _repostButton.left = _timeLabel.right+10;//self.width - 15;
        [_repostButton setTitle:@"删除" forState:UIControlStateNormal];
        _repostButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_repostButton setTitleColor:[UIColor colorWithHexString:@"#253FD8"] forState:UIControlStateNormal];
        [_repostButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        //[_repostButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    } else {
        _repostButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
        _repostButton.left = CGFloatPixelRound(self.width / 4.0 * 2);
        //[_repostButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    }
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.exclusiveTouch = YES;
    if(listType) {
        _likeButton.size = CGSizeMake(toolbarBntWidth/*CGFloatPixelRound(self.width / 3.0)*/, self.height);
        //_likeButton.right = _repostButton.left-10;//CGFloatPixelRound(self.width / 3.0 * 2.0);
        _likeButton.x = SCREEN_WIDTH - 80;
        [_likeButton setTitle:@"点赞" forState:UIControlStateNormal];
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [_likeButton setTitleColor:[UIColor colorWithHexString:@"#A0A0A0"] forState:UIControlStateNormal];
        [_likeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        //[_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    } else {
        _likeButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
        _likeButton.left = 0;//CGFloatPixelRound(self.width / 3.0 * 2.0);
        //[_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    }
    
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.exclusiveTouch = YES;
    if(listType) {
        _commentButton.size = CGSizeMake(toolbarBntWidth/*CGFloatPixelRound(self.width / 3.0)*/, self.height);
        //_commentButton.right = _likeButton.left - 10;//CGFloatPixelRound(self.width / 3.0);
        _commentButton.x = SCREEN_WIDTH - 180;
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [_commentButton setTitleColor:[UIColor colorWithHexString:@"#A0A0A0"] forState:UIControlStateNormal];
        [_commentButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        //[_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    } else {
        _commentButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
        _commentButton.left = CGFloatPixelRound(self.width / 4.0);
        //[_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    }
    
    
    
    _awardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _awardButton.exclusiveTouch = YES;
    
    if(listType) {
        _awardButton.size = CGSizeMake(toolbarBntWidth/*CGFloatPixelRound(self.width / 3.0)*/, self.height);
        _awardButton.right = self.width - kWBCellPadding;//CGFloatPixelRound(self.width / 3.0 * 2.0);
        //[_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    } else {
        _awardButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
        _awardButton.left = CGFloatPixelRound(self.width / 4.0 * 3.0);
        //[_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    }
    
    
//    _repostImageView = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_retweet"]];
//    _repostImageView.centerY = self.height / 2;
//    [_repostButton addSubview:_repostImageView];
    _commentImageView = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_comment"]];
    _commentImageView.centerY = self.height / 2;
    [_commentButton addSubview:_commentImageView];
    _likeImageView = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"timeline_icon_unlike"]];
    _likeImageView.centerY = self.height / 2;
    [_likeButton addSubview:_likeImageView];
    
    _repostLabel = [YYLabel new];
    _repostLabel.userInteractionEnabled = NO;
    _repostLabel.height = self.height;
    _repostLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _repostLabel.displaysAsynchronously = YES;
    _repostLabel.ignoreCommonProperties = YES;
    _repostLabel.fadeOnHighlight = NO;
    _repostLabel.fadeOnAsynchronouslyDisplay = NO;
    if(!listType) {
        _repostLabel.ignoreCommonProperties = NO;
        _repostLabel.text = @"删除";
        _repostLabel.font = [UIFont systemFontOfSize:14];
        _repostLabel.textColor = [UIColor blackColor];
        [_repostButton addSubview:_repostLabel];
    }
    
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.height = self.height;
    _commentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _commentLabel.displaysAsynchronously = YES;
    _commentLabel.ignoreCommonProperties = YES;
    _commentLabel.fadeOnHighlight = NO;
    _commentLabel.fadeOnAsynchronouslyDisplay = NO;
    if(!listType) {
        _commentLabel.ignoreCommonProperties = NO;
        _commentLabel.text = @"评论";
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = [UIColor blackColor];
        [_commentButton addSubview:_commentLabel];
    }
    
    _likeLabel = [YYLabel new];
    _likeLabel.userInteractionEnabled = NO;
    _likeLabel.height = self.height;
    _likeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _likeLabel.displaysAsynchronously = YES;
    _likeLabel.ignoreCommonProperties = YES;
    _likeLabel.fadeOnHighlight = NO;
    _likeLabel.fadeOnAsynchronouslyDisplay = NO;
    if(!listType) {
        _likeLabel.ignoreCommonProperties = NO;
        _likeLabel.text = @"点赞";
        _likeLabel.font = [UIFont systemFontOfSize:14];
        _likeLabel.textColor = [UIColor blackColor];
        [_likeButton addSubview:_likeLabel];
    }
    
//    _awardLabel = [YYLabel new];
//    _awardLabel.userInteractionEnabled = NO;
//    _awardLabel.height = self.height;
//    _awardLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
//    _awardLabel.displaysAsynchronously = YES;
//    _awardLabel.ignoreCommonProperties = YES;
//    _awardLabel.fadeOnHighlight = NO;
//    _awardLabel.fadeOnAsynchronouslyDisplay = NO;
//    _awardLabel.font = [UIFont systemFontOfSize:14];
//    _awardLabel.textColor = [UIColor blackColor];
//
//    [_awardButton setImage:[UIImage imageNamed:@"朋友圈_打赏"] forState:UIControlStateNormal];
//    [_awardButton setTitle:@" 打赏" forState:UIControlStateNormal];
//    [_awardButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [_awardButton setTitleColor:[UIColor moRed] forState:UIControlStateNormal];
    
    if(!listType) {
        UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
        UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
        
        NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
        NSArray *locations = @[@0.2, @0.5, @0.8];
        
        _line1 = [CAGradientLayer layer];
        _line1.colors = colors;
        _line1.locations = locations;
        _line1.startPoint = CGPointMake(0, 0);
        _line1.endPoint = CGPointMake(0, 1);
        _line1.size = CGSizeMake(CGFloatFromPixel(1), self.height);
        _line1.left = _repostButton.right;
        
        _line2 = [CAGradientLayer layer];
        _line2.colors = colors;
        _line2.locations = locations;
        _line2.startPoint = CGPointMake(0, 0);
        _line2.endPoint = CGPointMake(0, 1);
        _line2.size = CGSizeMake(CGFloatFromPixel(1), self.height);
        _line2.left = _commentButton.right;
        
        _topLine = [CALayer layer];
        _topLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
        _topLine.backgroundColor = kWBCellLineColor.CGColor;
        
        _bottomLine = [CALayer layer];
        _bottomLine.size = _topLine.size;
        _bottomLine.bottom = self.height;
        _bottomLine.backgroundColor = UIColorHex(e8e8e8).CGColor;
    }
    
    [self addSubview:_repostButton];
    [self addSubview:_commentButton];
    [self addSubview:_likeButton];
    [self addSubview:_timeLabel];
//    [self addSubview:_awardLabel];
//    [self addSubview:_awardButton];
    
#if 0
    [self.layer addSublayer:_line1];
    [self.layer addSublayer:_line2];
    [self.layer addSublayer:_topLine];
    [self.layer addSublayer:_bottomLine];
#endif
    
    @weakify(self);
    [_repostButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        WBStatusCell *cell = self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickRepost:)]) {
            [cell.delegate cellDidClickRepost:cell];
        }
    }];
    
    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        WBStatusCell *cell = self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
            [cell.delegate cellDidClickComment:cell];
        }
    }];
    
    [_likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        WBStatusCell *cell = self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
            [cell.delegate cellDidClickLike:cell];
        }
    }];
    
    [_awardButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        WBStatusCell *cell = self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
            [cell.delegate cellDidClickAward:cell];
        }
    }];
}

- (void)setWithLayout:(WBStatusLayout *)layout {
    //如果详情页就不用刷新数据了
#if 0
    if(self.type == ToolbarTypeDetail) {
        _repostLabel.width = layout.toolbarRepostTextWidth;
        _commentLabel.width = layout.toolbarCommentTextWidth;
        _likeLabel.width = layout.toolbarLikeTextWidth;
        
        _repostLabel.textLayout = layout.toolbarRepostTextLayout;
        _commentLabel.textLayout = layout.toolbarCommentTextLayout;
        _likeLabel.textLayout = layout.toolbarLikeTextLayout;
        //_likeButton.x = 60;
        [self adjustImage:_repostImageView label:_repostLabel inButton:_repostButton];
        [self adjustImage:_commentImageView label:_commentLabel inButton:_commentButton];
        [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
        return;
    } else {
        [_repostLabel sizeToFit];
        _repostLabel.height = self.height;
        [_commentLabel sizeToFit];
        _commentLabel.height = self.height;
        [_likeLabel sizeToFit];
        _likeLabel.height = self.height;
    }
#endif
    
    _repostButton.hidden = layout.index.length > 0; //index用于标识人气模块
    
    _awardLabel.textLayout = layout.toolbarAwardTextLayout;
    _awardLabel.width = layout.toolbarAwardTextWidth;
    _awardLabel.height = 20;
    _awardLabel.right = _awardButton.left - 5;
    _awardLabel.centerY = _awardButton.centerY+2;
    
    if(layout.status.user.userID == [AppUserModel.user_id intValue]) {
        _awardLabel.right = self.right-10;
        _awardButton.hidden = YES;
    } else {
        _awardButton.hidden = NO;
    }
    
//    [self adjustImage:_repostImageView label:_repostLabel inButton:_repostButton];
//    [self adjustImage:_commentImageView label:_commentLabel inButton:_commentButton];
//    [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
    
    _likeImageView.image = layout.status.attitudesStatus == 1 ? [self likeImage] : [self unlikeImage];
    
    //NSString *createTime = [WBStatusHelper stringWithTimelineDate:layout.status.createdAt];
    _timeLabel.textLayout = layout.timeTextLayout;
    _timeLabel.width = layout.timeTextLayout.textBoundingSize.width;
    _timeLabel.y = 2.5;
    _timeLabel.height = self.height-2.5;
    
    if(layout.status.user.userID == [AppUserModel.chatUser_id intValue]) {
        _repostButton.left = _timeLabel.right+10;
        _repostButton.hidden = NO;
    } else {
        _repostButton.hidden = YES;
    }
}

- (UIImage *)likeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [WBStatusHelper imageNamed:@"timeline_icon_like"];
    });
    return img;
}

- (UIImage *)unlikeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [WBStatusHelper imageNamed:@"timeline_icon_unlike"];
    });
    return img;
}

- (void)adjustImage:(UIImageView *)image label:(YYLabel *)label inButton:(UIButton *)button {
    CGFloat imageWidth = image.bounds.size.width;
    CGFloat labelWidth = label.width;
    CGFloat paddingMid = 5;
    CGFloat paddingSide = (button.width - imageWidth - labelWidth - paddingMid) / 2.0;
    //image.centerX = CGFloatPixelRound(paddingSide + imageWidth / 2);
    //label.right = CGFloatPixelRound(button.width/* - paddingSide*/);
}

- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation {
    WBStatusLayout *layout = _cell.statusView.layout;
    if (layout.status.attitudesStatus == liked) return;
    
    UIImage *image = liked ? [self likeImage] : [self unlikeImage];
    int newCount = layout.status.attitudesCount;
    //newCount = liked ? newCount + 1 : newCount - 1;
    //if (newCount < 0) newCount = 0;
    //if (liked && newCount < 1) newCount = 1;
    NSString *newCountDesc = newCount > 0 ? [WBStatusHelper shortedNumberDesc:newCount] : @"赞";
    
    UIFont *font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kWBCellToolbarHeight)];
    container.maximumNumberOfRows = 1;
    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] initWithString:newCountDesc];
    likeText.font = font;
    likeText.color = liked ? kWBCellToolbarTitleHighlightColor : kWBCellToolbarTitleColor;
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:likeText];
    
    layout.status.attitudesStatus = liked;
    layout.status.attitudesCount = newCount;
    layout.toolbarLikeTextLayout = textLayout;
    
    _likeImageView.image = image;
    
    if (!animation) {
        
        //_likeLabel.width = CGFloatPixelRound(textLayout.textBoundingRect.size.width);
        //_likeLabel.textLayout = layout.toolbarLikeTextLayout;
        //[self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
        return;
    }
    
    if(liked) {
        [_likeImageView like];
    } else {
        [_likeImageView shake];
    }
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//        _likeImageView.layer.transformScale = 1.7;
//    } completion:^(BOOL finished) {
//
//        _likeImageView.image = image;
//        _likeLabel.width = CGFloatPixelRound(textLayout.textBoundingRect.size.width);
//        _likeLabel.textLayout = layout.toolbarLikeTextLayout;
//        [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
//
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//            _likeImageView.layer.transformScale = 0.9;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//                _likeImageView.layer.transformScale = 1;
//            } completion:^(BOOL finished) {
//            }];
//        }];
//    }];
}

//仿网易圈圈点赞动画效果
- (void)like:(UIImage *)likeIcon {
    _likeImageView.image = likeIcon;
    [_likeImageView like];
}

//仿网易圈圈取消点赞动画效果
- (void)unLike {
    
}
@end


@implementation WBStatusTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    @weakify(self);
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageWithColor:kWBCellBackgroundColor] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.000 alpha:0.200]] forState:UIControlStateHighlighted];
    [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cellDidClickTag:)]) {
            [self.cell.delegate cellDidClickTag:self.cell];
        }
    }];
    _button.hidden = YES;
    [self addSubview:_button];
    
    _label = [YYLabel new];
    _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _label.displaysAsynchronously = YES;
    _label.ignoreCommonProperties = YES;
    _label.fadeOnHighlight = NO;
    _label.fadeOnAsynchronouslyDisplay = NO;
    _label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [self addSubview:_label];
    
    _imageView = [UIImageView new];
    _imageView.size = CGSizeMake(kWBCellTagPlaceHeight, kWBCellTagPlaceHeight);
    _imageView.image = [WBStatusHelper imageNamed:@"timeline_icon_locate"];
    _imageView.hidden = YES;
    [self addSubview:_imageView];
    
    _label.height = kWBCellTagPlaceHeight;
    _button.height = kWBCellTagPlaceHeight;
    self.height = kWBCellTagPlaceHeight;
    return self;
}

- (void)setWithLayout:(WBStatusLayout *)layout {
    if (layout.tagType == WBStatusTagTypePlace) {
        _label.height = kWBCellTagPlaceHeight;
        _imageView.hidden = NO;
        _button.hidden = NO;
        
        _label.left = _imageView.right + 6;
        _label.width = layout.tagTextLayout.textBoundingRect.size.width + 6;
        _label.textLayout = layout.tagTextLayout;
        _label.userInteractionEnabled = NO;
        
        self.width = _label.right;
        _label.width = self.width;
        _button.width = self.width;
    } else if (layout.tagType == WBStatusTagTypeNormal) {
        _imageView.hidden = YES;
        _button.hidden = YES;
        
        _label.left = 0;
        _label.width = layout.tagTextLayout.textBoundingRect.size.width + 1;
        _label.userInteractionEnabled = YES;
        _label.textLayout = layout.tagTextLayout;
    }
}

@end

@implementation WBStatusCommentView {
    
}
- (instancetype)initWithFrame:(CGRect)frame {
//    if (frame.size.width == 0 && frame.size.height == 0) {
//        frame.size.width = kScreenWidth;
//        frame.size.height = 1;
//    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.exclusiveTouch = YES;
    @weakify(self);
    
    _commentLabel = [YYLabel new];
    //_commentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _commentLabel.numberOfLines = 0;
    _commentLabel.displaysAsynchronously = YES;
    _commentLabel.ignoreCommonProperties = YES;
    _commentLabel.fadeOnAsynchronouslyDisplay = NO;
    _commentLabel.fadeOnHighlight = NO;
    _commentLabel.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    _commentLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [self addSubview:_commentLabel];
    return self;
}

- (void)setWithLayout:(WBStatusLayout *)layout {
    _commentLabel.frame = CGRectMake(10, 0, self.bounds.size.width-20, self.bounds.size.height);//CGRectInset(self.bounds, 10, 10);
    _commentLabel.textLayout = layout.commentTextLayout;
}

@end

@implementation WBStatusView {
    BOOL _touchRetweetView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    @weakify(self);
    
    _contentView = [UIView new];
    _contentView.width = kScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
    static UIImage *topLineBG, *bottomLineBG;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
            CGContextFillPath(context);
        }];
        bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
            CGContextFillPath(context);
        }];
    });
    UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
    topLine.width = _contentView.width;
    topLine.bottom = 0;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_contentView addSubview:topLine];
    
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
    bottomLine.width = _contentView.width;
    bottomLine.top = _contentView.height;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:bottomLine];
    [self addSubview:_contentView];
    
    _titleView = [WBStatusTitleView new];
    _titleView.hidden = YES;
    [_contentView addSubview:_titleView];
    
    _profileView = [WBStatusProfileView new];
    [_contentView addSubview:_profileView];
    
    _vipBackgroundView = [UIImageView new];
    _vipBackgroundView.size = CGSizeMake(kScreenWidth, 14.0);
    _vipBackgroundView.top = -2;
    _vipBackgroundView.contentMode = UIViewContentModeTopRight;
    [_contentView addSubview:_vipBackgroundView];
    
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.size = CGSizeMake(30, 30);
    [_menuButton setImage:[WBStatusHelper imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [_menuButton setImage:[WBStatusHelper imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    _menuButton.centerX = self.width - 20;
    _menuButton.centerY = 18;
    [_menuButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cellDidClickMenu:)]) {
            [self.cell.delegate cellDidClickMenu:self.cell];
        }
    }];
    [_contentView addSubview:_menuButton];
    
    _rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rankButton.size = CGSizeMake(31.5, 33);
    [_rankButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rankButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _rankButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    //[_rankButton setTitle:@"" forState:UIControlStateNormal];
    [_rankButton setBackgroundImage:[WBStatusHelper imageNamed:@"TopRankImage"] forState:UIControlStateNormal];
    _rankButton.right = _menuButton.left - 20;
    _rankButton.top = 0;
    //_rankButton.hidden = YES;
    [_contentView addSubview:_rankButton];
    
    _retweetBackgroundView = [UIView new];
    _retweetBackgroundView.backgroundColor = [UIColor whiteColor];//kWBCellInnerViewColor;
    _retweetBackgroundView.width = kWBCellContentWidth + 10;
    _retweetBackgroundView.left = kWBCellPadding-5;
    [_contentView addSubview:_retweetBackgroundView];
    
    _textLabel = [YYLabel new];
    _textLabel.left = kWBCellPadding;
    _textLabel.width = kWBCellContentWidth;
    _textLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _textLabel.displaysAsynchronously = YES;
    _textLabel.ignoreCommonProperties = YES;
    _textLabel.fadeOnAsynchronouslyDisplay = NO;
    _textLabel.fadeOnHighlight = NO;
//    _textLabel.highlightLongPressAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        @strongify(self)
//        if ([self.cell.delegate respondsToSelector:@selector(cell:didLongPressInLabel:textRange:)]) {
//            [self.cell.delegate cell:self.cell didLongPressInLabel:(YYLabel *)containerView textRange:range];
//        }
//    };
    [_contentView addSubview:_textLabel];
    
    UILongPressGestureRecognizer *longPressGuesture = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cell:didLongPressInLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didLongPressInLabel:self.cell.statusView.textLabel textRange:NSMakeRange(0, 0)];
        }
    }];
    [_textLabel addGestureRecognizer:longPressGuesture];
    
    _retweetTextLabel = [YYLabel new];
    _retweetTextLabel.left = kWBCellPadding;
    _retweetTextLabel.width = kWBCellContentWidth;
    _retweetTextLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _retweetTextLabel.displaysAsynchronously = YES;
    _retweetTextLabel.ignoreCommonProperties = YES;
    _retweetTextLabel.fadeOnAsynchronouslyDisplay = NO;
    _retweetTextLabel.fadeOnHighlight = NO;
    _retweetTextLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if ([self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [_contentView addSubview:_retweetTextLabel];
    
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        YYControl *imageView = [YYControl new];
        imageView.size = CGSizeMake(100, 100);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = kWBCellHighlightColor;
        imageView.exclusiveTouch = YES;
        imageView.touchBlock = ^(YYControl *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event) {
            @strongify(self)
            if (![self.cell.delegate respondsToSelector:@selector(cell:didClickImageAtIndex:)]) return;
            if (state == YYGestureRecognizerStateEnded) {
                UITouch *touch = touches.anyObject;
                CGPoint p = [touch locationInView:view];
                if (CGRectContainsPoint(view.bounds, p)) {
                    [self.cell.delegate cell:self.cell didClickImageAtIndex:i];
                }
            }
        };
        
        UIView *badge = [UIImageView new];
        badge.userInteractionEnabled = NO;
        badge.contentMode = UIViewContentModeScaleAspectFit;
        badge.size = CGSizeMake(68 / 2, 30 / 2);
        badge.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        badge.right = imageView.width-5;
        badge.bottom = imageView.height-5;
        badge.hidden = YES;
        [imageView addSubview:badge];
        
        [picViews addObject:imageView];
        [_contentView addSubview:imageView];
    }
    _picViews = picViews;
    
//    _sjPlayView = [SJPlayView new];
//    _sjPlayView.tag = 101;
//    _sjPlayView.hidden = YES;
//    [_contentView addSubview:_sjPlayView];
    
    _cardView = [WBStatusCardView new];
    _cardView.hidden = YES;
    [_contentView addSubview:_cardView];
    
    _tagView = [WBStatusTagView new];
    _tagView.left = kWBCellPadding;
    _tagView.hidden = YES;
    [_contentView addSubview:_tagView];
    
    _toolbarView = [WBStatusToolbarView new];
    [_contentView addSubview:_toolbarView];
    
    //评论
    _commentView = [WBStatusCommentView new];
    _commentView.left = kWBCellPadding;
    _commentView.hidden = YES;
    _commentView.width = kWBCellContentWidth;
    [_contentView addSubview:_commentView];

    return self;
}


- (void)setLayout:(WBStatusLayout *)layout {
    _layout = layout;
    
    self.height = layout.height;
    _contentView.top = layout.marginTop;
    _contentView.height = layout.height - layout.marginTop - layout.marginBottom;
    
    if(layout.index.length > 0) {
        [_rankButton setTitle:layout.index forState:UIControlStateNormal];
    } else {
        [_rankButton removeFromSuperview];
    }
    
    CGFloat top = 0;
    if (layout.titleHeight > 0) {
        _titleView.hidden = NO;
        _titleView.height = layout.titleHeight;
        _titleView.titleLabel.textLayout = layout.titleTextLayout;
        top = layout.titleHeight;
    } else {
        _titleView.hidden = YES;
    }
    
    /// 圆角头像
    [_profileView.avatarView setImageWithURL:layout.status.user.avatarLarge //profileImageURL
                                 placeholder:nil
                                     options:kNilOptions
                                     manager:nil//[WBStatusHelper avatarImageManager] //< 圆角头像manager，内置圆角处理
                                    progress:nil
                                   transform:nil
                                  completion:nil];

    _profileView.nameLabel.textLayout = layout.nameTextLayout;
    
    if(layout.addressTextLayout) {
        _profileView.addressLabel.hidden = NO;
        _profileView.addressLabel.attributedText = layout.addressTextLayout.text;
        _profileView.addressLabel.centerY = _profileView.nameLabel.centerY;
        _profileView.addressLabel.left = _profileView.nameLabel.left + layout.nameTextLayout.textBoundingSize.width + 15;
        CGFloat addrW = layout.addressTextLayout.textBoundingSize.width;
        CGFloat addrMaxW = self.menuButton.left - _profileView.addressLabel.left - 15;
        if(addrW > addrMaxW) {
            _profileView.addressLabel.width = addrMaxW;
        } else {
            _profileView.addressLabel.width = addrW+5;
        }
        
        //_profileView.addressLabel.textAlignment = NSTextAlignmentCenter;
        
    } else {
        _profileView.addressLabel.hidden = YES;
    }
    
    _profileView.sourceLabel.textLayout = layout.sourceTextLayout;
    _profileView.verifyType = layout.status.user.userVerifyType;
    _profileView.height = layout.profileHeight;
    _profileView.top = top;
    top += layout.profileHeight-28; //正文内容向上调整位置

    NSURL *picBg = [WBStatusHelper defaultURLForImageURL:layout.status.picBg];
    __weak typeof(_vipBackgroundView) vipBackgroundView = _vipBackgroundView;
    [_vipBackgroundView setImageWithURL:picBg placeholder:nil options:YYWebImageOptionAvoidSetImage completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (image) {
            image = [UIImage imageWithCGImage:image.CGImage scale:2.0 orientation:image.imageOrientation];
            vipBackgroundView.image = image;
        }
    }];
    
    _textLabel.top = top;
    _textLabel.height = layout.textHeight;
    _textLabel.textLayout = layout.textLayout;
    top += layout.textHeight;
    
    _retweetBackgroundView.hidden = YES;
    _retweetTextLabel.hidden = YES;
    _cardView.hidden = YES;
    if (layout.picHeight == 0 && layout.retweetPicHeight == 0) {
        [self _hideImageViews];
    }
    
    
    //优先级是 转发->图片->卡片
    if (layout.retweetHeight > 0) {
        _retweetBackgroundView.top = top;
        _retweetBackgroundView.height = layout.retweetHeight;
        _retweetBackgroundView.hidden = NO;
        
        _retweetTextLabel.top = top;
        _retweetTextLabel.height = layout.retweetTextHeight;
        _retweetTextLabel.textLayout = layout.retweetTextLayout;
        _retweetTextLabel.hidden = NO;
        
        if (layout.retweetPicHeight > 0) {
            [self _setImageViewWithTop:_retweetTextLabel.bottom+(layout.retweetTextHeight > 0 ? 0 : 5) isRetweet:YES];
        } else {
            [self _hideImageViews];
            if (layout.retweetCardHeight > 0) {
                _cardView.top = _retweetTextLabel.bottom+(layout.retweetTextHeight > 0 ? 0 : 5);
                _cardView.hidden = NO;
                [_cardView setWithLayout:layout isRetweet:YES];
            }
        }
    } else if (layout.picHeight > 0) {
        [self _setImageViewWithTop:top isRetweet:NO];
    } else if (layout.cardHeight > 0) {
        _cardView.top = top;
        _cardView.hidden = NO;
        [_cardView setWithLayout:layout isRetweet:NO];
    }
    
    if (layout.tagHeight > 0) {
        _tagView.hidden = NO;
        [_tagView setWithLayout:layout];
        _tagView.centerY = _contentView.height - kWBCellToolbarHeight - layout.tagHeight / 2;
    } else {
        _tagView.hidden = YES;
    }
    
    _toolbarView.top = top+layout.picHeight+layout.retweetHeight+layout.cardHeight+layout.tagHeight;
    [_toolbarView setWithLayout:layout];
    
    //设置评论内容
    _commentView.hidden = NO;
    _commentView.top = _toolbarView.bottom;
    _commentView.height = layout.commentTextHeight;
    
    [_commentView setWithLayout:layout];
    
}

- (void)_hideImageViews {
    for (UIImageView *imageView in _picViews) {
        imageView.hidden = YES;
    }
}

- (void)_setImageViewWithTop:(CGFloat)imageTop isRetweet:(BOOL)isRetweet {
    CGSize picSize = isRetweet ? _layout.retweetPicSize : _layout.picSize;
    NSArray *pics = isRetweet ? _layout.status.retweetedStatus.pics : _layout.status.pics;
    int picsCount = (int)pics.count;
    
    CGFloat valideWidth3 = kWBCellContentWidth-kWBCellPadding+kWBCellRightPadding; //两张照片以上
    
    CGFloat len1_2 = (valideWidth3 - kWBCellPaddingPic)/2;
    CGFloat len1_3 = (valideWidth3 - kWBCellPaddingPic*2) / 3;
    len1_3 = CGFloatPixelRound(len1_3);
    
    for (int i = 0; i < 9; i++) {
        UIView *imageView = _picViews[i];
        if (i >= picsCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = kWBCellPadding;
                    origin.y = imageTop;
                    imageView.frame = (CGRect){.origin = origin, .size = picSize};
                } break;
                case 4: {
                    origin.x = kWBCellPadding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                    imageView.frame = (CGRect){.origin = origin, .size = picSize};
                } break;
                case 5: {
                    if(i < 2) {
                        origin.x = kWBCellPadding + i * (len1_2 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth - kWBCellPaddingPic)/2;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_2, picSize.height)};
                    } else if(i < 4) {
                        origin.x = kWBCellPadding + (i % 2) * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    } else {
                        origin.x = kWBCellPadding + 2 * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    }
                } break;
                case 7: {
                    if(i < 2) {
                        origin.x = kWBCellPadding + i * (len1_2 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth - kWBCellPaddingPic)/2;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_2, picSize.height)};
                    } else if(i < 4) {
                        origin.x = kWBCellPadding + (i % 2) * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    } else if(i == 4) {
                        origin.x = kWBCellPadding + 2 * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    } else {
                        origin.x = kWBCellPadding + (i-5) * (len1_2 + kWBCellPaddingPic);
                        origin.y = imageTop + 2 * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth - kWBCellPaddingPic)/2;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_2, picSize.height)};
                    }
                } break;
                case 8: {
                    if(i < 2) {
                        origin.x = kWBCellPadding + i * (len1_2 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth - kWBCellPaddingPic)/2;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_2, picSize.height)};
                    } else if(i < 4) {
                        origin.x = kWBCellPadding + (i % 2) * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    } else if(i == 4) {
                        origin.x = kWBCellPadding + 2 * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    } else {
                        origin.x = kWBCellPadding + (i-5) * (len1_3 + kWBCellPaddingPic);
                        origin.y = imageTop + 2 * (picSize.height + kWBCellPaddingPic);
                        //CGFloat width = (kWBCellContentWidth - kWBCellPaddingPic)/2;
                        imageView.frame = (CGRect){.origin = origin, .size = CGSizeMake(len1_3, picSize.height)};
                    }
                }
                break;
                default: {
                    origin.x = kWBCellPadding + (i % 3) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                    imageView.frame = (CGRect){.origin = origin, .size = picSize};
                } break;
            }
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            WBPicture *pic = pics[i];
            
            UIView *badge = imageView.subviews.firstObject;
            switch (pic.largest.badgeType) {
                case WBPictureBadgeTypeNone: {
                    if (badge.layer.contents) {
                        badge.layer.contents = nil;
                        badge.hidden = YES;
                    }
                } break;
                case WBPictureBadgeTypeLong: {
                    badge.layer.contents = (__bridge id)([WBStatusHelper imageNamed:@"timeline_image_longimage"].CGImage);
                    badge.hidden = NO;
                } break;
                case WBPictureBadgeTypeGIF: {
                    badge.layer.contents = (__bridge id)([WBStatusHelper imageNamed:@"timeline_image_gif"].CGImage);
                    badge.hidden = NO;
                } break;
            }
            
            @weakify(imageView);
            [imageView.layer setImageWithURL:pic.bmiddle.url
                                 placeholder:nil
                                     options:YYWebImageOptionAvoidSetImage
                                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                @strongify(imageView);
                if (!imageView) return;
                if (image && stage == YYWebImageStageFinished) {
                    int width = image.size.width;//pic.bmiddle.width;
                    int height = image.size.height;//pic.bmiddle.height;
                    CGFloat scale = (height / width) / (imageView.height / imageView.width);
                    if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                        imageView.contentMode = UIViewContentModeScaleAspectFill;
                        imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                    } else { // 高图只保留中间部分,CGRectMake(0, 0, 1, (float)width / height); ---保留顶部
                        imageView.contentMode = UIViewContentModeScaleAspectFill;
                        imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                        //CGFloat ratio = (float)width / height;
                        //imageView.layer.contentsRect = CGRectMake(0, (1-ratio > 0 ? (1-ratio)/2 : 0), 1, ratio);//CGRectMake(0, 0, 1, (float)width / height);
                    }
                    ((YYControl *)imageView).image = image;
                    if (from != YYWebImageFromMemoryCacheFast) {
                        CATransition *transition = [CATransition animation];
                        transition.duration = 0.15;
                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                        transition.type = kCATransitionFade;
                        [imageView.layer addAnimation:transition forKey:@"contents"];
                    }
                }
            }];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:_retweetBackgroundView];
    BOOL insideRetweet = CGRectContainsPoint(_retweetBackgroundView.bounds, p);
    
    if (!_retweetBackgroundView.hidden && insideRetweet) {
        [(_retweetBackgroundView) performSelector:@selector(setBackgroundColor:) withObject:kWBCellHighlightColor afterDelay:0.15];
        _touchRetweetView = YES;
    } else {
        [(_contentView) performSelector:@selector(setBackgroundColor:) withObject:kWBCellHighlightColor afterDelay:0.15];
        _touchRetweetView = NO;
    }
    
    //[super touchesBegan:touches withEvent:event];
//    p = [touch locationInView:_commentView.commentLabel];
//    if (CGRectContainsPoint(_commentView.bounds, p) && _commentView.commentLabel.textLayout.textBoundingRect.size.width > p.x) {
//        _touchRetweetView = YES;
//    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesRestoreBackgroundColor];
    if (_touchRetweetView) {
        if ([_cell.delegate respondsToSelector:@selector(cellDidClickRetweet:)]) {
            [_cell.delegate cellDidClickRetweet:_cell];
        }
    } else {
        if ([_cell.delegate respondsToSelector:@selector(cellDidClick:)]) {
            [_cell.delegate cellDidClick:_cell];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesRestoreBackgroundColor];
}

- (void)touchesRestoreBackgroundColor {
    [NSObject cancelPreviousPerformRequestsWithTarget:_retweetBackgroundView selector:@selector(setBackgroundColor:) object:kWBCellHighlightColor];
    [NSObject cancelPreviousPerformRequestsWithTarget:_contentView selector:@selector(setBackgroundColor:) object:kWBCellHighlightColor];
    
    _contentView.backgroundColor = [UIColor whiteColor];
    _retweetBackgroundView.backgroundColor = [UIColor whiteColor];//kWBCellInnerViewColor;
}

@end






@implementation WBStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _statusView = [WBStatusView new];
    _statusView.cell = self;
    _statusView.titleView.cell = self;
    _statusView.profileView.cell = self;
    _statusView.cardView.cell = self;
    _statusView.toolbarView.cell = self;
    _statusView.tagView.cell = self;
    _statusView.commentView.cell = self;
    self.contentView.backgroundColor = BackGroundColor; //此颜色决定背景10像素的间隙颜色
    [self.contentView addSubview:_statusView];
    return self;
}

- (void)prepareForReuse {
    // ignore
}

- (void)setLayout:(WBStatusLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _statusView.layout = layout;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
