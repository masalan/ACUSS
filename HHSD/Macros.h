//
//  Macros.h
//  YWY2_M
//
//  Created by Serge Alain on 24/07/16.
//  Copyright © 2016 Alain Serge. All rights reserved.
//
#ifndef Macros_h
#define Macros_h
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CountryPicker.h"

#import "MBProgressHUD.h"
#import "ColorLabel.h"
#import "ProgressHUD.h"
#import "MyPicker.h"

#import "MJExtension.h"

#import "MJRefresh.h"
#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UIImage+Color.h"
#import "MyUI.h"
#import "UIImageView+SDWDImageCache.h"

#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "ConstantMacros.h"
#import "MJExtension.h"
#import "FYLoginTranslation.h"
#import "BlocksKit+UIKit.h"
//#import "ZXingObjC.h"
#import "MJRefresh.h"
#import "NSObject+MBHUD.h"
#import "UIImageView+SDWDImageCache.h"
#import "MJRefreshGifHeader.h"
#import "GYHHeadeRefreshController.h"


//Add tweet sucess
#define ADDTweetSuccess @"addtweetSuccess"
#define kAutoFont_(a) [UIScreen mainScreen].bounds.size.height>700?[UIFont systemFontOfSize:(a+2)]:[UIFont systemFontOfSize:a]

#define KLINE_HEIGHT 1.0 / [UIScreen mainScreen].scale


#define kSetDict(value,key) if (value)[params setObject:value forKey:key]
#define sss 44


#if __has_feature(objc_arc)
#define IMP_BLOCK_SELF(type) __weak type *block_self=self;
#else
#define IMP_BLOCK_SELF(type) __block type *block_self=self;
#endif


//----------------------------------------------------------------------------------------------
#define DEBUGLOG
#ifdef DEBUGLOG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#pragma mark - Coordinate Functions
#pragma mark   坐标相关

#define KNAVGATIONBAR_HEIGHT         64
#define PlaceHoderImage @"netPlaceHoder"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))
#define topImageHeight 148
#pragma mark - color functions
#pragma mark   颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:h saturation:s value:v alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:h saturation:s value:v alpha:a]

/// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - degrees/radian functions
#pragma mark   角度弧度转化
//#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


#define kDEFAULT_IMAGE_LONG     [UIImage imageNamed:@"luochengLoadinglong"]//Los Angeles

#define APP_NAME                            @"EducMobile"
#define CellIndentifier                     @"CellIndentifier"
#define USER_NOT_LOGIN_NOTIFICATION         @"UserNotLoginNotification"
#define NO_CONTENT                          @"No data"
/**
 *  color
 */
#define KCOLOR_Clear                        [UIColor clearColor]
#define kSetDict(value,key) if (value)[params setObject:value forKey:key]

#define KCOLOR_WHITE                        [UIColor whiteColor]
#define KCOLOR_WHITE_fafbfc                        [UIColor colorWithHex:@"#d2d6e2"]

//fafbfc
#define KCOLOR_BLACK                        [UIColor blackColor]
#define KCOLOR_BLACK_32343a                         [UIColor colorWithHex:@"#34373e"]

#define KCOLOR_CLEAR                        [UIColor clearColor]
#define KCOLOR_GRAY                         [UIColor grayColor]

#define KCOLOR_GRAY_WD                      [UIColor colorWithRed:(189)/255.f green:(189)/255.f blue:(189)/255.f alpha:1.f]

#define kCurrentVersion [[[UIDevice currentDevice] systemVersion] floatValue]


#define KCOLOR_GREEN_CREDIT                  [UIColor colorWithHex:@"#0C9C02"]  //e25d30
#define KCOLOR_NAME_SCHOOL                   [UIColor colorWithHex:@"#201e63"]
#define KCOLOR_SELECT_MENU                   [UIColor colorWithHex:@"#03013e"]

#define KCOLOR_DEAD_LINE                  [UIColor colorWithHex:@"#c69c9a"]


#define KCOLOR_GRAY_LIGHT                   [UIColor lightGrayColor]
#define KCOLOR_GREEN_COLOR                  [UIColor greenColor]   //[UIColor greenColor]
#define KCOLOR_GREEN                        [UIColor colorWithHex:@"#05923f"]   //[UIColor greenColor]
#define KCOLOR_GREEN_6ad968                  [UIColor colorWithHex:@"#e25d30"]   //[UIColor colorWithHex:@"#6ad968"]
#define KCOLOR_GREEN_09bb07                  [UIColor colorWithHex:@"#09bb07"]  //e25d30

#define KCOLOR_READING                       [UIColor colorWithHex:@"#05B302"]
#define KCOLOR_UNLOCK                       [UIColor colorWithHex:@"#FA021F"]
#define KCOLOR_UNAVAILABLE                      [UIColor colorWithHex:@"#B6BAB9"]



#define KCOLOR_RED                          [UIColor redColor]
#define KCOLOR_BLUE                         [UIColor blueColor]
#define KCOLOR_YELLOW_F2EB05                         [UIColor colorWithHex:@"#F2EB05"]
#define KCOLOR_VERIFY                     [UIColor colorWithHex:@"#049213"]

#define KCOLOR_GREEN_03B415                        [UIColor colorWithHex:@"#03B415"]
#define KCOLOR_BLUE_0210C3                        [UIColor colorWithHex:@"#0210C3"]



#define KCOLOR_19aa6b                       [UIColor colorWithHex:@"#19aa6b"]
#define KCOLOR_d7d8da                       [UIColor colorWithHex:@"#d7d8da"]


#define KCOLOR_YELLOW                       [UIColor colorWithHex:@"#FFFF00"]

#define KCOLOR_YELLOW_fbfb03                      [UIColor colorWithHex:@"#fbfb03"]
#define KCOLOR_YELLOW_ff9106                  [UIColor colorWithHex:@"#ff9106"]
#define KCOLOR_YELLOW_8bd9f6                 [UIColor colorWithHex:@"#8bd9f6"]
#define KCOLOR_YELLOW_ffd200                 [UIColor colorWithHex:@"#ffd200"]
#define KCOLOR_RED_ef4437                   [UIColor colorWithHex:@"#ef4437 "]
#define KCOLOR_RED_a61508                   [UIColor colorWithHex:@"#a61508"]


#define KCOLOR_BACKGROUND_WHITE             [UIColor colorWithHex:@"#f5f5f5"]//e9f6fe

#define KTHEME_COLOR                        [UIColor colorWithHex:@"#e25d30"]
#define KTHEME_COLOR_SELECT                       [UIColor colorWithHex:@"#e59866"]



#define KTHEME_COLOR_DATE                       [UIColor colorWithHex:@"#DF947B"]

#define KCOLOR_ff9106                 [UIColor colorWithHex:@"#ff9106"]
#define KCOLOR_ff5000                [UIColor colorWithHex:@"#ff5000"]
#define KCOLOR_ff8903               [UIColor colorWithHex:@"#ff8903"]

#define KCOLOR_f19c52               [UIColor colorWithHex:@"#f19c52"]
#define KCOLOR_f19c52               [UIColor colorWithHex:@"#f19c52"]

#define KCOLOR_86d3ff               [UIColor colorWithHex:@"#86d3ff"]
#define KCOLOR_f18a39               [UIColor colorWithHex:@"#f18a39"]
#define KCOLOR_576b95               [UIColor colorWithHex:@"#576b95"]
#define KCOLOR_727272               [UIColor colorWithHex:@"#727272"]

#define KCOLOR_e6f8e6               [UIColor colorWithHex:@"#e6f8e6"]

#define KCOLOR_09bb07               [UIColor colorWithHex:@"#e25d30"]  //09bb07 Green color

#define KCOLOR_GRAY_e5e5e5                  [UIColor colorWithHex:@"#e5e5e5"]
#define KCOLOR_GRAY_eeeeee                  [UIColor colorWithHex:@"#eeeeee"]
#define KCOLOR_GRAY_f5f5f5                  [UIColor colorWithHex:@"#f5f5f5"]
#define KCOLOR_GRAY_fafafa                 [UIColor colorWithHex:@"#fafafa"]
#define KCOLOR_Image_BK                     [UIColor colorWithHex:@"#f5f5f5"]

#define KAlphaTime 0.1
#define KCOLOR_GRAY_f8f9fb                 [UIColor colorWithHex:@"#f8f9fb"]
#define KCOLOR_GRAY_c9c9c9                  [UIColor colorWithHex:@"#c9c9c9"]
#define KCOLOR_GRAY_bcbcbc                  [UIColor colorWithHex:@"#bcbcbc"]

#define KCOLOR_Line_Color                  [UIColor colorWithHex:@"#c9c9c9"]

#define KCOLOR_enabled                  [UIColor colorWithHex:@"#c9c9c9"]

#define KCOLOR_GRAY_848484                  [UIColor colorWithHex:@"#848484"]
#define KCOLOR_GRAY_ff7800                  [UIColor colorWithHex:@"#ff7800"]
#define KCOLOR_18b4ed                  [UIColor colorWithHex:@"#18b4ed"]

#define KCOLOR_GRAY_999999                  [UIColor colorWithHex:@"#999999"]
#define KCOLOR_GRAY_c1c1c1                  [UIColor colorWithHex:@"#c1c1c1"]
#define KCOLOR_GRAY_bcbcbc                  [UIColor colorWithHex:@"#bcbcbc"]


#define KCOLOR_GRAY_Cell                  [UIColor colorWithRed:(187)/255.f green:(187)/255.f blue:(193)/255.f alpha:1.f]

#define KCOLOR_676f84                [UIColor colorWithHex:@"#676f84"]

#define KCOLOR_Black_3c3c3c                 [UIColor colorWithHex:@"#3c3c3c"]

#define KCOLOR_Black_343638                 [UIColor colorWithHex:@"#e25d30"]
//#define KCOLOR_Black_343638                 [UIColor colorWithHex:@"#343638"] version original


#define KCOLOR_Black_576b95                 [UIColor colorWithHex:@"#576b95"]
#define KCOLOR_CALL_ME                 [UIColor colorWithHex:@"#3a059d"]

#define KCOLOR_Black_343434                 [UIColor colorWithHex:@"#343434"]
#define KCOLOR_RED_f14d65                    [UIColor colorWithHex:@"#f14d65"]
#define KCOLOR_RED_ffe7e7                    [UIColor colorWithHex:@"#ffe7e7"]
#define KCOLOR_RED_fc8227                    [UIColor colorWithHex:@"#fc8227"]

#define KCOLOR_RED_3f4437                    [UIColor colorWithHex:@"#3f4437"]

#define KCOLOR_GRAY_676767                  [UIColor colorWithHex:@"#676767"]
#define KCOLOR_GRAY_E1DFDF                  [UIColor colorWithHex:@"#E1DFDF"]
#define KCOLOR_GRAY_C9C8C8                  [UIColor colorWithHex:@"#C9C8C8"]



#define KBORDER_COLOR                       [UIColor colorWithHex:@"#86d3ff"]
#define KTHEME_RED_COLOR                    [UIColor colorWithHex:@"#fc8277"]
#define KCOLOR_BACK_GRAY                    [UIColor colorWithHex:@"#f3f3f3"]
#define KCOLOR_WHITE_TRANSPARENT            [KCOLOR_WHITE colorWithAlphaComponent:0.15]
#define KCOLOR_SEPARTOR_COLOR               [KCOLOR_WHITE colorWithAlphaComponent:0.3]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define Khex(a)  [UIColor colorWithHex:a]

#define KCOLOR_Bar                [UIColor colorWithHex:@"#e25d30"]  // Orange
#define KCOLOR_App                [UIColor colorWithHex:@"#e25d30"] // Orange
#define KCOLOR_THEME                [UIColor colorWithHex:@"#e25d30"] // Orange


#define KCOLOR_YELLOW_B4A506    [UIColor colorWithHex:@"#B4A506 "] 
#define KCOLOR_YELLOW_D7DF01    [UIColor colorWithHex:@"#D7DF01 "]   // YELLOW
#define KCOLOR_GREEN_02A85D     [UIColor colorWithHex:@"#02A85D "]
#define KCOLOR_B4045F           [UIColor colorWithHex:@"#B4045F "]



#define KCOLOR_THEME_BETA          [UIColor colorWithHex:@"#151444"]





//#define UIColorFromRGB(rgbValue)            [UIColor \colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 *  font
 */
#define KSYSTEM_FONT_8                      [UIFont systemFontOfSize:8]
#define KSYSTEM_FONT_10                     [UIFont systemFontOfSize:10]
#define KSYSTEM_FONT_12                     [UIFont systemFontOfSize:12]
#define KSYSTEM_FONT_13                     [UIFont systemFontOfSize:13]
#define KSYSTEM_FONT_14                     [UIFont systemFontOfSize:14]
#define KSYSTEM_FONT_15                     [UIFont systemFontOfSize:15]
#define KSYSTEM_FONT_18                     [UIFont systemFontOfSize:18]
#define KSYSTEM_FONT_20                     [UIFont systemFontOfSize:20]
#define KSYSTEM_FONT_(a)                    [UIFont systemFontOfSize:a]

#define KSYSTEM_FONT_Px_KFont(a)            [UIFont systemFontOfSize:(a*72/96)]

#define KFont(px) (px*72/96)

#define KSYSTEM_FONT_BOLD_(a)               [UIFont boldSystemFontOfSize:a]



#define KICON_FONT_(a)                      [UIFont fontWithName:@"iconfont" size:a]
#define OSWALD_BOLD_(a)                        [UIFont fontWithName:@"Oswald-Bold" size:a]
#define OSWALD_DEMIBOLD_(a)                    [UIFont fontWithName:@"Oswald-DemiBold" size:a]
#define OSWALD_EXTRALIGHT_(a)                  [UIFont fontWithName:@"Oswald-ExtraLight" size:a]
#define OSWALD_HEAVY_(a)                       [UIFont fontWithName:@"Oswald-Heavy" size:a]
#define OSWALD_LIGHT_(a)                       [UIFont fontWithName:@"Oswald-Light" size:a]
#define OSWALD_BMEDIUM_(a)                     [UIFont fontWithName:@"Oswald-Medium" size:a]
#define OSWALD_REGULAR_(a)                     [UIFont fontWithName:@"Oswald-Regular" size:a]
#define OSWALD_STENCIL_(a)                     [UIFont fontWithName:@"Oswald-Stencil" size:a]

#define KHELVE_(a)                          [UIFont fontWithName:@"HelveticaNeue" size:a]
#define kNavgationTitleFont                 KSYSTEM_FONT_BOLD_(18)
#define KCFS(a) NSClassFromString(a)

/**
 *  margin
 */
#define KMARGIN_5                    5
#define KMARGIN_8                    8
#define KMARGIN_10                   10
#define KMARGIN_15                   15
#define KMARGIN_20                   20
#define KMARGIN_25                   25
#define KMARGIN_30                   30
#define KMARGIN_40                   40
#define KMARGIN_50                   50
#define KMARGIN_60                   60
#define KMARGIN_70                   70
#define KMARGIN_80                   80
#define KMARGIN_90                   90
#define KMARGIN_100                  100
#define KMARGIN_110                  110


#define KCORNER_RADIUS_3             3
#define KCORNER_RADIUS_5             5
#define KBORDER_WIDTH_001            0.01f
#define KBORDER_WIDTH_03             0.3f
#define KBORDER_WIDTH_01             0.1f
#define KBORDER_WIDTH_1              1.f
#define ROUND_PER_CENT               0.6f
/**
 *  height
 */
//#define STATUSBAR_HEIGHT            [UIApplication sharedApplication].statusBarFrame.size.height
#define NAV_BAR_HEIGHT              self.navigationController.navigationBar.bounds.size.height
#define KTAB_BAR_HEIGHT             self.tabBarController.tabBar.bounds.size.height
#define KNAVGATION_BAR_HEIGHT         (STATUSBAR_HEIGHT+NAV_BAR_HEIGHT)

//sort view width
#define SORT_VIEW_WIDTH              280
#define CLUB_MAIN_CELL_HEIGHT       110

#define CLUB_ICON_SIZE_BIG           80
#define CLUB_ICON_SIZE               50
#define CLUB_ICON_SIZE_SMALL         30


#define KHEIGHT_20                   20
#define KHEIGHT_30                   30
#define KHEIGHT_40                   40
#define KHEIGHT_50                   50
#define KHEIGHT_60                   60
#define KHEIGHT_70                   70
#define KHEIGHT_80                   80
#define KHEIGHT_100                  100
#define KHEIGHT_120                  120
#define KHEIGHT_(a)                  a

#define KICON_WIDTH_80              80
#define KICON_WIDTH_60              60
#define CheckLineHeight             30 //Orders page Row Height

#define KSDImage(a) 

#define KIntTS(a) [NSString stringWithFormat:@"%ld",(long)a]
#define KSFS(b) [NSString stringWithFormat:@"%@",(b =  b ? b :@"")]
#define KSFS1(a,b) [NSString stringWithFormat:a,(b =  b ? b :@"")]
#define KSFS2(a,b,c) [NSString stringWithFormat:a,(b =  b ? b :@""),(c =  c ? c :@"")]

#define ZFSuccess @"zhifuSuccess"

/**
 *  Methods
 */
#define kBOUNDS_WIDTH               self.bounds.size.width
#define KBOUNDS_HEIGHT              self.bounds.size.height

#define KSCREEN_WIDTH               [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT              [[UIScreen mainScreen] bounds].size.height

//____________________________________ IPHONE SIZE_______________________________________________

// iPhone3
#define iPhone3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320,480), [[UIScreen mainScreen] currentMode].size) : NO)
// iPhone4
#define iPhone4  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone4s
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)  
//iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone5s
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone6
#define iPhone6  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone6s
#define iPhone6s    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone6sPlus
#define iPhone6sPlus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080,1920), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone6Plus
#define iPhone6Plus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhone7
#define iPhone7    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone7 plus
#define iPhone7plus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080,1920), [[UIScreen mainScreen] currentMode].size) : NO)


//____________________________________ IPAD SIZE_______________________________________________

//iPad Pro
#define iPadPro   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048,2732), [[UIScreen mainScreen] currentMode].size) : NO)
// iPad mini 2, 3 (mine ipad mini 2)
#define  iPadmini23  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536,2048), [[UIScreen mainScreen] currentMode].size) : NO)
// iPad mini
#define  iPadmini  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768,1024), [[UIScreen mainScreen] currentMode].size) : NO)
//iPad 3, 4, Air, Air2
#define  iPadAir  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536,2048), [[UIScreen mainScreen] currentMode].size) : NO)
//iPad 1,2
#define  iPad  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768,1024), [[UIScreen mainScreen] currentMode].size) : NO)



#define PromptMessage        @"Refresh please"


#define tabbarHeight 44
#define KSESSION_ID @"sess_id"
#define SIGNUP_END @"signup_end"

#define KDeviceTokenStr @"deviceTokenStr"

#define KUSER_ID @"userid"
#define KVERSION @"version"

#define KUSERNAME @"username"
#define KPASSWORD @"password"
#define KHEADURL @"head_image"
#define KGROUPNAME @"groupName"
#define KTOPhoto @"to_photo"
#define KMe_NickName @"nickname"
#define KMe_Name @"name"

#define KTO_NickName @"to_nickname"
#define Klogin_status @"login_status"
#define KStartImageUrl @"startImageUrl"

#endif /* Macros_h */
