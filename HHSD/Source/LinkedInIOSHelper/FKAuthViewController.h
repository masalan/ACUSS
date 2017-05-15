//
//  FKAuthViewController.h
//  HHSD
//
//  Created by alain serge on 4/25/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FKAuthViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
