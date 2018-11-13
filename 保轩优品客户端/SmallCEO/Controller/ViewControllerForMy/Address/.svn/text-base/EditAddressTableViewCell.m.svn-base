//
//  EditAddressTableViewCell.m
//  Price
//
//  Created by 俊严 on 17/3/2.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import "EditAddressTableViewCell.h"
#import "UIColor+FlatUI.h"
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
@implementation EditAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel    alloc] initWithFrame:CGRectMake(12, 10, (UI_SCREEN_WIDTH-10)/2, 20)];
        //_nameLabel.text = @"收货人：张伟";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel    alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 10, UI_SCREEN_WIDTH - 12 - CGRectGetMaxX(_nameLabel.frame), 20)];
        //_phoneLabel.text = @"12345678901";
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_phoneLabel];
        
        _addressLabel = [[UILabel    alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_nameLabel.frame)+10, UI_SCREEN_WIDTH-10, 20)];
        //_addressLabel.text = @"收货地址：浙江省杭州市江干区景堂路";
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_addressLabel];
        
        UIView*line = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_addressLabel.frame)+10, UI_SCREEN_WIDTH-10, 0.5)];
        line.backgroundColor = [UIColor colorFromHexCode:@"cccccc"];
        [self addSubview:line];
        
        _submmitBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(line.frame)+7, 20, 20)];
        [_submmitBtn setBackgroundImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
        [_submmitBtn addTarget:self action:@selector(defaultBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_submmitBtn];
        
        UILabel * morenLaebl= [[UILabel    alloc] initWithFrame:CGRectMake(37, CGRectGetMaxY(line.frame)+7, 150, 20)];
        morenLaebl.text = @"设为默认地址";
        morenLaebl.textAlignment = NSTextAlignmentLeft;
        morenLaebl.font = [UIFont systemFontOfSize:14];
        [self addSubview:morenLaebl];
        
        UIButton*editBtn = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2, CGRectGetMaxY(line.frame)+5, (UI_SCREEN_WIDTH/4-15), 25)];
        editBtn.layer.borderColor = [UIColor colorFromHexCode:@"bcbcbc"].CGColor;
        editBtn.layer.borderWidth = 1;
        editBtn.layer.cornerRadius = 5;
//        editBtn.tag = self.tag;
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editBtn];
        
        UIButton*cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(editBtn.frame)+10, CGRectGetMaxY(line.frame)+5, (UI_SCREEN_WIDTH/4-15), 25)];
        cancelBtn.layer.borderColor = [UIColor colorFromHexCode:@"bcbcbc"].CGColor;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];

//        UIView*sepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelBtn.frame)+5, UI_SCREEN_WIDTH,10)];
//        sepView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
//        [self addSubview:sepView];
    }
    return self;
}
- (void)updateWithData:(NSDictionary *)dic {
    _nameLabel.text = [NSString stringWithFormat:@"收货人:%@",dic[@"contact_name"]];
    _phoneLabel.text = dic[@"phone_num"];
    _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@",dic[@"address"], dic[@"house_number"]];
    if ([dic[@"is_default"] integerValue] == 1) {
        [_submmitBtn setBackgroundImage:[UIImage imageNamed:@"button-xuanzhong@2x"] forState:UIControlStateNormal];
    }else {
        [_submmitBtn setBackgroundImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
    }
}
- (void)editeBtn:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(editeAddressBtn:)]) {
        
        [_delegate editeAddressBtn:self.tag];
    }
}

- (void)deleteBtn:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(deleteAddressBtn:)]) {
        
        [_delegate deleteAddressBtn:self.tag];
    }
}

- (void)defaultBtn:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(defaultAddressBtn:)]) {
        
        [_delegate defaultAddressBtn:self.tag];
    }
}
@end
