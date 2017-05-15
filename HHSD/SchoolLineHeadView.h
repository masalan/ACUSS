//
//  SchoolLineHeadView.h
//  HHSD
//
//  Created by alain serge on 3/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SchoolLineHeadViewDelegate<NSObject>
- (void)SchoolLineHeadViewbtnClick:(NSInteger)index;
//- (void)BtnClickLoginHere:(NSInteger)index;

@end
@interface SchoolLineHeadView : UIView
@property (nonatomic, strong) UIImageView *leftImageView,*logoSchool;
@property (nonatomic, strong) UILabel *titlaLabel,*nameUniversity,*numberLabel,*attribute,*level,*type,*location,*attributeIcone,*levelIcone,*typeIcone,*locationIcone,*descriptionSchool;
@property (nonatomic, strong) UIButton *selectedBtn,*popView;
@property (nonatomic, strong) UIScrollView *centerView;
@property (nonatomic, weak) id <SchoolLineHeadViewDelegate>delegate;
- (instancetype)initWithMode:(School_Details *)mode;
+ (CGFloat )getHeight;
@end
