//
//  ShowTextVC.m
//  XZF
//
//  Created by AlphaGo on 2020/2/6.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import "ShowTextVC.h"

@interface ShowTextVC ()

@end

@implementation ShowTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户使用协议";
    UITextView *tv = [UITextView new];
    tv.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    tv.text = @"你理解并同意，中掌柜一直致力于为用户提供文明健康、规范有序的网络环境，你不得利用中掌柜帐号或功能帐号或本软件及服务制作、复制、发布、传播如下干扰中掌柜正常运营，以及侵犯其他用户或第三方合法权益的内容，包括但不限于：\n1.1 发布、传送、传播、储存违反国家法律法规禁止的内容：\n（1）违反宪法确定的基本原则的；\n（2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n（3）损害国家荣誉和利益的；\n（4）煽动民族仇恨、民族歧视，破坏民族团结的；\n（5）破坏国家宗教政策，宣扬邪教和封建迷信的；\n（6）散布谣言，扰乱社会秩序，破坏社会稳定的；\n（7）散布淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的；\n（8）侮辱或者诽谤他人，侵害他人合法权益的；\n（9）煽动非法集会、结社、游行、示威、聚众扰乱社会秩序；\n（10）以非法民间组织名义活动的；\n（11）不符合《即时通信工具公众信息服务发展管理暂行规定》及遵守法律法规、社会主义制度、国家利益、公民合法利益、公共秩序、社会道德风尚和信息真实性等“七条底线”要求的；\n（12）含有法律、行政法规禁止的其他内容的。\n1.2 发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的内容；\n1.3 涉及他人隐私、个人信息或资料的；\n1.4 发表、传送、传播骚扰、广告信息、过度营销信息及垃圾信息或含有任何性或性暗示的；\n1.5 其他违反法律法规、政策及公序良俗、社会公德或干扰中掌柜正常运营和侵犯其他用户或第三方合法权益内容的信息。";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
