//
//  UIView+Line.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)
//根据y值创建一个水平的线 线的宽度为self的宽度
- (UIView *)addLineWithY:(CGFloat)y {
    return   [self addLineWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 0.5)];
}
- (UIView *)addLineWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor colorFromHexCode:@"#E9E9E9"];
    line.tag = 100000;
    [self addSubview:line];
    return line;
}

- (UIView *)addLineWithY:(CGFloat)y X:(CGFloat)x width:(CGFloat)width {
    return [self addLineWithFrame:CGRectMake(x, y, width, 0.5)];
}
@end
