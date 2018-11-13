//
//  StoreListCell.m
//  WanHao
//
//  Created by chensanli on 15/3/20.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "StoreListCell.h"

@implementation StoreListCell
@synthesize _imageV1,_imageV2,_titleLabel1,_titleLabel2,bgView1,bgView2,delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:(NSString *)reuseIdentifier];
    if (self) {
        
        
        float width=(UI_SCREEN_WIDTH-30)/2.0;
        
        float height=width+20+5;
        
        bgView1=[[UIView alloc] initWithFrame:CGRectMake(10, 0, width, height)];
        bgView1.backgroundColor=[UIColor clearColor];
        bgView1.layer.borderWidth=0.5;
        bgView1.layer.borderColor=myRGBA(220, 220, 220, 1).CGColor;
        [self.contentView addSubview:bgView1];
        
        
        
        _imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width-20, width-20)];
        _imageV1.backgroundColor = [UIColor clearColor];
        [bgView1 addSubview:_imageV1];
        
        
        _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageV1.frame)+5, width-20, 20)];
        _titleLabel1.backgroundColor = [UIColor clearColor];
        _titleLabel1.textAlignment=NSTextAlignmentCenter;
        _titleLabel1.textColor = [UIColor lightGrayColor];
        _titleLabel1.font = [UIFont systemFontOfSize:19.0];
        [bgView1 addSubview:_titleLabel1];
        
        
        UIButton *tempBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        tempBtn.backgroundColor=[UIColor clearColor];
        [tempBtn addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
        [bgView1 addSubview:tempBtn];
        
        
        bgView2=[[UIView alloc] initWithFrame:CGRectMake(20+width, 0, width, height)];
        bgView2.backgroundColor=[UIColor clearColor];
        bgView2.layer.borderWidth=0.5;
        bgView2.layer.borderColor=myRGBA(220, 220, 220, 1).CGColor;
        [self.contentView addSubview:bgView2];
        
        _imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, width-20, width-20)];
        _imageV2.backgroundColor = [UIColor clearColor];
        [bgView2 addSubview:_imageV2];
        
        
        _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageV1.frame)+5, width-20, 20)];
        _titleLabel2.backgroundColor = [UIColor clearColor];
        _titleLabel2.textAlignment=NSTextAlignmentCenter;
        _titleLabel2.textColor = [UIColor lightGrayColor];
        _titleLabel2.font = [UIFont systemFontOfSize:19.0];
        [bgView2 addSubview:_titleLabel2];
        
        
        UIButton *tempBtn1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        tempBtn1.backgroundColor=[UIColor clearColor];
        [tempBtn1 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
        [bgView2 addSubview:tempBtn1];
        
        // Initialization code
    }
    return self;
}

-(void)btn1{
    int index=bgView1.tag;
    if ([delegate respondsToSelector:@selector(clickIndex:)]) {
        [delegate clickIndex:index];
    }
}


-(void)btn2{
    int index=bgView2.tag;
    if ([delegate respondsToSelector:@selector(clickIndex:)]) {
        [delegate clickIndex:index];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
