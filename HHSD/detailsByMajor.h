//
//  detailsByMajor.h
//  HHSD
//
//  Created by alain serge on 4/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"

@interface detailsByMajor : BaseViewController
@property (nonatomic, copy) NSString *majorID;
@property (nonatomic, strong) School_Details *SID;

@property (nonatomic, strong) School_Details *school_details;

@end
