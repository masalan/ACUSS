//
//  EAIntroView.m
//  EAIntroView
//
//  Copyright (c) 2013 Evgeny Aleksandrov.
//

#import "EAIntroView.h"

#define DEFAULT_BACKGROUND_COLOR [UIColor clearColor]

@interface EAIntroView() {
    NSMutableArray *pageViews;
    NSInteger LastPageIndex;
}

@end

@implementation EAIntroView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 60.0f;
        [self buildUIWithFrame:frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 60.0f;
        [self buildUIWithFrame:self.frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray {
    self = [super initWithFrame:frame];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 60.0f;
        _pages = [pagesArray copy];
        [self buildUIWithFrame:frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

#pragma mark - UI building

- (void)buildUIWithFrame:(CGRect)frame {
    self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self buildScrollViewWithFrame:frame];
    
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}


- (void)buildScrollViewWithFrame:(CGRect)frame {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //A running x-coordinate. This grows for every page
    CGFloat contentXIndex = 0;
    for (int idx = 0; idx < _pages.count; idx++) {
        [pageViews addObject:[self viewForPage:_pages[idx] atXIndex:&contentXIndex]];
        [self.scrollView addSubview:pageViews[idx]];
    }
    
    [self makePanelVisibleAtIndex:0];
    
    if (self.swipeToExit) {
        [self appendCloseViewAtXIndex:&contentXIndex];
    }
    
    self.scrollView.contentSize = CGSizeMake(contentXIndex, self.scrollView.frame.size.height);
    [self addSubview:self.scrollView];
    
//    [self.pageBgBack setAlpha:0];
//    [self.pageBgBack setImage:[self bgForPage:1]];
//    [self.pageBgFront setAlpha:1];
//    [self.pageBgFront setImage:[self bgForPage:0]];
}

- (UIView *)viewForPage:(EAIntroPage *)page atXIndex:(CGFloat *)xIndex {
    
    UIImageView *pageView = [[UIImageView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    *xIndex += self.scrollView.frame.size.width;
    
    if(page.bgImage) {
        pageView.image = page.bgImage;
        return pageView;
    }

    return pageView;
}

- (void)appendCloseViewAtXIndex:(CGFloat*)xIndex {
    UIView *closeView = [[UIView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.frame.size.width, self.frame.size.height)];
    closeView.tag = 124;
    [self.scrollView addSubview:closeView];
    
    *xIndex += self.scrollView.frame.size.width;
}

- (void)removeCloseViewAtXIndex:(CGFloat*)xIndex {
    UIView *closeView = [self.scrollView viewWithTag:124];
    if(closeView) {
        [closeView removeFromSuperview];
    }
    
    *xIndex -= self.scrollView.frame.size.width;
}



#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPageIndex = scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
    if (self.currentPageIndex == (pageViews.count)) {
        if ([(id)self.delegate respondsToSelector:@selector(introDidFinish:)]) {
            [self.delegate introDidFinish:NO];
        }
    } else {
        LastPageIndex = self.pageControl.currentPage;
        self.pageControl.currentPage = self.currentPageIndex;
        
        [self makePanelVisibleAtIndex:(NSInteger)self.currentPageIndex];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    
    float offset = scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    
    if (offset <0) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        return;
    }
    
    if (offset > 4.01) {
        if ([(id)self.delegate respondsToSelector:@selector(introDidFinish:)]) {
            
            [self.delegate introDidFinish:NO];
        }
        
//        [UIView animateWithDuration:1.6 animations:^void{
//            self.alpha = 0;
//        } completion:^(BOOL finished){
            [self removeFromSuperview];
//        }];
        
       
    }
    NSInteger page = (int)(offset);
    
   
    if (page == (pageViews.count - 1) && self.swipeToExit) {
        self.alpha = 3*((self.scrollView.frame.size.width*pageViews.count)-self.scrollView.contentOffset.x)/self.scrollView.frame.size.width;
    } else {
//        [self crossDissolveForOffset:offset];
    }
}

- (void)crossDissolveForOffset:(float)offset {
//    NSInteger page = (int)(offset);
//    float alphaValue = offset - (int)offset;
//    
//    if (alphaValue < 0 && self.currentPageIndex == 0){
//        [self.pageBgBack setImage:nil];
//        [self.pageBgFront setAlpha:(1 + alphaValue)];
//        return;
//    }
//    
//    [self.pageBgFront setAlpha:1];
//    [self.pageBgFront setImage:[self bgForPage:page]];
//    [self.pageBgBack setAlpha:0];
//    [self.pageBgBack setImage:[self bgForPage:page+1]];
//    
//    float backLayerAlpha = alphaValue;
//    float frontLayerAlpha = (1 - alphaValue);
//    
//    [self.pageBgBack setAlpha:backLayerAlpha];
//    [self.pageBgFront setAlpha:frontLayerAlpha];
}

- (UIImage *)bgForPage:(int)idx {
    if(idx >= _pages.count || idx < 0)
        return nil;
    
    return ((EAIntroPage *)_pages[idx]).bgImage;
}

#pragma mark - Custom setters

- (void)setPages:(NSArray *)pages {
    _pages = [pages copy];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self buildScrollViewWithFrame:self.frame];
}


- (void)setSwipeToExit:(bool)swipeToExit {
    if (swipeToExit != _swipeToExit) {
        CGFloat contentXIndex = self.scrollView.contentSize.width;
        if(swipeToExit) {
            [self appendCloseViewAtXIndex:&contentXIndex];
        } else {
            [self removeCloseViewAtXIndex:&contentXIndex];
        }
        self.scrollView.contentSize = CGSizeMake(contentXIndex, self.scrollView.frame.size.height);
    }
    _swipeToExit = swipeToExit;
    
}

- (void)setTitleView:(UIView *)titleView {
    [_titleView removeFromSuperview];
    _titleView = titleView;
    [_titleView setFrame:CGRectMake((self.frame.size.width-_titleView.frame.size.width)/2, self.titleViewY, _titleView.frame.size.width, _titleView.frame.size.height)];
    [self addSubview:_titleView];
}

- (void)setTitleViewY:(CGFloat)titleViewY {
    _titleViewY = titleViewY;
    [_titleView setFrame:CGRectMake((self.frame.size.width-_titleView.frame.size.width)/2, self.titleViewY, _titleView.frame.size.width, _titleView.frame.size.height)];
}

- (void)setPageControlY:(CGFloat)pageControlY {
    _pageControlY = pageControlY;
    [self.pageControl setFrame:CGRectMake(0, self.frame.size.height - pageControlY, self.frame.size.width, 20)];
}

#pragma mark - Actions

- (void)makePanelVisibleAtIndex:(NSInteger)panelIndex{
    [UIView animateWithDuration:0.3 animations:^{
        for (int idx = 0; idx < pageViews.count; idx++) {
            if (idx == panelIndex) {
                [pageViews[idx] setAlpha:1];
            }
            else {
                if(!self.hideOffscreenPages) {
                    [pageViews[idx] setAlpha:0];
                }
            }
        }
    }];
}

- (void)showPanelAtPageControl {
    LastPageIndex = self.pageControl.currentPage;
    self.currentPageIndex = self.pageControl.currentPage;
    
    [self makePanelVisibleAtIndex:(NSInteger)self.currentPageIndex];
    
    [self.scrollView setContentOffset:CGPointMake(self.currentPageIndex * SCREEN_WIDTH, 0) animated:YES];
}

- (void)skipIntroduction {
    if ([(id)self.delegate respondsToSelector:@selector(introDidFinish:)]) {
        [self.delegate introDidFinish:NO];
    }
    
    [self hideWithFadeOutDuration:0.3];
}

- (void)hideWithFadeOutDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:nil];
}

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration {
    self.alpha = 0;
    [self.scrollView setContentOffset:CGPointZero];
    [view addSubview:self];
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}

@end
