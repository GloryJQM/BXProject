//
//  SlideShowScrollView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/24.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideShowScrollView : UIView<UIScrollViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame imageAry:(NSArray *)imageAry isRequest:(BOOL)isRequest;
@property UIPageControl *imagePageControl;
@property UIScrollView  *scrollView;
/** 滚动延时*/
@property (nonatomic, assign) NSTimeInterval AutoScrollDelay;

@end
