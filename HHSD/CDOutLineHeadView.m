//
//  CDOutLineHeadView.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "CDOutLineHeadView.h"
#import "UIImageView+SDWDImageCache.h"
#define btnWidth SCREEN_WIDTH/3
#define btnHeight 44
#define honorLabel 30
#define AL  SCREEN_WIDTH/2

@implementation CDOutLineHeadView
- (instancetype)initWithMode:(Student_Details *)mode
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.backgroundColor = KTHEME_COLOR;
    _leftImageView = [UIImageView createImageViewWithFrame:CGRectMake(10, 10, 60, 60)
                                           backgroundColor:KTHEME_COLOR
                                                     image:nil];
    _leftImageView.layer.cornerRadius = _leftImageView.width/2.0;
    _leftImageView.layer.borderColor = KTHEME_COLOR.CGColor;
    _leftImageView.layer.borderWidth = 1.0;
    _leftImageView.layer.masksToBounds = YES;
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_leftImageView imageCacheWithImageView:_leftImageView urlString:mode.avatar_user];
    [self addSubview:_leftImageView];
    
    // Status user
    _verify = [UIImageView createImageViewWithFrame:CGRectMake(SCREEN_WIDTH-50,20, 40, 40)
                                    backgroundColor:KCOLOR_WHITE
                                              image:nil];
    _verify.layer.cornerRadius = _verify.width/2.0;
    _verify.layer.borderColor = KCOLOR_WHITE.CGColor;
    _verify.layer.borderWidth = 2.0;
    _verify.layer.masksToBounds = YES;
    _verify.contentMode = UIViewContentModeScaleAspectFill;
    
    if ([mode.verify isEqualToString:@"0"])
    {
        _verify.image = [UIImage imageNamed:@"0"];
        _userStatus.text =@"Unverify profile";
    }
    else if ([mode.verify isEqualToString:@"1"])
    {
        _verify.image = [UIImage imageNamed:@"1"];
        _userStatus.text =@"Verify profile";
    }
    else if ([mode.verify isEqualToString:@"2"])
    {
        _verify.image = [UIImage imageNamed:@"2"];
        _userStatus.text =@"Trust user";
    }
    else if ([mode.verify isEqualToString:@"3"])
    {
        _verify.image = [UIImage imageNamed:@"3"];
        _userStatus.text =@"Spammer";
    }
    else if ([mode.verify isEqualToString:@"4"])
    {
        _verify.image = [UIImage imageNamed:@"4"];
        _userStatus.text =@"Moderateur";
    }
    else if ([mode.verify isEqualToString:@"5"])
    {
        _verify.image = [UIImage imageNamed:@"5"];
        _userStatus.text =@"Student";
    }
    else if ([mode.verify isEqualToString:@"6"])
    {
        _verify.image = [UIImage imageNamed:@"6"];
        _userStatus.text =@"Office";

    }
    else if ([mode.verify isEqualToString:@"7"])
    {
        _verify.image = [UIImage imageNamed:@"7"];
        _userStatus.text =@"Teacher";

    }
    [self addSubview:_verify];
    
    /***
     0 unverify
     1 verify
     2 secure user
     3 spammer
     4 moderateur
     5 graduate
     6 admin
     7teacher
     
     **/
    
    
    //userStatus
    _userStatus = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-71,_verify.bottom,70, 18)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE
                                           font:kAutoFont_(8)
                                  textalignment:NSTextAlignmentCenter
                                           text:nil
                                   numberOfLine:3];
    [self addSubview:_userStatus];
    
    //Title course
    _titlaLabel = [UILabel createLabelWithFrame:CGRectMake(_leftImageView.right + 10, 10, SCREEN_WIDTH - 90,30)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE
                                           font:kAutoFont_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:mode.fullName
                                   numberOfLine:3];
    [self addSubview:_titlaLabel];
    
    
    //Total users
    _numberLabel = [UILabel createLabelWithFrame:CGRectMake(_leftImageView.right + 10, _titlaLabel.bottom + 10, SCREEN_WIDTH - 100, 20)
                                 backgroundColor:KCOLOR_CLEAR
                                       textColor:KCOLOR_WHITE
                                            font:kAutoFont_(10)
                                   textalignment:NSTextAlignmentLeft
                                            text:nil];
    
    
    [self addSubview:_numberLabel];
    
    
    
    if( [mode.people isKindOfClass:[NSString class]] && mode.people)
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:NSLocalizedString(@"Localized_CDOutLineHeadView_people",comment:""),mode.people]];
        [string addAttribute:NSFontAttributeName value:KICON_FONT_(16) range:NSMakeRange(0, 1)];
        _numberLabel.attributedText = string;
        
    }
    else
    {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:NSLocalizedString(@"Localized_CDOutLineHeadView_people_zero",comment:"")]];
        [string addAttribute:NSFontAttributeName value:KICON_FONT_(16) range:NSMakeRange(0, 1)];
        _numberLabel.attributedText = string;
        
    }
    
    
    
    
    
    
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KTHEME_COLOR];
    [self addSubview:lineView];
    
    NSArray *array = [NSArray arrayWithObjects:NSLocalizedString(@"Localized_CDOutLineHeadView_me",comment:""),NSLocalizedString(@"Localized_CDOutLineHeadView_Majors",comment:""),NSLocalizedString(@"Localized_CDOutLineHeadView_share",comment:""),  nil];
    [array enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL *  stop) {
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(btnWidth * idx, 80, btnWidth, btnHeight)
                                        backgroundColor:KCOLOR_WHITE
                                             titleColor:KCOLOR_GRAY_676767
                                                   font:KICON_FONT_(15)
                                                  title:obj];
        btn.tag = idx;
        if(mode.indexType == idx)
        {
            btn.selected = YES;
            btn.backgroundColor = KTHEME_COLOR;
        }
        if(idx ==0 || idx ==1)
        {
            UIView *lineView = [UIView createViewWithFrame:CGRectMake(btn.width - 0.5, 0, 0.5, btn.height)
                                           backgroundColor:KCOLOR_GRAY_c9c9c9];
            [btn addSubview:lineView];
        }
        
        
        [self addSubview:btn];
        [btn setTitleColor:KCOLOR_GRAY_676767 forState:UIControlStateNormal];
        [btn setTitleColor:KCOLOR_WHITE forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // icon comments
        if ([mode.comment_total isEqualToString:@"0"])
        {
           // empty
            
        } else {
            UILabel *commentLabel = [UILabel  createLabelWithFrame:CGRectMake((SCREEN_WIDTH -(btnWidth/3))-2,82, btnWidth/3, btnWidth/3)
                                                   backgroundColor:KTHEME_COLOR
                                                         textColor:KCOLOR_WHITE
                                                              font:kAutoFont_(10)
                                                     textalignment:NSTextAlignmentCenter
                                                              text:mode.comment_total
                                                      numberOfLine:4];
            
            commentLabel.layer.cornerRadius = commentLabel.width/2.0;
            commentLabel.layer.borderColor = KCOLOR_WHITE.CGColor;
            commentLabel.layer.borderWidth = 2.0;
            commentLabel.layer.masksToBounds = true;
            commentLabel.clipsToBounds = YES;
            
            [self addSubview:commentLabel];
        }
        
        
        //  (SCREEN_WIDTH -(btnWidth/3))
        
        
    }];
    UIView *lineView1 = [UIView createViewWithFrame:CGRectMake(0, [[self class] getHeight]- 0.5, SCREEN_WIDTH, 0.5)
                                    backgroundColor:KTHEME_COLOR];
    [self addSubview:lineView1];
    return self;
}
- (void)btnClick:(UIButton *)sender
{
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    if(_delegate)
    {
        [_delegate CDOutLineHeadViewbtnClick:sender.tag];
    }
}
+ (CGFloat )getHeight
{
    return 80 + 44;
}
@end

