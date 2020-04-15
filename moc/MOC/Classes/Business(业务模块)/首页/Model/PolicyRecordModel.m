//
//  PolicyRecordModel.m
//  XZF
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "PolicyRecordModel.h"
#import "PolicyModel.h"
@implementation PolicyRecordModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"policy3List" :[PolicyModel class]};
}

-(NSArray*)policyList{
    if (!_policyList) {
        
          NSMutableArray* array = [[NSMutableArray alloc]initWithCapacity:10];
          [self.policy3List enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              PolicyModel* model = [obj copy];
              if ([self.choose isEqualToString:@"0"]) {
                  NSArray* array = [self.policy_id componentsSeparatedByString:@","];
                  if ([array indexOfObject:model.id] != NSNotFound) {
                      model.state = EnableTakeReward;
                  }else{
                       model.state = UnEnableTakeReward;
                  }
              }else{
                  if ([model.id isEqualToString:self.choose]) {
                       model.state = TakeRewarded;
                  }else{
                      model.state = UnEnableTakeReward;
                  }
              }
              
              [array addObject:model];
          }];
        _policyList = array;
    }
  
    return _policyList;
}
@end
