//
//  listModelData.m
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "listModelData.h"

@implementation listModelData
+ (NSDictionary *)objectClassInArray
{
    return @{@"school":[School_data class],
             @"student":[Student_data class]};
}

@end
