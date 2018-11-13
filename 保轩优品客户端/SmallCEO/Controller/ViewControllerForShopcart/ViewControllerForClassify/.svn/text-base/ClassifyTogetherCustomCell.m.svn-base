//
//  ClassifyCustomCell.m
//  WanHao
//
//  Created by wuxiaohui on 14-2-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ClassifyTogetherCustomCell.h"

#define ClassifyCell_Width      (UI_SCREEN_WIDTH-5.0*5.0)/4.0
#define ClassifyCell_Height     30
#define ClassifyCell_between    5.0
#define ClassifyCell_X          5.0
#define ClassifyCell_Y          5.0+5.0

@implementation ClassifyTogetherCustomCell
-(void)dealloc{
    [_btnArray removeAllObjects];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnArray = [[NSMutableArray alloc] init];
        _reuseIdentifier = reuseIdentifier;
        if ([reuseIdentifier isEqualToString:@"addCell"]) {
            //聚合分类随意显示
            _image = NO;
            return self;
        }
        _leftImagV = [[UIImageView alloc] init];
        _leftImagV.backgroundColor = [UIColor clearColor];
        //  _leftImagV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_leftImagV];
        _leftImagV.contentMode = UIViewContentModeScaleAspectFit;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_titleLabel];
        
        
        _subTLabel = [[UILabel alloc] init];
        _subTLabel.backgroundColor = [UIColor clearColor];
        _subTLabel.textColor = [UIColor colorWithWhite:0.4  alpha:1.0];
        _subTLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_subTLabel];
       
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([_reuseIdentifier isEqualToString:@"addCell"]) {
        
    }else{
        //聚合分类同显示
       /* _leftImagV.frame = CGRectMake(8, 8, 44, 44);// CGPointMake(50, self.frame.size.height / 2.0);
        _titleLabel.frame = CGRectMake(60, 5, 200, 20);
        _subTLabel.frame = CGRectMake(60, 30, 250, 20);*/
    }
    // _rightImageV.center = CGPointMake(self.frame.size.width - 30.0,self.frame.size.height / 2.0);
    
    
}


-(void)setViewDit:(id)viewDit{
    //  _leftImagV.image = [viewDit objectForKey:@"image"];
    CGFloat origin_x = ClassifyCell_X;
    CGFloat origin_y = ClassifyCell_Y;
    if ([_reuseIdentifier isEqualToString:@"addCell"]) {
        for (int i =0; i<_btnArray.count; i++) {
            [((UIButton *)[_btnArray objectAtIndex:i]) removeFromSuperview];
        }
        _idArray = viewDit;
        
        
        for (int i =0; i<[viewDit count]; i++) {
            NSString *cat_name = [[viewDit objectAtIndex:i] objectForKey:@"cat_name"];
            float lenght = cat_name.length *16.0;
            if (origin_x + lenght > UI_SCREEN_WIDTH) {
                origin_x = ClassifyCell_X;
                origin_y += ClassifyCell_Height+ClassifyCell_between;
            }
            if (lenght < ClassifyCell_Width) {
                lenght = ClassifyCell_Width;
            }
            UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            classBtn.frame = CGRectMake(origin_x, origin_y, lenght, ClassifyCell_Height);
            [classBtn setTitle:[[viewDit objectAtIndex:i] objectForKey:@"cat_name"] forState:UIControlStateNormal];
            [classBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1.0] forState:UIControlStateNormal];
            classBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            classBtn.tag = i;
            [classBtn.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            //            classBtn.layer.borderColor = [UIColor colorFromHexCode:@"#78c430"].CGColor;
            //            classBtn.layer.borderWidth = 0.5;
            [classBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
            classBtn.backgroundColor = [UIColor clearColor];
            [self addSubview:classBtn];
            
            if (i == [viewDit count]-1) {
                if (origin_y == ClassifyCell_X) {
                    origin_y += ClassifyCell_Height+ClassifyCell_between;
                }
            }
            
            origin_x += lenght+ClassifyCell_between;

            [_btnArray addObject:classBtn];
        }
    }else{
        _titleLabel.text = [viewDit objectForKey:@"cat_name"];
        
        //聚合分类随意显示
        if ([[viewDit objectForKey:@"child"] isKindOfClass:[NSArray class]])
        {
            _image = YES;
        }else{
            _image = YES;
        }
        if (_image == NO) {
            _leftImagV.frame = CGRectMake(8, 8, 44, 44);
            _titleLabel.frame = CGRectMake(60-44, 5, 200, 20);
            _subTLabel.frame = CGRectMake(60-44, 30, UI_SCREEN_WIDTH-70, 20);
        }if (_image == YES) {
            //判断图片是需要加载上
            NSString *url = [NSString stringWithFormat:@"%@",[viewDit objectForKey:@"icon_url"]];
            [_leftImagV sd_setImageWithURL:[NSURL URLWithString:url]];
            _leftImagV.frame = CGRectMake(8, 8, 44, 44);
            _titleLabel.frame = CGRectMake(60, 5, 200, 20);
            _subTLabel.frame = CGRectMake(60, 30, UI_SCREEN_WIDTH-70, 20);
            
        }
        
        //聚合二级图片判断故隐去
        // [_leftImagV af_setImageWithURL:[NSURL URLWithString:[viewDit objectForKey:@"icon_url"]]];
        
        NSString *subtitle = @"";
        //        for (int i = 0; i<[[viewDit objectForKey:@"child"] count]; i++) {
        //            subtitle = [NSString stringWithFormat:@"%@/%@",subtitle,[[[viewDit objectForKey:@"child"] objectAtIndex:i] objectForKey:@"cat_name"]];
        //
        //        }
        //2014-03-24 聚合分类 逻辑添加
        //原先的child从数组改成string
        //        if ([subtitle length] > 0){
        //            _subTLabel.text = [subtitle substringFromIndex:1];//[viewDit objectForKey:@"subTitle"];
        //        }else{
        //            _subTLabel.text = [NSString stringWithFormat:@"%@" ,[viewDit objectForKey:@"child"]];
        //        }
        //    }
        if ([[viewDit objectForKey:@"child"] isKindOfClass:[NSArray class]]) {
            for (int i = 0; i<[[viewDit objectForKey:@"child"] count]; i++) {
                subtitle = [NSString stringWithFormat:@"%@/%@",subtitle,[[[viewDit objectForKey:@"child"] objectAtIndex:i] objectForKey:@"cat_name"]];
                
            }
        }
        if ([subtitle length] > 0){
            _subTLabel.text = [subtitle substringFromIndex:1];//[viewDit objectForKey:@"subTitle"];
        }else{
            if ([[viewDit objectForKey:@"child"] isKindOfClass:[NSString class]]) {
                _subTLabel.text = [NSString stringWithFormat:@"%@" ,[viewDit objectForKey:@"child"]];
            }else{
                _subTLabel.text = @"";
            }
            
        }
    }
}

-(void)btnDown:(UIButton *)btn{
    //聚合二级修改时delegate修改
//    [_delegate claddifyChoseBtnIndex:btn.tag withTabeleView:_cellTableView atIndexPath:_indexPath withID:[[[_idArray objectAtIndex:btn.tag] objectForKey:@"cid"] intValue] withName:[[_idArray objectAtIndex:btn.tag] objectForKey:@"cat_name"]];
    [_delegate claddifyTogetherBtnIndex:btn.tag withTabeleView:_cellTableView atIndexPath:_indexPath withID:[[[_idArray objectAtIndex:btn.tag] objectForKey:@"cid"] intValue] withName:[[_idArray objectAtIndex:btn.tag] objectForKey:@"cat_name"] itemdic:[_idArray objectAtIndex:btn.tag]];
}

-(CGFloat)widthbtn:(NSString *)str{
    CGSize descSize = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 30) lineBreakMode:NSLineBreakByWordWrapping];
    return descSize.width ;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    if ([_reuseIdentifier isEqualToString:@"addCell"]) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextSetLineWidth(context, 1.0);
//        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
         CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:155/255.0 green:212/255.0 blue:161/255.0 alpha:1].CGColor);
        CGContextSetFillColorWithColor(context, [[UIColor colorFromHexCode:@"#EBEDF3"]CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 1, 5);
        CGContextAddLineToPoint(context,100, 5);
        CGContextAddLineToPoint(context,105, 0);
        CGContextAddLineToPoint(context,110, 5);
        CGContextAddLineToPoint(context,self.frame.size.width-1, 5);
        CGContextAddLineToPoint(context,self.frame.size.width-1, self.frame.size.height - 1.0);
        CGContextAddLineToPoint(context,1, self.frame.size.height - 1.0);
        CGContextAddLineToPoint(context,1, 5);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
        
    }else{
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetRGBStrokeColor(context,0.88, 0.88, 0.88, 1.0);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 59);
        CGContextAddLineToPoint(context,self.frame.size.width, 59);
        CGContextStrokePath(context);
    }
    
}

@end
