//
//  MyNavBar.h
//  YWYiphone2
//
//  Created by liufengting on 15/1/12.
//  Copyright (c) 2015年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"

@interface MyNavBar : UIView

@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UILabel *titleLabel;

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title leftAction:(SEL )leftAction forViewController:(UIViewController *)vc;

@end
