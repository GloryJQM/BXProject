//
//  BQCoinSuccessViewController.m
//  Price
//
//  Created by 俊严 on 17/2/28.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import "BQCoinSuccessViewController.h"
#import "UIColor+FlatUI.h"
@interface BQCoinSuccessViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong)UILabel * coinStaticLabel;


@end

@implementation BQCoinSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"交易详情";
    [self creatMainView];
}

- (void)creatMainView
{
    UIImageView*detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-105/2, 50, 105, 105)];
    detailImageView.image = [UIImage imageNamed:@"pho-zhuanzhangchenggong@2x"];
    //detailImageView.backgroundColor = [UIColor grayColor];
    detailImageView.layer.cornerRadius = 105/2;
    [self.view addSubview:detailImageView];
    
    _coinStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailImageView.frame)+12, self.view.frame.size.width, 20)];
    _coinStaticLabel.text = [NSString stringWithFormat:@"%@转出成功",_type];
    _coinStaticLabel.textAlignment = NSTextAlignmentCenter;
    _coinStaticLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_coinStaticLabel];
    
    UIView*coinDetailView = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_coinStaticLabel.frame)+12, self.view.frame.size.width-24, 180)];
    coinDetailView.layer.cornerRadius   = 5;
    coinDetailView.clipsToBounds = YES;
    coinDetailView.layer.borderColor = [UIColor colorFromHexCode:@"c8c8c8"].CGColor;
    coinDetailView.layer.borderWidth = 0.5;
    [self.view addSubview:coinDetailView];
    
    NSArray*detailArray = @[@"转出人",@"转入人",@"时间"];
    NSArray*coinDetailArray = @[_dataDic[@"o_username"],_dataDic[@"i_username"],_dataDic[@"log_time"]];
    for (int i = 0; i < detailArray.count; i++) {
        UIView*backView = [[UIView alloc] initWithFrame:CGRectMake(0, 60*i, coinDetailView.frame.size.width, 60)];
        
        [coinDetailView addSubview:backView];
        
        UILabel*detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, coinDetailView.frame.size.width/3-0.5, 59.5)];
        detailLabel.text = detailArray[i];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.textColor = [UIColor colorFromHexCode:@"000000"];
        [backView addSubview:detailLabel];
        
        UILabel*coinDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(coinDetailView.frame.size.width/3, 0, coinDetailView.frame.size.width*2/3, 59.5)];
        coinDetailLabel.text = coinDetailArray[i];
        coinDetailLabel.font = [UIFont systemFontOfSize:14];
        coinDetailLabel.textAlignment = NSTextAlignmentCenter;
        coinDetailLabel.textColor = [UIColor colorFromHexCode:@"000000"];
        [backView addSubview:coinDetailLabel];
        
        UILabel*hengLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 59.5, coinDetailView.frame.size.width-10, 0.5)];
        hengLine.backgroundColor = [UIColor colorFromHexCode:@"c8c8c8"];
        [backView addSubview:hengLine];
        if (i == detailArray.count-1) {
            hengLine.hidden = YES;
        }
        
        UILabel*shuLine = [[UILabel alloc] initWithFrame:CGRectMake(coinDetailView.frame.size.width/3, 20, 0.5, 20)];
        shuLine.backgroundColor = [UIColor colorFromHexCode:@"c8c8c8"];
        [backView addSubview:shuLine];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
