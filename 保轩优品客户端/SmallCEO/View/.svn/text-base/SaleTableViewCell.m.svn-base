//
//  SaleTableViewCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "SaleTableViewCell.h"

@implementation SaleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WHITE_COLOR;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,0, 150, 30)];
        _dateLabel.text = @"2015-07-12 17:06";
        _dateLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_dateLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60 ,  0, 60, 30)];
        _typeLabel.text = @"售后过期";
        _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_typeLabel];
        
        
        UIView * middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, UI_SCREEN_WIDTH, 85)];
        middleView.backgroundColor=MONEY_COLOR;
        [self addSubview:middleView];
        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (85-37.5)/2, 37.5, 37.5)];
        _titleImageView.image = [UIImage imageNamed:@"thumb60014220724666247@2x.png"];
        [middleView addSubview:_titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 7, 5, self.frame.size.width - (CGRectGetMaxX(self.titleImageView.frame) + 7)-10, 20)];
        _titleLabel.text = @"Welloop小黑智能手表";
        _titleLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        //                _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [middleView addSubview:_titleLabel];
        
        
        
        
        self.guiGeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 7, 25, self.frame.size.width - (CGRectGetMaxX(self.titleImageView.frame) + 7)-10, 40)];
        _guiGeLabel.text = @"颜色: 银色 规格: 16G 送数据线耳机 送插线板 和交换空间";
        _guiGeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _guiGeLabel.font = [UIFont systemFontOfSize:12];
        _guiGeLabel.numberOfLines = 0;
        //                    _guiGeLabel.backgroundColor = [UIColor redColor];
        [middleView addSubview:_guiGeLabel];
        
        
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 7, 65, 90, 15)];
        _totalLabel.text = @"￥14568";
        _totalLabel.font = [UIFont systemFontOfSize:13];
        _totalLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        [middleView addSubview:_totalLabel];
        
        
        
//        self.GoodTotalNum = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100-10, 65, 100 , 15)];
//        _GoodTotalNum.text = @"X100";
//        _GoodTotalNum.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
//        _GoodTotalNum.font = [UIFont systemFontOfSize:12];
//        //            _GoodTotalNum.backgroundColor = [UIColor redColor];
//        [middleView addSubview:_GoodTotalNum];
        
        
        
        self.totalNum = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame), 120 , 20)];
        _totalNum.text = @"共1000件产品";
        _totalNum.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _totalNum.font = [UIFont systemFontOfSize:12];
        _totalNum.textAlignment = NSTextAlignmentRight;
        //                    _totalNum.backgroundColor = [UIColor redColor];
        [self addSubview:_totalNum];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, CGRectGetMaxY(middleView.frame), self.frame.size.width - 120 , 20)];
        _moneyLabel.text = @"合计:￥40.63(含运费￥5.00)";
        _moneyLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _moneyLabel.font = [UIFont systemFontOfSize:12];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        //        _moneyLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_moneyLabel];
        
        
        //        self.nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 5 - 15, 29, 5, 8)];
        //        _nextImageView.image = [UIImage imageNamed:@"gj_jt_right@2x.png"];
        //        [self addSubview:_nextImageView];
        
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.moneyLabel.frame), UI_SCREEN_WIDTH, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [self addSubview:line1];
        
        self.quxiaoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _quxiaoButton.frame = CGRectMake(UI_SCREEN_WIDTH - 100-5, CGRectGetMaxY(self.moneyLabel.frame) + 5, 100, 30) ;
        [_quxiaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_quxiaoButton setTitle:@"申请售后" forState:UIControlStateNormal];
        [self addSubview:_quxiaoButton];
        
        //        self.customLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 18, 70, 150, 30)];
        //        //        quxiaoButton.frame = CGRectMake(UI_SCREEN_WIDTH - 150 - 10, 202, 150, 30) ;
        //        _customLabel.font = [UIFont systemFontOfSize:14];
        //        _customLabel.textColor = SUB_TITLE;
        //        _customLabel.text = @"顾客 12345678901";
        //        [self addSubview:_customLabel];
        //
        //
        self.line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.quxiaoButton.frame)+5, UI_SCREEN_WIDTH, 1)];
        _line2.backgroundColor = LINE_SHALLOW_COLOR;
        [self addSubview:_line2];
        
        self.aView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line2.frame), UI_SCREEN_WIDTH, 5)];
        _aView.backgroundColor = MONEY_COLOR;
        [self addSubview:_aView];
        
        self.line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.aView.frame), UI_SCREEN_WIDTH, 1)];
        _line3.backgroundColor = LINE_SHALLOW_COLOR;
        [self addSubview:_line3];
        
        
    }
    return self;
}
- (void)updateCellData:(NSDictionary *)dic
{
    NSDictionary*goodsInfoDic = [[dic objectForKey:@"goodsinfo"] objectAtIndex:0];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [goodsInfoDic objectForKey:@"subject"]];
    _typeLabel.text =[NSString stringWithFormat:@"%@", [dic objectForKey:@"is_pay_change"]];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [goodsInfoDic objectForKey:@"picurl"]]];
    [_titleImageView af_setImageWithURL:url];
    
    self.guiGeLabel.text = [NSString stringWithFormat:@"%@", [goodsInfoDic objectForKey:@"goods_attr"]];
    _totalNum.text =[NSString stringWithFormat:@"共%@件产品", [goodsInfoDic objectForKey:@"goods_number"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"合计:￥%@(含运费￥%@)", [dic objectForKey:@"actual_pay_money"], [dic objectForKey:@"order_freight"]];
    
    self.totalLabel.text= [NSString stringWithFormat:@"￥%@", [dic objectForKey:@"actual_pay_money"]];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"create_time"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
