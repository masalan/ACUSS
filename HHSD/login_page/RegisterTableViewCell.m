//
//  RegisterTableViewCell.m
//  HHSD
//
//  Created by alain serge on 3/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//
#import "RegisterTableViewCell.h"



@implementation RegisterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KCOLOR_GRAY_f5f5f5;
        _nameLabel = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_15, 10, 80, 30)
                                   backgroundColor:KCOLOR_WHITE
                                         textColor:KCOLOR_BLACK
                                              font:KSYSTEM_FONT_(16)
                                     textalignment:NSTextAlignmentLeft
                                              text:@""];
        [self addSubview:_nameLabel];
        //
        _titleLabel = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_15+85, 10, 150, 30)
                                    backgroundColor:KCOLOR_WHITE
                                          textColor:KCOLOR_GRAY
                                               font:KSYSTEM_FONT_(16)
                                      textalignment:NSTextAlignmentLeft
                                               text:nil];
        
        [self addSubview:_titleLabel];
        
        //
        _achieveBtn = [UIButton createButtonwithFrame:CGRectMake(KSCREEN_WIDTH-95, 10, 80, 30)
                                      backgroundColor:KTHEME_COLOR
                                           titleColor:KCOLOR_WHITE
                                                title:@"获取验证码"];
        _achieveBtn.layer.cornerRadius = 5.0;
        _achieveBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _achieveBtn.hidden = YES;
        [_achieveBtn addTarget:self action:@selector(achieveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_achieveBtn];
    }
    return self;
}

-(void)setInfo:(NSArray *)nameArr withTitleArr:(NSArray *)titleArr withIndexPath:(NSInteger)index{
    _nameLabel.text = nameArr[index];
    _titleLabel.text = titleArr[index];
    if (index == 4) {
        _achieveBtn.hidden = NO;
    }
    else {
        _achieveBtn.hidden = YES;
    }
}

- (void)achieveBtnClick {
    if(_delegate) {
        [_delegate achieveBtnClick];
    }
}

@end
