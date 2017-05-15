//
//  listModelData.h
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModelData : NSObject
@property (nonatomic, strong) NSMutableArray *school;
@property (nonatomic, strong) NSMutableArray *student;

+ (NSDictionary *)objectClassInArray;
@end
