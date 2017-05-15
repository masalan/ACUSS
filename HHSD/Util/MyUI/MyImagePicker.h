//
//  MyImagePicker.h
//  Ulay
//
//  Created by liufengting on 14/11/11.
//  Copyright (c) 2014年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"

@protocol MyImagePickerDelegate <NSObject>

-(void)myImagePickerDidSlectedImage:(UIImage *)image info:(NSDictionary *)info;
@end


@interface MyImagePicker : NSObject <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIActionSheet *actionSheet;
@property (nonatomic,strong)UIViewController *superViewController;
@property (nonatomic,strong)id <MyImagePickerDelegate> delegate;
@property (nonatomic,strong)UIImagePickerController *imagePickerController;


-(id)initWithTitle:(NSString *)title forController:(UIViewController *)controller delegate:(id<MyImagePickerDelegate>)delegate;
-(void)show;

@end
