//
//  SearchStudentModel.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchStudentModel : NSObject

@property (nonatomic, strong) NSMutableArray *student;
@property (nonatomic, strong) NSMutableArray *school;


+ (NSDictionary *)objectClassInArray;

@end
