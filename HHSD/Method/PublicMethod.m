//
//  PublicMethod.m
//  YWY2
//
//  Created by 汪达 on 15/3/16.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "PublicMethod.h"

@implementation PublicMethod

+(CGFloat)getHeightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.height;
}
+(CGFloat)getWidthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.width;
}







#pragma mark
#pragma mark - date now
+(NSDateComponents *)component
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents * component= [gregorian  components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:[NSDate date]];
    return component;
}
+(NSInteger )getYear
{
    return [[self component] year];
}
+(NSInteger )getMonth
{
    return [[self component] month];
}
+(NSInteger )getDay
{
    return [[self component] day];
}
+(NSString *)getNowTime
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
}

#pragma mark
#pragma mark -createdTimestamp

+(NSString *)getDateUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getDateUsingDate:(NSDate *)date withFormater:(NSString *)formater
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:formater];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getCreateTimeWithDate:(NSDate *)date
{
    NSTimeInterval timeIn = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",timeIn];
}
+(NSString *)getDateUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *time = [NSString stringWithFormat:@"%@",createdTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return @"无时间";
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            return [self timeAgoWithDate:date];
        }
    }
    return @"无时间";
}
+(NSString *)getYMDUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *time = [NSString stringWithFormat:@"%@",createdTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return @"无时间";
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"yyyy-MM-dd"];
            return [dateFormater stringFromDate:date];
        }
    }
    return @"无时间";
}
+(NSString *)getNowTimeStamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeIn = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",timeIn];
}



+(NSString *)getYearUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"YYYY"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMonthUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getDayUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"d"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getTimeUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
    
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getYMDHMWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy年M月d日 HH:mm"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMDHMWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M月d日 HH:mm"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMDWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M-d"];
    return [dateFormater stringFromDate:date];
}
+(NSDate *)getDateWithCreatedTimestamp:(NSString *)createdTimestamp
{
    return [NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
}

+(NSString *)getAgeWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *birthYear = [[self class] getYearUsingCreatedTimestamp:createdTimestamp];
    NSInteger thisYear = [[self class] getYear];
    NSString *age = [NSString stringWithFormat:@"%ld",(long)thisYear-[birthYear integerValue]+1];
    return age;
}
+ (BOOL)timeAgoWithCurrentTime:(NSString *)createdTimestamp
{
    NSString *nowTimeString = [[self class] getNowTimeStamp];
    if([nowTimeString intValue] > [createdTimestamp intValue])
    {
        return NO;
    }else
    {
        return YES;
    }
}
+(BOOL )timeBigThanTime:(NSString *)time1 time2:(NSString *)time2
{
    if([time1 intValue] > [time2 intValue])
    {
        return YES;
    }else
    {
        return NO;
    }
}
+(NSString *)timeAgoWithStamp:(NSString *)createdTimestamp
{
    NSDate *now = [NSDate date];
    NSDate *createDate = [[self class] getDateWithCreatedTimestamp:createdTimestamp];
    double deltaSeconds = fabs([createDate timeIntervalSinceDate:now]);
    
    int deltaMinutes = ((int)floor(deltaSeconds/60))%60;
    int DeltaHour =((int)deltaSeconds/(60*60))%24;
    int deltaDay = (int)(deltaSeconds/(60*60*24));
    return [NSString stringWithFormat:@"%d天%d时%d分",deltaDay,DeltaHour,deltaMinutes];
}
+(NSString *)timeAgoWithStampEndTime:(NSString *)createdTimestamp
{
    NSDate *now = [NSDate date];
    NSDate *createDate = [[self class] getDateWithCreatedTimestamp:createdTimestamp];
    double deltaSeconds = [createDate timeIntervalSinceDate:now];
    if(deltaSeconds >0)
    {
        int deltaMinutes = ((int)floor(deltaSeconds/60))%60;
        int DeltaHour =((int)deltaSeconds/(60*60))%24;
        int deltaDay = (int)(deltaSeconds/(60*60*24));
        return [NSString stringWithFormat:@"%d天%d时%d分",deltaDay,DeltaHour,deltaMinutes];
    }else
    {
        return  @"";
    }
  
}
+ (NSString *)timeAgoWithDate:(NSDate *)date
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([date timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    if(deltaSeconds < 5)
    {
                return @"刚刚";
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"hh:mm"]];
    }
    else if(deltaSeconds < 60)
    {
                return [NSString stringWithFormat:@"%.0f秒前",deltaSeconds];
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"hh:mm"]];
    }
    else if(deltaSeconds < 120)
    {
                return @"1分钟前";
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"hh:mm"]];
    }
    else if (deltaMinutes < 60)
    {
                return [NSString stringWithFormat:@"%.0f分钟前",deltaMinutes];
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
    }
    else if (deltaMinutes < 120)
    {
                return @"1小时前";
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
                return [NSString stringWithFormat:@"%d小时前",minutes];
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24));
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 7));
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
//        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日 hh:mm"]];
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];

    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date]];
    }
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date]];
}



+(void)showMessage:(NSString *)message
{
//    [JDStatusBarNotification showWithStatus:message
//                               dismissAfter:3.0
//                                  styleName:@"Notifications"];
}
/**
 *  正则表达式 验证手机号
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{

    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    return NO;
}
@end
