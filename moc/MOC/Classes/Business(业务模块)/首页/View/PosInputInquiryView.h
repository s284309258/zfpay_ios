//
//  PosInputInquiryView.h
//  XZF
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosInputInquiryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PosInputInquiryView : UITableViewCell

@property (nonatomic,strong) CompletionBlock showDetail;

-(void)reload:(PosInputInquiryModel*)model type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
