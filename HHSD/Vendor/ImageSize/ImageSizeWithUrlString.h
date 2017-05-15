//
//  ImageSizeWithUrlString.h
//  YWY2
//
//  Created by 汪达 on 15/7/28.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSizeWithUrlString : NSObject
+(CGSize)downloadImageSizeWithURLString:(id)imageURL;
+ (CGSize)SizeLow:(CGSize)size;
@end
