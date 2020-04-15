//
//  MXPushModel.m
//  MoPal_Developer
//
//  Created by 李星楼 on 15/9/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXPushModel.h"

@implementation MXPushModel

-(NSString*)tipMsg{
    
    if(self.t==5){
        if(self.unRead>1){
            NSString *num =[NSString stringWithFormat:@"%@", self.unRead<100?[@(self.unRead) description]:@"99+"];
            NSString *str = MXLang(@"MoMessage_Push_N", @"%@条与您相关的信息");
            return [NSString stringWithFormat:str,num];
        }
        
        
       
        
        NSString *typeCode=[NSString stringWithFormat:@"MoMessage_Push_Type_%@",@(self.type)];
        NSString *msgTypeCode=[NSString stringWithFormat:@"MoMessage_Push_MsgType_%@",@(self.msgType)];
        
        return [NSString stringWithFormat:@"%@%@%@%@",self.name,
                MXLang(msgTypeCode, @"互动了"),
                MXLang(@"MoMessage_Push_Your", @"你的"),
                MXLang(typeCode, @"内容")];

    }else{
        return self.msg;
    }
    
}

#pragma mark - 对象序列化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.msg forKey:@"msg"];
    [aCoder encodeObject:@(self.unRead) forKey:@"unRead"];
    [aCoder encodeObject:@(self.msgType) forKey:@"msgType"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:@(self.t) forKey:@"t"];
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    [aCoder encodeObject:@(self.id) forKey:@"id"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        self.unRead = [[aDecoder decodeObjectForKey:@"unRead"] integerValue];
        self.msgType = [[aDecoder decodeObjectForKey:@"msgType"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.t = [[aDecoder decodeObjectForKey:@"t"] integerValue];
        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
        self.id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
    }
    return self;
}

@end
