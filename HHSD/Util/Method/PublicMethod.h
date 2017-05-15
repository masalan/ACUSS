//
//  PublicMethod.h
//  YWY2
//
//  Created by 汪达 on 15/3/16.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_2G= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_4G= 3,
    NETWORK_TYPE_5G= 4,//  5G目前为猜测结果
    NETWORK_TYPE_WIFI= 5,
}NETWORK_TYPE;

@interface PublicMethod : NSObject

+(CGFloat)getHeightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font;
+(CGFloat)getWidthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font;

+(NSString *)getNowTime;
+(NSString *)getDateUsingDate:(NSDate *)date;
+(NSString *)getDateWithYMDHMUsingDate:(NSDate *)date;
+(NSString *)getDateUsingDate:(NSDate *)date withFormater:(NSString *)formater;



+(NSString *)getDateUsingDateEasy:(NSDate *)date;
+(NSString *)getDateUsingDateEasy:(NSDate *)date withFormater:(NSString *)formater;


+(NSString *)getCreateTimeWithDate:(NSDate *)date;
+(NSString *)getChooseTimeWithDate:(NSDate *)date;
+(NSString *)getDateUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDUsingStringTimestamp:(NSString *)stringTimestamp;
+(NSString *)getMDUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getNowTimeStamp;
+(NSString *)getTimeUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getTimeWithHMUsingCreatedTimestamp:(NSString *)createdTimestamp;
+(NSDate *)getDateWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getAgeWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDHMWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getDateOfMDWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getYMDHMWithGetTimestamp:(NSString *)createdTimestamp;
+(NSString *)getMDWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)timeAgoWithDate:(NSDate *)date;
+(NSString *)getMDHMWithCreatedTimestamp:(NSString *)createdTimestamp;
+(NSString *)getMDHMWithTimestamp:(NSString *)createdTimestamp;
+(NSString *)timeAgoWithStamp:(NSString *)createdTimestamp;
+(NSString *)timeAgoWithStampEndTime:(NSString *)createdTimestamp;
+(NSString *)getTimeUsingCreatedTimestampWith8H:(NSString *)createdTimestamp;
+(NSInteger )getYear;
+(NSInteger )getMonth;
+(NSInteger )getDay;
+(NSString *)getStringwithNowOfDate;
+(NSString *)getYMDHMSWithCreatedTimestamp:(NSString *)createdTimestamp;
+(BOOL)timeAgoWithCurrentTime:(NSString *)createdTimestamp;
+(BOOL)timeBigThanTime:(NSString *)time1 time2:(NSString *)time2;
+(void)showMessage:(NSString *)message;
+(BOOL)validateMobile:(NSString *)mobileNum;
+(BOOL)validateEmail:(NSString *)email;

+ (void)toPushVC:(NSString *)vcName
  viewController:(UIViewController *)superViewController
        andTitle:(NSString *)vcTitle;

+ (CGRect)animation: (float) frame;

+(void)applyAttributeToLabel:(UILabel *)label atRange:(NSRange )range withAttributes:(NSDictionary *)attributes;
//判断相机权限是否打开
+(UIAlertView*)judgeCanUseCamera;
//判断字符串是否为空或是空格
+(BOOL)judgeStringIsSpace:(NSString *)str;

+(BOOL)isContainsEmoji:(NSString *)string;

#pragma mark - 生成二维码
+(UIImage *)getImageWithErweima:(NSString *)str withScale:(CGFloat)scale;

//获取当前wifi
+(NSString *)getCurrentWifiName;
//网络类型
+(NETWORK_TYPE)getNetworkTypeFromStatusBar;
//播放系统音效
+(SystemSoundID)playSystemSound:(NSString *)fileName;
//播放音乐
+(AVAudioPlayer *)playMusic:(NSString *)fileName;
//猫眼设置时间：距1970时间毫秒与标准时间转换
+(NSString *)GetTime:(NSString *)time;
//登录页图标视图设置
//+(UIImageView *)loginWithIconView :(UIImageView *)topImageView withImageNamed :(NSString *)named withIPhone4And5 :(CGRect)rect4 withIPhone6 :(CGRect)rect6 withElse :(CGRect)rectOther;
+(UIImageView *)loginWithIconView :(UIImageView *)topImageView withImageNamed :(NSString *)named withIPhone:(CGRect)rect;
//当前时间
+(NSString *)getDateNowWithMMDD;
+(NSString *)getDateNowWithYMDHM;
+(NSString *)getDateNowWithMMDDHHMM;
+(NSString *)getDateNowWithYYYY;
+(NSString *)getDateNowWithYYYYMMDD;
+(NSString *)getIconStringWithName:(NSString *)name;
//配置NaviBarItemColor
+(UIColor *)getNaviBarItemColor;
+(UIColor *)getNaviBarBackColor;

@end


