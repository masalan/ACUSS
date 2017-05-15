//
//  UIImageView+SDWDImageCache.h
//  HHSD
//
//  Created by Serge Alain on 02/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImageView (SDWDImageCache)
- (void)imageCacheWithImageView:(UIImageView *)imageView urlString:(NSString *)urlString;
@end
