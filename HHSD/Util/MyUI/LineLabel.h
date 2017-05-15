//
//  LineLabel.h
//  YWY2
//
//  Created by 汪达 on 15/4/8.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineLabel : UILabel
@property (nonatomic, strong) UIView *lineView;
- (void)initstance:(NSString *)string height:(CGFloat)height font:(UIFont *)font color:(UIColor *)color width:(CGFloat )width;
@end
