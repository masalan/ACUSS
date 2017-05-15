//
//  CDCommentCell.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDCommentCellDelegate<NSObject>
- (void)imageTap:(NSArray *)urlArray index:(NSUInteger )index;
@end
@interface CDCommentCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel,*titlePost;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *bottomImageView;
@property (nonatomic, strong) UIView *userImageView;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) StudentDetail_Column_M *mainMode;

@property (nonatomic, weak) id  <CDCommentCellDelegate>delegate;
- (void)setMode:(StudentDetail_Column_M *)mode;
+ (CGFloat)getCellHeight:(StudentDetail_Column_M *)mode;
@end

//  StudentDetail_Column_M
