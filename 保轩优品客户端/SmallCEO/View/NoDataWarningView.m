//
//  NoDataWarningView.m
//  SmallCEO
//
//  Created by ni on 16/7/7.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "NoDataWarningView.h"
@interface NoDataWarningView ()
{
    CGRect oldFrame;
}
@property (nonatomic, strong) UIImageView *warningImageView;
@property (nonatomic, strong) UILabel *warningLabel;


@end

@implementation NoDataWarningView

#define wLoginButtonOff 15
#define wLoginButtonHeight 30
#define wLoginButtonWidth (75*adapterFactor)

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
{
    if (self)
    {
        self = [super initWithFrame:frame];
        oldFrame = frame;
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;

        CGFloat off_y = frame.origin.y;
        off_y = off_y == 0 ? (150-IPHONE4HEIGHT(30)) : 50;
        
        UIImage *img = [UIImage imageNamed:@"ic_no_order"];
        CGFloat imgW = 60*adapterFactor;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((UI_SCREEN_WIDTH -imgW)/2.0, off_y, imgW, imgW);
        imageView.image = img;
        [self addSubview:imageView];
        self.warningImageView = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, imageView.maxY + 10, UI_SCREEN_WIDTH, 20);
        label.textColor = SUB_TITLE;
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:label];
        self.warningLabel = label;
    }
    return self;
}
- (void)setWarningType:(WarningType)warningType
{
    // default image
    UIImage *img  = [UIImage imageNamed:@"ic_no_order"];
    if (warningType == WarningTypeDefult)
    {
        img  = [UIImage imageNamed:@"ic_no_order"];
        self.frame = oldFrame;
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[UIButton class]] ) {
                [sub removeFromSuperview];
            }
        }
    }
    else if (warningType == WarningTypeNoNetWork)
    {
        img = [UIImage imageNamed:@"msg_warning_nonet.png"];
        CGRect newframe = self.frame;
        if (self.height < (self.warningLabel.maxY+wLoginButtonHeight+wLoginButtonOff)) {
            newframe.size.height += wLoginButtonHeight+wLoginButtonOff;
            self.frame = newframe;
        }
        [self addSubview:self.loginButton];
        [_loginButton setTitle:@"点击加载" forState:UIControlStateNormal];
    }
    else if (warningType == WarningTypeNotFound)
    {
        img = [UIImage imageNamed:@"msg_warning_notfound.png"];
    }
    else if (warningType == WarningTypeNotLogin)
    {
        CGRect newframe = self.frame;
        if (self.height < (self.warningLabel.maxY+wLoginButtonHeight+wLoginButtonOff)) {
            newframe.size.height += wLoginButtonHeight+wLoginButtonOff;
            self.frame = newframe;
        }
        [self addSubview:self.loginButton];
        [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];

    }
    self.warningImageView.image = img;
}
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake((UI_SCREEN_WIDTH-wLoginButtonWidth)/2.0, self.warningLabel.maxY + wLoginButtonOff, wLoginButtonWidth, wLoginButtonHeight);
        _loginButton.backgroundColor = App_Main_Color;
//        _loginButton.cornerRadius = 5;
//        _loginButton.titleLabel.font = FONT_XT(15);
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _loginButton;
}
- (void)loginBtnClicK:(id)sender
{
    if (self.loginBlock) {
        self.loginBlock();
    }
}

- (void)setWarningTitle:(NSString *)warningTitle
{
    self.warningLabel.text = warningTitle;
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    if (!_loginBlock) return;
    [_loginButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end

