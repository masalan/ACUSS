//
//  BaseViewController.h
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 mas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TPKeyboardAvoidingCollectionView.h"
#import "NetWork.h"
#import "UIImageView+SDWDImageCache.h"
#import "JSON_API.h"
#import "NofificationMacros.h"


@interface BaseViewController : UIViewController
@property (nonatomic, copy) NSString *sess_id;
@property (nonatomic, strong) UIView *baseBackView;
@property (nonatomic, strong) UIView *backTitleLabel;
@property (nonatomic, strong) UIButton *leftBackBtn;
+ (void)presentVC:(UIViewController *)viewController;
@end
