//
//  NavigationItemButton.m
//  HuaQi
//
//  Created by 黄建芳 on 8/8/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import "NavigationItemButton.h"

@implementation NavigationItemButton

+ (instancetype)returnButton
{
    NavigationItemButton *returnButton = [[NavigationItemButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    returnButton.imageEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 0);
    returnButton.imageView.contentMode = UIViewContentModeLeft;
    [returnButton setImage:[UIImage imageNamed:@"NewNav_back_white.png"] forState:UIControlStateNormal];
    return returnButton;
}

+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title
{
    CGFloat buttonHeight = 28.0;
    NavigationItemButton *button = [NavigationItemButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, buttonHeight)];
    button.frame = CGRectMake(0, 0, size.width + 10, buttonHeight);
    return button;
}

+ (instancetype)textMainColorStyleButtonWithTitle:(NSString *)title
{
    NavigationItemButton *button = [self defaultStyleButtonWithTitle:title];
    [button setTitleColor:App_Main_Color forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

+ (instancetype)navigationItemButtonWithImage:(UIImage *)image imageSize:(CGSize)size
{
    NavigationItemButton *button = [NavigationItemButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[image imageWithMinimumSize:size] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    return button;
}

@end
