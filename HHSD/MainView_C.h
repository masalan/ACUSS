//
//  MainView_C.h
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchModel.h"

#import "BaseViewController.h"
@interface MainView_C : BaseViewController
//@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) School_Details *mainMode;
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic, strong) SearchModel *searchList;;
@property (nonatomic, copy) NSString *schoolId;
@end



@interface majorCell : UITableViewCell

@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) UILabel *salesLabel;
@property (nonatomic, retain) UIImageView *statusView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
