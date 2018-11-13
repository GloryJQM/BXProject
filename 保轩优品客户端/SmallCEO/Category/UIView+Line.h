//
//  UIView+Line.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)
//根据y值创建一个水平的线 线的宽度为self的宽度
- (UIView *)addLineWithY:(CGFloat)y;

- (UIView *)addLineWithY:(CGFloat)y X:(CGFloat)x width:(CGFloat)width;
@end
