//
//  EULARules.m
//  YWYiphone
//
//  Created by liufengting on 14/12/2.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "EULARules.h"
#import "UIAlertView+Blocks.h"
#define SendFirstTime @"sendFirstTime"//用户第一次发布内容
#define FistOpenTheApp @"FistOpenTheApp"//用户第一次发布内容
@implementation EULARules

// 是否第一次发布，必须同意用户条例
+(void)checkEULARules
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![[defaults objectForKey:SendFirstTime] isEqual:@"1"]){
//        [UIAlertView showAlertViewWithTitle:@"用户协议 - User Agreement"
//                                    message:@"      用户不得利用本软件发表、传送、传播、储存违反国家法律、危害国家安全、祖国统一、社会稳定的内容，或任何不当的、侮辱诽谤的、淫秽的、暴力的及任何违反国家法律法规政策的内容；不得制造虚假身份以误导、欺骗或利用本软件批量发表、传送、传播广告信息。否则，本公司有权终止用户账号使用。\n\n\n Users may not use the software publication, transmission, dissemination, storage, violation of state law, endangering national security, reunification, social stability, content, or any inappropriate, insulting defamatory, obscene, violent, and any policy in violation of state laws and regulations content; shall not create false identity to mislead, deceive or take advantage of this software batch publish, transfer, dissemination of advertising messages. Otherwise, the Company has the right to terminate the user account to use."
//                          cancelButtonTitle:@"I agree"
//                          otherButtonTitles:@[]
//                                  onDismiss:^(int buttonIndex) {
//                                      
//                                  } onCancel:^{
//                                      [defaults setObject:@"1" forKey:SendFirstTime];
//                                  }];
//    }
//    
    
    UIAlertView *alertView = [UIAlertView showAlertViewWithTitle:@"User Agreement"
                                                        message:@" \n\n\n Users may not use the software publication, transmission, dissemination, storage, violation of state law, endangering national security, reunification, social stability, content, or any inappropriate, insulting defamatory, obscene, violent, and any policy in violation of state laws and regulations content; shall not create false identity to mislead, deceive or take advantage of this software batch publish, transfer, dissemination of advertising messages. Otherwise, the Company has the right to terminate the user account to use."
                                              cancelButtonTitle:@"I agree"
                                              otherButtonTitles:@[]
                                                      onDismiss:^(int buttonIndex) {
                                                          //
                                                      }
                                                       onCancel:^{
                                                           //
                                                       }];
    alertView.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
   
    [alertView show];
    
    
    
    
    
    
    
    
    
    
    
    
}


@end
