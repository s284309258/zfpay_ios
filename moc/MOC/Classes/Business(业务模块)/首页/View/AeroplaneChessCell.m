//
//  AeroplaneChessCell.m
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AeroplaneChessCell.h"
#import "NSMutableAttributedString+Attributes.h"

@interface AeroplaneChessCell ()
@property(nonatomic, strong) UIButton *bnt;
@property(nonatomic, assign) NSInteger curIndex;
@end

@implementation AeroplaneChessCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bnt];
        [self.bnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@(0));
        }];
        
        //[self performSelector:@selector(pressEffect:) withObject:nil afterDelay:2];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressEffect:) name:@"JumpAtHere" object:nil];
    }
    return self;
}

- (void)pressEffect:(NSNotification *)noti {
    NSInteger index = [noti.object integerValue];
    if(self.curIndex != index) {
        return;
    }
    
    Block_Exec(self.starPressBlock,nil);
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, CellItemHeight/2)];
    anima.toValue = [NSNumber numberWithFloat:10];
    anima.duration = 0.25;
    anima.autoreverses = YES;
    anima.repeatCount = 1;
    [self.bnt.layer addAnimation:anima forKey:@"position.y"];
}

- (void)reloadUI:(NSDictionary *)dic index:(NSInteger)index {
    self.curIndex = index;
    //[self.bnt setTitle:[@(index) description] forState:UIControlStateNormal];
    
    if(dic == nil) {
        return;
    }
    
    self.bnt.hidden = NO;
    NSInteger row = index / 5;
    if(row > 0 && row < 9) {
        if(index > row*5 && index < (row+1)*5-1) {
            self.bnt.hidden = YES;
        }
    }
    
    NSString *title = [[[dic valueForKey:@"title"] componentsSeparatedByString:@"\n"] firstObject];
    NSString *subtitle = [[[dic valueForKey:@"title"] componentsSeparatedByString:@"\n"] lastObject];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",title,subtitle]];
    [attString addAlignment:NSTextAlignmentCenter substring:attString.string];
    [attString addFont:_bnt.titleLabel.font substring:attString.string];
    if(![[dic valueForKey:@"color"] isKindOfClass:[NSNull class]]) {
        [attString addColor:[dic valueForKey:@"color"] substring:attString.string];
    }
    [self.bnt setAttributedTitle:attString forState:UIControlStateNormal];
    
    [self.bnt setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"bgName"]] forState:UIControlStateNormal];
}

- (UIButton *)bnt {
    if(!_bnt) {
        _bnt = [[UIButton alloc] init];
        _bnt.titleLabel.numberOfLines = 2;
        _bnt.titleLabel.font = [UIFont systemFontOfSize:13];
        [_bnt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
    return _bnt;
}
@end
