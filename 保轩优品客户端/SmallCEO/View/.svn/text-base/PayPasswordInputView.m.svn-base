//
//  PayPasswordInputView.m
//  SmallCEO
//
//  Created by huang on 15/8/31.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "PayPasswordInputView.h"

@interface PayPasswordInputView ()

@property (nonatomic, strong) UIWindow    *overlayWindow;
@property (nonatomic, strong) UITextField *pwdTextFiled;
@property (nonatomic, strong) UIView      *mainView;
@property (nonatomic, strong) UIView      *payPwdInputView;

@end

@implementation PayPasswordInputView

- (instancetype)init
{
    if (self = [super init]) {
        [self createMainView];
    }
    
    return self;
}

- (void)createMainView
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    self.frame = [UIScreen mainScreen].bounds;
    [self addTarget:self action:@selector(hideInputView) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    [self.overlayWindow addSubview:self.mainView];
    
    self.payPwdInputView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.payPwdInputView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.payPwdInputView];
    
    self.pwdTextFiled = [[UITextField alloc] initWithFrame:CGRectZero];
    self.pwdTextFiled.hideStatus=@"1";
    [self.payPwdInputView addSubview:self.pwdTextFiled];
}

- (void)keyboardWillShow:(NSNotification*)aNotification {

    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGPoint keybordPoint = [aValue CGRectValue].origin;
    CGSize keyboardRect = [aValue CGRectValue].size;
    
    self.mainView.frame = CGRectMake(keybordPoint.x, keybordPoint.y - 150, keyboardRect.width, 150);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50)];
    titleLabel.text = @"输入支付密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:titleLabel];

    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"Button-fanhui.png"] forState:UIControlStateNormal];
    returnBtn.frame = CGRectMake(16.5, 15, 20, 20);
    [returnBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:returnBtn];

    UILabel *separatedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) - 0.5, UI_SCREEN_WIDTH, 0.5)];
    separatedLine.backgroundColor = [UIColor colorFromHexCode:@"aaaaaa"];
    [self.mainView addSubview:separatedLine];

    self.payPwdInputView.frame = CGRectMake(16.5, CGRectGetMaxY(separatedLine.frame) + 10, UI_SCREEN_WIDTH - 33, 50);
    self.payPwdInputView.layer.cornerRadius = 5.0;
    self.payPwdInputView.layer.borderWidth = 0.5;
    self.payPwdInputView.layer.borderColor = [[UIColor colorFromHexCode:@"aaaaaa"] CGColor];
    
    CGFloat widthForPayBtn = 60.0;
    self.pwdTextFiled.frame = CGRectMake(15, 0, CGRectGetWidth(self.payPwdInputView.frame) - widthForPayBtn - 30, 50);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0], NSFontAttributeName, [UIColor colorFromHexCode:@"CACBCD"], NSForegroundColorAttributeName, nil];
    self.pwdTextFiled.secureTextEntry = YES;
    self.pwdTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"支付密码" attributes:attributes];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    payBtn.layer.cornerRadius = 5.0;
    [payBtn setTitle:@"付款" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundColor:App_Main_Color];
    payBtn.frame = CGRectMake(CGRectGetMaxX(self.pwdTextFiled.frame), 10, widthForPayBtn, 30);
    payBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.payPwdInputView addSubview:payBtn];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    CGSize sizeForForgetPwdBtn = [forgetPwdBtn.titleLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    forgetPwdBtn.frame = CGRectMake(UI_SCREEN_WIDTH - sizeForForgetPwdBtn.width - 21.5, CGRectGetMaxY(self.payPwdInputView.frame) + 12, sizeForForgetPwdBtn.width, 20);
    [forgetPwdBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:forgetPwdBtn];
}

#pragma mark - Getter
- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        _overlayWindow.userInteractionEnabled = YES;
    }
    return _overlayWindow;
}

#pragma mark - 点击事件的方法
- (void)forgetPassword
{
    if ([self.delegate respondsToSelector:@selector(inputView:doClickButtonWithType:withPassword:)])
    {
        [self.delegate inputView:self doClickButtonWithType:ButtonTypeForgetPassword withPassword:@""];
    }
    [self hideInputView];
}

- (void)pay
{
    if ([self.delegate respondsToSelector:@selector(inputView:doClickButtonWithType:withPassword:)])
    {
        NSString *md5Pwd = [NSString md5:self.pwdTextFiled.text];
        [self.delegate inputView:self doClickButtonWithType:ButtonTypePay withPassword:md5Pwd];
    }
    [self hideInputView];
}

- (void)returnBtnClick
{
    if ([self.delegate respondsToSelector:@selector(inputView:doClickButtonWithType:withPassword:)])
    {
        [self.delegate inputView:self doClickButtonWithType:ButtonTypeReturn withPassword:@""];
    }
    [self hideInputView];
}

#pragma mark - 显示或隐藏的方法
- (void)showInView:(UIView *)view
{
    [view endEditing:NO];
    
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self.overlayWindow makeKeyAndVisible];
    
    [self.pwdTextFiled becomeFirstResponder];
}

- (void)hideInputView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.pwdTextFiled resignFirstResponder];
    
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:_overlayWindow];
    [self.overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}

@end
