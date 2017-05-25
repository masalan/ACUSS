//
//  SecondHandModel.h
//  HHSD
//
//  Created by alain serge on 4/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondHandModel : NSObject
@property (nonatomic, copy) NSString *i_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *low_price;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *zone_id;
@property (nonatomic, copy) NSString *see_count;
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, strong)NSMutableArray *photo;


@property (nonatomic, copy) NSString *issue_type;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *cycleName;
@property (nonatomic, copy) NSString *cycle_id;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *ip_user;
@property (nonatomic, copy) NSString *majorName;
@property (nonatomic, copy) NSString *major_id;
@property (nonatomic, copy) NSString *nameSchool;
@property (nonatomic, copy) NSString *school_id;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *studentActualCycle;
@property (nonatomic, copy) NSString *studentActualMajor;
@property (nonatomic, copy) NSString *studentBirthday;
@property (nonatomic, copy) NSString *studentMobilePhone;
@property (nonatomic, copy) NSString *studentMotherTongue;
@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *tuitionMajor;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *user_device;
@end

@interface Fabu_List : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;

@end



// Tweet list

@interface ALL_TWEET : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end



@interface tweet_view : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *avatar_user;
@property (nonatomic, copy) NSString *nationality;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *tweet_open;
@end











