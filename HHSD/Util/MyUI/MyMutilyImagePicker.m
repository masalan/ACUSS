//
//  MyMutilyImagePicker.m
//  YWY2
//
//  Created by 汪达 on 15/3/31.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "MyMutilyImagePicker.h"
#import "UIImage+fixOrientation.h"
@interface MyMutilyImagePicker()<UIImagePickerControllerDelegate>
@end
@implementation MyMutilyImagePicker
-(id)initWithTitle:(NSString *)title forController:(UIViewController *)controller delegate:(id<MyMutilyImagePickerDelegate>)delegate
{
    self = [super init];
    if (self) {
        _superViewController = controller;
        _delegate = delegate;
        _MaxChoose = 5;
        _actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [_actionSheet showInView:_superViewController.view];
    }
    return self;
}
-(void)show
{
    [_actionSheet showInView:_superViewController.view];
}

#pragma mark
#pragma mark ----- actionSheetDelegate -----

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
                [_superViewController presentViewController:_imagePickerController
                                                   animated:YES
                                                 completion:^(void){
                                                 }];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            }
        } else if (buttonIndex == 1) {
            ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
            picker.view.backgroundColor = KTHEME_COLOR;
            picker.maximumNumberOfSelection = _MaxChoose;
            picker.assetsFilter = [ALAssetsFilter allPhotos];
            picker.showEmptyGroups=NO;
            picker.delegate=self;
            picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                    NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                    return duration >= _MaxChoose;
                } else {
                    return YES;
                }
            }];
            [_superViewController presentViewController:picker animated:YES completion:NULL];
        }
      
    }
}
#pragma mark - ZYQAssetPickerController

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        for (int i=0; i<assets.count; i++) {
            ALAsset *asset=assets[i];
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            if(!_imageArray)
            {
                _imageArray = [NSMutableArray array];
                [_imageArray addObject:tempImg];

            }else
            {
                [_imageArray addObject:tempImg];
            }
        }
        if(_imageArray.count  && _delegate)
        {
            [_delegate myImageMutilyPickerDidSlectedImage:_imageArray];
            _imageArray = nil;
        }
    });
    
}
-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    NSLog(@"到达上限");
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            image = [image fixOrientation];
            if(!_imageArray)
            {
                _imageArray = [NSMutableArray array];
                [_imageArray addObject:image];
            }else
            {
                [_imageArray addObject:image];
            }
            if (_delegate) {
                [_delegate myImageMutilyPickerDidSlectedImage:_imageArray];
                _imageArray = nil;
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
