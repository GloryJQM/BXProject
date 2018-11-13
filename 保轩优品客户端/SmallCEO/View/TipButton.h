//
//  TipButton.h
//  HuaQi
//
//  Created by 黄建芳 on 8/4/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipButton : UIButton

+ (instancetype)defaultStyleTipButtonWithTitle:(NSString *)title;
+ (instancetype)cancelableTipButtonWithTitle:(NSString *)title;

+ (CGFloat)cancelableTipButtonWidthWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString *cancelableTipText;

@end
