//
//  ImagePickerBar.m
//  HHSD
//
//  Created by alain serge on 4/6/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "ImagePickerBar.h"

@implementation ImagePickerBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KCOLOR_BLACK;
        
      
        
        _imagePickerButton = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH/4, 0, KHEIGHT_80, KBOUNDS_HEIGHT)
                                             backgroundColor:KCOLOR_CLEAR
                                                  titleColor:KCOLOR_WHITE
                                                        font:KICON_FONT_(15)
                                                       title:@"\U0000e6fd Gallery"];
        [self addSubview:_imagePickerButton];
        
        _cameraPickerButton = [UIButton createButtonwithFrame:CGRectMake(_imagePickerButton.right+20, 0, KHEIGHT_80, KBOUNDS_HEIGHT)
                                              backgroundColor:KCOLOR_CLEAR
                                                   titleColor:KCOLOR_WHITE
                                                         font:KICON_FONT_(15)
                                                        title:@"\U0000e600 Camera"];
        [self addSubview:_cameraPickerButton];
    }
    return self;
}


@end
