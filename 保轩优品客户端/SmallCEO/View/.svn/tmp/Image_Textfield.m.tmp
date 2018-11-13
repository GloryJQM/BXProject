//
//  Image_Textfield.m
//  chufake
//
//  Created by wuxiaohui on 13-12-26.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "Image_Textfield.h"


@implementation Image_Textfield

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        
//        self.layer.cornerRadius = UI_SCREEN_HEIGHT/15/2;
//        [self.layer setBorderColor:LAYER_COLOR.CGColor];
//        [self.layer setBorderWidth:1];
        
//        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10+h/4,h/4,h/2, h/2)];
////        _imageV.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
//        _imageV.backgroundColor = [UIColor clearColor];
//        _imageV.contentMode = UIViewContentModeCenter;
//        [self addSubview:_imageV];
        
        
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(10+h/4, 1, w-42-h,  h-2)];
        _textfield.backgroundColor = [UIColor clearColor];
        [self addSubview:_textfield];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_textfield.x, _textfield.maxY, self.width - 30, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        // Initialization code
    }
    
    
    return self;
}


//-(void)drawRect:(CGRect)rect{
//
//    [super drawRect:rect];
//    CGFloat w = self.frame.size.width;
//    CGFloat h = self.frame.size.height;
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor silverColor].CGColor);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context,h/2, 0.0);
//    CGContextAddLineToPoint(context,w-h/2, 0.0);
//    CGContextAddArcToPoint(context, w, h/2, w-h/2, h, h/2);
//    CGContextAddLineToPoint(context,h/2, h);
//    CGContextAddArcToPoint(context, 0.0, h/2, h/2, 0.0, h/2);
//    
//    CGContextStrokePath(context);
//    
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextSetLineCap(context, kCGLineCapSquare);
////    CGContextSetLineWidth(context, 1.0);
////    CGContextSetStrokeColorWithColor(context, [UIColor silverColor].CGColor);
////    CGContextBeginPath(context);
//////    CGContextMoveToPoint(context,0.0, 0.0);
////    CGContextMoveToPoint(context,0.0, 0.0);
////    CGContextAddLineToPoint(context,self.frame.size.width, 0.0);
//////    CGContextAddLineToPoint(context,self.frame.size.width, self.frame.size.height);
////    CGContextAddArcToPoint(context, self.frame.size.width+self.frame.size.height/2, self.frame.size.height/2, self.frame.size.width, self.frame.size.height, self.frame.size.height/2);
////    CGContextAddLineToPoint(context,0.0, self.frame.size.height);
//////    CGContextAddLineToPoint(context,0.0, 0.0);
////    CGContextAddArcToPoint(context, -self.frame.size.height/2, self.frame.size.height/2, 0.0, 0.0, self.frame.size.width/2);
////
////    CGContextStrokePath(context);
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
