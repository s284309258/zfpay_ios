//
//  MBImagePicker.m
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/13.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import "MBImagePicker.h"

typedef void(^PickerImage)(UIImage *image);

@interface MBImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, weak  ) UIViewController        *rvc;
// 回调，把图片返回
@property (nonatomic, strong) PickerImage             pickerImage;

@end

@implementation MBImagePicker

- (void)dealloc
{
   
}

- (instancetype)initWithViewController:(__weak UIViewController*)rvc
                        configureParam:(void(^)(UIImagePickerController *pickerController))pickerController
{
    self = [super init];
    if (self) {
        _rvc = rvc;
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        if (pickerController) {
            pickerController(_imagePicker);
        }
        
        if (_imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self = nil;
            return nil;
        }
    }
    
    return self;
}

- (void)selectImage:(void(^)(UIImage *image))pickerImage
{
    self.pickerImage = pickerImage;
    [self.rvc presentViewController:_imagePicker animated:NO completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage  *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.rvc dismissViewControllerAnimated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pickerImage) {
                self.pickerImage(image);
            }
        });
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.rvc dismissViewControllerAnimated:YES completion:^{
        self.imagePicker = nil;
        self.pickerImage = nil;
    }];
}

@end
