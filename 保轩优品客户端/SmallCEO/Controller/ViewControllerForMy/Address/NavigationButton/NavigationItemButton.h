//
//  NavigationItemButton.h
//  HuaQi
//
//  Created by 黄建芳 on 8/8/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationItemButton : UIButton

+ (instancetype)returnButton;
+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title;
+ (instancetype)textMainColorStyleButtonWithTitle:(NSString *)title;
+ (instancetype)navigationItemButtonWithImage:(UIImage *)image imageSize:(CGSize)size;

@end
