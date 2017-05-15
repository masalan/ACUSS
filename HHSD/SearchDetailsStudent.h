//
//  SearchDetailsStudent.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchStudentModel.h"

@interface SearchDetailsStudent : UIViewController
@property (nonatomic, strong) Student_Details *mainMode;
@property (nonatomic, strong) SearchStudentModel *searchList;;
@property (nonatomic, copy) NSString *studentId;

@end

