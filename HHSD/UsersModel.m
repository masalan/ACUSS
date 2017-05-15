//
//  UsersModel.m
//  HHSD
//
//  Created by alain serge on 5/11/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "UsersModel.h"

@implementation UsersModel
+ (NSDictionary *)objectClassInArray
{
    return @{@"users":[Users_data class]
             
             };
}
@end
