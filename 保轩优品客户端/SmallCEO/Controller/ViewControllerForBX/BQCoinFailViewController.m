//
//  TradeDetailViewController.m
//  Price
//
//  Created by 俊严 on 17/2/28.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import "BQCoinFailViewController.h"
//#import "UIColor+FlatUI.h"

@interface BQCoinFailViewController ()
@property (nonatomic, strong)UILabel * coinStaticLabel;
@end

@implementation BQCoinFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"交易详情";
    
    UIImageView*detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-54, 25+64, 108, 108)];
    detailImageView.image = [UIImage imageNamed:@"pho-zhuanzhangshibai@2x"];
    //detailImageView.backgroundColor = [UIColor grayColor];
    detailImageView.layer.cornerRadius = 54;
    [self.view addSubview:detailImageView];
    
    _coinStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailImageView.frame)+24, self.view.frame.size.width, 20)];
    _coinStaticLabel.text = [NSString stringWithFormat:@"%@转出失败",_type];
    _coinStaticLabel.textAlignment = NSTextAlignmentCenter;
    _coinStaticLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_coinStaticLabel];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton*actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(23+(((self.view.frame.size.width-46-13)/2+13)*i), CGRectGetMaxY(_coinStaticLabel.frame)+29, (self.view.frame.size.width-46-13)/2, 40);
        [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        actionBtn.layer.cornerRadius = 5;
        actionBtn.clipsToBounds = YES;
        [self.view addSubview:actionBtn];
        
        if (i == 0) {
            actionBtn.backgroundColor = [UIColor colorFromHexCode:@"01126a"];
            [actionBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
            [actionBtn setTitle:@"再试一次" forState:UIControlStateNormal];
        }else if ( i == 1){
            actionBtn.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
            [actionBtn addTarget:self action:@selector(popTwice) forControlEvents:UIControlEventTouchUpInside];
            [actionBtn setTitle:@"返回" forState:UIControlStateNormal];
        }
    }
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)popTwice {
    UIViewController * viewVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
    [self.navigationController popToViewController:viewVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
