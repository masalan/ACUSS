//
//  CDCommentCell.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import "CDCommentCell.h"
#define marginX 10
@implementation CDCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return  nil;
    }
    //titlePost
    _titlePost = [[UILabel alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _detailLabel = [[UILabel alloc] init];
    _bottomImageView = [[UIImageView alloc] init];
    _lineView = [[UIView alloc] init];
    _bottomImageView.hidden = NO;
    return self;
}
- (void)setMode:(StudentDetail_Column_M *)mode
{
    self.backgroundColor = KCOLOR_WHITE;
    
    //name
    _titleLabel = [UILabel resizeFrameWithLabel:_titleLabel
                                          frame:CGRectMake(marginX, 10,60, 15)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE
                                           font:KSYSTEM_FONT_(13)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    if( [mode.nickname isKindOfClass:[NSString class]] && mode.nickname)
    {
        _titleLabel.text = mode.nickname;
    }else
    {
        _titleLabel.text = @"username";
    }
    [self addSubview:_titleLabel];
    
    // Title post
    
    _titlePost = [UILabel resizeFrameWithLabel:_titlePost
                                          frame:CGRectMake(_titleLabel.right + 3, 5, SCREEN_WIDTH-200, 20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_BLACK
                                           font:KSYSTEM_FONT_(10)
                                  textalignment:NSTextAlignmentCenter
                                           text:@""];
    if ([mode.nameSchool isEqualToString:@"0"]) {
        _titlePost.text = @"";
    } else
    {
        _titlePost.text = mode.nameSchool;
    }
    
    [self addSubview:_titlePost];

    
    
    //Date
    _timeLabel = [UILabel resizeFrameWithLabel:_timeLabel
                                         frame:CGRectMake(SCREEN_WIDTH -200, 10, 180, 12)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE
                                          font:KSYSTEM_FONT_(10)
                                 textalignment:NSTextAlignmentRight
                                          text:@""];
    if(![mode.create_time isKindOfClass:[NSNull class]])
    {
        _timeLabel.text = [PublicMethod getMDHMWithCreatedTimestamp:mode.create_time];
    }
    [self addSubview:_timeLabel];
    CGFloat detailHeight = [[self class] getDetailHeight:mode];
    
    //Containt
    
    _detailLabel = [ UILabel createLabelWithFrame:CGRectMake(marginX, _titleLabel.bottom , SCREEN_WIDTH - marginX - 10, detailHeight)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_WHITE
                                             font:KSYSTEM_FONT_(11)
                                    textalignment:NSTextAlignmentLeft
                                             text:mode.contents
                                     numberOfLine:5];
    
    
    
    
    [self addSubview:_detailLabel];
    
    
    CGFloat imageViewWidth = [[self class] getImageViewHeight];
    _bottomImageView.hidden = NO;
    if([mode.images isKindOfClass:[NSArray class]] && [mode.images count] >0)
    {
        _bottomImageView = [UIView resizeView:_bottomImageView
                                        frame:CGRectMake(marginX, _detailLabel.bottom + 10, SCREEN_WIDTH - 2 * marginX, imageViewWidth)
                              backgroundColor:KCOLOR_CLEAR];
        _bottomImageView.userInteractionEnabled = YES;
        
        [mode.images enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *  stop) {
            if([obj hasPrefix:@"http"])
            {
                if(idx >=5)
                {
                    *stop = YES;
                    return ;
                }
                UIImageView *imageView = [UIImageView createImageViewWithFrame:CGRectMake(0 +  (imageViewWidth + 5) * idx, 0, imageViewWidth, imageViewWidth)
                                                               backgroundColor:KCOLOR_GRAY_f5f5f5 image:nil];
                imageView.userInteractionEnabled = YES;
                imageView.layer.cornerRadius = 8.0;
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj]]];
                
                imageView.tag = idx;
                [imageView bk_whenTapped:^{
                    if(_delegate && [_delegate respondsToSelector:@selector(imageTap:index:)])
                    {
                        [_delegate imageTap:mode.images index:idx];
                    }
                }];
                
                
                [_bottomImageView addSubview:imageView];
            }
        }];
        [self addSubview:_bottomImageView];
    }
    
    
    
    _lineView = [UIView resizeView:_lineView
                             frame:CGRectMake(0, [[self class] getCellHeight:mode] - 0.5, SCREEN_WIDTH, 0.5)
                   backgroundColor:KCOLOR_THEME];
    [self addSubview:_lineView];
    
}
+ (CGFloat)getCellHeight:(StudentDetail_Column_M *)mode
{
    CGFloat height = 45;
    height = height +[[self class] getDetailHeight:mode];
    
    if([mode.images isKindOfClass:[NSArray class]] && [mode.images count]>0)
    {
        height = height + [[self class] getImageViewHeight];
        height = height +5;
    }
    return  height ;
}
+ (CGFloat)getDetailHeight:(StudentDetail_Column_M *)mode
{
    return [PublicMethod getHeightWithWidth:SCREEN_WIDTH - marginX - 10 text:mode.contents font:KSYSTEM_FONT_(11)];
    
    
}
+ (CGFloat)getImageViewHeight
{
    return  (SCREEN_WIDTH - 2 * marginX)/5 - 10;
}

- (void)tabClick:(UITapGestureRecognizer *)tap
{
    
    if(_delegate && [_delegate respondsToSelector:@selector(imageTap:index:)])
    {
        [_delegate imageTap:self.mainMode.images index:[tap view].tag];
    }
}



@end

