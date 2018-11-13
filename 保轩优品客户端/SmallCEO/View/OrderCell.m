//
//  OrderCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WHITE_COLOR;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake( 15,0, 150, 30)];
        _dateLabel.text = @"2015-07-12 17:06";
        _dateLabel.textColor = [UIColor colorFromHexCode:@"828B91"];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_dateLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80 ,  0, 65, 30)];
        _typeLabel.text = @"待发货";
        _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        _typeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_typeLabel];
        
        
        UIView * middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, UI_SCREEN_WIDTH, 98)];
        middleView.backgroundColor=[UIColor colorFromHexCode:@"#f7f7f7"];
        [self.contentView addSubview:middleView];
        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 15, 10, 78, 78)];
        _titleImageView.image = [UIImage imageNamed:@"thumb60014220724666247.png"];
        [middleView addSubview:_titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 15, 10, self.frame.size.width - (CGRectGetMaxX(self.titleImageView.frame) + 15)-15, 20)];
        _titleLabel.text = @"Welloop小黑智能手表";
        _titleLabel.textColor = [UIColor colorFromHexCode:@"#414141"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [middleView addSubview:_titleLabel];
        
        
        
        
        self.guiGeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 15, 35, self.frame.size.width - (CGRectGetMaxX(self.titleImageView.frame) + 15)-30, 40)];
        _guiGeLabel.text = @"颜色: 银色 规格: 16G 送数据线耳机 送插线板 和交换空间";
        _guiGeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _guiGeLabel.font = [UIFont systemFontOfSize:14];
        _guiGeLabel.numberOfLines = 0;
        [middleView addSubview:_guiGeLabel];
        
        
        
        
        
        self.totalNum = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH- 135, 80, 120 , 20)];
        _totalNum.text = @"共1000件产品";
        _totalNum.textColor = App_Main_Color;
        _totalNum.font = [UIFont boldSystemFontOfSize:14];
        _totalNum.textAlignment = NSTextAlignmentRight;
        [middleView addSubview:_totalNum];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0-15, CGRectGetMaxY(middleView.frame), UI_SCREEN_WIDTH/2.0 , 30)];
        _moneyLabel.text = @"合计:￥40.63(含运费￥5.00)";
        _moneyLabel.textColor = [UIColor colorFromHexCode:@"#414141"];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyLabel];
        
        
        
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.moneyLabel.frame), UI_SCREEN_WIDTH-10, 1)];
        line1.backgroundColor = [UIColor colorFromHexCode:@"dfe1eb"];
        [self.contentView addSubview:line1];
        
        self.checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _checkButton.frame = CGRectMake(UI_SCREEN_WIDTH -80-10, CGRectGetMaxY(self.moneyLabel.frame) + 9, 80, 27) ;
        [_checkButton setTitleColor:Red_Color forState:UIControlStateNormal];
        
        [_checkButton setTitle:@"查看物流" forState:UIControlStateNormal];
        _checkButton.layer.borderWidth = 0.5;
        _checkButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
        [self.contentView addSubview:_checkButton];
        

        
        
        self.line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.checkButton.frame)+8, UI_SCREEN_WIDTH, 1)];
        _line2.backgroundColor = [UIColor colorFromHexCode:@"dfe1eb"];
        [self.contentView addSubview:_line2];
        
        self.aView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line2.frame), UI_SCREEN_WIDTH, 10)];
        _aView.backgroundColor = [UIColor colorFromHexCode:@"ececed"];
        [self.contentView addSubview:_aView];
        
        self.line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.aView.frame), UI_SCREEN_WIDTH, 1)];
        _line3.backgroundColor = [UIColor colorFromHexCode:@"dfe1eb"];
        [self.contentView addSubview:_line3];
        

    }
    return self;
}

-(void)updataWith:(NSDictionary *)dic
{
    
    NSDictionary * goodsinfoDic = [[dic objectForKey:@"goodsinfo"] objectAtIndex:0];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"picurl"]]];
    [self.titleImageView af_setImageWithURL:url];
    
    self.totalLabel.text = [NSString stringWithFormat:@"总额:%@",[dic objectForKey:@"actual_pay_money"]];
    
    _customLabel.text = [NSString stringWithFormat:@"顾客: %@", [dic objectForKey:@"contact_name"]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"subject"]];
    self.guiGeLabel.text = [NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"goods_attr"]];
    
    self.typeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_pay_change"]];
    _totalNum.text =[NSString stringWithFormat:@"等%@件商品", [dic objectForKey:@"num"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_typeLabel.text attributes:nil];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, _typeLabel.text.length)];
    
     _moneyLabel.text=[NSString stringWithFormat:@"合计:￥%@  (含运费￥%@)", [dic objectForKey:@"actual_pay_money"],[dic objectForKey:@"order_freight"]];
    
     self.dateLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"create_time"]];
    
    /*
     is_pay_change = "售后过期";
     is_pay_status = 10;
     
     is_pay_change = "可售后";
     is_pay_status = 11;
     
     is_pay_change="查看评价";
     is_pay_status = 12;
     is_pay_change="待评价";
     is_pay_status = 13;
     
     is_pay_change="待发货";
     is_pay_status = 2;
     is_pay_change="已发货";
     is_pay_status = 3;
     
     
     $temp['is_pay_change']="已收货";
     $temp['is_pay_status'] = 4;
     
     $temp['is_pay_change']="已付款";
     $temp['is_pay_status'] = 1;
     
     0表示代付款
     */
    int status = [[dic objectForKey:@"is_pay_status"] intValue];
    switch (status) {
        case 0:
        {
            _checkButton.hidden = YES;
            [str addAttribute:NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(0, _typeLabel.text.length)];
            _typeLabel.attributedText = str;

        }
            break;
        case 2:
        {
            _checkButton.hidden = YES;
             _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        }
            break;
        case 3:
        {
            _checkButton.hidden = NO;
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        }
            break;
        case 4:
        {
            _checkButton.hidden = NO;
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        }
            break;
            
        default:
            break;
    }
}

@end
