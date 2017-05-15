//
//  MainView_A_details.h
//  HHSD
//
//  Created by alain serge on 3/30/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchModel.h"
@interface MainView_A_details : BaseViewController
@property (nonatomic, strong) School_Details *mainMode;
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, strong) SearchModel *searchList;;
@property (nonatomic, copy) NSString *schoolId;
@end
