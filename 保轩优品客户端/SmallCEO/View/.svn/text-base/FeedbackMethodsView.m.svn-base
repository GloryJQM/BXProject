//
//  FeedbackMethodsView.m
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "FeedbackMethodsView.h"

@interface FeedbackMethodsView ()

@property (nonatomic, strong) UIWindow *overlayWindow;

@end

@implementation FeedbackMethodsView

@synthesize overlayWindow;

+ (FeedbackMethodsView *)sharedView {
    static dispatch_once_t once;
    static FeedbackMethodsView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[FeedbackMethodsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)setupMainView:(NSArray *)array
{
    [self addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    DLog(@"%@",array);
    NSMutableArray *methodNames = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        if ([[array[i] objectForKey:@"is_show"] integerValue] == 1) {
            methodNames[i] = [array[i] objectForKey:@"name"];
        }
    }
    //    NSArray *methodNames = @[@"æ¨æç­çº¿"];
    CGFloat viewWidth = UI_SCREEN_WIDTH - 70;
    CGFloat subviewHeight = 60;
    CGFloat mainViewHeight = subviewHeight * (methodNames.count);
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(35.0, (UI_SCREEN_HEIGHT - mainViewHeight) / 2.0, viewWidth, mainViewHeight)];
    mainView.layer.cornerRadius = 5.0;
    mainView.clipsToBounds = YES;
    mainView.backgroundColor = [UIColor whiteColor];
    [self.overlayWindow addSubview:mainView];
    
    UIFont *labelFont = [UIFont systemFontOfSize:20.0];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainView.width, subviewHeight)];
//    titleLabel.font = labelFont;
//    titleLabel.text = @"请选择反馈方式";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [mainView addSubview:titleLabel];
    
    [methodNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,idx * subviewHeight, mainView.width, subviewHeight)];
        methodLabel.font = labelFont;
        methodLabel.text = methodNames[idx];
        methodLabel.textAlignment = NSTextAlignmentCenter;
        methodLabel.tag = idx;
        if (idx>0) {
            methodLabel.textColor = App_Main_Color;
        }
        [mainView addSubview:methodLabel];
        [methodLabel addTarget:self action:@selector(selectFeedbackMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, methodLabel.y, mainView.width, 0.5)];
        lineView.backgroundColor = SUB_TITLE;
        [mainView addSubview:lineView];
    }];
}

#pragma mark - 
- (void)selectFeedbackMethod:(UIButton *)sender
{
    if (sender.tag != 0) {
        if (self.selectBlock)
        {
            DLog(@"%ld",(long)sender.tag);
            self.selectBlock(sender.tag);
        }
        
        [self hideSelectView];
    }
}

#pragma mark - Getter
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        overlayWindow.userInteractionEnabled = YES;
    }
    return overlayWindow;
}

#pragma mark - 显示或隐藏的方法
+ (void)showWithArray:(NSArray *)array
{
    [[FeedbackMethodsView sharedView] showSelectView:array];
}

+ (void)dismiss
{
    [[FeedbackMethodsView sharedView] hideSelectView];
}

- (void)showSelectView:(NSArray *)array
{
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self setupMainView:array];
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideSelectView
{
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:overlayWindow];
    [overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}

@end
