//
//  FKAuthViewController.h
//  HHSD
//
//  Created by alain serge on 4/28/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//
#import "BaseViewController.h"

#import <UIKit/UIKit.h>

@interface FKAuthViewController : BaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
