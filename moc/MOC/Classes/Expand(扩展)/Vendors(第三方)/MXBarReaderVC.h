//
//  MXBarReaderVC.h
//  Moxian
//
//  Created by liuxz on 13-11-15.
//  Copyright (c) 2013年 Moxian. All rights reserved.
//

#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import <AVFoundation/AVFoundation.h>
#import "MXButton.h"
#import "BaseViewController.h"

@class MXBarReaderVC;

@interface MXBarReaderVC : BaseViewController

- (void)startReader;
- (void)stopReader;

@end

@protocol MXBarReaderDelegate <NSObject>

// 扫描出来的字符串
- (void)readerText:(NSString *)readerCode readerVC:(MXBarReaderVC*)reader ;

@end
