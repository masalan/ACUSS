//
//  CDOutLineHeadView.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CDOutLineHeadViewDelegate<NSObject>
- (void)CDOutLineHeadViewbtnClick:(NSInteger)index;
@end
@interface CDOutLineHeadView : UIView
@property (nonatomic, strong) UIImageView *leftImageView,*verify;
@property (nonatomic, strong) UILabel *titlaLabel,*userStatus,*numberLabel;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, weak) id <CDOutLineHeadViewDelegate>delegate;
- (instancetype)initWithMode:(Student_Details *)mode;
+ (CGFloat )getHeight;
@end
