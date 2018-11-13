//
//  ShopTopNewReuView.m
//  WanHao
//
//  Created by Cai on 14-6-12.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ShopTopNewReuView.h"

@implementation ShopTopNewReuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        [self drawLine];
    
        _backimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70.0)];
        _backimg.backgroundColor = [UIColor clearColor];
        [self addSubview:_backimg];
        
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0+50.0, 95.0+10.0, 95.0+10.0)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(4.0, 4.0, 87.0+10.0, 87.0+10.0)];
        _imageV.backgroundColor = [UIColor whiteColor];
        [view addSubview:_imageV];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(113.0+5.0, 9.0+60.0, 365.0/2.0, 35.0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_titleLabel];
        
        //星星
        _ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointZero emptyColor:[UIColor colorFromHexCode:@"#ff6600"] solidColor:[UIColor colorFromHexCode:@"#ff6600"] andMaxRating:5];
        _ratingControl.center = CGPointMake(294.0/2.0+5.0+50.0-45.0, 50.0+60.0);
        _ratingControl.userInteractionEnabled = NO;
        [self addSubview:_ratingControl];
        
        NSArray *titileArray = @[@"商品数:",@"所在地:"];
        
        for (int i =0; i<2; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(113.0+5.0, 124.0/2.0 + i*20.0+60.0, 50.0, 17.0)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
            label.text = [titileArray objectAtIndex:i];
            label.font = [UIFont systemFontOfSize:14.0];
            [self addSubview:label];
            
        }
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(322.0/2.0+5.0, 124.0/2.0+60.0, 100.0, 17.0)];
        _numberLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview: _numberLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(322.0/2.0+5.0, 124.0/2.0+20.0+60.0, 100.0, 17.0)];
        _addressLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview: _addressLabel];
        
        
    }
    return self;
}

-(void)drawLine{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 170, UI_SCREEN_WIDTH, 2)];
    [self addSubview:imageView1];
    
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [[UIColor lightGrayColor] CGColor]);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 4.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, UI_SCREEN_WIDTH-4, 0.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
}

//-(void)drawRect:(CGRect)rect{
//    
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1.0f);
//    CGContextSetLineDash(context, 0, (CGFloat[]){10, 5}, 2);//绘制10个跳过5个
//    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
//    CGContextMoveToPoint(context,4.0,170.0);
//    CGContextAddLineToPoint(context,self.frame.size.width - 4.0, 170.0);
//    CGContextStrokePath(context);
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
