//
//  GoodsListTableViewCell.m
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "GoodsListTableViewCell.h"

@implementation GoodsListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.goodsImgVi = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 66, 66)];
        self.goodsImgVi.backgroundColor = [UIColor clearColor];
        [self addSubview:self.goodsImgVi];
        
        self.nameLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImgVi.frame) + 5, 15, 160, 20)];
        self.nameLab.textColor=BLACK_COLOR;
        self.nameLab.font=LMJ_CT 16];
        self.nameLab.text=@"";
        [self addSubview:self.nameLab];
        
        self.priceLab=[[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-80-10, 15, 80, 20)];
        self.priceLab.textColor=Red_Color;
        self.priceLab.font=LMJ_XT 13];
        self.priceLab.text=@"";
        self.priceLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.priceLab];
        
        self.ggLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImgVi.frame) + 5, CGRectGetMaxY(self.nameLab.frame), 160, 60)];
        self.ggLab.numberOfLines = 3;
        self.ggLab.textColor=LINE_DEEP_COLOR;
        self.ggLab.font=LMJ_XT 14];
        self.ggLab.text=@"";
        _ggLab.font = [UIFont systemFontOfSize:12];

        [self addSubview:self.ggLab];
        
        self.numLab=[[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-80-10, 50, 80, 20)];
        self.numLab.textColor=BLACK_COLOR;
        self.numLab.font=LMJ_XT 13];
        self.numLab.textAlignment = NSTextAlignmentRight;
        self.numLab.text=@"X1";
        [self addSubview:self.numLab];
        
        UIView* line2 = [[UIView alloc]initWithFrame:CGRectMake(15, 85, UI_SCREEN_WIDTH-30, 1)];
        line2.backgroundColor = LINE_SHALLOW_COLOR;
        [self addSubview:line2];
    }
    return self;
}
- (void)updateDic:(NSDictionary *)dic is_point_type:(NSString *)is_point_type
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_img"]]];
    [self.goodsImgVi af_setImageWithURL:url];
    
    
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.f", [[dic objectForKey:@"goods_price"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@", [dic objectForKey:@"goods_price"]];
    }
    CGSize sizeForPriceLab = [self.priceLab sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    self.priceLab.frame = CGRectMake(UI_SCREEN_WIDTH - sizeForPriceLab.width - 10, 15, sizeForPriceLab.width, 20);
    
    self.nameLab.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_name"]];
    CGRect frameForNameLab = self.nameLab.frame;
    frameForNameLab.size = CGSizeMake(CGRectGetMinX(self.priceLab.frame) - self.nameLab.frame.origin.x - 20, 20);
    self.nameLab.frame = frameForNameLab;
    
    self.numLab.text = [NSString stringWithFormat:@"X%@", [dic objectForKey:@"goods_num"]];

    self.ggLab.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_attr"]];
    CGSize size = [self.ggLab sizeThatFits:CGSizeMake(self.nameLab.frame.size.width, 60)];
    CGRect frameForGgLab = self.ggLab.frame;
    frameForGgLab.size = size;
    self.ggLab.frame = frameForGgLab;
    if (CGRectGetMaxY(self.ggLab.frame) <= CGRectGetMaxY(self.goodsImgVi.frame))
    {
        CGRect frameOffsetY = self.ggLab.frame;
        frameOffsetY.origin.y = CGRectGetMaxY(self.goodsImgVi.frame) - self.ggLab.frame.size.height;
        self.ggLab.frame = frameOffsetY;
    }
}

- (void)updateDic1:(NSDictionary *)dic is_point_type:(NSString *)is_point_type
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_img"]]];
    [self.goodsImgVi af_setImageWithURL:url];
    
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.f", [[dic objectForKey:@"goods_price"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@", [dic objectForKey:@"goods_price"]];
    }
    
    CGSize sizeForPriceLab = [self.priceLab sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    self.priceLab.frame = CGRectMake(UI_SCREEN_WIDTH - sizeForPriceLab.width - 10, 15, sizeForPriceLab.width, 20);
    
    if ([[dic allKeys]containsObject:@"goods_name"]) {
        self.nameLab.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_name"]];
        CGRect frameForNameLab = self.nameLab.frame;
        frameForNameLab.size = CGSizeMake(CGRectGetMinX(self.priceLab.frame) - self.nameLab.frame.origin.x - 20, 20);
        self.nameLab.frame = frameForNameLab;
    }
    
    self.numLab.text = [NSString stringWithFormat:@"X%@", [dic objectForKey:@"goods_number"]];
    self.ggLab.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_attr_str"]];
    NSArray *attrArr=[dic objectForKey:@"goods_attr_str"];
    if ([attrArr isKindOfClass:[NSArray class]]) {
        NSString *temp=[attrArr componentsJoinedByString:@" "];
        self.ggLab.text=temp;
        CGSize size = [self.ggLab sizeThatFits:CGSizeMake(self.nameLab.frame.size.width, 60)];
        CGRect frameForGgLab = self.ggLab.frame;
        frameForGgLab.size = size;
        self.ggLab.frame = frameForGgLab;
    }
    
    if (CGRectGetMaxY(self.ggLab.frame) <= CGRectGetMaxY(self.goodsImgVi.frame))
    {
        CGRect frameOffsetY = self.ggLab.frame;
        frameOffsetY.origin.y = CGRectGetMaxY(self.goodsImgVi.frame) - self.ggLab.frame.size.height;
        self.ggLab.frame = frameOffsetY;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
