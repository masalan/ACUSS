//
//  NetWork.h
//  HHSD
//
//  Created by Serge Alain on 02/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"
#import "AFNetworking.h"

typedef void (^SucessBlock )(AFHTTPRequestOperation *operation,id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation,NSError *eror);

@interface NetWork : NSObject
@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;
@property (nonatomic, copy) NSString *  sess_id;  


#pragma mark - AFNetWorking Request Method
+(NetWork *)shareInstance;

- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
                isPost:(BOOL )isPost
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock ;

- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
             dataArray:(NSArray *)dataArray
              fileName:(NSString *)fileName
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock ;

- (void)netWorkWithUrl:(NSString *)url
                params:(NSMutableDictionary *)params
              jsonData:(NSData *)jsonData
              dataName:(NSString *)dataName
           sucessBlock:(SucessBlock)sucessBlock
             failBlock:(FailureBlock)failBlock;
@end
