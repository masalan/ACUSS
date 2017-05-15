//
//  SearchDetailsViewController.h
//  HHSD
//
//  Created by alain serge on 3/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchDetailsViewController : UIViewController
@property (nonatomic, strong) School_Details *mainMode;
@property (nonatomic, strong) SearchModel *searchList;;
@property (nonatomic, copy) NSString *schoolId;

@end
