//
//  MainView_A.h
//  HHSD
//
//  Created by alain serge on 3/29/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"
#import "SWTableViewCell.h"


@protocol MySchoolDelegate <NSObject>
- (void)mySchool:(School_Details *)mySchoolCenter;
@end
@interface MainView_A : BaseViewController
@property (nonatomic, assign) BOOL isDelete; //if u want clean
@property (nonatomic, assign) BOOL isMySetting;
@property (nonatomic, weak) id <MySchoolDelegate> delegate;
@end



