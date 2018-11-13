//
//  MaskViewForUITextField.m
//  SmallCEO
//
//  Created by huang on 15/9/7.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MaskViewForUITextField.h"

@interface MaskViewForUITextField ()

@property (nonatomic, strong) UIWindow    *overlayWindow;

@end

@implementation MaskViewForUITextField

- (instancetype)init
{
    if (self = [super init]) {
        [self createMainView];
    }
    
    return self;
}

- (void)createMainView
{
    self.frame = [UIScreen mainScreen].bounds;
    [self.overlayWindow addSubview:self];
    [self addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickView
{
    [self.textFiled resignFirstResponder];
    [self hideMaskView];
}

#pragma 显示/隐藏视图
- (void)showMaskView
{
    self.alpha = 0.4;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideMaskView
{
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:_overlayWindow];
    [self.overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _overlayWindow = nil;

    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyAndVisible];
            *stop = YES;
        }
    }];
}

#pragma mark - Getter
- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.windowLevel = UIWindowLevelNormal;
        _overlayWindow.userInteractionEnabled = YES;
    }
    return _overlayWindow;
}

@end
