//
//  BtnView.h
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnView : UIView
@property (strong, nonatomic) UIButton *bottomBtn;

- (instancetype)initWithTitle:(NSString *)title;
@end
