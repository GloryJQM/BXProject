//
//  MyOrderCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/31.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WHITE_COLOR;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake( 15,0, 150, 30)];
        _dateLabel.text = @"";
        _dateLabel.textColor = [UIColor colorFromHexCode:@"828B91"];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_dateLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80 ,  0, 65, 30)];
        _typeLabel.text = @"";
        _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        _typeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_typeLabel];

        
        UIView * middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, UI_SCREEN_WIDTH, 98)];
        middleView.backgroundColor=[UIColor colorFromHexCode:@"#f7f7f7"];
        [self.contentView addSubview:middleView];
        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 15, 10, 78, 78)];
        [middleView addSubview:_titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 15, 10, UI_SCREEN_WIDTH - (CGRectGetMaxX(self.titleImageView.frame) + 15)-15, 20)];
        _titleLabel.text = @"";
        _titleLabel.textColor = [UIColor colorFromHexCode:@"#414141"];
        _titleLabel.font = LMJ_XT 15];
        [middleView addSubview:_titleLabel];
        
        self.guiGeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 15, 35, self.frame.size.width - (CGRectGetMaxX(self.titleImageView.frame) + 15)-30, 30)];
        _guiGeLabel.text = @"";
        _guiGeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _guiGeLabel.font = [UIFont systemFontOfSize:14];
        _guiGeLabel.numberOfLines = 0;
        [middleView addSubview:_guiGeLabel];


        self.totalNum = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH- 135, 70, 120 , 20)];
        _totalNum.text = @"";
        _totalNum.textColor = App_Main_Color;
        _totalNum.font = [UIFont boldSystemFontOfSize:14];
        _totalNum.textAlignment = NSTextAlignmentRight;
        [middleView addSubview:_totalNum];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0-15, CGRectGetMaxY(middleView.frame), UI_SCREEN_WIDTH/2.0 , 30)];
        _moneyLabel.text = @"";
        _moneyLabel.textColor = [UIColor colorFromHexCode:@"#414141"];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyLabel];

 
        
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.moneyLabel.frame), UI_SCREEN_WIDTH-10, 1)];
        line1.backgroundColor = [UIColor colorFromHexCode:@"dfe1eb"];
        [self addSubview:line1];
        
        self.checkWuLiuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _checkWuLiuBtn.frame = CGRectMake(UI_SCREEN_WIDTH - 80-30-80-10, CGRectGetMaxY(self.moneyLabel.frame) + 9, 80, 27) ;
        [_checkWuLiuBtn setTitleColor:Red_Color forState:UIControlStateNormal];
        
        [_checkWuLiuBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        _checkWuLiuBtn.layer.borderWidth = 0.5;
        _checkWuLiuBtn.hidden = YES;
        _checkWuLiuBtn.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
        [self.contentView addSubview:_checkWuLiuBtn];

        
        self.quxiaoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _quxiaoButton.frame = CGRectMake(UI_SCREEN_WIDTH - 80-10, CGRectGetMaxY(self.moneyLabel.frame) + 9, 80, 27) ;
        [_quxiaoButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
        _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
        _quxiaoButton.layer.borderWidth = 0.5;
        _quxiaoButton.hidden = YES;
        [self.contentView addSubview:_quxiaoButton];
        
   
        self.line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.quxiaoButton.frame)+8, UI_SCREEN_WIDTH, 1)];
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
    NSArray *goodArr = [dic objectForKey:@"goodsinfo"];
    if (![goodArr isKindOfClass:[NSArray class]] || goodArr.count <= 0) {
        return;
    }
    
    NSDictionary * goodsinfoDic = [[dic objectForKey:@"goodsinfo"] objectAtIndex:0];

    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"picurl"]]];
    [self.titleImageView af_setImageWithURL:url];
    
    self.totalLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"actual_pay_money"]];
    
    
    _guiGeLabel.text = [NSString stringWithFormat:@"%@", [goodsinfoDic objectForKey:@"goods_attr"]];
    
    _totalNum.text =[NSString stringWithFormat:@"等%@件商品", [dic objectForKey:@"num"]];
    _moneyLabel.text=[NSString stringWithFormat:@"合计:￥%@  (含运费￥%@)", [dic objectForKey:@"actual_pay_money"],[dic objectForKey:@"order_freight"]];
    self.judge = [[dic objectForKey:@"goods_totalnum"] intValue];
    if (_judge == 1) {
      
        self.GoodTotalNum.hidden = YES;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"subject"]];
    self.typeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_pay_change"]];
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
     
     if($row['dingdanstatus']==100){
     $temp['is_pay_change']="售后处理中";
     $temp['is_pay_status'] = 7;
     }elseif($row['dingdanstatus']==101){
     $temp['is_pay_change']="已成功处理";
     $temp['is_pay_status'] = 8;
     }elseif($row['dingdanstatus']==102){
     $temp['is_pay_change']="售后被拒绝";
     $temp['is_pay_status'] = 9;
     */
    
    int status = [[dic objectForKey:@"is_pay_status"] intValue];
    switch (status) {
        case 0:
        {
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_typeLabel.text attributes:nil];
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, _typeLabel.text.length)];
            _typeLabel.textColor = Red_Color;
            _typeLabel.attributedText = str;
            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.hidden = NO;
            
            [_quxiaoButton setTitleColor:Red_Color forState:UIControlStateNormal];
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
            _quxiaoButton.layer.borderWidth = 0.5;
             [_quxiaoButton setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.hidden = YES;
        }
            break;
        case 2:
        {

            _checkWuLiuBtn.hidden = YES;
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
            _quxiaoButton.hidden = YES;

        }
            break;
        case 3:
        {
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

            _checkWuLiuBtn.hidden = NO;
            _quxiaoButton.hidden = NO;
            [_quxiaoButton setTitleColor:Red_Color forState:UIControlStateNormal];
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
            _quxiaoButton.layer.borderWidth = 0.5;
            [_quxiaoButton setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case 7:
        {
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.layer.borderWidth = 0.5;
            [_quxiaoButton setTitleColor:[UIColor colorFromHexCode:@"8a8a8a"] forState:UIControlStateNormal];
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"c0c0c0"].CGColor;
           [_quxiaoButton setTitle:@"不可售后" forState:UIControlStateNormal];
            
        }
            break;
        case 8:
        {
            _checkWuLiuBtn.hidden = YES;
            [_quxiaoButton setTitleColor:[UIColor colorFromHexCode:@"8a8a8a"] forState:UIControlStateNormal];
            [_quxiaoButton setTitle:@"不可售后" forState:UIControlStateNormal];
            _quxiaoButton.layer.borderWidth = 0.5;
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"c0c0c0"].CGColor;
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            break;
        case 9:
        {
            _checkWuLiuBtn.hidden = YES;
            [_quxiaoButton setTitleColor:[UIColor colorFromHexCode:@"8a8a8a"] forState:UIControlStateNormal];
            _quxiaoButton.layer.borderWidth = 0.5;
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"c0c0c0"].CGColor;
            [_quxiaoButton setTitle:@"不可售后" forState:UIControlStateNormal];
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            break;
        case 10:
        {
            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.layer.borderWidth = 0.5;
            [_quxiaoButton setTitleColor:[UIColor colorFromHexCode:@"8a8a8a"] forState:UIControlStateNormal];
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"c0c0c0"].CGColor;
            [_quxiaoButton setTitle:@"不可售后" forState:UIControlStateNormal];
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            break;
        case 11:
        {
            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.hidden = NO;
            [_quxiaoButton setTitleColor:Red_Color forState:UIControlStateNormal];
            _quxiaoButton.layer.borderWidth = 0.5;
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
            [_quxiaoButton setTitle:@"申请售后" forState:UIControlStateNormal];
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            break;
        case 12:
        {
            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.hidden = YES;
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            break;
        case 13:
        {
            _checkWuLiuBtn.hidden = YES;
            _quxiaoButton.hidden = NO;
            _quxiaoButton.layer.borderWidth = 0.5;
            [_quxiaoButton setTitleColor:Red_Color forState:UIControlStateNormal];
            _quxiaoButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
            [_quxiaoButton setTitle:@"立即评价" forState: UIControlStateNormal];
            _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];

        }
            
        default:
            break;
    }
}


@end
