//
//  OrderAddressView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderAddressView.h"
@interface OrderAddressView(){
    UILabel *phoneLabel;
    NSDictionary *data;
}
@property (nonatomic, assign) CGFloat y;
@end

@implementation OrderAddressView
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 0)];
    if (self) {
        self.y = y;
        [self creationView:dataDic];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)creationView:(NSDictionary *)dic {
    data = dic;
    
    NSInteger receiving_method = [dic[@"receiving_method"] integerValue];
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addressicon@2x"]];
    leftImageView.frame = CGRectMake(15, 17, 16, 19);
    [self addSubview:leftImageView];
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(leftImageView.maxX + 10, 17, 125, 20)];
    address.font = [UIFont systemFontOfSize:14];
    address.textAlignment = NSTextAlignmentLeft;
    address.textColor = [UIColor colorFromHexCode:@"#3D4E56"];
    [self addSubview:address];
    
    [self addLineWithY:49.5];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UI_SCREEN_WIDTH, 100)];
    [self addSubview:backView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, UI_SCREEN_WIDTH - 30, 20)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = Color161616;
    [backView addSubview:nameLabel];
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, nameLabel.maxY + 6, UI_SCREEN_WIDTH - 30, 20)];
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = Color161616;
    [backView addSubview:phoneLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, phoneLabel.maxY + 6, UI_SCREEN_WIDTH - 30, 20)];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = Color161616;
    addressLabel.numberOfLines = 0;
    [backView addSubview:addressLabel];
    
    if (receiving_method == 1) {
        address.text = @"提货地址";
        nameLabel.text =[NSString stringWithFormat:@"提货门店: %@", dic[@"shop_name"]];
        addressLabel.text = [NSString stringWithFormat:@"提货地址: %@", dic[@"address"]];
    }else {
        address.text = @"收货地址";
        nameLabel.text =[NSString stringWithFormat:@"收货人: %@", dic[@"contact_name"]];
        addressLabel.text = [NSString stringWithFormat:@"收货地址: %@", dic[@"address"]];
    }
    
    CGSize addressSize = [addressLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 30, 100)];
    addressLabel.frame = CGRectMake(15, phoneLabel.maxY + 6, UI_SCREEN_WIDTH - 30, addressSize.height);
    
    backView.frame = CGRectMake(0, 50, UI_SCREEN_WIDTH, addressLabel.maxY + 10);
    self.frame = CGRectMake(0, self.y, UI_SCREEN_WIDTH, backView.maxY);
}

- (void)setIs_point_type:(NSInteger)is_point_type {
    NSString *string = [NSString stringWithFormat:@"联系方式: %@", data[@"contact_tel"]];
    if (is_point_type == 1 && [data[@"receiving_method"] integerValue] == 1) {
        phoneLabel.attributedText = [string String:[NSString stringWithFormat:@"%@", data[@"contact_tel"]] Color:App_Main_Color];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        phoneLabel.userInteractionEnabled = YES;
        [phoneLabel addGestureRecognizer:tap];
    }else {
        phoneLabel.text = [NSString stringWithFormat:@"联系方式: %@", data[@"contact_tel"]];
    }
}

- (void)handleTap {
    NSString *phone = [NSString stringWithFormat:@"%@", data[@"contact_tel"]];
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",phone];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    });
}

@end
