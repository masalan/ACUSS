//
//  RegisterTableViewCell.h
//  HHSD
//
//  Created by alain serge on 3/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AchieveVerCodeDelegate <NSObject>
- (void)achieveBtnClick;
@end

@interface RegisterTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *achieveBtn;
@property (nonatomic, weak) id<AchieveVerCodeDelegate> delegate;
//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setInfo:(NSArray *)nameArr withTitleArr:(NSArray *)titleArr withIndexPath:(NSInteger)index;
@end
