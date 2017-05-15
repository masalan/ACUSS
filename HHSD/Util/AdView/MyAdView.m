//
//  MyAdView.m
//  GLKiphone
//
//  Created by 刘锋婷 on 14-4-12.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "MyAdView.h"

@interface MyAdView() <UIScrollViewDelegate>


@end


@implementation MyAdView

#define WIDTH            self.bounds.size.width
#define HEIGHT           self.bounds.size.height

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=KCOLOR_BACKGROUND_WHITE;
    }
    _imageViewContentMode = UIViewContentModeScaleToFill;
    return self;
}
-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray withAnimationDurtion:(NSTimeInterval) durition
{
    
    if(urlArray)
    {
        _numberOfImages=[urlArray count];
    }else
    {
        _numberOfImages=[nameArray count];
        
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,HEIGHT-30,WIDTH,30)]; // 初始化mypagecontrol
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    _pageControl.numberOfPages =_numberOfImages;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    for (int i = 0;i<[urlArray count];i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WIDTH*(i+1),0, WIDTH,HEIGHT);
        imageView.contentMode = _imageViewContentMode;
        [_scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!500",urlArray [i]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        imageView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        
    }
    
    for (int i = 0;i<[nameArray count];i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WIDTH*(i+1),0, WIDTH,HEIGHT);
        imageView.contentMode = _imageViewContentMode;
        [_scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        imageView.image = nameArray[i];
        imageView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        
    }
    
    // 添加最后1页在首页 循环
    UIImageView *imageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
    imageView.contentMode = _imageViewContentMode;
    imageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    if(urlArray)
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[urlArray lastObject]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    else
    {
        imageView.image = [nameArray lastObject];
    }
    
    [_scrollView addSubview:imageView];
    
    UIImageView *lastimageView= [[UIImageView alloc] init];
    // 取数组第一张图片 放在最后1页
    //    UIImageView *lastimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[urlArray firstObject]]]];
    lastimageView.contentMode = _imageViewContentMode;
    lastimageView.frame = CGRectMake((WIDTH * (_numberOfImages+1)) , 0, WIDTH, HEIGHT);
    
    if(urlArray)
    {
        [lastimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!500",[urlArray firstObject]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }else
    {
        lastimageView.image = [nameArray firstObject];
    }
    [_scrollView addSubview:lastimageView];
    
    //  +上第1页和第4页  原理：4-[1-2-3-4]-1// 默认从序号1位置放第1页 ，序号0位置位置放第4页
    [_scrollView setContentSize:CGSizeMake(WIDTH * (_numberOfImages + 2), HEIGHT)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO];

    [_timer invalidate];
    _timer=[NSTimer scheduledTimerWithTimeInterval:durition target:self selector:@selector(timerActins) userInfo:nil repeats:YES];
    
}

#pragma -mark 轮播图
-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray animationDurtion:(NSTimeInterval) durition
{
    
    if(urlArray)
    {
        _numberOfImages=[urlArray count];
    }else
    {
        _numberOfImages=[nameArray count];

    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,HEIGHT-30,WIDTH,30)]; // 初始化mypagecontrol
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    _pageControl.numberOfPages =_numberOfImages;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];

    for (int i = 0;i<[urlArray count];i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WIDTH*(i+1),0, WIDTH,HEIGHT);
        imageView.contentMode = _imageViewContentMode;
        [_scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        
        [imageView sd_setImageWithURL:[NSURL URLWithString: urlArray[i]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        //[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!500",urlArray [i]]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];

    }
    
    for (int i = 0;i<[nameArray count];i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WIDTH*(i+1),0, WIDTH,HEIGHT);
        imageView.contentMode = _imageViewContentMode;
        [_scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        imageView.image = nameArray[i];
        imageView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        
    }
    
    // 添加最后1页在首页 循环
    UIImageView *imageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
    imageView.contentMode = _imageViewContentMode;
    imageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    if(urlArray)
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[urlArray lastObject]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    else
    {
        imageView.image = [nameArray lastObject];
    }
  
    [_scrollView addSubview:imageView];
    
    UIImageView *lastimageView= [[UIImageView alloc] init];
    // 取数组第一张图片 放在最后1页
//    UIImageView *lastimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[urlArray firstObject]]]];
    lastimageView.contentMode = _imageViewContentMode;
    lastimageView.frame = CGRectMake((WIDTH * (_numberOfImages+1)) , 0, WIDTH, HEIGHT);
    
    if(urlArray)
    {
        [lastimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!500",[urlArray firstObject]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }else
    {
        lastimageView.image = [nameArray firstObject];
    }
    [_scrollView addSubview:lastimageView];

    //  +上第1页和第4页  原理：4-[1-2-3-4]-1// 默认从序号1位置放第1页 ，序号0位置位置放第4页
    [_scrollView setContentSize:CGSizeMake(WIDTH * (_numberOfImages + 2), HEIGHT)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO];
//    
//    [_timer invalidate];
    
}
- (void)timeStart
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerActins) userInfo:nil repeats:YES];
//    [_timer fire];
}
- (void)timeStop
{
    [_timer invalidate];
    _timer = nil;
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/(_numberOfImages+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (_numberOfImages+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH * _numberOfImages,0,WIDTH,HEIGHT) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==(_numberOfImages+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    long int page = _pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(WIDTH*(page+1),0,WIDTH,HEIGHT) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1

}
// 定时器 绑定的方法
- (void)timerActins
{
    DLog(@"timerActins--------");
    long int page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > _numberOfImages-1 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}
-(void)imagePressed:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(myAdViewTappedAtIndex:)]) {
        [_delegate myAdViewTappedAtIndex:sender.view.tag];
    }
}
@end
