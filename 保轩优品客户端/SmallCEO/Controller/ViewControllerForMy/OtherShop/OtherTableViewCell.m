//
//  OtherTableViewCell.m
//  SmallCEO
//
//  Created by ni on 17/3/21.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat height = 107 / 667.0 * UI_SCREEN_HEIGHT ;
        CGFloat width = 154 / 375.0 * UI_SCREEN_WIDTH;
        
        _tipImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, width, height)];
        _tipImage.backgroundColor = [UIColor whiteColor];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tipImage.maxX+10, 10, UI_SCREEN_WIDTH-_tipImage.maxX - 20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + 5, UI_SCREEN_WIDTH - _nameLabel.x - 10, 20)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = [UIColor colorFromHexCode:@"#666666"];
        
        _proL = [[UILabel alloc]initWithFrame:CGRectMake(_addressLabel.maxX, _addressLabel.maxY, UI_SCREEN_WIDTH -_addressLabel.maxX-10 , 20)];
        _proL.font = [UIFont systemFontOfSize:12];
        _proL.textColor = [UIColor colorFromHexCode:@"#666666"];
        
        _averagePrice = [[UILabel alloc]initWithFrame:CGRectMake(_addressLabel.x, _addressLabel.maxY + 10, UI_SCREEN_WIDTH - _addressLabel.x - 10, 20)];
        _averagePrice.font = [UIFont systemFontOfSize:12];
        _averagePrice.textColor = [UIColor colorFromHexCode:@"#666666"];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tipImage.maxX+10, _averagePrice.maxY + 10, UI_SCREEN_WIDTH - _tipImage.maxX - 10, 12)];
        _detailLabel.textColor = [UIColor colorFromHexCode:@"#666666"];
        _detailLabel.font = [UIFont systemFontOfSize:11];
        
        [self.contentView addSubview:_tipImage];
        [self.contentView addSubview:_detailLabel];
        [self.contentView addSubview:_addressLabel];
        [self.contentView addSubview:_proL];
        [self.contentView addSubview:_averagePrice];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
- (void)setDictionary:(NSDictionary *)model isFujin:(BOOL)isFujin {
    self.nameLabel.text = [model objectForKey:@"shop_name"];
    self.averagePrice.text = [NSString stringWithFormat:@"%@", [model objectForKey:@"user_able_use_coupon_percent_text"]];
    NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@", [model objectForKey:@"address"], [model objectForKey:@"shop_cat_name"], [model objectForKey:@"distance"]];
    self.addressLabel.text = addressStr;
    CGSize sizeForCardHolderLabel = [_addressLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - _nameLabel.x - 10, 20)];
    _addressLabel.frame = CGRectMake(_nameLabel.x, _nameLabel.maxY + 5, UI_SCREEN_WIDTH - _nameLabel.x - 10, sizeForCardHolderLabel.height);
    if (isFujin) {
        self.addressLabel.frame = CGRectMake(self.addressLabel.x, self.addressLabel.y, 80, 20);
        self.proL.frame =
        CGRectMake(self.addressLabel.maxX, self.addressLabel.y, UI_SCREEN_WIDTH-self.addressLabel.maxX-5 , 20);
        self.proL.text = [NSString stringWithFormat:@" %@ %@", [model objectForKey:@"shop_cat_name"], [model objectForKey:@"distance"]];
        self.addressLabel.text = [NSString stringWithFormat:@"%@", [model objectForKey:@"address"]];
    }
    [self.tipImage sd_setImageWithURL:[NSURL URLWithString:[model objectForKey:@"shop_img"]]];
}
@end
