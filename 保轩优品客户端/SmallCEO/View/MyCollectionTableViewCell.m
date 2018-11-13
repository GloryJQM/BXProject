//
//  MyCollectionTableViewCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyCollectionTableViewCell.h"

@implementation MyCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];

        UIView * backCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, UI_SCREEN_WIDTH, 207/2)];
        backCellView.backgroundColor = WHITE_COLOR;
        [self addSubview:backCellView];
        
        self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, 78, 72.5)];
        [backCellView addSubview:_goodsImageView];
        
        self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+19, 11.5 , backCellView.frame.size.width - 15-(CGRectGetMaxX(self.goodsImageView.frame)+19), 40)];
        _goodsTitleLabel.numberOfLines = 0;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:14];
        _goodsTitleLabel.textColor = [UIColor colorFromHexCode:@"434343"];
        [backCellView addSubview:_goodsTitleLabel];
        
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+19, 137/2 , backCellView.frame.size.width -17-78-(CGRectGetMaxX(self.goodsImageView.frame)+19), 30)];
        _priceLabel.numberOfLines = 0;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = App_Main_Color;
        [backCellView addSubview:_priceLabel];
        
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(UI_SCREEN_WIDTH-77, backCellView.frame.size.height - 40, 65, 30);
        [_cancelButton setTitle:@"删除" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = LMJ_XT 15];
        _cancelButton.backgroundColor = [UIColor colorWithRed:232/255.0 green:91/255.0 blue:83/255.0 alpha:1];
        _cancelButton.layer.cornerRadius = 3;
        _cancelButton.layer.masksToBounds = YES;
        [backCellView addSubview:_cancelButton];
        [_cancelButton addTarget:self action:@selector(cancelGoods:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;

}

- (void)updateCellData:(NSDictionary *)dic
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"img"]]];
    
    [self.goodsImageView sd_setImageWithURL:url];
    
    NSString *is_point = [NSString stringWithFormat:@"%@", dic[@"is_point_type"]];
    NSString *price = [NSString stringWithFormat:@"%@", dic[@"price"]];
    self.priceLabel.text = [price moneyPoint:[is_point integerValue]];
    self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_name"]];
    
}

- (void)cancelGoods:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(cancelCollectionGoods:)]) {
        [_delegate cancelCollectionGoods:sender];
    }
}


@end
