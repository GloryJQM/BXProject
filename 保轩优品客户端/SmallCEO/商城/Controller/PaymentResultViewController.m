//
//  PaymentResultViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/15.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PaymentResultViewController.h"
#import "OrderViewController.h"
#import "BillsViewController.h"
#import "ProductDetailsViewController.h"
@interface PaymentResultViewController ()
@property (nonatomic, strong) NSArray *buttonTitleAry;
@property (nonatomic, strong) UIView *backView;
@end

@implementation PaymentResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    self.view.backgroundColor = backWhite;
    [self creatView];
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)creatView {
    self.backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    UIImageView * finishImageView = [[UIImageView alloc] init];
    finishImageView.frame = CGRectMake((UI_SCREEN_WIDTH - 44)/2.0, 20, 44, 44);
    [_backView addSubview:finishImageView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, finishImageView.maxY + 12, UI_SCREEN_WIDTH, 20)];
    priceLabel.textAlignment=NSTextAlignmentCenter;
    NSString *pay_number = [NSString stringWithFormat:@"%@", self.payMoney[@"pay_number"]];
    priceLabel.text = [NSString stringWithFormat:@"%@", [pay_number moneyPoint:self.is_point_type]];
    priceLabel.textColor = Color161616;
    priceLabel.font = [UIFont boldSystemFontOfSize:20];
    [_backView addSubview:priceLabel];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, priceLabel.maxY + 3, UI_SCREEN_WIDTH - 30, 20)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = Color161616;
    statusLabel.font = [UIFont systemFontOfSize:15];
    statusLabel.text = self.resultStr;
    [_backView addSubview:statusLabel];
    
    UILabel *finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statusLabel.maxY + 30, UI_SCREEN_WIDTH, 30)];
    finishLabel.textAlignment=NSTextAlignmentCenter;
    finishLabel.text = self.infoStr;
    finishLabel.textColor = [UIColor colorFromHexCode:@"#74838b"];
    finishLabel.font = [UIFont systemFontOfSize:15];
    [_backView addSubview:finishLabel];
    
    if ([self.resultStr isEqualToString:@"支付失败"]) {
        self.buttonTitleAry = @[@"返回首页", @"继续支付"];
        finishLabel.text = self.infoStr;
        finishImageView.image = [UIImage imageNamed:@"logo_failpay.png"];
        [self creationButton:finishLabel.maxY + 70];
    }else if ([self.resultStr isEqualToString:@"支付成功"]) {
        
        if ([[NSString stringWithFormat:@"%@", self.payMoney[@"is_rebate"]] isEqualToString:@"1"]) {
            finishLabel.text = @"------  本次消费获得  ------";
            
            CGFloat maxY = finishLabel.maxY + 34;
            NSArray *array = self.payMoney[@"fanli_msg"];
            if ([array isBlankArray]) {
                for (int i = 0; i < array.count; i++) {
                    NSDictionary *dic = array[i];
                    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, maxY, 40, 20)];
                    pointLabel.text = [NSString stringWithFormat:@"%@", dic[@"title"]];
                    pointLabel.font = [UIFont systemFontOfSize:12];
                    pointLabel.textColor = App_Main_Color;
                    pointLabel.layer.cornerRadius = 1;
                    pointLabel.layer.masksToBounds = YES;
                    pointLabel.layer.borderWidth = 1;
                    pointLabel.layer.borderColor = App_Main_Color.CGColor;
                    pointLabel.textAlignment = NSTextAlignmentCenter;
                    [_backView addSubview:pointLabel];
                    
                    UILabel *point = [[UILabel alloc] initWithFrame:CGRectMake(pointLabel.maxX , pointLabel.minY, UI_SCREEN_WIDTH - 25 - pointLabel.maxX, 20)];
                    point.textAlignment = NSTextAlignmentRight;
                    point.font = [UIFont systemFontOfSize:14];
                    point.text = [NSString stringWithFormat:@"%@", dic[@"content"]];;
                    point.textColor = Color74828B;
                    [_backView addSubview:point];
                    
                    maxY = pointLabel.maxY + 18;
                }
            }
           

            [_backView addLineWithY:maxY + 16];
            
            self.buttonTitleAry = @[@"返回首页", @"查看消费详情"];
            finishImageView.image = [UIImage imageNamed:@"s_payFinish.png"];
            [self creationButton:maxY + 66];
        }else {
            finishLabel.hidden = YES;
            self.buttonTitleAry = @[@"返回首页", @"查看消费详情"];
            finishImageView.image = [UIImage imageNamed:@"s_payFinish.png"];
            [self creationButton:finishLabel.maxY + 70];
        }
        
    }else if ([self.resultStr isEqualToString:@"交易取消"]) {
        self.buttonTitleAry = @[@"返回首页", @"继续支付"];
        finishLabel.hidden = YES;
        finishImageView.image = [UIImage imageNamed:@"logo_failpay.png"];
        [self creationButton:finishLabel.maxY + 70];
    }
}

- (void)creationButton:(CGFloat)y {
    CGFloat width  = (UI_SCREEN_WIDTH - 90) / 2;
    CGFloat space = 30;
    CGFloat maxY = y;
    for (int i = 0; i < self.buttonTitleAry.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(space, y, width, 40)];
        [button setTitle:self.buttonTitleAry[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = App_Main_Color.CGColor;
        button.layer.borderWidth = 0.5;
        [button setTitleColor:App_Main_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:button];
        space = button.maxX + 30;
        maxY = button.maxY;
    }
    
    _backView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, maxY + 20);
    
    if ([self.resultStr isEqualToString:@"支付成功"]) {
        if ([[NSString stringWithFormat:@"%@", self.payMoney[@"is_luckydraw"]] isEqualToString:@"1"]) {
            UIButton * drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            drawBtn.frame = CGRectMake(0, _backView.maxY + 16, UI_SCREEN_WIDTH, 100);
            [drawBtn setImage:[UIImage imageNamed:@"立即抽奖@2x.png"] forState:UIControlStateNormal];
            [drawBtn addTarget:self action:@selector(handleDrawBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:drawBtn];
        }
    }
}

- (void)handleButton:(UIButton *)sender {
    NSString *titleStr = [sender currentTitle];
    if ([titleStr isEqualToString:@"查看订单"]) {
        OrderViewController * orderVC = [[OrderViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else if ([titleStr isEqualToString:@"继续支付"]){
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([titleStr isEqualToString:@"查看消费详情"]){
        
        NSMutableArray *array = [NSMutableArray array] ;
        [array addObject:self.navigationController.viewControllers.firstObject];
        
        BillsViewController *bill = [[BillsViewController alloc]init];
        [array addObject:bill];
        [self.navigationController setViewControllers:array animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)handleDrawBtn:(UIButton *)sender {
    NSMutableArray *array = [NSMutableArray array] ;
    [array addObject:self.navigationController.viewControllers.firstObject];
    ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
    [array addObject:viewController];
    [self.navigationController setViewControllers:array animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@", self.payMoney[@"award_url"]];
    [viewController loadWebView:urlStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
