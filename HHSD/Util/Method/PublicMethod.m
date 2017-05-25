//
//  PublicMethod.m
//  YWY2
//
//  Created by 汪达 on 15/3/16.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "PublicMethod.h"
#import <objc/runtime.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#ifdef _YWY2_ZHFG_MACROS_
#import "MyDeviceViewController.h"
#endif


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
    
    NSDateComponents * component= [gregorian  components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                fromDate:[NSDate date]];
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
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    //    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormater stringFromDate:date];
}

+(NSString *)getDateUsingDateEasy:(NSDate *)date
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    return [dateFormater stringFromDate:date];
}
//getDateUsingDateEasy



+(NSString *)getDateWithYMDHMUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy年M月d日HH时mm分"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getDateUsingDate:(NSDate *)date withFormater:(NSString *)formater
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:formater];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getDateUsingDateEasy:(NSDate *)date withFormater:(NSString *)formater
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
//解决 上面 getCreateTimeWithDate方法 时间差问题（时间差是时间空间传过来就少，在这里加上）
+(NSString *)getChooseTimeWithDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSTimeInterval timeIn = [localeDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",timeIn];
}
+(NSString *)getDateUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *time = [NSString stringWithFormat:@"%@",createdTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            return [self timeAgoWithDate:date];
        }
    }
    return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
}
+(NSString *)getYMDUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *time = [NSString stringWithFormat:@"%@",createdTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"yyyy-MM-dd"];
            return [dateFormater stringFromDate:date];
        }
    }
    return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
}

+(NSString *)getMDUsingCreatedTimestamp:(NSString *)createdTimestamp
{
    NSString *time = [NSString stringWithFormat:@"%@",createdTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"MM-dd"];
            return [dateFormater stringFromDate:date];
        }
    }
    return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
}

+(NSString *)getYMDUsingStringTimestamp:(NSString *)stringTimestamp{
    NSString *time = [NSString stringWithFormat:@"%@",stringTimestamp];
    if ([time length]) {
        if ([time isEqualToString:@"0"]) {
            return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:[time floatValue]];
            NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"yyyy/MM/dd"];
            return [dateFormater stringFromDate:date];
        }
    }
    return NSLocalizedString(@"TIME_TRANSLATE_EDIT_A",comment:"");
}

+(NSString *)getNowTimeStamp
{
    NSDate *date = [NSDate date];
    //解决8小时时差
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSTimeInterval timeIn = [localeDate timeIntervalSince1970];
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

+(NSString *)getTimeUsingCreatedTimestampWith8H:(NSString *)createdTimestamp
{
    CGFloat times = [createdTimestamp floatValue]-28800;
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:times];
    //    //解决8小时时差
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm"];
    return [dateFormater stringFromDate:date];
}

+(NSString *)getTimeWithHMUsingCreatedTimestamp:(NSString *)createdTimestamp {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp floatValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH时mm分"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getYMDWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy年M月d日"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getYMDHMWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:NSLocalizedString(@"TIME_TRANSLATE_EDIT_B",comment:"")];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getYMDHMWithGetTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy年M月d日HH时mm分"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMDHMWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M月d日 HH:mm"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMDHMWithTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M月d日HH时mm分"];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getMDWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:NSLocalizedString(@"TIME_TRANSLATE_EDIT_D",comment:"")];
    return [dateFormater stringFromDate:date];
}
+(NSString *)getDateOfMDWithCreatedTimestamp:(NSString *)createdTimestamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"M.d"];
    return [dateFormater stringFromDate:date];
}
+(NSDate *)getDateWithCreatedTimestamp:(NSString *)createdTimestamp
{
    return [NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
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
    }
    else if(deltaSeconds < 60)
    {
        return [NSString stringWithFormat:@"%.0f秒前",deltaSeconds];
    }
    else if(deltaSeconds < 120)
    {
        return @"1分钟前";
    }
    else if (deltaMinutes < 60)
    {
        return [NSString stringWithFormat:@"%.0f分钟前",deltaMinutes];
    }
    else if (deltaMinutes < 120)
    {
        return @"1小时前";
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
        return [NSString stringWithFormat:@"%d小时前",minutes];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
        
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
        
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date withFormater:@"M月d日"]];
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date]];
    }
    
    return [NSString stringWithFormat:@"%@",[[self class] getDateUsingDate:date]];
}

//当前时间字符串（YYYY-MM-dd）
+(NSString *)getStringwithNowOfDate {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)getYMDHMSWithCreatedTimestamp:(NSString *)createdTimestamp {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[createdTimestamp integerValue]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    return [dateFormater stringFromDate:date];
}

+(void)showMessage:(NSString *)message
{
    
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

/**
 *  正则表达式 验证邮箱
 */
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - push
+ (void)toPushVC:(NSString *)vcName
  viewController:(UIViewController *)superViewController
        andTitle:(NSString *)vcTitle
{
    NSString *class =[NSString stringWithFormat:@"%@",vcName];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    if (vcTitle) {
        [instance setValue:vcTitle forKey:@"titleString"];
    }
    
    [superViewController.navigationController pushViewController:instance animated:YES];
}

+ (CGRect)animation:(float)frame
{
    NSTimeInterval textAnimation = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:textAnimation];
    
    CGRect theframe = CGRectMake(0.0f, frame, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    
    return theframe;
}

+(void)applyAttributeToLabel:(UILabel *)label atRange:(NSRange )range withAttributes:(NSDictionary *)attributes {
    NSMutableAttributedString *attributeString = [label.attributedText mutableCopy];
    [attributeString addAttributes:attributes range:range];
    label.attributedText = attributeString;
}

//判断相机权限是否打开
+(UIAlertView*)judgeCanUseCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    UIAlertView *alert;
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        alert = [[UIAlertView alloc]
                 initWithTitle:@"相机权限受限"
                 message:@"请到系统设置中打开相机访问权限"
                 delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    return alert;
}

//判断字符串是否为空或是空格
+(BOOL)judgeStringIsSpace:(NSString *)str {
    if([str isEqualToString:@""] || !(str.length>0) ) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string = [str stringByTrimmingCharactersInSet:set];
    if([string length] == 0){
        return YES;
    }
    else {
        return NO;
    }
}


+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

+(UIImage *)getImageWithErweima:(NSString *)str withScale:(CGFloat)scale {
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    //将CIImage转换成UIImage,并放大显示
    UIImage *image = [UIImage imageWithCIImage:outputImage scale:scale orientation:UIImageOrientationUp];
    return image;
}

//获取当前wifi
+ (NSString *)getCurrentWifiName {
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }
    NSLog(@"wifiName:%@", wifiName);
    return wifiName;
}

//网络类型
+(NETWORK_TYPE)getNetworkTypeFromStatusBar {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])     {
            dataNetworkItemView = subview;
            break;
        }
    }
    NETWORK_TYPE nettype = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    nettype = [num intValue];
    return nettype;
}

//播放系统音效
+(SystemSoundID)playSystemSound:(NSString *)fileName{
    if (!fileName) {
        return 0;
    }
    SystemSoundID soundId;
    
    //加载url
    NSURL *fileUrl=[[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    if (!fileUrl) {
        return 0;
    }
    //创建系统音效
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundId);
    //播放
    AudioServicesPlaySystemSound(soundId);
    return soundId;
}

//播放音乐
+(AVAudioPlayer *)playMusic:(NSString *)fileName{
    if (!fileName) {
        return nil;
    }
    AVAudioPlayer *player;
    NSURL *url=[[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    if (!url) {
        return nil;
    }
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];//准备播放，提前把这个音频文件放入缓存
    [player play];
    return player;
}

//猫眼设置时间：距1970时间毫秒与标准时间转换
+(NSString *)GetTime:(NSString *)time {
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time integerValue]/1000];
    //    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    //    [dateFormater setDateFormat:@"yyyy年M月d日 HH:mm:ss"];
    //    return [dateFormater stringFromDate:date];
    
    double publishLong = [time doubleValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong];
    NSString *publishString = [formatter stringFromDate:publishDate];
    return publishString;
}

//登录页图标视图设置
//+(UIImageView *)loginWithIconView :(UIImageView *)topImageView withImageNamed :(NSString *)named
//                  withIPhone4And5 :(CGRect)rect4 withIPhone6 :(CGRect)rect6 withElse :(CGRect)rectOther {
//    if(iPhone4 || iPhone5) {
//        topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect4.origin.x, SCREEN_HEIGHT/6-10, rect4.size.width, rect4.size.height)];
//    }else if(iPhone6) {
//        topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect6.origin.x, SCREEN_HEIGHT/6-10, rect6.size.width, rect6.size.height)];
//    }else {
//        topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rectOther.origin.x, SCREEN_HEIGHT/6-10, rectOther.size.width, rectOther.size.height)];
//    }
//    topImageView.centerX = SCREEN_WIDTH/2;
//    topImageView.image = [UIImage imageNamed:named];
//    return topImageView;
//}

//登录页图标视图设置（新20161228）
+(UIImageView *)loginWithIconView :(UIImageView *)topImageView withImageNamed:(NSString *)named withIPhone:(CGRect)rect {
    topImageView = [[UIImageView alloc] initWithFrame:rect];
    topImageView.centerX = SCREEN_WIDTH/2;
    topImageView.image = [UIImage imageNamed:named];
    return topImageView;
}

//当前时间
+(NSString *)getDateNowWithMMDD{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}
+(NSString *)getDateNowWithYMDHM{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}
+(NSString *)getDateNowWithMMDDHHMM{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日HH时mm分"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}
+(NSString *)getDateNowWithYYYY{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}

+(NSString *)getDateNowWithYYYYMMDD{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}

+(NSString *)getIconStringWithName:(NSString *)name {
    NSString *hexString = [name substringWithRange:NSMakeRange(3, 4)];
    unsigned int character;
    NSScanner* scanner = [NSScanner scannerWithString:hexString ];
    [scanner scanHexInt:&character ];
    UTF32Char inputChar = NSSwapHostIntToLittle(character); // swap to little-endian if necessary
    NSString *str = [[NSString alloc] initWithBytes:&inputChar length:4 encoding:NSUTF32LittleEndianStringEncoding];
    return str;
}

+(UIColor *)getNaviBarItemColor {
    UIColor *color;
#ifdef _YWY2_DEXELOP_MACROS_
    color = KCOLOR_333;   //白色navigationBar背景色，设置title／baritem 颜色为：KCOLOR_333
#elif ztxTargetName
    color = KCOLOR_333;
#else
    color = KCOLOR_WHITE; //蓝色(KTHEME_COLOR)navigationBar背景色，设置title／baritem 颜色为：白色
#endif
    return color;
}

+(UIColor *)getNaviBarBackColor {
    UIColor *color;
#ifdef _YWY2_DEXELOP_MACROS_
    color = KCOLOR_WHITE;   //白色navigationBar背景色
#elif ztxTargetName
    color = KCOLOR_WHITE;
#else
    color = KTHEME_COLOR; //蓝色(KTHEME_COLOR)navigationBar背景色
#endif
    return color;
}

@end
