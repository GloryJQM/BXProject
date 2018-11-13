//
//  ShoppingCartCell.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/13.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ShoppingCartCell.h"
@interface ShoppingCartCell(){
    UIImageView *imageView;
    UILabel *priceLabel;
    UILabel *nameLabel;
    UILabel *standard;
    UILabel *number;
}
@end
@implementation ShoppingCartCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationView];
    }
    return self;
}

- (void)creationView {
    self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 122)];
    [_selectButton setImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"chartCheckbox@2x"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectButton];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_selectButton.maxX, 11, 100, 100)];
    [self.contentView addSubview:imageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 8.3, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - 20, 0)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = Color161616;
    nameLabel.numberOfLines = 0;
    [self.contentView addSubview:nameLabel];
    
    standard = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, nameLabel.maxY + 5, 150, 20)];
    standard.textAlignment = NSTextAlignmentLeft;
    standard.font = [UIFont systemFontOfSize:12];
    standard.textColor = ColorB0B8BA;
    [self.contentView addSubview:standard];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 40, standard.minY, 36, 24)];
    [_button setImage:[UIImage imageNamed:@"ArrowIcon@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 8.3, imageView.maxY - 20, UI_SCREEN_WIDTH - imageView.maxX - 50, 20)];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = Color3D4E56;
    [self.contentView addSubview:priceLabel];
    
    
    number = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 50, priceLabel.minY, 32, 20)];
    number.textAlignment = NSTextAlignmentRight;
    number.font = [UIFont systemFontOfSize:12];
    number.textColor = Color3D4E56;
    [self.contentView addSubview:number];
    
    [self.contentView addLineWithY:121.5 X:15 width:UI_SCREEN_WIDTH - 30];
}

- (void)addTheValue:(ShopCartModel *)shopCartModel is_point_type:(NSInteger)is_point_type isShow:(BOOL)isShow {
    [imageView sd_setImageWithURL:[NSURL URLWithString:shopCartModel.imageName]];
    nameLabel.text = shopCartModel.goodsTitle;
    standard.text = shopCartModel.goodsType;
    priceLabel.text = [shopCartModel.goodsPrice moneyPoint:is_point_type];
    number.text = [NSString stringWithFormat:@"x%@", shopCartModel.goodsNum];
    
    CGSize nameSize = [nameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - imageView.maxX - 20, 100)];
    nameLabel.frame = CGRectMake(imageView.maxX + 8.3, imageView.minY, UI_SCREEN_WIDTH -  20 - imageView.maxX, nameSize.height);
    
    CGSize standardSize = [standard sizeThatFits:CGSizeMake(200, 20)];
    standard.frame = CGRectMake(nameLabel.minX, nameLabel.maxY + 7.2, standardSize.width, 20);

    _button.frame = CGRectMake(UI_SCREEN_WIDTH - 40, standard.minY, 36, 24);
    _selectButton.selected = shopCartModel.selectState;
    
    self.button.hidden = !isShow;
}

@end
