//  The MIT License (MIT)
//
//  Copyright (c) 2014 Intermark Interactive
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>

@interface IMQuickSearchFilter : NSObject


#pragma mark - Create Filter
/**
 Creates an IMQuickSearchFilter object from a given NSArray of objects and an NSArray of NSStrings that correspond to the keys/properties that you want to search over.
 @param searchArray - NSArray of NSObjects to search over
 @param keys        - NSArray of NSStrings that correspond to the properties of the searchArray objects that you want to focus on.
 @returns IMQuickSearchFilter
 */
+ (IMQuickSearchFilter *)filterWithSearchArray:(NSArray *)searchArray keys:(NSArray *)keys;

/**
 Creates an IMQuickSearchFilter object from a given NSArray of objects and an NSArray of NSStrings that correspond to the keys/properties that you want to search over. Allows for input of alternative values to be searched.
 @param searchArray         - NSArray of NSObjects to search over
 @param keys                - NSArray of NSStrings that correspond to the properties of the searchArray objects that you want to focus on.
 @param alternativeValues   - NSDictionary of NSArray that will have a list of alternative values to search.
 @returns IMQuickSearchFilter
 */
+ (IMQuickSearchFilter *)filterWithSearchArray:(NSArray *)searchArray keys:(NSArray *)keys alternativeValues:(NSDictionary *)alternativeValues;


#pragma mark - Filter With Value
/**
 Filters the array for each key based on the input value parameter.
 @param value
 @returns NSSet
 */
- (NSSet *)filteredObjectsWithValue:(id)value;

@end
