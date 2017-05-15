//
//  Request.h
//  pywiphone
//
//  Created by 刘锋婷 on 14-2-20.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

typedef void (^SucessModeBlock )(id mode, NSString * code);
typedef void (^FailureModeBlock )(id mode, NSString * code,NSString *message,NSError *error);

typedef void (^SucessBlock )(AFHTTPRequestOperation *operation,id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation,NSError *eror);
typedef void (^PostSucessBlock)(NSURLResponse *response, id responseObject, NSError *error);
typedef void (^PostFailureBlock)(NSURLResponse *response, id responseObject, NSError *error);



@interface Request : NSObject
@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) MBProgressHUD *hud;

#pragma mark - AFNetWorking Request Method
+(Request *)shareInstance;
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
- (id)MBGETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)MBrequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)MBrequestWithUrlWithDissmiss:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)MBNODismissrequestWithUrlWith:(NSString *)url  params:(NSMutableDictionary *)params superView:(UIView *)superView sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)MBGETNODismissrequestWithUrlWith:(NSString *)url  params:(NSMutableDictionary *)params superView:(UIView *)superView  sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)MBrequestWithPhotoWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray fileName:(NSString *)fileName superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
- (id)GETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;


/**
 *  AFNetWorking Request Method
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return nil
 */
- (id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;
- (id)requestWithUrlWithNODismiss:(NSString *)url  params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock;

/**
 *  AFNetWorking Request Method With Images
 *
 *  @param url         地址
 *  @param params      参数
 *  @param dataArray   图片数组
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *
 *  @return nil
 */
- (id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray postSucessBlock:(PostSucessBlock)postSucessBlock postFailBlock:(PostFailureBlock)postFailBlock;
@end

