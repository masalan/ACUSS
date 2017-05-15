//
//  PhdInteractView.h
//  HHSD
//
//  Created by alain serge on 3/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PhdCellDelegate<NSObject>
- (void)imageTap:(NSArray *)urlArray index:(NSUInteger )index;
@end
@interface PhdInteractView : UITableViewCell
@property (nonatomic, strong) UILabel *IconeFee,*startingDateText,*IconeSLang,*IconeStarting,*IconeName,*detailLabel,*timeLabel,*titleLabel,*CourseName,*startingDate,*deadline,*language,*fee,*IconDeadline,*deadLineText,*deadlineText;
@property (nonatomic, strong) UILabel *lineZero,*lineOne,*lineTtwo,*lineFour,*lineFive,*lineTree,*IconDuration,*Icondurationtext,*languageText,*IconeFeeText,*IconDurationLabel;
@property (nonatomic, strong) UIView *bottomImageView,*lineView;
@property (nonatomic, strong) UIButton *selectedBtn,*popView;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UILabel *textLeft,*textRigth;
@property (nonatomic, strong) PhdDetail_Column_M *mainMode;
@property (nonatomic, weak) id  <PhdCellDelegate>delegate;
- (void)setMode:(PhdDetail_Column_M *)mode;
+ (CGFloat)getCellHeight:(PhdDetail_Column_M *)mode;
@end
