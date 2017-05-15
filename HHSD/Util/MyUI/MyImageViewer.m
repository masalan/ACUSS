//
//  MyImageViewer.m
//  YWYiphone
//
//  Created by 汪达 on 14/8/29.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import "MyImageViewer.h"
//#import <SDWebImageManager.h>
#import "SDWebImageManager.h"

#import "UIImageView+WebCache.h"


@interface MyImageViewer () <UIScrollViewDelegate,MyImageViewDelegate>

@end

@implementation MyImageViewer

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark -
-(void)showImagesWithImageURLs:(NSArray *)imageURLs
{
    _totalCount = [imageURLs count];
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        _scrollView.backgroundColor = [KCOLOR_BLACK colorWithAlphaComponent:0.9];
        _scrollView.pagingEnabled = YES;
        _scrollView.alpha = 0;
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setContentSize:CGSizeMake(KSCREEN_WIDTH*[imageURLs count], KSCREEN_HEIGHT)];
        [superView addSubview:_scrollView];
    }else{
        for (UIImageView *imageView in _scrollView.subviews) {
            [imageView removeFromSuperview];
        }
    }
    
    if ([imageURLs count]) {
        for (NSInteger i = 0; i<[imageURLs count]; i++) {
            MyImageView *imageView = [[MyImageView alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH*i,0,KSCREEN_WIDTH,KSCREEN_HEIGHT)
                                                            withImageURL:imageURLs[i]
                                                               atIndex:i];
            imageView.tapDelegate = self;
            [_scrollView addSubview:imageView];
        }
    }

    if (!_tabBar) {
        _tabBar = [[MyImageViewTabBar alloc] initWithFrame:CGRectMake(0, _scrollView.bounds.size.height-KHEIGHT_40, KSCREEN_WIDTH, KHEIGHT_40)
                                            withTotalCount:_totalCount];
        [_tabBar.saveButton addTarget:self action:@selector(onSaveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:_tabBar];
        _tabBar.alpha = 0;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _scrollView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         _tabBar.alpha = 1;
                     }];
}
-(void)onSaveButtonTapped
{
    NSInteger page =(NSInteger)_scrollView.contentOffset.x/KSCREEN_WIDTH;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = NO;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    for (MyImageView *imageView in _scrollView.subviews) {
        if (imageView.index == page) {
            if (imageView.image) {
                UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil,nil);
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
                hud.mode = MBProgressHUDModeCustomView;
                hud.label.text = @"Picture Save!";
                [hud hideAnimated:YES afterDelay:1.0];
            }
        }
    }
}

#pragma mark -
-(void)showImagesWithImageURLs:(NSArray *)imageURLs atIndex:(NSInteger )index
{
    [self showImagesWithImageURLs:imageURLs];
    if (index <= _totalCount-1) {
        [_scrollView scrollRectToVisible:CGRectMake(KSCREEN_WIDTH*index, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) animated:NO];
        _tabBar.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)index+1,(long)_totalCount];
    }
}
#pragma mark -
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page =(NSInteger)scrollView.contentOffset.x/KSCREEN_WIDTH;
    _tabBar.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)page+1,(long)_totalCount];
}
#pragma mark -
-(void)myImageViewHandleSingleTap
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _scrollView.alpha = 0;
                         _tabBar.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [_scrollView removeFromSuperview];
                         [_tabBar removeFromSuperview];
                     }];
}

@end

/**
 MyImageView
 
 :param: idinitWithFrame 
 */

@implementation MyImageView

-(id)initWithFrame:(CGRect)frame withImageURL:(NSString *)imageURL atIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 4.0;
        _index = index;
        //gesture
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.delaysTouchesBegan = YES;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        //
        _act = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((kBOUNDS_WIDTH-KHEIGHT_40)/2, (KBOUNDS_HEIGHT-KHEIGHT_40)/2, KHEIGHT_40, KHEIGHT_40)];
        _act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [_act startAnimating];
        [self addSubview:_act];
        
        _imageView = [UIImageView createImageViewWithFrame:self.bounds backgroundColor:KCOLOR_CLEAR image:nil];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 _image = image;
                                 [_act removeFromSuperview];
                             }];
        [self addSubview:_imageView];
        
        
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat Ws = scrollView.frame.size.width - scrollView.contentInset.left - scrollView.contentInset.right;
    CGFloat Hs = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom;
    CGFloat W = _imageView.frame.size.width;
    CGFloat H = _imageView.frame.size.height;
    
    CGRect rct = _imageView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.frame = rct;
}

-(void)handleTap
{
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(myImageViewHandleSingleTap)]) {
        [_tapDelegate myImageViewHandleSingleTap];
    }
}
-(void)handleDoubleTap:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}


@end



/**
 MyImageViewTabBar
 
 :param: idinitWithFrame
 */

@implementation MyImageViewTabBar

-(id)initWithFrame:(CGRect)frame withTotalCount:(NSInteger)totalCount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [KCOLOR_BLACK colorWithAlphaComponent:0.6];
        
        _saveButton = [UIButton createButtonwithFrame:CGRectMake(KMARGIN_10, 0, KBOUNDS_HEIGHT, KBOUNDS_HEIGHT)
                                      backgroundColor:KCOLOR_CLEAR
                                                image:[UIImage imageNamed:@"Download"]];
        [self addSubview:_saveButton];
        
        _countLabel = [UILabel createLabelWithFrame:CGRectMake(KBOUNDS_HEIGHT+KMARGIN_10, 0, (kBOUNDS_WIDTH-(KBOUNDS_HEIGHT+KMARGIN_10)*2), KBOUNDS_HEIGHT)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_WHITE
                                               font:KSYSTEM_FONT_BOLD_(14)
                                      textalignment:NSTextAlignmentCenter
                                               text:[NSString stringWithFormat:@"1/%ld",(long)totalCount]];
        [self addSubview:_countLabel];
    }
    return self;
}

@end
