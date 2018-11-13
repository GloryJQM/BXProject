//
//  appCustomCell.m
//  WanHao
//
//  Created by wuxiaohui on 14-1-10.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "appCustomCell.h"

@implementation appCustomCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _circyView = [[CircyView alloc]init];
        _circyView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_circyView];
        
        _imageV = [[UIImageView alloc]init];
        // _imageV.contentMode = UIViewContentModeCenter;
        _imageV.backgroundColor = [UIColor clearColor];
        _imageV.layer.cornerRadius = 3.0;
        [_circyView addSubview:_imageV];
        
        
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = [UIFont systemFontOfSize:20.0];
        _titlelabel.backgroundColor = [UIColor clearColor];
        _titlelabel.textColor = [UIColor colorFromHexCode:@"#28384B"];
        [self.contentView addSubview:_titlelabel];
        
        
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.font = [UIFont systemFontOfSize:16.0];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.textColor = [UIColor colorFromHexCode:@"#28384B"];
        [self.contentView addSubview:_subtitleLabel];
        
        _nextImgV = [[UIImageView alloc]init];
        _nextImgV.contentMode = UIViewContentModeCenter;
        _nextImgV.backgroundColor = [UIColor clearColor];
        _nextImgV.image = [UIImage imageNamed:@"imgae_tab_next.png"];
        [self.contentView addSubview:_nextImgV];
        
        self.backgroundColor = [UIColor redColor];
        // Initialization code

    }
    return self;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
     _circyView.frame = CGRectMake(0, 5, 145.0/2.0, 145.0/2.0);
    _imageV.frame = CGRectMake(10, 10,55,55);
    _titlelabel.frame = CGRectMake(196.0/2.0,10, 370.0/2.0, 25.0);
    _subtitleLabel.frame = CGRectMake(196.0/2.0,40,370.0/2.0, 20.0);
    _nextImgV.frame = CGRectMake(self.frame.size.width-30, 25,30, 30);
    
    NSLog(@"~~~~frame width %f,height %f",self.frame.size.width,self.frame.size.height);
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context,3, lengths,2);
    CGContextSetRGBStrokeColor(context,0.88, 0.88, 0.88, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 10, 79);
    CGContextAddLineToPoint(context,self.frame.size.width-20, 79);
    CGContextStrokePath(context);
    
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    CGContextSetLineWidth(context, 1.0);
//    float lengths[] = {5,5};
//    CGContextSetLineDash(context,3, lengths,2);
//    CGContextSetStrokeColorWithColor(context, [UIColor silverColor].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor colorFromHexCode:@"eff1f5"].CGColor);
//    CGContextSetLineDash(context, 3, lengths, 2);
//    CGContextAddRect(context, CGRectMake(10, 78, rect.size.width -20, 1.0));
//    //   CGContextAddLineToPoint(context,20.0, 33.0);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    

}



@end
