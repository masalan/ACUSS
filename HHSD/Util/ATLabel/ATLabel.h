//
//  ATLabel.h
//  BLHealth
//
//  Created by felix on 15/1/28.
//  Copyright (c) 2015年 BLHealth. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol ATLabelDelegate <NSObject>
- (void)ATLabelTag:(NSUInteger )tag;
@end

@interface ATLabel : UILabel {
    
}
@property(nonatomic,retain) NSArray *wordList;
@property(nonatomic,assign) double duration;
@property (nonatomic, weak) id<ATLabelDelegate>delegate;

- (void)animateWithWords:(NSArray *)words forDuration:(double)time;
@end
