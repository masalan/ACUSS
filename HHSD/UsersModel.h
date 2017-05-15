//
//  UsersModel.h
//  HHSD
//
//  Created by alain serge on 5/11/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface UsersModel : NSObject

@property (nonatomic, strong) NSMutableArray *users;

+ (NSDictionary *)objectClassInArray;

@end
