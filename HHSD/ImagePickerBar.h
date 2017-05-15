//
//  ImagePickerBar.h
//  HHSD
//
//  Created by alain serge on 4/6/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"


@interface ImagePickerBar : UIView

@property (nonatomic,strong)UIButton *imagePickerButton;
@property (nonatomic,strong)UIButton *cameraPickerButton;

- (id)initWithFrame:(CGRect)frame;

@end
