//
//  SlideShowScrollView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/24.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "SlideShowScrollView.h"
@interface SlideShowScrollView () {
    NSTimer *timer;
    
    NSTimer *_timer;
    
    /** 当前显示的是第几个*/
    NSInteger _currentIndex;
    
    /** 图片个数*/
    NSInteger _MaxImageCount;
    
}
@end
@implementation SlideShowScrollView
- (instancetype)initWithFrame:(CGRect)frame imageAry:(NSArray *)imageAry isRequest:(BOOL)isRequest{
    self = [super initWithFrame:frame];
    if (self) {

        //设置引导视图的scrollview
        self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH*imageAry.count, frame.size.height);
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        for (int i = 0; i < imageAry.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, frame.size.height)];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            imageView.tag = i;
            if (isRequest) {
                NSURL *url = [NSURL URLWithString:imageAry[i]];
                [imageView sd_setImageWithURL:url placeholderImage:nil];
            }else {
                imageView.image = [UIImage imageNamed:imageAry[i]];
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
        }
        
        //设置引导页上的页面控制器
        self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,frame.size.height - 50, UI_SCREEN_WIDTH, 50)];
        self.imagePageControl.currentPage = 0;
        self.imagePageControl.numberOfPages = imageAry.count;
        self.imagePageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.imagePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_imagePageControl];
        
        _currentIndex = 0;
        /** 定时器*/
        [self setUpTimer];
    }
    return self;
}

- (void)setUpTimer {
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)scorll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x +UI_SCREEN_WIDTH, 0) animated:YES];
    int page = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
    int page = scrollview.contentOffset.x / scrollview.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    UIImageView *imageview = (UIImageView *)gesture.view;
    DLog(@"%ld", imageview.tag);
}


@end
