//
//  CityViewSelectCell.m
//  HHSD
//
//  Created by alain serge on 4/5/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "CityViewSelectCell.h"

@implementation CityViewSelectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [[self class] getWidth], [[self class] getHeight])];
    if(!self)
    {
        return nil;
    }
    self.backgroundColor = KCOLOR_WHITE;
    _titleLabel = [[UILabel alloc] init];
    [self setMode];
    return self;
}
- (void)setMode
{
    _titleLabel = [UILabel resizeFrameWithLabel:_titleLabel
                                          frame:CGRectMake(0, 0, [[self class] getWidth], [[self class] getHeight])
                                backgroundColor:KCOLOR_WHITE
                                      textColor:KCOLOR_Black_343434
                                           font:KSYSTEM_FONT_(15)
                                  textalignment:NSTextAlignmentCenter
                                           text:[NSString stringWithFormat:@"select"]];
    _titleLabel.center = self.center;
    [self addSubview:_titleLabel];
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake([[self class] getWidth] - 0.5, 0, 0.4, [[self class] getHeight])
                                   backgroundColor:KCOLOR_GRAY_c9c9c9];
    [self addSubview:lineView];
    
    UIView *lineView1 = [UIView createViewWithFrame:CGRectMake(0, [[self class] getHeight] - 0.5, [[self class] getWidth], 0.5)
                                    backgroundColor:KCOLOR_GRAY_c9c9c9];
    [self addSubview:lineView1];
}
+ (CGFloat)getHeight
{
    return 46*(SCREEN_WIDTH/320);
}
+ (CGFloat)getWidth
{
    return SCREEN_WIDTH/4.0;
}
@end

