//
//  MyImagePicker.m
//  Ulay
//
//  Created by liufengting on 14/11/11.
//  Copyright (c) 2014年 liufengting. All rights reserved.
//

#import "MyImagePicker.h"
#import "UIImage+fixOrientation.h"
@implementation MyImagePicker

-(id)initWithTitle:(NSString *)title forController:(UIViewController *)controller delegate:(id<MyImagePickerDelegate>)delegate
{
    self = [super init];
    if (self) {
        _superViewController = controller;
        _delegate = delegate;
        
        _actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Take Photo", @"Choose from Photos", nil];
        [_actionSheet showInView:_superViewController.view];
        
    }
    return self;
}
-(void)show
{
    [_actionSheet showInView:_superViewController.view];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.navigationBar.barTintColor = KTHEME_COLOR;
        _imagePickerController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:KCOLOR_WHITE,NSFontAttributeName:KSYSTEM_FONT_BOLD_(18)};
        _imagePickerController.navigationBar.tintColor = KCOLOR_WHITE;
        [_imagePickerController.navigationBar setTranslucent:NO];
        _imagePickerController.delegate = self;
    }
    
    if (buttonIndex>=0 && buttonIndex<=1) {
        if (buttonIndex == 0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;            // 拍照
            }
        } else if (buttonIndex == 1) {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;            // 从相册中选取
            }
        }
        [_superViewController presentViewController:_imagePickerController
                                           animated:YES
                                         completion:^(void){
                                         }];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            image = [image fixOrientation];
            if (_delegate) {
                [_delegate myImagePickerDidSlectedImage:image info:info];
            }
        });
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

@end
