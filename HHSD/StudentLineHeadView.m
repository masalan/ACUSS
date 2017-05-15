//
//  StudentLineHeadView.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "StudentLineHeadView.h"
#import "UIImageView+SDWDImageCache.h"
#define btnWidth SCREEN_WIDTH/3
#define btnHeight 44
#define logo_length SCREEN_WIDTH/3

#define lineH logo_length+52
#define lineBtn lineH+btnHeight+30

#define honorLabel 30

//#define H logo_length+340
#define H logo_length + 44

@implementation StudentLineHeadView
- (instancetype)initWithMode:(Student_Details *)mode
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH,H);
    self.backgroundColor = KCOLOR_CLEAR;
    
    
    _logoSchool = [UIImageView createImageViewWithFrame:CGRectMake(10,25, logo_length, logo_length)
                                        backgroundColor:KCOLOR_CLEAR
                                                  image:nil];
    
    if([mode.head_image hasPrefix:@"http"]) {
        [_logoSchool sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.head_image]]
                       placeholderImage:[UIImage imageNamed:@"PlaceHoder"]];
    }
    else {
        _logoSchool.image = [UIImage imageNamed:@"PlaceHoder"];
    }
    
    
    _logoSchool.layer.cornerRadius = _logoSchool.size.height/2;
    _logoSchool.layer.masksToBounds = YES;
    _logoSchool.backgroundColor = KCOLOR_CLEAR;
    _logoSchool.layer.borderWidth = 2.0;
    _logoSchool.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_logoSchool];
    
    // Name University
    _nameUniversity = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10, 10, SCREEN_WIDTH-(logo_length+10)-20,50)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_NAME_SCHOOL
                                               font:KSYSTEM_FONT_(13)
                                      textalignment:NSTextAlignmentCenter
                                               text:mode.realname];
    if (mode.realname) {
        _nameUniversity.text = [NSString stringWithFormat:@"%@",mode.realname];
    }else{
        _nameUniversity.text = [NSString stringWithFormat:@"..."];
    }
    
    _nameUniversity.numberOfLines = 3;
    [self addSubview:_nameUniversity];
    
    // attribute University
    _attributeIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_nameUniversity.bottom, 20,20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:KICON_FONT_(15)
                                      textalignment:NSTextAlignmentLeft
                                               text:@"\U0000e781"];
    [self addSubview:_attributeIcone];
    
    // attribute University
    _attribute = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_nameUniversity.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_GRAY
                                          font:KICON_FONT_(10)
                                 textalignment:NSTextAlignmentLeft
                                          text:mode.attribute];
    if (mode.attribute) {
        _attribute.text = [NSString stringWithFormat:@"%@",mode.attribute];
    }else{
        _attribute.text = [NSString stringWithFormat:@""];
    }
    
    [self addSubview:_attribute];
    
    // Level Icone
    _levelIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_attribute.bottom, 20,20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_Black_343434
                                           font:KICON_FONT_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:@"\U0000e76a"];
    [self addSubview:_levelIcone];
    
    // Level University
    _level = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_attribute.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                           backgroundColor:KCOLOR_CLEAR
                                 textColor:KCOLOR_GRAY
                                      font:KICON_FONT_(10)
                             textalignment:NSTextAlignmentLeft
                                      text:nil];
    if (mode.level) {
        _level.text = [NSString stringWithFormat:@"%@",mode.level];
    }else{
        _level.text = [NSString stringWithFormat:@""];
    }
    [self addSubview:_level];
    
    // Type Icone
    _typeIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_level.bottom, 20,20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_GREEN
                                          font:KICON_FONT_(15)
                                 textalignment:NSTextAlignmentLeft
                                          text:@"\U0000e601"];
    [self addSubview:_typeIcone];
    
    // Type University
    _type = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_level.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                          backgroundColor:KCOLOR_CLEAR
                                textColor:KCOLOR_GRAY
                                     font:KICON_FONT_(10)
                            textalignment:NSTextAlignmentLeft
                                     text:nil];
    
    if (mode.type) {
        _type.text = [NSString stringWithFormat:@"%@",mode.type];
    }else{
        _type.text = [NSString stringWithFormat:@""];
    }
    [self addSubview:_type];
    
    
    // Type Icone
    _locationIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_type.bottom, 20,20)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_RED
                                              font:KICON_FONT_(15)
                                     textalignment:NSTextAlignmentLeft
                                              text:@"\U0000e677"];
    [self addSubview:_locationIcone];
    
    // Type University
    _location = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_type.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_GRAY
                                         font:KICON_FONT_(10)
                                textalignment:NSTextAlignmentLeft
                                         text:nil];
    
    if (mode.locationName) {
        _location.text = [NSString stringWithFormat:@"%@ , Urban",mode.locationName];
    }else{
        _location.text = [NSString stringWithFormat:@""];
    }
    [self addSubview:_location];
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, H+44, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_CLEAR];
    [self addSubview:lineView];
    NSArray *array = [NSArray arrayWithObjects:@"Bachelor",@"Master", @"Phd",  nil];
    [array enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL *  stop) {
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(btnWidth * idx,H, btnWidth, btnHeight)
                                        backgroundColor:KCOLOR_SELECT_MENU
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:obj];
        btn.tag = idx;
        if(mode.indexType == idx)
        {
            btn.selected = YES;
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
        
        
        
        
        
        
        
        
    }];
    UIView *lineView1 = [UIView createViewWithFrame:CGRectMake(0,[[self class] getHeight]+0.5, SCREEN_WIDTH, 0.5)
                                    backgroundColor:KCOLOR_CLEAR];
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
        [_delegate SchoolLineHeadViewbtnClick:sender.tag];
    }
}





+ (CGFloat )getHeight
{
    return H+45;
}


@end
