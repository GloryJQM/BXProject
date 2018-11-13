//
//  ListCollectionViewCell.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ListCollectionViewCell.h"

@implementation ListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creationView:frame];
    }
    return self;
}

- (void)creationView:(CGRect)frame {
    self.cellFrame = frame;

    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    self.mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, width, width)];
    [self.contentView addSubview:_mainImageView];
    
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(_mainImageView.minX, _mainImageView.maxY, width, height - _mainImageView.maxY)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, width,19)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = Color161616;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_titleLabel];
    
    self.view1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.maxY + 10, width, 20)];
    [_backView addSubview:_view1];
    
    //价格
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.maxY+8, 80, 15)];
    _priceLabel.textColor = Color161616;
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:12];
    [_backView addSubview:_priceLabel];
    
    
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(width - 120, _priceLabel.minY, 120, 15)];
    _numberLabel.backgroundColor = [UIColor clearColor];
    _numberLabel.textColor = [UIColor colorFromHexCode:@"#747373"];
    _numberLabel.textAlignment = NSTextAlignmentRight;
    _numberLabel.font = [UIFont systemFontOfSize:10];
    [_backView addSubview:_numberLabel];
    
    self.goods_overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goods_overlayButton.frame = CGRectMake(0, width - 20, width, 20);
    _goods_overlayButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_mainImageView addSubview:_goods_overlayButton];
    _goods_overlayButton.hidden = YES;
}

- (void)setDictionary:(NSDictionary *)dataDic isLeft:(BOOL)isleft {
    CGFloat width = self.cellFrame.size.width;

    [self.mainImageView sd_setImageWithURL:dataDic[@"goods_img"]];
    
    _titleLabel.text = dataDic[@"goods_name"];

    
    NSString *goods_price = [NSString stringWithFormat:@"%f", [dataDic[@"goods_price"] floatValue]];
    
    
    if ([dataDic[@"is_point_type"] integerValue] == 0) {
        _numberLabel.text = [NSString stringWithFormat:@"已售 %@",dataDic[@"goods_sale_number"]];
        _priceLabel.text = [goods_price moneyPoint:[dataDic[@"is_point_type"] integerValue]];
    }else {
        _numberLabel.text = [NSString stringWithFormat:@"已兑换%@",dataDic[@"goods_sale_number"]];
        _priceLabel.text = [goods_price moneyPoint:2];
    }
    
    NSDictionary *goods_overlay = dataDic[@"goods_overlay"];
    
    if ([goods_overlay isKindOfClass:[NSDictionary class]] && goods_overlay != nil) {
        NSString *text = goods_overlay[@"text"];
        if ([text isBlankString] && text.length > 0) {
            _goods_overlayButton.hidden = NO;
            [_goods_overlayButton setTitle:text forState:UIControlStateNormal];
            NSString *bgcolor = [NSString stringWithFormat:@"#%@", goods_overlay[@"bgcolor"]];
            _goods_overlayButton.backgroundColor = [UIColor colorFromHexCode:bgcolor];
            _goods_overlayButton.alpha = [goods_overlay[@"opacity"] floatValue];
        }else {
            _goods_overlayButton.hidden = YES;
        }
    }else {
        _goods_overlayButton.hidden = YES;
    }
    
    [_view1.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([dataDic[@"is_point_type"] integerValue] == 0) {
        NSArray *array = [dataDic objectForKey:@"goods_label"];
        CGFloat labelX = 0;
        if ([array isKindOfClass:[NSArray class]] && array != nil) {
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                NSString *text = [dic objectForKey:@"text"];
                NSString *color = [NSString stringWithFormat:@"#%@", [dic objectForKey:@"color"]];
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, 0, 0)];
                titleLabel.layer.borderColor = [UIColor colorFromHexCode:color].CGColor;
                titleLabel.textColor = [UIColor colorFromHexCode:color];
                titleLabel.tag = 10 + i;
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.font = [UIFont systemFontOfSize:12];
                titleLabel.layer.borderWidth = 0.5;
                titleLabel.layer.cornerRadius = 2;
                titleLabel.layer.masksToBounds = YES;
                titleLabel.text = text;
                CGSize sizeForCardHolderLabel1 = [titleLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 90, 20)];
                if ([text isBlankString]) {
                    if (labelX + sizeForCardHolderLabel1.width + 15 <= _mainImageView.width) {
                        titleLabel.frame = CGRectMake(labelX, 0, sizeForCardHolderLabel1.width + 15, 20);
                    }
                    
                    labelX = titleLabel.maxX + 8;
                }
                if (i == array.count - 1) {
                    _priceLabel.frame = CGRectMake(0, _view1.maxY+8, 80, 15);
                    _numberLabel.frame = CGRectMake(width - 120, _priceLabel.minY, 120, 15);
                }
                [_view1 addSubview: titleLabel];
            }
        }else {
            _priceLabel.frame = CGRectMake(0, _titleLabel.maxY+8, 80, 15);
            _numberLabel.frame = CGRectMake(width - 120, _priceLabel.minY, 120, 15);
        }
    }
}
@end
