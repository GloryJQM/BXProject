//
//  AddressView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "AddressView.h"
@interface AddressView(){
    CGFloat _y;
    NSInteger _is_point_type;
}
@end
@implementation AddressView
- (instancetype)initWithY:(CGFloat)y is_point_type:(NSInteger)is_point_type Block:(void (^) (void))block {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 100 * is_point_type)];
    if (self) {
        _y = y;
        _is_point_type = is_point_type;
        [self creationView:is_point_type];
        self.finishBlock = block;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)creationView:(NSInteger)is_point_type {
    CGFloat space = 15;
    if (is_point_type == 1) {
        self.seleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, self.height)];
        [_seleButton setImage:[UIImage imageNamed:@"addressweixuanzhong@2x"] forState:UIControlStateNormal];
        [_seleButton setImage:[UIImage imageNamed:@"addressxuanzhong@2x"] forState:UIControlStateSelected];
        [self addSubview:_seleButton];
        space = _seleButton.maxX;
    }
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, 20, UI_SCREEN_WIDTH - space - 15, 20)];
    _nameLabel.textColor = Color0E0E0E;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.numberOfLines = 0;
    [self addSubview:_nameLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, _nameLabel.maxY + 8, UI_SCREEN_WIDTH - space - 15, 20)];
    _addressLabel.textColor = Color74828B;
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_addressLabel];
    
    self.houseLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, _addressLabel.maxY + 4, UI_SCREEN_WIDTH - space - 15, 20)];
    _houseLabel.textColor = Color74828B;
    _houseLabel.textAlignment = NSTextAlignmentLeft;
    _houseLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_houseLabel];
    
    self.rightArrowImageView = [[UIImageView alloc] init];
    _rightArrowImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    [self addSubview:_rightArrowImageView];
    
    [self addTarget:self action:@selector(handleButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleButton {
    if (self.finishBlock) {
        self.finishBlock();
    }
}

- (void)setDictionary:(NSDictionary *)model {
    
    NSString *contacts_id = [NSString stringWithFormat:@"%@", model[@"contacts_id"]];
    
    if ([contacts_id isBlankString]) {
        _nameLabel.text = [NSString stringWithFormat:@"%@  %@", model[@"contacts_name"], model[@"contacts_tel"]];
        _addressLabel.text = [NSString stringWithFormat:@"%@", model[@"area_name"]];
        _houseLabel.text = [NSString stringWithFormat:@"%@", model[@"address"]];
        self.frame = CGRectMake(0, _y, UI_SCREEN_WIDTH, _houseLabel.maxY + 20);
        self.seleButton.selected = YES;
    }else {
        if (_is_point_type == 1) {
            _nameLabel.text = @"送货上门(推荐使用)";
        }else {
            _nameLabel.text = @"添加收货地址";
        }
        
        _addressLabel.text = @"";
        _houseLabel.text = @"";
        self.frame = CGRectMake(0, _y, UI_SCREEN_WIDTH, _nameLabel.maxY + 20);
    }
    _seleButton.frame = CGRectMake(0, 0, 50, self.height);
    self.rightArrowImageView.frame = CGRectMake(UI_SCREEN_WIDTH - 15, self.frame.size.height/2-4, 5, 8);
}

- (void)setPointDictionary:(NSDictionary *)model {
     NSString *contacts_id = [NSString stringWithFormat:@"%@", model[@"contacts_id"]];
    if ([contacts_id isBlankString]) {
        _nameLabel.text = [NSString stringWithFormat:@"%@%@",model[@"area_name"], model[@"address"]];
        CGSize nameSize = [_nameLabel sizeThatFits:CGSizeMake(_nameLabel.width, 100)];
        _nameLabel.frame = CGRectMake(_nameLabel.x, 20, _nameLabel.width, nameSize.height);
    }else {
        _nameLabel.text =@"到店取货";
    }
    self.frame = CGRectMake(0, _y, UI_SCREEN_WIDTH, _nameLabel.maxY + 20);
    _seleButton.frame = CGRectMake(0, 0, 50, self.height);
    self.rightArrowImageView.frame = CGRectMake(UI_SCREEN_WIDTH - 15, self.frame.size.height/2-4, 5, 8);
}

- (void)setTihuo_info:(NSString *)tihuo_info {
    _nameLabel.attributedText = [[NSString stringWithFormat:@"到店取货 %@", tihuo_info]  String:tihuo_info Color:Color74828B];
    _seleButton.frame = CGRectMake(0, 0, 50, self.height);
    self.frame = CGRectMake(0, _y, UI_SCREEN_WIDTH, _nameLabel.maxY + 20);
}
@end
