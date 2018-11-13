//
//  CircyView.m
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "CircysView.h"

@implementation CircysView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setSelect:(BOOL)select{
    
    _select = select;
    [self setNeedsDisplay];
    
}

-(void)setNumberText:(NSString *)numberText{
    _numberText = [numberText copy];
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    if (_select) {
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorFromHexCode:@"#00C0F0"] CGColor]));
    }else{
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorFromHexCode:@"#6C6C6C"] CGColor]));
    }
    CGContextFillPath(ctx);

    UIColor *magentaColor = [UIColor whiteColor];
    [magentaColor set];
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    NSString *myString = _numberText;
    [myString drawAtPoint:CGPointMake(7, 0) withFont:helveticaBold];

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
