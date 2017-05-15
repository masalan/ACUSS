//
//  Parser.h
//
//
//  Created by 汪达 on 14-2-28.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

@interface Parser : NSObject

#pragma mark - json array --> object array
/**
 *  json array --> object array
 *
 *  @param className className
 *  @param array     array
 *
 *  @return objectArray
 */
+(NSMutableArray *)parseToObjectArray:(NSString *)className WithArray:(NSArray*)array;

#pragma mark - json dictionary --> object
/**
 *  json dictionary --> object
 *
 *  @param className  className description
 *  @param dictionary dictionary description
 *
 *  @return nil
 */
+(id)parseToObject:(NSString *)className withDictionary:(NSDictionary *)dictionary;


@end


