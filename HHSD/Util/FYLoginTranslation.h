//
//  FYLoginTranslation.h
//  HHSD
//
//  Created by alain serge on 3/17/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYLoginTranslation : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL reverse;

- (instancetype)initWithView:(UIView*)btnView;
- (void)stopAnimation;
@end
