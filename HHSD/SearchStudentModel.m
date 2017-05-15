//
//  SearchStudentModel.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchStudentModel.h"


@implementation SearchStudentModel

+ (NSDictionary *)objectClassInArray
{    return @{@"student":[Student_data class],
           @"school":[School_data class]};
}

@end
