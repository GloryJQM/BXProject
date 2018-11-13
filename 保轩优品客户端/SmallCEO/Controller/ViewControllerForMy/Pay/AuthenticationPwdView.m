//
//  AuthenticationPwdView.m
//  Jiang
//
//  Created by huang on 16/10/17.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "AuthenticationPwdView.h"

@interface AuthenticationPwdView ()

@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) UIView *myContentView;

@end

@implementation AuthenticationPwdView

@synthesize overlayWindow;

+ (AuthenticationPwdView *)sharedView {
    static dispatch_once_t once;
    static AuthenticationPwdView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[[self class] alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)createMainView
{
    self.myContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [[AuthenticationPwdView sharedView].overlayWindow addSubview:self.myContentView];
    
    CGFloat orignalY = IS_IPHONE4 ? 60 * adapterFactor : 110 * adapterFactor;
    CGFloat mainViewWidth = 256 *adapterFactor;
    CGFloat mainViewHeight = 170 *adapterFactor;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - mainViewWidth) / 2.0, orignalY, mainViewWidth, mainViewHeight)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.myContentView addSubview:mainView];
    
    CGFloat cancelButtonWidthOrHeight = 20 * adapterFactor;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(mainView.width - 15 - cancelButtonWidthOrHeight, 15, cancelButtonWidthOrHeight, cancelButtonWidthOrHeight);
    [cancelButton setImage:[[UIImage imageNamed:@"pwdinput_cancel_icon.png"] imageWithMinimumSize:cancelButton.size] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelButton];
    
    CGFloat textFontValue = IS_IPHONE4 || IS_IPHONE5 ? 18.0 : 20.0;
    CGFloat subtextFontValue = IS_IPHONE4 || IS_IPHONE5 ? 14.0 : 16.0;
    UILabel *promptTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, mainView.width, 22 * adapterFactor)];
    promptTextLabel.text = @"请输入支付密码";
    promptTextLabel.textAlignment = NSTextAlignmentCenter;
    promptTextLabel.textColor = [UIColor colorFromHexCode:@"333333"];
    promptTextLabel.font = [UIFont boldSystemFontOfSize:textFontValue];
    [mainView addSubview:promptTextLabel];
    
    UILabel *promptSubtextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, promptTextLabel.maxY + 10, mainView.width, 20 * adapterFactor)];
    promptSubtextLabel.textAlignment = NSTextAlignmentCenter;
    promptSubtextLabel.textColor = [UIColor colorFromHexCode:@"333333"];
    promptSubtextLabel.font = [UIFont systemFontOfSize:subtextFontValue];
    [mainView addSubview:promptSubtextLabel];
    self.promptSubtextLabel = promptSubtextLabel;
    
    AuthenticationPwdInputView *pwdInputView = [[AuthenticationPwdInputView alloc] initWithFrame:CGRectMake((mainView.width - 217 * adapterFactor) / 2.0, mainView.height / 2.0 + 15, 217 * adapterFactor, 43 * adapterFactor)];
    [pwdInputView becomeFirstResponder];
    [mainView addSubview:pwdInputView];
    self.inputView = pwdInputView;
    
    UIButton *forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:[UIColor colorFromHexCode:@"42aef5"] forState:UIControlStateNormal];
    CGSize forgetPwdButtonSize = [forgetPwdButton sizeThatFits:CGSizeMake(mainView.width, MAXFLOAT)];
    forgetPwdButton.titleLabel.font = [UIFont systemFontOfSize:subtextFontValue];
    forgetPwdButton.frame = CGRectMake((mainView.width - forgetPwdButtonSize.width) / 2.0, pwdInputView.maxY, forgetPwdButtonSize.width, forgetPwdButtonSize.height);
    [forgetPwdButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:forgetPwdButton];
    self.forgetPwdButton = forgetPwdButton;
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

#pragma mark - UIButton action methods
- (void)forgetPassword
{
}

#pragma mark - 显示或隐藏的方法
+ (void)show
{
    [[AuthenticationPwdView sharedView] showSelectView];
}

+ (void)dismiss
{
    [[AuthenticationPwdView sharedView] hideSelectView];
}

- (void)showSelectView
{
    [self createMainView];
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideSelectView
{
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:overlayWindow];
    [overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.myContentView = nil;
    overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}

@end
