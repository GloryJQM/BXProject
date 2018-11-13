//
//  UIButton+Custom.m
//  DeKang
//
//  Created by quanmai on 16/3/9.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton(Custom)

+(UIButton *)submitButtonWithFrameOriginY:(CGFloat)y titleString:(NSString *)titleString{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, y, UI_SCREEN_WIDTH - 40, 44)];
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor colorFromHexCode:@"eb6100"];
    [button setTitle:titleString forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+(UIButton *)buttonWithNavRightTitle:(NSString * )title{
    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 44)];
    navRightButton .backgroundColor = [UIColor clearColor];
    navRightButton.adjustsImageWhenHighlighted = NO;
    navRightButton.layer.cornerRadius = 0;
    navRightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [navRightButton setTitle:title forState:UIControlStateNormal];
    [navRightButton setTitleColor:[UIColor colorFromHexCode:@"8b8b8b"] forState:UIControlStateNormal];
    return navRightButton;
}

+(UIButton *)buttonWithNavRightImage:(UIImage * )image{
    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 44)];
    navRightButton .backgroundColor = [UIColor clearColor];
    navRightButton.adjustsImageWhenHighlighted = NO;
    navRightButton.layer.cornerRadius = 0;
    navRightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [navRightButton setImage:image forState:UIControlStateNormal];
    return navRightButton;
}


+(UIButton *)buttonWithImageString:(NSString *)imageString{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button .backgroundColor = [UIColor clearColor];
    button.adjustsImageWhenHighlighted = NO;
    button.layer.cornerRadius = 0;
    [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateSelected];
    return button;
}


/**包含选中状态按钮*/
+(UIButton *)buttonWithNormalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button .backgroundColor = [UIColor clearColor];
    button.adjustsImageWhenHighlighted = NO;
    button.layer.cornerRadius = 0;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    return button;
}

@end
