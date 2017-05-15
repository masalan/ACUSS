//
//  ATLabel.m
//  BLHealth
//
//  Created by felix on 15/1/28.
//  Copyright (c) 2015年 BLHealth. All rights reserved.
//

#import "ATLabel.h"

@implementation ATLabel
@synthesize wordList = _wordList;
@synthesize duration = _duration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    self.tag = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    return self;
}
- (void)tapClick:(UITapGestureRecognizer *)sender
{
    if(_delegate)
    {
        [_delegate ATLabelTag:sender.view.tag];
    }
}


- (void)animateWithWords:(NSArray *)words forDuration:(double)time {
    self.duration = time;
    if(self.wordList){
        self.wordList = nil;
    }
    self.wordList = [[NSArray alloc] initWithArray:words];
    self.text = [self.wordList objectAtIndex:0];
    [NSThread detachNewThreadSelector:@selector(_startAnimations:) toTarget:self withObject:self.wordList];
    
}

- (void) _startAnimations:(NSArray *)images {
    
    @autoreleasepool {
        
        for (uint i = 1; i < [images count]; i++) {
            sleep(self.duration);
            [self performSelectorOnMainThread:@selector(_animate:)
                                   withObject:[NSNumber numberWithInt:i]
                                waitUntilDone:YES];
            self.tag = i;
            sleep(self.duration);
            if (i == [images count] - 1) {
                i = -1;
            }
        }
        
    }
}


- (void) _animate:(NSNumber*)num
{
    
    [UIView animateWithDuration:self.duration/2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:self.duration/2 animations:^{
            self.alpha = 1.0;
            self.text = [self.wordList objectAtIndex:[num intValue]];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

@end