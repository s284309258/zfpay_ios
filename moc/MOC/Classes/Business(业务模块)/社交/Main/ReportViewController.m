//
//  ReportViewController.m
//  MoPal_Developer
//
//  Created by fred on 15/5/27.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "ReportViewController.h"
//#import "ChatGroupModel.h"
#import "FriendsManager.h"
#import "AmplifyRespondButton.h"
//#import "SCRequestHelper.h"

@interface ReportViewController ()<UITextViewDelegate>
{
    UITextField *nameFiled;
    NSInteger postID;
    UIScrollView* keyboardScroll;
    UIButton *rightButton;
    id entity;
    NSMutableArray* reportTypeArray;
    UIView* reportReasonView;
    UILabel* title2;
    UIView* otherView;
    NSMutableArray* selectArray;

}

@property (strong, nonatomic) UITextView *valueView;
@property (strong, nonatomic) NSString   *selectType;
@property (strong, nonatomic) UILabel    * tvPlaceHolder;

@end

@implementation ReportViewController

@synthesize selectType;
@synthesize valueView;

- (id)initWithModel:(id)model {
    self = [super init];
    if (self) {
        entity = model;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.isShowBackButton = YES;
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    keyboardScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:keyboardScroll];
    [self setNavBarTitle:Lang(@"投诉")];
    rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];

    [rightButton setTitle:Lang(@"提交") forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [rightButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    //[rightButton setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(uploadValue)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    rightButton.enabled = NO;

    [self initView];
    [self initData];
    [self.view addSubview:keyboardScroll];

}

-(void)initData{
    selectArray = [[NSMutableArray alloc]initWithCapacity:0];
    reportTypeArray = @[
                        @{@"desc":@"色情",@"id":@"1"},
  @{@"desc":@"欺诈",@"id":@"2"},
  @{@"desc":@"广告骚扰",@"id":@"3"},
  @{@"desc":@"敏感信息",@"id":@"4"},
  @{@"desc":@"侵权",@"id":@"5"},
  @{@"desc":@"赌博",@"id":@"6"},
  @{@"desc":@"其他",@"id":@"7"}];
[self reloadReportReasonView:reportTypeArray];
}

- (void)initView
{
    reportReasonView = [[UIView alloc]initWithFrame:CGRectZero];
    [keyboardScroll addSubview:reportReasonView];

    title2 = [[UILabel alloc] initWithFrame:CGRectZero];
    [title2 setBackgroundColor:[UIColor clearColor]];
    [title2 setText:MXLang(@"Talk_friend_other_40",@"其他")];
    [title2 setTextAlignment:NSTextAlignmentLeft];
    [title2 setTextColor:[UIColor lightGrayColor]];
    [title2 setFont:[UIFont font12]];
    [keyboardScroll addSubview:title2];

    otherView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title2.frame)+10, SCREEN_WIDTH, 150)];
    otherView.backgroundColor = [UIColor whiteColor];
    otherView.layer.borderWidth = 0.5;
    otherView.layer.borderColor = [UIColor separatorLine].CGColor;

//    valueView = [[UITextView alloc] initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-50, 150)];
    valueView = [[UITextView alloc] initWithFrame:CGRectZero];
    valueView.backgroundColor = [UIColor clearColor];
    valueView.delegate = self;
    self.tvPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-50, 20)];
    self.tvPlaceHolder.font = [UIFont font14];
    self.tvPlaceHolder.text = MXLang(@"Talk_friend_report_placeholder_41", @"请输入举报原因");
    self.tvPlaceHolder.textColor = [UIColor separatorLine];
//    [otherView addSubview:self.tvPlaceHolder];
//    [otherView addSubview:valueView];
    self.valueView.delegate=self;
    [self.valueView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    self.valueView.textColor = [UIColor blackColor];
    self.valueView.font = [UIFont fontWithName:@"Arial" size:15.0];

    //给图层添加一个有色边框
    self.valueView.returnKeyType = UIReturnKeyDefault;
    self.valueView.keyboardType = UIKeyboardTypeDefault;
    self.valueView.scrollEnabled = YES;

//    self.textLimitLabel = [[UILabel alloc] initWithFrame:(CGRect){SCREEN_WIDTH-50, CGRectGetHeight(otherView.frame)-20, 50, 21}];
    self.textLimitLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    [self.textLimitLabel setFont:[UIFont font12]];
    [self updatetextLimitLabel:0];
//    [otherView addSubview:self.textLimitLabel];

    [keyboardScroll addSubview:otherView];



    keyboardScroll.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(otherView.frame)+100);
}

-(BOOL)isCanEdit{
    if ((selectArray.count>0)) {
        rightButton.selected = YES;
        rightButton.enabled = YES;
        return YES;
    }else{
        rightButton.selected = NO;
        rightButton.enabled = NO;
        return NO;

    }
//    if ((selectArray.count>0 && [StringUtil asciiLengthOfString:valueView.text]<=100) || (valueView.text.length > 0 && [StringUtil asciiLengthOfString:valueView.text]<=100)) {
//        rightButton.selected = YES;
//        rightButton.enabled = YES;
//        return YES;
//    }else{
//        rightButton.selected = NO;
//        rightButton.enabled = NO;
//        return NO;
//
//    }
}

- (void)textViewDidChange:(UITextView *)textView{
    NSUInteger textLength = [StringUtil asciiLengthOfString:textView.text];

    if (textLength == 0) {
        self.tvPlaceHolder.hidden = NO;
    }else{
        self.tvPlaceHolder.hidden = YES;
    }
    [self isCanEdit];
    [self updatetextLimitLabel:textLength];
    [self isCanEdit];
}

-(void)reloadReportReasonView:(NSMutableArray*)array{
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width, 20)];
    [title1 setBackgroundColor:[UIColor clearColor]];
    [title1 setText:MXLang(@"Talk_friend_report_reason_39", @"请选择举报原因")];

    [title1 setTextAlignment:NSTextAlignmentLeft];
    [title1 setTextColor:[UIColor lightGrayColor]];
    [title1 setFont:[UIFont font12]];
    [reportReasonView addSubview:title1];
    reportReasonView.clipsToBounds = YES;
    reportReasonView.backgroundColor = [UIColor whiteColor];
    int hight = 45;
    for (int i = 0; i <[array count]; i++) {
        if (i == 0) {
            MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:SCREEN_WIDTH orginX:0 orginY:hight];
            [reportReasonView addSubview:line];
        }

        hight = hight + 12.5;

        UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(10, hight, self.view.frame.size.width-20, 20)];
        //        [value setBackgroundColor:[UIColor clearColor]];
        NSDictionary* dict = [array safeObjectAtIndex:i];
        [value setText:[dict objectForKey:@"desc"]];  //name -->desc special by lhy 2015-08-26
        [value setTextAlignment:NSTextAlignmentLeft];
        [value setTextColor:[UIColor blackColor]];
        [value setFont:[UIFont font14]];
        [reportReasonView addSubview:value];

        //扩大点击区域 fix by xgh
        AmplifyRespondButton *btn = [AmplifyRespondButton buttonWithType:UIButtonTypeCustom];
        btn.expendDx = -15;
        btn.expendDy = -15;
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setFrame:CGRectMake(self.view.frame.size.width-50, hight-6, 35, 35)];
        btn.tag = 2001000 + i;
        [btn setImage:[UIImage imageNamed:@"chatRadioUnChosed"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"chatRadioChosed"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        [reportReasonView addSubview:btn];

        hight = hight + value.frame.size.height;


        MXSeparatorLine* line = [MXSeparatorLine initHorizontalLineWidth:self.view.frame.size.width-20  orginX:10 orginY:hight+12.5];
        [reportReasonView addSubview:line];
        hight = hight + 12.5;

        if (i == [array count]-1) {
            line.frame = CGRectMake(0, hight+5, self.view.frame.size.width, 0.5);
        }
    }
    reportReasonView.frame = CGRectMake(0, 0, SCREEN_WIDTH+1, array.count*45+40);
    reportReasonView.layer.borderColor = [UIColor separatorLine].CGColor;
    reportReasonView.layer.borderWidth = 0.5;
    title2.frame = CGRectZero;
    otherView.frame = CGRectMake(0, CGRectGetMaxY(title2.frame)+10, SCREEN_WIDTH, 0);

    keyboardScroll.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(otherView.frame)+100);
}

- (void)clickChangeButton:(UIButton *)btn {
    NSInteger x = btn.tag - 2001000;

    NSDictionary* dict = [reportTypeArray safeObjectAtIndex:x];
    NSString* reportId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    if (!btn.selected) {
        [selectArray addObject:reportId];
    }else{
        [selectArray removeObject:reportId];
    }
    btn.selected = !btn.selected;
    [self isCanEdit];

}



- (void)uploadValue
{
    NSString* reportText = self.valueView.text;
    if ([StringUtil isEmpty:reportText]) {
        reportText = @"";
    }

    if (_reportBlock) {
        _reportBlock(selectArray,reportText);
        return;
    }

    [NotifyHelper showHUDAddedTo:self.view animated:YES];
    [FriendsManager complain:@{@"complain_type":@"1",@"friend_id":self.complainId ?: @"",@"resoan":[selectArray componentsJoinedByString:@","]} completion:^(BOOL success, NSString *error) {
        [NotifyHelper hideHUDForView:self.view animated:YES];
        [NotifyHelper showMessageWithMakeText:@"提交成功，我们将尽快处理，感谢投诉"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)updatetextLimitLabel:(NSInteger)textLength {
    NSString* colorString = (textLength>100 ? @"red" : @"gray");
    NSString* limitString = [NSString stringWithFormat: @"<font color='%@'>%@</font><font color='gray'>/100</font>",colorString,@(textLength)];
    self.textLimitLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[limitString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} documentAttributes:nil error:nil];
}


@end
