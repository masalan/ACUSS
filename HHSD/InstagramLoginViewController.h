//
//  InstagramLoginViewController.h
//  HHSD
//
//  Created by alain serge on 4/28/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InstagramLoginViewController : BaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginIndicator;
@property(strong,nonatomic)NSString *typeOfAuthentication;

@end
