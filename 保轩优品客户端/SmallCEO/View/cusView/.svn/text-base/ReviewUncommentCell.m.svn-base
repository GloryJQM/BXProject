//
//  ReviewUncommentCell.m
//  WanHao
//
//  Created by Lai on 14-4-21.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ReviewUncommentCell.h"

@implementation ReviewUncommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftImagV = [[UIImageView alloc] init];
        _leftImagV.backgroundColor = [UIColor clearColor];
        //  _leftImagV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_leftImagV];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_titleLabel];
        
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor colorFromHexCode:@"#FF7F66"];
        _priceLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_priceLabel];
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _countLabel.layer.cornerRadius=3.0;
        _countLabel.textColor = [UIColor colorFromHexCode:@"#FF7F66"];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_countLabel];
        
        _btn = [[UIButton alloc] init];
        _btn.layer.cornerRadius = 3.0;
        _btn.backgroundColor = App_Main_Color;
        [_btn setTitle:@"评价" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        
    }
    
    return self;
    
}

-(void)btnDown:(UIButton *)btn{
    //NSLog(@"btnDown:%@",_idArray);
    [_delegate UncommentBtnIndex:_cellTableView atIndexPath:_indexPath];
}

-(void)layoutSubviews{
    
    _leftImagV.frame = CGRectMake(8, 8, 50, 50);// CGPointMake(50, self.frame.size.height / 2.0);
    _titleLabel.frame = CGRectMake(60*adapterFactor, 8, 200*adapterFactor, 20);
    _priceLabel.frame = CGRectMake(60*adapterFactor, 30, 100, 20);
    _countLabel.frame = CGRectMake(200*adapterFactor, 30, 20, 20);
    _btn.frame=CGRectMake(260*adapterFactor, 18, 50, 30);
}

-(void)setViewDit:(id)viewDit{
    
    NSLog(@"icon_urlimage%@",[viewDit objectForKey:@"picurl"]);
    [_leftImagV af_setImageWithURL:[NSURL URLWithString:[viewDit objectForKey:@"picurl"]]];
    _titleLabel.text = [viewDit objectForKey:@"subject"];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",[viewDit objectForKey:@"single_price"] ];
    _countLabel.text = [NSString stringWithFormat:@"%@",[viewDit objectForKey:@"goods_number"] ];
}


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
