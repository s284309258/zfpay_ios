//
//  ScanPayPhotoView.h
//  XZF
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanPayPhotoView :UITableViewCell

@property (nonatomic,strong) CompletionBlock block;

-(void)configData:(NSArray*)dataArray value:(NSArray*)array;
    
@end

NS_ASSUME_NONNULL_END
