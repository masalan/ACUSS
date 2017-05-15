//
//  WDTabBarItem.h
//  HHSD
//
//  Created by Serge Alain on 16/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDTabBarItem : UIButton
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *iconString;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *iconLabel;
@end
