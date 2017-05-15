//
//  NetWork.m
//  HHSD
//
//  Created by Serge Alain on 02/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import "MainPageViewController.h"

#import "NetWork.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "LoginViewController.h"
#import "NetWork+Animation.h"
@interface NetWork ()
@property (nonatomic, assign) AFNetworkReachabilityStatus netStatus;
@end
static NetWork *_gNetWork = nil;
@implementation NetWork
+(NetWork *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gNetWork = [[NetWork alloc] init];
        
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
        switch (status) {
            case -1:
            {
                //                                _hud.mode = MBProgressHUDModeText;
                // _hud.labelText = @"Unknown network is being used";
                //                                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 0:
            {
                [self MBShowHint:@"No network connection" delay:5.0];  // its okay
            }
                break;
            case 1:
            {
                //                                _hud.mode = MBProgressHUDModeText;
                //  _hud.labelText = @"It is a mobile communication network";
                //                                [_hud hide:YES afterDelay:2.0];
            }
                break;
            case 2:
            {
                //                                _hud.mode = MBProgressHUDModeText;
                //  _hud.labelText = @"You are using WIFI";
                //                                [_hud hide:YES afterDelay:2.0];
            }
                break;
                
            default:
                break;
        }
    }];
    AFNetworkActivityIndicatorManager *netactivity = [AFNetworkActivityIndicatorManager sharedManager];
    netactivity.enabled = NO;
}
- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
                isPost:(BOOL )isPost
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock
{
    [self showAnimation];
    self.sess_id = [[NSUserDefaults standardUserDefaults] objectForKey:KSESSION_ID];
    kSetDict(self.sess_id, @"sess_id");
    if(isPost)
    {
        [_manager POST:url
            parameters:params
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hiddenAnimation];
                   DLog(@"%@", operation.response);
                   DLog(@"JSON: %@", responseObject);
                   DLog(@"\n message = %@",responseObject[@"message"]);
                   if([[responseObject objectForKey:@"code"] isEqual:@200])
                   {
                       sucessBlock(operation,responseObject);
                   }
                   else if([[responseObject objectForKey:@"code"] isEqual:@201])
                   {
                       [self MBShowHint:@"You are already signed out" delay:2.0];
                     [self logOut];
                   }
                   else if([[responseObject objectForKey:@"code"] isEqual:@500])
                   {
                       sucessBlock(operation,responseObject);
                   }else if([[responseObject objectForKey:@"code"] isEqual:@600])
                   {
                   }
                   else
                   {
                       [self MBShowHint:responseObject[@"message"] delay:1.0];
                       sucessBlock(operation,responseObject);
                   }
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [self hiddenAnimation];
                   DLog(@"%@", operation.response);
                  // [self MBShowSuccess:PromptMessage];
                  // [self logOut];

                   failBlock(operation, error);
               }];
    }else
    {
        [_manager GET:url
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self hiddenAnimation];
                  DLog(@"%@", operation.response);
                  DLog(@"JSON: %@", responseObject);
                  DLog(@"\n message = %@",responseObject[@"message"]);
                  if([[responseObject objectForKey:@"code"] isEqual:@200])
                  {
                      sucessBlock(operation,responseObject);
                  }
                  else if([[responseObject objectForKey:@"code"] isEqual:@201])
                  {
                      [self MBShowHint:@"You are already signed out" delay:2.0];
                       [self logOut];
                  }
                  else if([[responseObject objectForKey:@"code"] isEqual:@500])
                  {
                      sucessBlock(operation,responseObject);
                  }else if([[responseObject objectForKey:@"code"] isEqual:@600])
                  {
                  }
                  else
                  {
                      [self MBShowHint:responseObject[@"message"] delay:1.0];
                      sucessBlock(operation,responseObject);
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self hiddenAnimation];
                 // [self logOut];
                  DLog(@"%@", operation.response);
                  [self MBShowSuccess:PromptMessage];
                  failBlock(operation, error);
              }];
    }
    
}
- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
             dataArray:(NSArray *)dataArray
              fileName:(NSString *)fileName
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock
{
    [_manager POST:url
        parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    if(dataArray.count >1)
    {
        for (NSInteger i = 0; i<[dataArray count]; i++)
        {
            [formData appendPartWithFileData:dataArray[i]
                                        name:[NSString stringWithFormat:@"%@_%ld",fileName,(long)i]
                                    fileName:[NSString stringWithFormat:@"image%ld.jpg",(long)i]
                                    mimeType:@"image/jpg"];
        }
    }else if(dataArray.count ==1)
    {
        [formData appendPartWithFileData:dataArray[0]
                                    name:[NSString stringWithFormat:@"%@",fileName]
                                fileName:[NSString stringWithFormat:@"image.jpg"]
                                mimeType:@"image/jpg"];
    }
    
}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               DLog(@"%@", operation.response);
               DLog(@"JSON: %@", responseObject);
               DLog(@"\n message = %@",responseObject[@"message"]);
               if([[responseObject objectForKey:@"code"] isEqual:@200])
               {
                   sucessBlock(operation,responseObject);
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@201])
               {
                   [self MBShowHint:@"You are already signed out" delay:2.0];
                   [self logOut];
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@600])
               {
                   [self closePinaqu];
               }
               else
               {
                   [self MBShowHint:responseObject[@"message"] delay:1.0];
                   sucessBlock(operation,responseObject);
               }
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               DLog(@"%@", operation.response);
               //[self MBShowSuccess:PromptMessage];
               failBlock(operation, error);
           }];
}
- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
              jsonData:(NSData *)jsonData
              dataName:(NSString *)dataName
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock;
{
    [self showAnimation];
    [_manager POST:url
        parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    [formData appendPartWithFormData:jsonData name:dataName];
    
}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               [self hiddenAnimation];
               DLog(@"%@", operation.response);
               DLog(@"JSON: %@", responseObject);
               DLog(@"\n message = %@",responseObject[@"message"]);
               if([[responseObject objectForKey:@"code"] isEqual:@200])
               {
                   sucessBlock(operation,responseObject);
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@201])
               {
                   [self MBShowHint:@"You are already signed out" delay:2.0];
                   [self logOut];
               }
               else if([[responseObject objectForKey:@"code"] isEqual:@600])
               {
                   [self closePinaqu];
               }
               else
               {
                   [self MBShowHint:responseObject[@"message"] delay:1.0];
                   sucessBlock(operation,responseObject);
               }
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [self hiddenAnimation];
               DLog(@"%@", operation.response);
              // [self MBShowSuccess:PromptMessage];
               failBlock(operation, error);
           }];
}
- (void)logOut
{
    DLog(@"Log out");
    MainPageViewController *VC = [[MainPageViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
}
- (void)closePinaqu
{
    //    sleep(2.0);
    //LoginViewController *vc = [[LoginViewController alloc] init];
   // UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
}
@end
