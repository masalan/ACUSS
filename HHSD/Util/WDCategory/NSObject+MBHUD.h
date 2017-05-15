//
//  NSObject+MBHUD.h
//  HHSD
//
//  Created by Serge Alain on 02/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface NSObject (MBHUD)
- (void)MBShow;
- (void)MBHidden;
- (void)MBShowHint:(NSString *)hint;
- (void)MBShowHint:(NSString *)hint delay:(NSTimeInterval)delay;
- (void)MBShowSuccess:(NSString *)hint;
- (void)MBShowSuccess:(NSString *)hint delay:(NSTimeInterval)delay;
- (void)MBShowError:(NSString*)hint;
- (void)MBShowError:(NSString*)hint delay:(NSTimeInterval)delay;
@end
