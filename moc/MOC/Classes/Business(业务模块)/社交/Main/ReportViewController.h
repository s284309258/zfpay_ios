//
//  ReportViewController.h
//  MoPal_Developer
//
//  Created by fred on 15/5/27.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^HandleReportBlock)(NSArray* reportTypeIds,NSString* reportReason);

@interface ReportViewController : BaseViewController<UITextViewDelegate>

@property (strong, nonatomic) NSString *complainId;
///1,：好友投诉，2：群投诉
@property (strong, nonatomic) NSString *complain_type;
@property (strong, nonatomic) NSString *circle_id;
@property (strong, nonatomic) UILabel *textLimitLabel;

@property (copy, nonatomic) HandleReportBlock reportBlock;

- (id)initWithModel:(id)model;

@end
