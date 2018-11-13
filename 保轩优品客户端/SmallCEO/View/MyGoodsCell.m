//
//  MyGoodsCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyGoodsCell.h"

@implementation MyGoodsCell
{
    UIView *bottomView;
    UIView *recodeView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 8)];
        shadowView.backgroundColor = MONEY_COLOR;
        [self.contentView addSubview:shadowView];
        
        self.goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 18, 79, 79)];
        [self.contentView addSubview:_goodImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 18, UI_SCREEN_WIDTH - 96, 16)];
        _titleLabel.text = @"iPhone6 pluse";
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        recodeView = [[UIView alloc] initWithFrame:CGRectMake(96, CGRectGetMaxY(self.titleLabel.frame), UI_SCREEN_WIDTH-96, 70)];
        recodeView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:recodeView];

        
        self.originPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, (UI_SCREEN_WIDTH - 85)/2, 16)];
        _originPriceLabel.text = @"售价 ￥10000";
        _originPriceLabel.font = [UIFont systemFontOfSize:13];
        [recodeView addSubview:_originPriceLabel];
        
        self.yiLiLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 85)/2, 5, (UI_SCREEN_WIDTH - 85) / 2, 16)];
        _yiLiLabel.text = @"利润 ￥10000";
        _yiLiLabel.textColor = App_Main_Color;
        _yiLiLabel.font = [UIFont boldSystemFontOfSize:13];
        [recodeView addSubview:_yiLiLabel];

        
        self.markPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16+5+3, (UI_SCREEN_WIDTH - 85) / 2, 16)];
        _markPriceLabel.text = @"会员价￥10000";
        _markPriceLabel.font = [UIFont systemFontOfSize:12];
        _markPriceLabel.textColor = SUB_TITLE;
        [recodeView addSubview:_markPriceLabel];
        
        
        self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 85) / 2, 16+5+3 , (UI_SCREEN_WIDTH - 85) / 2, 16)];
        _nowLabel.text = @"参考价￥10000";
        _nowLabel.textColor = SUB_TITLE;
        _nowLabel.font = [UIFont systemFontOfSize:12];
        [recodeView addSubview:_nowLabel];
        
        self.saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16*3 , (UI_SCREEN_WIDTH - 85) / 2, 16)];
        _saleLabel.text = @"已售10000件";
        _saleLabel.textColor = SUB_TITLE;
        _saleLabel.font = [UIFont systemFontOfSize:12];
        
        [recodeView addSubview:_saleLabel];
  
        self.lookLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 85) / 2, 16*3 , (UI_SCREEN_WIDTH - 85) / 2, 16)];
        _lookLabel.text = @"被查看:10000次";
        _lookLabel.textColor = SUB_TITLE;
        _lookLabel.font = [UIFont systemFontOfSize:12];
         [recodeView addSubview:_lookLabel];
        
        self.StatisticsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _StatisticsBtn.frame = CGRectMake(recodeView.frame.size.width-65-10, 70-20-5, 65, 20);
        _StatisticsBtn.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
        _StatisticsBtn.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
        _StatisticsBtn.layer.borderWidth = 0.3;
        _StatisticsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_StatisticsBtn setTitle:@"查看统计" forState: UIControlStateNormal];
        [_StatisticsBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
        [recodeView addSubview:_StatisticsBtn];
        
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recodeView.frame), UI_SCREEN_WIDTH, 41)];
        bottomView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:bottomView];

        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , UI_SCREEN_WIDTH , 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [bottomView addSubview:line];
        
        UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH , 1)];
        line2.backgroundColor = LINE_SHALLOW_COLOR;
        [bottomView addSubview:line2];
 
        
        NSArray * array = @[@"分享", @"价格调整", @"移除商品", @"点击下架"];
        for (int i = 0; i < array.count; i++) {
            UIButton * label = [[UIButton alloc] initWithFrame:CGRectMake(((UI_SCREEN_WIDTH - 3) / array.count + 1)  * i, 1, (UI_SCREEN_WIDTH - 3) / array.count+1, 39)];
            [label setTitle:array[i] forState:UIControlStateNormal];
            [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            label.backgroundColor = [UIColor colorFromHexCode:@"f7f7f7"];
            label.titleLabel.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];

            if (i == 0) {
                self.fiel = label;
            }
            if (i == 1) {
                self.jiage = label;
            }
            if (i == 3) {
                self.xiaJiaBtn = label;
            }
            if (i == 2) {
                self.cancelBtn = label;
            }
        }
     
        for (int i = 0; i < 3; i++) {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 3) / 4 * (i + 1), 11, 1, 15)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            [bottomView addSubview:line];
        }
    }
    return self;
}
- (void)updateWith:(NSDictionary *)dic
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
    [self.goodImageView af_setImageWithURL:url];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    self.originPriceLabel.text = [NSString stringWithFormat:@"商城价 ￥%@", [dic objectForKey:@"price"]];
    self.nowLabel.text = [NSString stringWithFormat:@"参考价￥%@", [dic objectForKey:@"F_Price"]];
    self.markPriceLabel.text = [NSString stringWithFormat:@"会员价￥%@", [dic objectForKey:@"gonghuoprice"]];
    self.yiLiLabel.text = [NSString stringWithFormat:@"佣金 ￥%@", [dic objectForKey:@"profit"]];
    self.lookLabel.text = [NSString stringWithFormat:@"浏览%@次", [dic objectForKey:@"chakan"]];
    self.saleLabel.text = [NSString stringWithFormat:@"已售%@件", [dic objectForKey:@"isbuy"]];
    self.iD = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    
    
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(self.titleLabel.frame.size.width, FLT_MAX)];
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, titleSize.height);
    recodeView.frame = CGRectMake(recodeView.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), recodeView.frame.size.width, recodeView.frame.size.height);
    bottomView.frame = CGRectMake(bottomView.frame.origin.x, CGRectGetMaxY(recodeView.frame), bottomView.frame.size.width, bottomView.frame.size.height);
    
    CGSize saleSize = [self.saleLabel sizeThatFits:CGSizeMake( FLT_MAX, self.saleLabel.frame.size.height)];
    self.saleLabel.frame = CGRectMake(self.saleLabel.frame.origin.x, self.saleLabel.frame.origin.y, saleSize.width, self.saleLabel.frame.size.height);
    
    CGSize lookSize = [self.lookLabel sizeThatFits:CGSizeMake( FLT_MAX, self.lookLabel.frame.size.height)];
    self.lookLabel.frame = CGRectMake(CGRectGetMaxX(self.saleLabel.frame)+15, self.lookLabel.frame.origin.y, lookSize.width, self.lookLabel.frame.size.height);
    
    
    
    NSString *isShow=[NSString stringWithFormat:@"%@",[dic valueForKey:@"isshow"]];
    if ([isShow isEqualToString:@"1"]) {
        [self.xiaJiaBtn setTitle:@"点击下架" forState:UIControlStateNormal];
        self.xiaJiaBtn.userInteractionEnabled=YES;
        [self.xiaJiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if([isShow isEqualToString:@"0"]){
        [self.xiaJiaBtn setTitle:@"点击上架" forState:UIControlStateNormal];
        self.xiaJiaBtn.userInteractionEnabled=YES;
        [self.xiaJiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.xiaJiaBtn setTitle:@"系统已下架" forState:UIControlStateNormal];
        self.xiaJiaBtn.userInteractionEnabled=NO;
        [self.xiaJiaBtn setTitleColor:SUB_TITLE forState:UIControlStateNormal];
    }
}

@end
