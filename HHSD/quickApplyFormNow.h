//
//  quickApplyFormNow.h
//  HHSD
//
//  Created by alain serge on 5/3/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//



#import "BaseViewController.h"

@interface quickApplyFormNow : BaseViewController
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL isMyFabu;

@end
