//
//  MyImageViewer.h
//  YWYiphone
//
//  Created by 汪达 on 14/8/29.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"

@protocol MyImageViewDelegate <NSObject>

-(void)myImageViewHandleSingleTap;

@end

@interface MyImageViewTabBar : UIView

@property (nonatomic,strong)UIButton *saveButton;
@property (nonatomic,strong)UILabel *countLabel;

-(id)initWithFrame:(CGRect)frame withTotalCount:(NSInteger)totalCount;

@end



/**
 *  MyImageView
 */

@interface MyImageView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)id <MyImageViewDelegate> tapDelegate;
@property (nonatomic,strong)UIActivityIndicatorView *act;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,assign)NSInteger index;


-(id)initWithFrame:(CGRect)frame withImageURL:(NSString *)imageURL atIndex:(NSInteger)index;


@end


/**
 *  MyImageViewer
 */

@interface MyImageViewer : NSObject

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger totalCount;
@property (nonatomic,strong)MyImageViewTabBar *tabBar;

-(void)showImagesWithImageURLs:(NSArray *)imageURLs;
-(void)showImagesWithImageURLs:(NSArray *)imageURLs atIndex:(NSInteger )index;

@end

