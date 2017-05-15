//
//  UIImageView+SDWDImageCache.m
//  HHSD
//
//  Created by Serge Alain on 02/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import "UIImageView+SDWDImageCache.h"

@implementation UIImageView (SDWDImageCache)
- (void)imageCacheWithImageView:(UIImageView *)imageView urlString:(NSString *)urlString
{
    if(urlString && [urlString isKindOfClass:[NSString class]])
    {
        if([urlString hasPrefix:@"http"])
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                placeholderImage:[UIImage imageNamed:PlaceHoderImage]];
        }else
        {
            NSString *httpString = [NSString stringWithFormat:@"%@%@",urlHeader,urlString];
            [imageView sd_setImageWithURL:[NSURL URLWithString:httpString]
                         placeholderImage:[UIImage imageNamed:PlaceHoderImage]];
        }
    }
}
@end
