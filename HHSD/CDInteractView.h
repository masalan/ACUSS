//
//  CDInteractView.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDInteractView : UIScrollView
@property (nonatomic, strong) UIImageView *headView,*verify,*bgImageView;
@property (nonatomic, strong) UILabel *nameLabel,*bottomLabel,*profession,*major,*nationality,*professionIcone,*nationalityIcone,*cityName,*cityIcone,*userStatus;
@property (nonatomic, strong) UIView *centerView;
- (instancetype)initWithMode:(Student_Details *)mode;
+ (CGFloat)getHeight:(Student_Details *)mode;
@end
