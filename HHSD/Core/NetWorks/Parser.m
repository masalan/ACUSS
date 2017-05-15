//
//  Parser.m
//  
//
//  Created by 汪达 on 14-2-28.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import "Parser.h"
#include <objc/runtime.h>

@implementation Parser


#pragma mark - json array --> object array

+(NSMutableArray *)parseToObjectArray:(NSString *)className WithArray:(NSArray*)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray *needArray=[[NSMutableArray alloc]init];
        NSMutableArray *nameArray=[[NSMutableArray alloc]init];
        NSMutableArray *typeArray=[[NSMutableArray alloc]init];
        unsigned int numberOfIvars = 0;//model的变量数
        Ivar *vars = class_copyIvarList(NSClassFromString(className), &numberOfIvars);
        NSString *key = [NSString string];
        NSString *type = [NSString string];
        for(int i = 0; i < numberOfIvars; i++) {
            Ivar thisIvar = vars[i];
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
            type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
            [nameArray addObject:key];
            [typeArray addObject:typeArray];
        }
        for (NSInteger i = 0; i < [array count]; i++) {
            id object = [[NSClassFromString(className) alloc] init];//类名转化成类。。-----------model------------
            for (NSInteger n = 0; n<[nameArray count]; n++) {
                NSString *name = nameArray[n];
                if ([array[i] objectForKey:name] ) {
                    if ([[array[i] objectForKey:name] isEqual:[NSNull null]]) {
                            [object setValue:nil forKey:name];
                    }else{
                        [object setValue:[array[i] objectForKey:name] forKey:name];
                    }
                }else{
                    [object setValue:nil forKey:name];
                }
            }
            
            
            
//            for (NSString *name in nameArray) {
//                if ([array[i] objectForKey:name] ) {
//                    if ([[array[i] objectForKey:name] isEqual:[NSNull null]]) {
//                        [object setValue:nil forKey:name];
//                    }else{
//                        [object setValue:[array[i] objectForKey:name] forKey:name];
//                    }
//                }else{
//                    [object setValue:nil forKey:name];
//                }
//            }
            [needArray addObject:object];
        }
        return needArray;
    }
    return nil;
}



#pragma mark - json dictionary --> object

+(id)parseToObject:(NSString *)className withDictionary:(NSDictionary *)dictionary
{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *nameArray=[[NSMutableArray alloc]init];
        unsigned int numberOfIvars = 0;//model的变量数
        Ivar *vars = class_copyIvarList(NSClassFromString(className), &numberOfIvars);
        NSString *key=nil;
        for(int i = 0; i < numberOfIvars; i++) {
            Ivar thisIvar = vars[i];
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
            [nameArray addObject:key];
        }
        id object = [[NSClassFromString(className) alloc] init];//类名转化成类。。-----------model------------
        for (NSString *name in nameArray) {
            if ([dictionary objectForKey:name] ) {
                if ([[dictionary objectForKey:name] isEqual:[NSNull null]]) {
                    [object setValue:nil forKey:name];
                }else{
                    [object setValue:[dictionary objectForKey:name] forKey:name];
                }
            }else{
                [object setValue:nil forKey:name];
            }
        }
        return object;
    }
    return nil;
}

@end

