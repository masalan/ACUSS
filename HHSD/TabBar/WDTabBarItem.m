//
//  WDTabBarItem.m
//  HHSD
//
//  Created by Serge Alain on 16/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import "WDTabBarItem.h"
#define iconFont 25
#define nameFont 12
@implementation WDTabBarItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    self.backgroundColor = KCOLOR_WHITE;
    _nameLabel = [[UILabel alloc] init];
    _iconLabel = [[UILabel alloc] init];
    _iconLabel = [UILabel resizeFrameWithLabel:_iconLabel
                                         frame:CGRectMake(0, 5, self.width - 40, 25)
                               backgroundColor:KCOLOR_WHITE
                                     textColor:KCOLOR_Black_343434
                                          font:KICON_FONT_(iconFont)
                                 textalignment:NSTextAlignmentCenter
                                          text:self.iconString];
    self.iconLabel.centerX = self.width/2;
    [self addSubview:_iconLabel];
    _nameLabel = [UILabel resizeFrameWithLabel:_nameLabel
                                         frame:CGRectMake(0, _iconLabel.bottom + 5, _iconLabel.width, 12)
                               backgroundColor:KCOLOR_WHITE
                                     textColor:KCOLOR_Black_343434
                                          font:KSYSTEM_FONT_(nameFont)
                                 textalignment:NSTextAlignmentCenter
                                          text:self.nameString];
    self.nameLabel.centerX = self.width/2;
    [self addSubview:_nameLabel];
    [RACObserve(self, selected) subscribeNext:^(id x) {
        if(self.selected)
        {
            _iconLabel.textColor = KTHEME_COLOR;
           // _iconLabel.textColor = KCOLOR_GREEN_6ad968;

        }else
        {
            _iconLabel.textColor = KCOLOR_Black_343434;
        }
    }];
    return self;
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//}
/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
//    _iconLabel.textColor = KCOLOR_GREEN_6ad968;
}
@end
