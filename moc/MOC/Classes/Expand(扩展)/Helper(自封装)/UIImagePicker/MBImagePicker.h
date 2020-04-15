//
//  MBImagePicker.h
//  MoPromo_Develop
//  选择图片
//
//  Created by yang.xiangbao on 15/5/13.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBImagePicker : NSObject

/**
*  初始化方法
*
*  @param rvc   UIViewController 用于弹出 UIImagePickerController
*  @param param UIImagePickerController 参数设置
*
*  @return 实例
*/
- (instancetype)initWithViewController:(__weak UIViewController*)rvc
                        configureParam:(void(^)(UIImagePickerController *pickerController))param;

/**
 *  选择图片
 *
 *  @param pickerImage 返回选择的图片
 */
- (void)selectImage:(void(^)(UIImage *image))pickerImage;

@end
