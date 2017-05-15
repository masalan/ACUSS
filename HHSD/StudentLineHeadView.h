//
//  StudentLineHeadView.h
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StudentLineHeadViewDelegate<NSObject>
- (void)SchoolLineHeadViewbtnClick:(NSInteger)index;
- (void)BtnClickLoginHere:(NSInteger)index;

@end
@interface StudentLineHeadView : UIView
@property (nonatomic, strong) UIImageView *leftImageView,*logoSchool;
@property (nonatomic, strong) UILabel *titlaLabel,*nameUniversity,*numberLabel,*attribute,*level,*type,*location,*attributeIcone,*levelIcone,*typeIcone,*locationIcone,*descriptionSchool;
@property (nonatomic, strong) UIButton *selectedBtn,*popView;
@property (nonatomic, strong) UIScrollView *centerView;
@property (nonatomic, weak) id <StudentLineHeadViewDelegate>delegate;
- (instancetype)initWithMode:(Student_Details *)mode;
+ (CGFloat )getHeight;
@end
