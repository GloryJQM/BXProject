//
//  CommentCell.m
//  chufake
//
//  Created by pan on 13-12-6.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

+ (float)calculateCellHeight:(NSString *)str
{
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(260, MAXFLOAT)];
    return size.height + 80;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _reuseIdentifierStr = reuseIdentifier;
        if ([reuseIdentifier isEqualToString:@"firstNetCommnet"]) {
            UILabel* overallLabel = [[UILabel alloc] initWithFrame:CGRectMake(41.0/2.0, 11.0, 80.0/2.0, 25.0)];
            overallLabel.text = @"总评:";
            overallLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            overallLabel.backgroundColor = [UIColor clearColor];
            overallLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:overallLabel];
            
            
            UILabel* chufaLabel = [[UILabel alloc] initWithFrame:CGRectMake(41.0/2.0,46.0, 160.0/2.0, 25.0)];
            chufaLabel.text = @"顾客点评:";
            chufaLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            chufaLabel.backgroundColor = [UIColor clearColor];
            chufaLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:chufaLabel];
            
            _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(200.0/2.0, 46.0, 50.0, 25.0)];
            _numberLabel.text = @"";
            _numberLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            _numberLabel.backgroundColor = [UIColor clearColor];
            _numberLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:_numberLabel];
            
        }else{
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _nameLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = [UIFont systemFontOfSize:14];

            
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _timeLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            _timeLabel.textAlignment = NSTextAlignmentRight;
            _timeLabel.backgroundColor = [UIColor clearColor];
            //_timeLabel.font =[UIFont systemFontOfSize:14];
            _timeLabel.font =[UIFont systemFontOfSize:12];
            
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _contentLabel.textColor = [UIColor colorWithWhite:.3 alpha:1];
            _contentLabel.numberOfLines = 0;
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = [UIFont systemFontOfSize:14];
        
        }
        
   

        _ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointZero emptyColor:[UIColor colorFromHexCode:@"#ff6600"] solidColor:[UIColor colorFromHexCode:@"#ff6600"] andMaxRating:5];
        _ratingControl.userInteractionEnabled = NO;
        [self addSubview:_ratingControl];
        
        [self addSubview:_nameLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_contentLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([_reuseIdentifierStr isEqualToString:@"firstNetCommnet"]){
      _ratingControl.center = CGPointMake(310.0/2.0-50.0,41.0/2.0);
    }else{
    
    /*_nameLabel.frame = CGRectMake(30, 10, 180, 30);
    _timeLabel.frame = CGRectMake(150, 10, 140, 30);*/
        _nameLabel.frame = CGRectMake(30, 10, 140, 30);
        _timeLabel.frame = CGRectMake(170, 10, 126, 30);
    _ratingControl.center = CGPointMake(70, 48);
    
    _contentLabel.frame = CGRectMake(30, 60, 260, 0);
    [_contentLabel sizeToFit];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([_reuseIdentifierStr isEqualToString:@"firstNetCommnet"]){

            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetLineWidth(context, 1.0);
            CGContextSetRGBStrokeColor(context,0.88, 0.88, 0.88, 1.0);
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, 0, 44);
            CGContextAddLineToPoint(context,self.frame.size.width, 44);
            CGContextStrokePath(context);
      
    }else{
        
        
        [super drawRect:rect];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextSetLineWidth(context, 1.0);
        CGFloat lengths[] = {5,5};
        CGContextSetLineDash(context,3, lengths,2);
        CGContextSetStrokeColorWithColor(context, [UIColor silverColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor colorFromHexCode:@"eff1f5"].CGColor);
        CGContextSetLineDash(context, 3, lengths, 2);
        CGContextAddRect(context, CGRectMake(20.0, 10.0, rect.size.width -40, rect.size.height -20));
        //   CGContextAddLineToPoint(context,20.0, 33.0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
        
//        
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 0.15, 0.15, 0.15, .6);
//    CGContextSetFillColorWithColor(context, [UIColor colorFromHexCode:@"eff1f5"].CGColor);
//    CGContextSetLineWidth(context, 1.0);
//    CGFloat dashArray[] = {2,2};
//    CGContextSetLineDash(context, 3, dashArray, 2);
//    CGContextAddRect(context, CGRectMake(20.0, 10.0, rect.size.width -40, rect.size.height -20));
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathStroke);

    }
}

@end
