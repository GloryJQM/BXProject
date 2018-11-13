//
//  CircyView.m
//  WanHao
//
//  Created by wuxiaohui on 14-1-13.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "CircyView.h"

@implementation CircyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorFromHexCode:@"#EBF0F1"] CGColor]));
    CGContextFillPath(ctx);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
