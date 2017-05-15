//
//  Request.m
//  pywiphone
//
//  Created by 刘锋婷 on 14-2-20.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "Request.h"
#import "LoginViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "WoDeXiaoQuViewController.h"
#import "XBZLoginViewController.h"

#define kServerApiVersion @"1.0"
#define kPageSize @"20"
#define kTimeOut 10
@interface Request ()
@property (nonatomic, assign) AFNetworkReachabilityStatus netStatus;
@end
static Request *_gNetWork = nil;
@implementation Request

+(Request *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gNetWork = [[Request alloc] init];
    
        [_gNetWork reach];
    });
    return _gNetWork;
}

- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    _manager =  [AFHTTPRequestOperationManager manager];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [_hud hide:YES];
        [self mbView];
        switch (status) {
            case -1:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用未知网络";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 0:
            {
                _hud.mode = MBProgressHUDModeText;
                _hud.labelText = @"无网络连接";
                [_hud hide:YES afterDelay:5.0];
            }
                break;
            case 1:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用移动通信网络";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 2:
            {
//                _hud.mode = MBProgressHUDModeText;
//                _hud.labelText = @"正在使用WIFI";
//                [_hud hide:YES afterDelay:2.0];
            }
                break;
                
            default:
                break;
        }
    }];
    AFNetworkActivityIndicatorManager *netactivity = [AFNetworkActivityIndicatorManager sharedManager];
    netactivity.enabled = YES;
}
- (void)mbView
{
    [_hud hide:NO];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
        _hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    }
    _hud.margin = 10.f;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES afterDelay:10.0];
}
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/
/* ---------------------------------------     MBProgressHud       ------------------------------------------------------*/

/**
 *  GET请求
 *
 @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return return value description
 */

/**
 *  GET请求
 *
 @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return return value description
 */
- (id)MBGETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [self mbView];
    _hud.hidden = isHiddenMB;
    [_manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"code"] isEqual:@200])
              {
                  [_hud hide:isDissMissM];
                  sucessBlock(operation,responseObject);
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  _hud.mode = MBProgressHUDModeText;
                  _hud.labelText = @"用户长时间未使用,请重新登陆";
                  [_hud hide:YES afterDelay:2.0];
                  [self logOut];
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@500])
              {
                  [_hud hide:YES];
                  sucessBlock(operation,responseObject);
              }else if([[responseObject objectForKey:@"code"] isEqual:@600])
              {
//                  [self showMBHint:@"当前片区已被关闭,请重新选择片区"];
                  [self closePinaqu];
              }
              else
              {
                  _hud.mode = MBProgressHUDModeText;
                  _hud.labelText = responseObject[@"message"];
                  [_hud hide:YES afterDelay:1.0];
                  sucessBlock(operation,responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              _hud.mode = MBProgressHUDModeText;
              _hud.labelText = PromptMessage;
              [_hud hide:YES afterDelay:1.0];
              failBlock(operation, error);
          }];
    return nil;
}
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
- (id)MBrequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [self mbView];
    _hud.hidden = isHiddenMB;
    [_manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"code"] isEqual:@200])
              {
                  [_hud hide:isDissMissM];
                  sucessBlock(operation,responseObject);
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
                  _hud.mode = MBProgressHUDModeCustomView;
                  _hud.labelText = @"用户长时间未使用,请重新登陆";
                  [_hud hide:YES afterDelay:2.0];
                  [self logOut];
              }else if([[responseObject objectForKey:@"code"] isEqual:@600])
              {
                  [self closePinaqu];
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@500])
              {
                  [_hud hide:YES];
                  sucessBlock(operation,responseObject);
              }
              else
              {
                  _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
                  _hud.mode = MBProgressHUDModeCustomView;
                  _hud.labelText = responseObject[@"message"];
                  [_hud hide:YES afterDelay:1.0];
                  sucessBlock(operation,responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
             // _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
              _hud.mode = MBProgressHUDModeCustomView;
              _hud.labelText = PromptMessage;
              [_hud hide:YES afterDelay:1.0];
              failBlock(operation, error);
          }];
    return nil;
}


- (id)MBrequestWithUrlWithDissmiss:(NSString *)url params:(NSMutableDictionary *)params superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [self mbView];
    [_manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              [_hud hide:YES];
              if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  _hud.mode = MBProgressHUDModeText;
                  _hud.labelText = @"用户长时间未使用,请重新登陆";
                  [self logOut];
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@600])
              {
                  [self closePinaqu];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              _hud.labelText = PromptMessage;
              [_hud hide:YES afterDelay:2.0];
              failBlock(operation, error);
          }];
    return nil;
}
- (id)MBNODismissrequestWithUrlWith:(NSString *)url  params:(NSMutableDictionary *)params superView:(UIView *)superView  sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [self mbView];
    [_manager POST:url
        parameters:params
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               DLog(@"JSON: %@", responseObject);
               DLog(@"%@", operation.response);
               DLog(@"\n message = %@",responseObject[@"message"]);
               [_hud hide:YES];
               if([[responseObject objectForKey:@"code"] isEqual:@201])
               {
                   _hud.mode = MBProgressHUDModeText;
                   _hud.labelText = @"用户长时间未使用,请重新登陆";
                   [self logOut];
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@600])
               {
                   [self closePinaqu];
               }
               sucessBlock(operation,responseObject);
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               _hud.labelText = PromptMessage;
               [_hud hide:YES afterDelay:2.0];
               failBlock(operation, error);
           }];
    return nil;
}
- (id)MBGETNODismissrequestWithUrlWith:(NSString *)url  params:(NSMutableDictionary *)params superView:(UIView *)superView  sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    
    [self mbView];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"JSON: %@", responseObject);
              DLog(@"%@", operation.response);
              DLog(@"\n message = %@",responseObject[@"message"]);              [_hud hide:YES];
              if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  _hud.mode = MBProgressHUDModeText;
                  _hud.labelText = @"用户长时间未使用,请重新登陆";
                  [self logOut];
              }
              else if([[responseObject objectForKey:@"code"] isEqual:@600])
              {
                  [self closePinaqu];
              }
              sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              _hud.labelText = PromptMessage;
              [_hud hide:YES afterDelay:2.0];
              failBlock(operation, error);
          }];
    return nil;
}
/**
 *  AFNetWorking Request Method 上传照片
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return nil
 */
- (id)MBrequestWithPhotoWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray fileName:(NSString *)fileName superView:(UIView *)superView isHiddenMB:(BOOL)isHiddenMB isDissMissM:(BOOL)isDissMissM sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [self mbView];
    _hud.hidden = isHiddenMB;
    //    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [_manager POST:url
        parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    for (NSInteger i = 0; i<[dataArray count]; i++)
    {
        [formData appendPartWithFileData:dataArray[i]
                                    name:[NSString stringWithFormat:@"%@[%ld]",fileName,(long)i]
                                fileName:[NSString stringWithFormat:@"image%ld.jpg",(long)i]
                                mimeType:@"image/jpg"];
    }
}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               DLog(@"%@", operation.response);
               DLog(@"JSON: %@", responseObject);
               DLog(@"\n message = %@",responseObject[@"message"]);
               if([[responseObject objectForKey:@"code"] isEqual:@200])
               {
                   [_hud hide:isDissMissM];
                   sucessBlock(operation,responseObject);
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@201])
               {
                   _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
                   _hud.mode = MBProgressHUDModeCustomView;
                   _hud.labelText = @"用户长时间未使用,请重新登陆";
                   [_hud hide:YES afterDelay:2.0];
                   [self logOut];
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@600])
               {
                   [self closePinaqu];
               }
               else
               {
                   _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
                   _hud.mode = MBProgressHUDModeCustomView;
                   _hud.labelText = responseObject[@"message"];
                   [_hud hide:YES afterDelay:1.0];
                   sucessBlock(operation,responseObject);
               }
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               DLog(@"%@", operation.response);
               //_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
               _hud.mode = MBProgressHUDModeCustomView;
               _hud.labelText = PromptMessage;
               [_hud hide:YES afterDelay:1.0];
               failBlock(operation, error);
           }];
    return nil;
}
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/
/* ---------------------------------------     svprogresshud       ------------------------------------------------------*/


/**
 *  GET请求
 *
    @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return return value description
 */
- (id)GETRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  [ProgressHUD showError:@"用户长时间未使用,请重新登陆"];
                  [self logOut];
              }
              if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]] isEqualToString:@"1401"]) {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [[NSNotificationCenter defaultCenter] postNotificationName:USER_NOT_LOGIN_NOTIFICATION object:self];
                  });
              }else{
                  sucessBlock(operation,responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              
              [SVProgressHUD showInfoWithStatus:PromptMessage];
              failBlock(operation, error);
          }];
    return nil;
}
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
 - (id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              [SVProgressHUD dismiss];
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  [ProgressHUD showError:@"用户长时间未使用,请重新登陆"];
                  [self logOut];
              }
              if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]] isEqualToString:@"1401"]) {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [[NSNotificationCenter defaultCenter] postNotificationName:USER_NOT_LOGIN_NOTIFICATION object:self]; 
                  });
              }else{
                  sucessBlock(operation,responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [SVProgressHUD showInfoWithStatus:PromptMessage];
              failBlock(operation, error);
          }];
    return nil;
}
- (id)requestWithUrlWithNODismiss:(NSString *)url  params:(NSMutableDictionary *)params sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock
{
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@", operation.response);
              DLog(@"JSON: %@", responseObject);
              DLog(@"\n message = %@",responseObject[@"message"]);
              if([[responseObject objectForKey:@"code"] isEqual:@201])
              {
                  [ProgressHUD showError:@"用户长时间未使用,请重新登陆"];
                  [self logOut];
              }
            sucessBlock(operation,responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              DLog(@"%@", operation.response);
              [SVProgressHUD showInfoWithStatus:PromptMessage];
              
              failBlock(operation, error);
          }];
    return nil;
}
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
-(id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params dataArray:(NSArray *)dataArray postSucessBlock:(PostSucessBlock)postSucessBlock postFailBlock:(PostFailureBlock)postFailBlock
{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                               URLString:url
                                                              parameters:params
                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                   
                                                   for (NSInteger i = 0; i<[dataArray count]; i++)
                                                   {
        
                                                       [formData appendPartWithFileData:dataArray[i]
                                                                                   name:[NSString stringWithFormat:@"photo"]
                                                                               fileName:[NSString stringWithFormat:@"image%ld.jpg",(long)i]
                                                                               mimeType:@"image/jpg"];
                                                   }
                                                   

                                               }error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:&progress
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                  
                                                                  if (error) {
                                                                      
                                                                      DLog(@"error:%@", error);
//                                                                      [error code];
                                                                      postFailBlock(response,responseObject,error);
                                                                      
                                                                  } else {
                                                                      DLog(@"response:%@", responseObject);
                                                                      
                                                                      if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]] isEqualToString:@"1401"]) {
                                                                          [[NSNotificationCenter defaultCenter] postNotificationName:USER_NOT_LOGIN_NOTIFICATION object:self];
                                                                      }else{
                                                                          postSucessBlock(response,responseObject,error);
                                                                          
                                                                      }
                                                                  }
                                                              }];
    [uploadTask resume];
    
    return nil;
}

- (void)logOut
{
    DLog(@"退出账号");
#ifdef _YWY2_XBZ_MACROS_
    XBZLoginViewController *VC = [[XBZLoginViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
#else
    LoginViewController *VC = [[LoginViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
#endif
}
- (void)closePinaqu
{
//    sleep(2.0);
    LoginViewController *VC = [[LoginViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
}
@end


