//
//  citiesModel.h
//  HHSD
//
//  Created by alain serge on 5/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface citiesModel : NSObject

@property (nonatomic, strong) NSMutableArray *cities;

+ (NSDictionary *)objectClassInArray;

@end
