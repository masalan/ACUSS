//
//  MyFabuTableViewCell.m
//  HHSD
//
//  Created by alain serge on 4/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MyFabuTableViewCell.h"
#define SW2 SCREEN_WIDTH/2
@implementation MyFabuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    
    // school name
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-50, 40)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_Black_343434
                                           font:kAutoFont_(13)
                                  textalignment:NSTextAlignmentCenter
                                           text:@""];
    _titleLabel.numberOfLines = 3;
    
    // Cycle
    _liuLabel = [UILabel createLabelWithFrame:CGRectMake(15, _titleLabel.bottom,70, 30)
                              backgroundColor:KCOLOR_Clear
                                    textColor:KCOLOR_GRAY_999999
                                         font:kAutoFont_(12)
                                textalignment:NSTextAlignmentLeft
                                         text:@""];
    // major
    _ciLabel = [UILabel createLabelWithFrame:CGRectMake(_liuLabel.right+10, _titleLabel.bottom, SW2+100, 40)
                             backgroundColor:KCOLOR_Clear
                                   textColor:KCOLOR_GRAY_999999
                                        font:kAutoFont_(12)
                               textalignment:NSTextAlignmentLeft
                                        text:@""];
    _ciLabel.numberOfLines = 3;
    
    
    
    _priceLabel = [UILabel createLabelWithFrame:CGRectMake(_ciLabel.right+10, _titleLabel.bottom, 130, 30)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_GRAY_999999
                                           font:kAutoFont_(13)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    
    _dateLabel = [UILabel createLabelWithFrame:CGRectMake(10, _liuLabel.bottom, _titleLabel.width, 30)
                               backgroundColor:KCOLOR_Clear
                                     textColor:KTHEME_COLOR
                                          font:kAutoFont_(10)
                                 textalignment:NSTextAlignmentLeft
                                          text:@""];
    _rightIconLabel = [UILabel createLabelWithFrame:CGRectMake(KSCREEN_WIDTH-35, _titleLabel.bottom, 25, 25)
                                    backgroundColor:KCOLOR_Clear
                                          textColor:KTHEME_COLOR
                                               font:KICON_FONT_(25)
                                      textalignment:NSTextAlignmentLeft
                                               text:@"\U0000e6cf"];
    
    _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH-40, _titleLabel.bottom, 40, 40)];
    _moreBtn.selected = NO;
    [_moreBtn addTarget:self action:@selector(moreBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.contentView addSubview:_liuLabel];
    [self.contentView addSubview:_photoImg];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_ciLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_rightIconLabel];
    [self.contentView addSubview:_moreBtn];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH-40-135, _titleLabel.bottom-8, 140, 50)];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"actionForm"]];
    [_backView addSubview:image];
    
    _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
    //[_editBtn addTarget:self action:@selector(editBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_editBtn];
    
    _delBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 0, 70, 50)];
    //[_delBtn addTarget:self action:@selector(delBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_delBtn];
    [self.contentView addSubview:_backView];
    _backView.hidden = YES;
    
    return self;
}


-(void)moreBtnAction {
    if(_moreBtn.selected == YES){
        _moreBtn.selected = NO;
        _backView.hidden = YES;
        _rightIconLabel.text = @"\U0000e6cf";
    }
    else {
        _moreBtn.selected = YES;
        _backView.hidden = NO;
        _rightIconLabel.text = @"\U0000e71b";
    }
}

- (void)setMode:(SecondHandModel *)mode withIndexSection:(NSInteger)section {
    
    _titleLabel.text = [NSString stringWithFormat:@"%@",mode.nameSchool];
    _liuLabel.text = [NSString stringWithFormat:@"%@",mode.cycleName];
    _ciLabel.text = [NSString stringWithFormat:@"%@",mode.majorName];
    _dateLabel.text = [NSString stringWithFormat:@"Apply date: %@",[PublicMethod getYMDUsingCreatedTimestamp:
                                                           mode.create_time]];
    _editBtn.tag = section;
    _delBtn.tag = section;
    _rightIconLabel.text = @"\U0000e6cf";
}

+ (CGFloat)getHeight
{
    return 100;
}

@end
