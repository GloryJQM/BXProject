//
//  SupplierView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "SupplierView.h"
@interface SupplierView()
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) NSInteger is_point_type;
@end
@implementation SupplierView
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic is_point_type:(NSInteger)is_point_type {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 160)];
    if (self) {
        self.y = y;
        self.dataDic = dataDic;
        self.is_point_type = is_point_type;
        [self creationView];
    }
    return self;
}

- (void)creationView {
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 15, 15)];
    imageView.image = [UIImage imageNamed:@"填写订单:Icon@2x"];
    [self addSubview:imageView];
    
    UILabel *supplierLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, 15, UI_SCREEN_WIDTH - imageView.maxX - 20, 20)];
    supplierLabel.text = [NSString stringWithFormat:@"%@", self.dataDic[@"supplier_name"]];
    supplierLabel.textAlignment = NSTextAlignmentLeft;
    supplierLabel.font = [UIFont systemFontOfSize:14];
    supplierLabel.textColor = Color3D4E56;
    [self addSubview:supplierLabel];
    
    UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, UI_SCREEN_WIDTH - 65, 20)];
    NSString *statusStr = [NSString stringWithFormat:@"%@", self.dataDic[@"status_content"]];
    if ([statusStr isBlankString]) {
        status.text = statusStr;
    }
    status.textAlignment = NSTextAlignmentRight;
    status.font = [UIFont systemFontOfSize:14];
    
    NSString *status_value = [NSString stringWithFormat:@"%@", self.dataDic[@"status_value"]];
    
    status.textColor = [status_value getStatusColor];
    [self addSubview:status];
    
    [self addLineWithY:49.5];
    
    CGFloat y = supplierLabel.maxY + 15;
    NSArray *list = self.dataDic[@"list"];
    for (int i = 0; i < list.count; i++) {
        NSDictionary *dic = list[i];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 122)];
        [self addSubview:backView];
        
        if (i != 0) {
           [backView addLineWithY:0 X:15 width:UI_SCREEN_WIDTH - 30];
        }
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 100, 100)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dic[@"goods_img"]]]];
        [backView addSubview:imageView];
        
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - 20, 20)];
        NSString *goods_price = [NSString stringWithFormat:@"%@", dic[@"goods_price"]];
        priceLabel.text = [goods_price moneyPoint:self.is_point_type];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = Color3D4E56;
        CGSize priceSize = [priceLabel sizeThatFits:CGSizeMake(999, 20)];
        priceLabel.frame = CGRectMake(UI_SCREEN_WIDTH - priceSize.width - 15, imageView.minX, priceSize.width, 20);
        [backView addSubview:priceLabel];
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, imageView.minX, 0, 0)];
        nameLabel.text = [NSString stringWithFormat:@"%@", dic[@"goods_name"]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = Color161616;
        nameLabel.numberOfLines = 0;
        CGSize nameSize = [nameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, 100)];
        nameLabel.frame = CGRectMake(imageView.maxX + 10, imageView.minX, UI_SCREEN_WIDTH - imageView.maxX - priceSize.width - 30, nameSize.height);
        [backView addSubview:nameLabel];
        
        UILabel *standard = [[UILabel alloc] initWithFrame:CGRectMake(imageView.maxX + 10, nameLabel.maxY + 5, 150, 20)];
        standard.text = [NSString stringWithFormat:@"%@", dic[@"goods_attr_str"]];
        standard.textAlignment = NSTextAlignmentLeft;
        standard.font = [UIFont systemFontOfSize:12];
        standard.textColor = ColorB0B8BA;
        [backView addSubview:standard];
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 45, 45, 30, 20)];
        number.text = [NSString stringWithFormat:@"X%@", dic[@"goods_number"]];
        number.textAlignment = NSTextAlignmentRight;
        number.font = [UIFont systemFontOfSize:12];
        number.textColor = ColorB0B8BA;
        [backView addSubview:number];
        
        NSString *f_logistics_id = [NSString stringWithFormat:@"%@", dic[@"f_logistics_id"]];
        if (![f_logistics_id isEqualToString:@"0"] && [status_value isEqualToString:@"3"]) {
            UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 115, imageView.maxY - 20, 100, 20)];
            status.text = @"已发货";
            status.textAlignment = NSTextAlignmentRight;
            status.font = [UIFont systemFontOfSize:12];
            status.textColor = App_Main_Color;
            [backView addSubview:status];
        }
        
        
        y += 122;
    }
    self.frame = CGRectMake(0, self.y, UI_SCREEN_WIDTH, y);
}

@end
