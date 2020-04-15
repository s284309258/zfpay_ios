//
//  UploadBankPhotoView.h
//  XZF
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
#import "RealNameForm.h"
#import "AddBankModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UploadBankPhotoView : UIView


@property (nonatomic ,strong) UILabel* title;

@property (nonatomic ,strong) SPButton* upPhoto;

@property (nonatomic ,strong) SPButton* downPhoto;

@property (nonatomic ,strong) SPButton* handPhoto;

-(void)configVC:(UIViewController*)vc model:(RealNameForm*)form;

@end

NS_ASSUME_NONNULL_END
