//
//  BackgroundImgCell.m
//  HHSD
//
//  Created by alain serge on 3/26/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BackgroundImgCell.h"

@implementation BackgroundImgCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    
    _leftImageView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _contentLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _addressLabel = [[UILabel alloc] init];
    _companyLabel = [[UILabel alloc] init];
    _numberLabel = [[UILabel alloc] init];
    _statusUsing = [[UILabel alloc] init];

    return self;
}

- (void)setMode:(Background_list *)mode
{
    _mainMode = mode;
    _leftImageView = [UIImageView resizeImageViewWithImageView:_leftImageView
                                                         Frame:CGRectMake(10, 10, 95, 95)
                                               backgroundColor:KCOLOR_CLEAR
                                                         image:nil];
    [_leftImageView imageCacheWithImageView:_leftImageView urlString:mode.bg_image];
    [self addSubview:_leftImageView];
    
    
    _titleLabel = [UILabel resizeFrameWithLabel:_titleLabel
                                          frame:CGRectMake(_leftImageView.right + 10, 12, SCREEN_WIDTH - _leftImageView.width - 20,40)
                                backgroundColor:KCOLOR_WHITE
                                      textColor:KCOLOR_Black_343434
                                           font:KSYSTEM_FONT_(14)
                                  textalignment:NSTextAlignmentCenter
                                           text:[NSString stringWithFormat:@"%@",mode.name]];
    _titleLabel.numberOfLines = 3;
    [self addSubview:_titleLabel];
    
   
 
    
    
 
    _companyLabel = [UILabel resizeFrameWithLabel:_companyLabel
                                            frame:CGRectMake(_leftImageView.right + 10, 5 + _titleLabel.bottom, SCREEN_WIDTH - _leftImageView.right - 20, 13)
                                  backgroundColor:KCOLOR_WHITE
                                        textColor:KCOLOR_GRAY_676767
                                             font:KSYSTEM_FONT_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:nil];
    [self addSubview:_companyLabel];
    
    
   
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(_leftImageView.right+ 10 ,90, SCREEN_WIDTH - _leftImageView.right - 10, 0.5)
                                   backgroundColor:KCOLOR_GRAY_c9c9c9];
    [self addSubview:lineView];
    
    _numberLabel = [UILabel resizeFrameWithLabel:_numberLabel
                                           frame:CGRectMake(_leftImageView.right + 10, 5 + lineView.bottom, 200, 13)
                                 backgroundColor:KCOLOR_WHITE
                                       textColor:KCOLOR_RED
                                            font:KICON_FONT_(12)
                                   textalignment:NSTextAlignmentLeft
                                            text:[NSString stringWithFormat:@"\U0000e611: %@",mode.attend]]; // nombre de personne
    [self addSubview:_numberLabel];
    
    //statusUsing
    
    _statusUsing = [UILabel resizeFrameWithLabel:_statusUsing
                                           frame:CGRectMake(SCREEN_WIDTH - 80, lineView.bottom + 3, 70, 20)
                                 backgroundColor:KCOLOR_UNLOCK
                                       textColor:KCOLOR_WHITE
                                            font:KICON_FONT_(11)
                                   textalignment:NSTextAlignmentCenter
                                            text:@"Unlock"];
    _statusUsing.layer.cornerRadius = 3.0;
    _statusUsing.layer.masksToBounds = YES;
    [self addSubview:_statusUsing];
    
    _actionBtn = [UIButton createButtonwithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 95)
                                 backgroundColor:KCOLOR_CLEAR
                                      titleColor:KCOLOR_CLEAR
                                            font:KSYSTEM_FONT_(11)
                                           title:@"Unlock"];
    _actionBtn.layer.cornerRadius = 3.0;
    _actionBtn.layer.masksToBounds = YES;
    if([mode.is_open intValue] ==1)
    {
        if([mode.is_apply intValue])
        {
            _statusUsing.text =@"Using";
            _statusUsing.backgroundColor =KCOLOR_READING;
        }else
        {
            _statusUsing.text =@"Unlock";
        }
        
    }else
    {
        if([mode.is_apply intValue])
        {
            _statusUsing.text =@"Using";
            _statusUsing.backgroundColor =KCOLOR_READING;
        }else
        {
            _statusUsing.text =@"Unlock";
        }
        
    }
    [_actionBtn addTarget:self action:@selector(actionClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_actionBtn];
    
    UIView *bottomView = [UIView createViewWithFrame:CGRectMake(0, _leftImageView.bottom + 10, SCREEN_WIDTH, 10)
                                     backgroundColor:KCOLOR_GRAY_f5f5f5];
    [self addSubview:bottomView];
    UIView *bottomViewLine1 = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                          backgroundColor:KCOLOR_GRAY_c9c9c9];
    [bottomView addSubview:bottomViewLine1];
    UIView *bottomViewLine2 = [UIView createViewWithFrame:CGRectMake(0, 9.5, SCREEN_WIDTH, 0.5)
                                          backgroundColor:KCOLOR_GRAY_c9c9c9];
    [bottomView addSubview:bottomViewLine2];
}
- (void)actionClick
{
    if(_delegate && _mainMode)
    {
        [_delegate BgImgActionBtnClick:_mainMode];
    }
}

+ (CGFloat)getHeight
{
    CGFloat height = 125;
    return height;
}
@end
