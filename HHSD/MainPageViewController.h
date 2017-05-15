//
//  MainPageViewController.h
//  HHSD
//
//  Created by alain serge on 4/28/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FlickrKit.h"

@interface MainPageViewController : UIViewController<GIDSignInUIDelegate>
- (IBAction)loginButtonClick:(id)sender;
- (IBAction)userLogin:(id)sender;
- (IBAction)userSignup:(id)sender;
- (IBAction)studentSearch:(id)sender;
- (IBAction)schoolSearch:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *userLogin;
@property (weak, nonatomic) IBOutlet UIButton *userSignup;
@property (weak, nonatomic) IBOutlet UIButton *studentSearch;
@property (weak, nonatomic) IBOutlet UIButton *schoolSearch;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end
