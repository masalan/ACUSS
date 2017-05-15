//
//  MyMutilyImagePicker.h
//  YWY2
//
//  Created by 汪达 on 15/3/31.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYQAssetPickerController.h"


@protocol MyMutilyImagePickerDelegate <NSObject>

-(void)myImageMutilyPickerDidSlectedImage:(NSArray *)imageArray;

@end


@interface MyMutilyImagePicker : NSObject <UIActionSheetDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>

@property (nonatomic,strong)UIActionSheet *actionSheet;
@property (nonatomic,strong)UIViewController *superViewController;
@property (nonatomic,weak)id <MyMutilyImagePickerDelegate> delegate;
@property (nonatomic,strong)UIImagePickerController *imagePickerController;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger MaxChoose;

-(id)initWithTitle:(NSString *)title forController:(UIViewController *)controller delegate:(id<MyMutilyImagePickerDelegate>)delegate;
-(void)show;

@end