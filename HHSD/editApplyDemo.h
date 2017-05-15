//
//  editApplyDemo.h
//  HHSD
//
//  Created by alain serge on 4/21/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"

@interface editApplyDemo : BaseViewController
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL isMyFabu;
@end
