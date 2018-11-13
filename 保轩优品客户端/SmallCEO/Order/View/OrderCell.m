//
//  OrderCell.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationView];
    }
    return self;
}

- (void)creationView {
    [self.contentView addLineWithY:0];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://bxup.cvgou.com/upload/payment_icon/4.png"]];
    [self.contentView addSubview:imageView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - 20, 20)];
    priceLabel.text = @"¥ 2900";
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor blueColor];
    CGSize priceSize = [priceLabel sizeThatFits:CGSizeMake(999, 20)];
    priceLabel.frame = CGRectMake(UI_SCREEN_WIDTH - priceSize.width - 15, imageView.minX, priceSize.width, 20);
    [self.contentView addSubview:priceLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, imageView.minX, 0, 0)];
    nameLabel.text = @"2017奥康皮鞋 男士夏季新款真皮透气";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.numberOfLines = 0;
    CGSize nameSize = [nameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, 100)];
    nameLabel.frame = CGRectMake(imageView.maxX + 10, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, nameSize.height);
    [self.contentView addSubview:nameLabel];
    
    UILabel *standard = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, nameLabel.maxY + 5, 150, 20)];
    standard.text = @"墨绿色/40.5";
    standard.textAlignment = NSTextAlignmentLeft;
    standard.font = [UIFont systemFontOfSize:14];
    standard.textColor = [UIColor blueColor];
    [self.contentView addSubview:standard];
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 45, 45, 30, 20)];
    number.text = @"X1";
    number.textAlignment = NSTextAlignmentRight;
    number.font = [UIFont systemFontOfSize:14];
    number.textColor = [UIColor blueColor];
    [self.contentView addSubview:number];
}
@end
