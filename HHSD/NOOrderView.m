//
//  NOOrderView.m
//  HHSD
//
//  Created by alain serge on 4/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "NOOrderView.h"
#import "Masonry.h"
@implementation NOOrderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initStance];
    }
    return self;
}
- (void)initStance
{
    self.backgroundColor = KCOLOR_GRAY_f5f5f5;
    _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _orderLabel.centerX = self.centerX;
    _orderLabel.centerY = self.centerY - 100;
    _orderLabel.text = @"\U0000e78b";
    _orderLabel.textColor = KCOLOR_Line_Color;
    _orderLabel.font = KICON_FONT_(80);
    _orderLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, _orderLabel.bottom + 5, 200, 20)
                                backgroundColor:KCOLOR_Clear textColor:KCOLOR_Line_Color
                                           font:KSYSTEM_FONT_(15)
                                  textalignment:NSTextAlignmentCenter text:@"No data"];
    _titleLabel.centerX = self.centerX;
    [self addSubview:_orderLabel];
    [self addSubview:_titleLabel];
    
}
@end
