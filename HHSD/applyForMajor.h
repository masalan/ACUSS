//
//  applyForMajor.h
//  HHSD
//
//  Created by alain serge on 4/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"

@interface applyForMajor : BaseViewController
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL isMyFabu;

@end
