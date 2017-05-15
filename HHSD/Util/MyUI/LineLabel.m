//
//  LineLabel.m
//  YWY2
//
//  Created by 汪达 on 15/4/8.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "LineLabel.h"

@implementation LineLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    _lineView = [[UIView alloc] init];
    return self;
}
- (void)initstance:(NSString *)string height:(CGFloat)height font:(UIFont *)font color:(UIColor *)color width:(CGFloat )width
{
    self.text = string;
    CGFloat linewidth = [PublicMethod getWidthWithHeight:12 text:string font:font ];
    _lineView.frame = CGRectMake(-0.5, 0,(int)linewidth +2, height);
    _lineView.backgroundColor = color;
    _lineView.centerY = self.height/2;
    [self addSubview:_lineView];
}
@end
