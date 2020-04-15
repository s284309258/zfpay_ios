//
//  AgentAddressBookDetailVC.h
//  XZF
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentAddressBookDetailView : UIView

@property (nonatomic,strong) CompletionBlock telBlock;

@property (nonatomic,strong) dispatch_block_t dateBlock;

-(void)reload:(NSString *)avatar name:(NSString* )name merchant:(NSString*)merchant money:(NSString*)money tipAttr:(NSMutableAttributedString*)tip;

-(void)reloadTrade:(NSString*)trade;

-(void)reloadMonth:(NSString*)date;

@end

NS_ASSUME_NONNULL_END
