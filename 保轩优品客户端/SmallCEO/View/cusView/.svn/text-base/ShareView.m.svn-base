//
//  ShareView.m
//  Lemuji
//
//  Created by Cai on 15-8-4.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ShareView.h"

const CGFloat buttonWidthOrHeight = 115.0/2;
const CGFloat intervalWidth = 5.0;

@interface ShareView ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL animation;

@end

@implementation ShareView

-(instancetype)initWithShareButtonNameArray:(NSArray *)nameArray animation:(BOOL)animation
{
    self = [super init];
    if (self)
    {
        self.animation = animation;
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.7]];
        self.window.windowLevel = UIWindowLevelAlert;
        [self.window addSubview:self];
        [self.window makeKeyAndVisible];
        self.window.hidden = YES;
        
        CGFloat intervalBetweenButtons = (UI_SCREEN_WIDTH - 2 * intervalWidth - nameArray.count * buttonWidthOrHeight) / (nameArray.count + 1);
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 130, UI_SCREEN_WIDTH, 130)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        
        for(int i = 1; i <= nameArray.count; i++)
        {
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(intervalWidth + i * (buttonWidthOrHeight + intervalBetweenButtons) - buttonWidthOrHeight, 20, buttonWidthOrHeight, buttonWidthOrHeight)];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-fengxiang%d", i - 1]] forState:UIControlStateNormal];
            
            UILabel* nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, buttonWidthOrHeight, 20)];
            nameLab.center = CGPointMake(btn.center.x, btn.center.y + 50);
            nameLab.text = nameArray[i - 1];
            nameLab.numberOfLines = 2;
            CGSize size = [nameLab sizeThatFits:CGSizeMake(btn.frame.size.width + intervalBetweenButtons, 80)];
            nameLab.frame = CGRectMake(0, nameLab.frame.origin.y, size.width, size.height);
            nameLab.center = CGPointMake(btn.center.x, nameLab.center.y);
            nameLab.textAlignment = NSTextAlignmentCenter;
            
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [backgroundView addSubview:btn];
            [backgroundView addSubview:nameLab];
        }
        [self addSubview:backgroundView];
        self.frame = [UIScreen mainScreen].bounds;
        
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.frame.size.height - 130)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [maskView addGestureRecognizer:tap];
        [self addSubview:maskView];
        self.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    }
    
    return self;
}

- (void)show
{
    self.window.hidden = NO;
    if(self.animation)
    {
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationDuration:0.2];
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.frame.size.height)];
        [UIView commitAnimations];
    }
}

#pragma mark - Button Click Method
- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(shareView:clickButtonAtIndex:)])
    {
        [self.delegate shareView:self clickButtonAtIndex:button.tag - 1];
    }
    
    if(self.animation)
    {
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationDuration:0.5];
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, self.frame.size.height)];
        [UIView commitAnimations];
    }
    self.window.hidden = YES;
}

- (void)tapView:(id)sender
{
    if(self.animation)
    {
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationDuration:0.2];
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, self.frame.size.height)];
        [UIView commitAnimations];
    }
    self.window.hidden = YES;
}


@end
