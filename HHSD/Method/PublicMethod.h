//
//  PublicMethod.h
//  YWY2
//
//  Created by 汪达 on 15/3/16.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicMethod : NSObject

+(CGFloat)getHeightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font;
+(CGFloat)getWidthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font;

+(NSString *)getNowTime;
+(NSString *)getDateUsingDate:(NSDate *)date;
+(NSString *)getDateUsingDate:(NSDate *)date withFormater:(NSString *)formater;
+(NSString *)getCreateTimeWithDate:(NSDate *)date;
+(NSString *)getDateUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getNowTimeStamp;
+(NSString *)getTimeUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSDate *)getDateWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getAgeWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDHMWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getMDWithCreatedTimestamp:(NSString *)createdTimestamp;
+ (NSString *)timeAgoWithDate:(NSDate *)date;
+(NSString *)getMDHMWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)timeAgoWithStamp:(NSString *)createdTimestamp;
+(NSString *)timeAgoWithStampEndTime:(NSString *)createdTimestamp;
+ (BOOL)timeAgoWithCurrentTime:(NSString *)createdTimestamp;
+(BOOL )timeBigThanTime:(NSString *)time1 time2:(NSString *)time2;
+(void)showMessage:(NSString *)message;
+ (BOOL)validateMobile:(NSString *)mobileNum;
@end
