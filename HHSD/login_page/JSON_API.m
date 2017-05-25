//
//  JSON_API.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "JSON_API.h"

/**
 *  Login
 */
@implementation Login_API
@end

/**
 *  Signup
 */
@implementation Signup_API
@end

// All list Data School
@implementation School_data
@end

@implementation Users_data
@end
// Details School
@implementation School_Details
@end

// Comments School
@implementation School_Comments
@end

// Bachelor Programms List
@implementation SchoolDetail_Column_M_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [SchoolDetail_Column_M class],
             @"data": [MasterDetail_Column_M class],
             @"data": [PhdDetail_Column_M class],
             @"data": [User_list_view class],

             };
}
@end

// Bachelor Programms
@implementation SchoolDetail_Column_M
@end

// Master Programms
@implementation MasterDetail_Column_M
@end

// Phd Programms
@implementation PhdDetail_Column_M
@end

//------------------------------------------- Students------------------------------------------- //

// Bachelor Programms List
@implementation StudentDetail_Column_M_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [StudentDetail_Column_M class],
             @"data": [MasterDetail_Column_M class],
             @"data": [PhdDetail_Column_M class],
             @"data": [StudentDetail_Comment_M class],
            // @"data": [Student_data class]

             };
}
@end
// Major User student
@implementation User_major
@end

// Profil User student
@implementation User_profil
@end

// All Student list
@implementation Student_data
@end

//  Student detail
@implementation Student_Details
@end


@implementation StudentDetail_Column_M
@end


@implementation StudentDetail_Comment_M
@end



// Background List

@implementation Background_list
@end


@implementation BACKGROUND_IMAGES_LIST
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"list": [Background_list class],
             };
}
@end


// Program cycle
@implementation propertyService_topCategory
@end

// Program cycle List
@implementation propertyService_topCategory_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [propertyService_topCategory class],
             };
}

@end




@implementation propertyService_secondCategory

@end
@implementation propertyService_secondCategory_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [propertyService_secondCategory class],
             };
}
@end




@implementation Countries_List_view

@end
@implementation All_Countries_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [Countries_List_view class],
             };
}
@end





@implementation Province_List_details

@end
@implementation All_Province_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"list": [Province_List_details class],
             };
}
@end






@implementation Type_List_details

@end
@implementation Type_Universities_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [Type_List_details class],
             };
}
@end


@implementation Attribute_List_details

@end
@implementation Attribute_Universities_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [Attribute_List_details class],
             };
}
@end





@implementation Teaching_language_details

@end
@implementation Teaching_languages_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [Teaching_language_details class],
             };
}
@end


@implementation Duration_details

@end
@implementation Duration_study_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [Duration_details class],
             };
}
@end

@implementation Mobile_Config
@end



// All list Data cities
@implementation Cities_data
@end

@implementation Users_view_data
@end

@implementation All_Users_list
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"users": [Users_view_data class],
             };
}
@end


@implementation School_description
@end


@implementation All_comments
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [User_list_view class],
             };
}
@end

@implementation User_list_view
@end



// move


@implementation JiaZhengDingDanMList
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [JiaZhengDingDanM class],
             };
}
@end


@implementation PropertyServiceMList
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data": [PropertyServiceM class],
             };
}
@end

@implementation kuaiDiDingDanM_List
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"orderInfo": [kuaiDiDingDanM class],
             };
}
@end



@implementation JiaZhengDingDanM
@end

@implementation PropertyServiceM
@end

@implementation kuaiDiDingDanM
@end


@implementation JiaZhengDingDanM_Category
@end
@implementation PropertyService_Category
@end




@implementation ALL_GRADUATE

+ (NSDictionary *)objectClassInArray
{
    return @{@"data":[gradutate_view class]};
}
@end

@implementation gradutate_view

@end






















