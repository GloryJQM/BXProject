//
//  SlideScrollView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "SlideScrollView.h"
@interface SlideScrollView ()<UIScrollViewDelegate> {
    BOOL shouldPullup; //yes时界面上拉
    BOOL shouldPullDown; //yes时界面下滑
    BOOL isShowImages;
    
    //提示label
    UILabel *pushUpLabel;
    //提示label
    UILabel *pushDownLabel;
}
@end
@implementation SlideScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creationScrollView];
    }
    return self;
}

- (void)creationScrollView {
    self.delegate = self;
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    _firstScrollView.delegate = self;
    _firstScrollView.alwaysBounceVertical = YES;
    _firstScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_firstScrollView];
    
    self.loadImagesScrollView = [[LoadImagesScrollView alloc] initWithFrame:CGRectMake(0, _firstScrollView.frame.size.height, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    _loadImagesScrollView.delegate = self;
    _loadImagesScrollView.alwaysBounceVertical = YES;
    _loadImagesScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_loadImagesScrollView];

}

#pragma mark UIScrollViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _firstScrollView) {
        CGFloat y = scrollView.contentSize.height - scrollView.height + 55;
        if (y <= 0) {
            y = 55;
        }
        if (scrollView.contentOffset.y > y) {
            pushUpLabel.hidden=NO;
            shouldPullup=YES;
            //加载下面的图片
            if (!isShowImages) {
                [_loadImagesScrollView addImageToScrollView:0];
                isShowImages=YES;
            }
        }else{
            shouldPullup=NO;
        }
    }
    if(scrollView == _loadImagesScrollView){
        if (scrollView.contentOffset.y < -55) {
            pushDownLabel.hidden=NO;
            shouldPullDown=YES;
        }else{
            shouldPullDown=NO;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _firstScrollView) {
        if (shouldPullup) {
            shouldPullup=NO;
            [self setContentOffset:CGPointMake(0, self.frame.size.height) animated:YES];
        }
    }
    if(scrollView == _loadImagesScrollView){
        if (shouldPullDown) {
            shouldPullDown=NO;
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}
@end
