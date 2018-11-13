//
//  ProductShareView.m
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ProductShareView.h"

@interface ProductShareView ()

@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) UIView *mainView;

@end

@implementation ProductShareView

@synthesize overlayWindow;

+ (ProductShareView *)sharedView {
    static dispatch_once_t once;
    static ProductShareView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[ProductShareView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)setupMainView
{
    [self addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *shareNames = @[@"微信好友", @"QQ好友", @"朋友圈", @"新浪微博"];
    NSArray *shareImages = @[@"button-fengxiang0", @"pho-qq@2x", @"button-fengxiang1", @"pho-weibo@2x"];
    
    CGFloat interval = 15.0;
    CGFloat subviewWidth = (UI_SCREEN_WIDTH - interval * (shareNames.count + 1)) / shareNames.count;
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 135.0)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.overlayWindow addSubview:mainView];
    self.mainView = mainView;
    
    [shareNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.frame = CGRectMake(interval * (idx + 1) + idx * subviewWidth, 15.0, subviewWidth, 80);
        [shareButton setTitle:shareNames[idx] forState:UIControlStateNormal];
        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shareButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -48, 0);
        shareButton.tag = idx;
        [shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:shareButton];
        
        CGFloat logoWidth = subviewWidth - 10.0;
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, logoWidth, logoWidth)];
        logoImageView.image = [UIImage imageNamed:shareImages[idx]];
        [shareButton addSubview:logoImageView];
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, mainView.height - 35, mainView.width , 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [mainView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
- (void)clickShareButton:(UIButton *)sender
{
    if (self.selectBlock)
    {
        self.selectBlock(sender.tag);
    }
    
    [self hideSelectView];
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
+ (void)show
{
    [[ProductShareView sharedView] showSelectView];
}

+ (void)dismiss
{
    [[ProductShareView sharedView] hideSelectView];
}

- (void)showSelectView
{
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self setupMainView];
    [self.overlayWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.y -= self.mainView.height;
    }];
}

- (void)hideSelectView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.y += self.mainView.height;
    } completion:^(BOOL finished) {
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
    }];
}

@end
