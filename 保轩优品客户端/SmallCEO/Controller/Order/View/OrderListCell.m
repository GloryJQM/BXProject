//
//  OrderListCell.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderListCell.h"
@interface OrderListCell(){
    UIScrollView *_scrollView;
    UILabel *status;
    UILabel *ghsLabel;
    UILabel *label1;
    
    UIView *backView;

}
@end
@implementation OrderListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationView];
    }
    return self;
}

- (void)creationView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 11, UI_SCREEN_WIDTH - 15 - 90, 100)];
    _scrollView.userInteractionEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:_scrollView];
    [self.contentView addGestureRecognizer:_scrollView.panGestureRecognizer];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, _scrollView.maxY + 22, 40, 20)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:10];
    label1.text = @"供应商";
    label1.textColor = App_Main_Color;
    label1.layer.borderColor = App_Main_Color.CGColor;
    label1.layer.borderWidth = 0.5;
    [self.contentView addSubview:label1];
    
    ghsLabel = [[UILabel alloc] initWithFrame:CGRectMake(label1.maxX + 10, label1.minY, UI_SCREEN_WIDTH - label1.maxX - 40, 20)];
    ghsLabel.textAlignment = NSTextAlignmentLeft;
    ghsLabel.font = [UIFont systemFontOfSize:14];
    ghsLabel.textColor = Color74828B;
    [self.contentView addSubview:ghsLabel];
    
    status = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    status.textAlignment = NSTextAlignmentRight;
    status.font = [UIFont systemFontOfSize:14];
    status.textColor = App_Main_Color;
    [self.contentView addSubview:status];
    
    [self.contentView addLineWithY:_scrollView.maxY + 10.5 X:15 width:UI_SCREEN_WIDTH - 30];
}

- (void)setDictionary:(NSDictionary *)model is_point_type:(NSInteger)is_point_type{
    if (![model isKindOfClass:[NSDictionary class]] || model == nil) {
        return;
    }
    NSArray *array = model[@"list"];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [backView removeFromSuperview];
    if (array.count == 1) {
        _scrollView.frame = CGRectMake(0, 6, UI_SCREEN_WIDTH, 100);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 100, 100)];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - 20, 20)];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = Color3D4E56;
        [_scrollView addSubview:priceLabel];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, imageView.minX, 0, 0)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = Color161616;
        nameLabel.numberOfLines = 0;
        [_scrollView addSubview:nameLabel];
        
        UILabel *standard = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, nameLabel.maxY + 5, 150, 20)];
        standard.textAlignment = NSTextAlignmentLeft;
        standard.font = [UIFont systemFontOfSize:12];
        standard.textColor = ColorB0B8BA;
        [_scrollView addSubview:standard];
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 45, 45, 30, 20)];
        number.textAlignment = NSTextAlignmentRight;
        number.font = [UIFont systemFontOfSize:12];
        number.textColor = ColorB0B8BA;
        [_scrollView addSubview:number];
        
        NSDictionary *dic = [array firstObject];
        
        number.text = [NSString stringWithFormat:@"X%@", dic[@"goods_number"]];
        standard.text = [NSString stringWithFormat:@"%@", dic[@"goods_attr_str"]];
        nameLabel.text = [NSString stringWithFormat:@"%@", dic[@"goods_name"]];
        
        NSString *goods_price = [NSString stringWithFormat:@"%@", dic[@"goods_price"]];
        priceLabel.text = [goods_price moneyPoint:is_point_type];
        CGSize priceSize = [priceLabel sizeThatFits:CGSizeMake(999, 20)];
        priceLabel.frame = CGRectMake(UI_SCREEN_WIDTH - priceSize.width - 15, imageView.minX, priceSize.width, 20);
        
        CGSize nameSize = [nameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, 100)];
        nameLabel.frame = CGRectMake(imageView.maxX + 10, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, nameSize.height);
        
        standard.frame = CGRectMake(imageView.maxX + 10, nameLabel.maxY + 5, 150, 20);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dic[@"goods_img"]]]];
    }else {
        _scrollView.frame = CGRectMake(15, 6, UI_SCREEN_WIDTH - 15 - 90, 100);
        
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *(100 + 15), 0, 100, 100)];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dic[@"goods_img"]]]];
            
            if (i == array.count - 1) {
                _scrollView.contentSize = CGSizeMake(imageView.maxX + 15, 100);
            }
        }
        backView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 90, 0, 90, 116)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 48, 82, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = Color74828B;
        label.text = [NSString stringWithFormat:@"共%@件商品", model[@"supplier_goods_num"]];
        [backView addSubview:label];
    }
    
    ghsLabel.text = [NSString stringWithFormat:@"%@", model[@"supplier_name"]];
    CGSize ghsSize = [ghsLabel sizeThatFits:CGSizeMake(100, 20)];
    ghsLabel.frame = CGRectMake(label1.maxX + 10, label1.minY, ghsSize.width, 20);
}
@end
