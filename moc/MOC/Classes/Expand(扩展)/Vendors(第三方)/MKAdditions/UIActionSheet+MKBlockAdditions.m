//
//  UIActionSheet+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import "UIActionSheet+MKBlockAdditions.h"
#import "UIImage+FixOrientation.h"
#import "NSObject+CapacityAuthorize.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;
static PhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;
static BOOL _imagePickerAllowsEditing;
static BOOL _actionSheetIsClicking;

@implementation UIActionSheet (MKBlockAdditions)

+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(DismissBlock) dismissed                   
                    onCancel:(CancelBlock) cancelled
{    
    [UIActionSheet actionSheetWithTitle:title 
                                message:message 
                 destructiveButtonTitle:nil 
                                buttons:buttonTitles 
                             showInView:view 
                              onDismiss:dismissed 
                               onCancel:cancelled];
}

+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(DismissBlock) dismissed                   
                     onCancel:(CancelBlock) cancelled
{
    _cancelBlock = nil;
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock = nil;
    _dismissBlock  = [dismissed copy];
    
    _actionSheetIsClicking = NO;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil];
#pragma clang diagnostic pop

    
    for(NSString* thisButtonTitle in buttonTitles)
        [actionSheet addButtonWithTitle:thisButtonTitle];
    
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle)
        actionSheet.cancelButtonIndex ++;
    
    if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    
}

+ (void) photoPickerWithTitle:(NSString*) title
                allowsEditing:(BOOL)allowsEditing
                   showInView:(UIView*) view
                    presentVC:(UIViewController*) presentVC
                onPhotoPicked:(PhotoPickedBlock) photoPicked
                     onCancel:(CancelBlock) cancelled{
    _cancelBlock = nil;
    _cancelBlock  = [cancelled copy];
    
    _photoPickedBlock = nil;
    _photoPickedBlock  = [photoPicked copy];
    
    _presentVC = nil;
    _presentVC = presentVC;
    
    _imagePickerAllowsEditing = NO;
    _imagePickerAllowsEditing = allowsEditing;
    
    _actionSheetIsClicking = NO;

    int cancelButtonIndex = -1;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
#pragma clang diagnostic pop
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
//        [actionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"")];
        [actionSheet addButtonWithTitle:@"拍照"];
        cancelButtonIndex ++;
    }
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
//        [actionSheet addButtonWithTitle:NSLocalizedString(@"相册", @"")];
        [actionSheet addButtonWithTitle:@"从相册中选择"];
        cancelButtonIndex ++;
    }
    
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
    cancelButtonIndex ++;
    
    actionSheet.tag = kPhotoActionSheetTag;
    actionSheet.cancelButtonIndex = cancelButtonIndex;
    
    if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    
}

+ (void) photoPickerWithTitle:(NSString*) title
                   showInView:(UIView*) view
                    presentVC:(UIViewController*) presentVC
                onPhotoPicked:(PhotoPickedBlock) photoPicked                   
                     onCancel:(CancelBlock) cancelled
{

    [self photoPickerWithTitle:title allowsEditing:NO showInView:view presentVC:presentVC onPhotoPicked:photoPicked onCancel:cancelled];
}


+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage){
        editedImage = (UIImage*)[info valueForKey:UIImagePickerControllerOriginalImage];
        editedImage = [editedImage fixOrientation];
    }
    
	[picker dismissViewControllerAnimated:YES completion:^{
        _photoPickedBlock(editedImage);
    }];
}


+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [_presentVC dismissViewControllerAnimated:YES completion:^{
        
    }];
    picker = nil;
    _presentVC = nil;
    _actionSheetIsClicking = NO;
    if (_cancelBlock) {
        _cancelBlock();
    }
}

//+ (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    _actionSheetIsClicking = YES;
//}

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    
	if(buttonIndex == [actionSheet cancelButtonIndex])
	{
        if (_cancelBlock) {
            _cancelBlock();
        }
	}
    else
    {
        if (_actionSheetIsClicking) {
            return;
        }
        _actionSheetIsClicking = YES;
        if(actionSheet.tag == kPhotoActionSheetTag)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                buttonIndex ++;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                buttonIndex ++;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
            
            picker.delegate = [self class];

#pragma clang diagnostic pop
            picker.allowsEditing = _imagePickerAllowsEditing;
            
            if(buttonIndex == 1) 
            {
                if (![_presentVC isAuthorizedPhotoLibraryStatus]) {
                    return;
                }
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            else if(buttonIndex == 2)
            {
                if (![_presentVC isAuthorizedCameraStatus]) {
                    return;
                }
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
            [_presentVC presentViewController:picker animated:YES completion:^{
                _actionSheetIsClicking = NO;
            }];
        }
        else
        {
            _actionSheetIsClicking = NO;
            if (_dismissBlock) {
                _dismissBlock(buttonIndex);
            }
        }
    }
}
@end
