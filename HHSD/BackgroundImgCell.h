//
//  BackgroundImgCell.h
//  HHSD
//
//  Created by alain serge on 3/26/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//@interface BackgroundImgCell : UITableViewCell
//
//@end




#import <UIKit/UIKit.h>
typedef void (^BgImgCellBlock) ();
@protocol BgImgCellDelegate <NSObject>
- (void)BgImgActionBtnClick:(Background_list *)mode;

@end
@interface BackgroundImgCell : UITableViewCell
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *numberLabel,*statusUsing;
@property (nonatomic, strong) UIButton *actionBtn; ;
@property (nonatomic, strong) Background_list *mainMode;

@property (nonatomic, weak) BgImgCellBlock actionBtnBlock;
@property (nonatomic, weak) id<BgImgCellDelegate>delegate;

- (void)setMode:(Background_list *)mode;
+ (CGFloat)getHeight;
@end
