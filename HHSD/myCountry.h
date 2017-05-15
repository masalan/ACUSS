//
//  myCountry.h
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"
#import "BaseViewController.h"
@interface myCountry : BaseViewController <CountryPickerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *codeLabel;

@end
