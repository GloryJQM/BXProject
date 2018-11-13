//
//  PayResultViewController.m
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()

@property (nonatomic, strong) UIImageView *resultImageView;
@property (nonatomic, strong) UILabel *statusTextLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, strong) UIView *extraInfoView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    // Do any additional setup after loading the view.
    [self createNagivationBarView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIImageView *resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((topView.width - 80.0) / 2.0, 20.0, 80, 80)];
    resultImageView.image = [UIImage imageNamed:@"pho-zhuanzhangshibai.png"];
    [topView addSubview:resultImageView];
    self.resultImageView = resultImageView;
    
    UILabel *statusTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, resultImageView.maxY, topView.width, 40)];
    statusTextLabel.text = @"付款成功";
    statusTextLabel.textAlignment = NSTextAlignmentCenter;
    statusTextLabel.textColor = App_Main_Color;
    statusTextLabel.font = [UIFont systemFontOfSize:16.0];
    [topView addSubview:statusTextLabel];
    self.statusTextLabel = statusTextLabel;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statusTextLabel.maxY, topView.width, 40)];
    priceLabel.text = @"您账户当前余额不足";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = App_Main_Color;
    priceLabel.font = [UIFont systemFontOfSize:16.0];
    [topView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    topView.height = priceLabel.maxY;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.maxY - 0.5, topView.width, 0.5)];
    lineView.backgroundColor = SUB_TITLE;
    [topView addSubview:lineView];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(15.0, topView.maxY + 25.0, UI_SCREEN_WIDTH - 30.0, 50.0);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.backgroundColor = App_Main_Color;
    finishButton.layer.cornerRadius = finishButton.height / 2.0;
    [finishButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNagivationBarView
{
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账单详情" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(lookBillDetails)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
}

#pragma mark -
- (void)lookBillDetails
{
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter
- (UIView *)extraInfoView
{
    if (!_extraInfoView)
    {
        _extraInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.maxY, UI_SCREEN_WIDTH, 40.0)];
        _extraInfoView.backgroundColor = [UIColor whiteColor];
        
        CGFloat labelWidth = (_extraInfoView.width - 30.0) / 2.0;
        UILabel *storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, labelWidth, _extraInfoView.height)];
        storeNameLabel.text = @"张伟的店铺";
        storeNameLabel.font = [UIFont systemFontOfSize:16.0];
        [_extraInfoView addSubview:storeNameLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(storeNameLabel.maxX, 0, labelWidth, _extraInfoView.height)];
        timeLabel.text = @"交易时间 2017-02-22";
        timeLabel.font = [UIFont systemFontOfSize:16.0];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [_extraInfoView addSubview:timeLabel];
    }
    
    return _extraInfoView;
}

#pragma mark - Setter
- (void)setPaySucceed:(BOOL)paySucceed
{
    _paySucceed = paySucceed;
    NSString *imageStr = paySucceed ? @"pho-zhuanzhangchenggong.png" : @"pho-zhuanzhangshibai.png";
    self.resultImageView.image = [UIImage imageNamed:imageStr];
    self.statusTextLabel.text = paySucceed ? @"付款成功" : @"付款失败";
    
    if (paySucceed)
    {
        [self.view addSubview:self.extraInfoView];
        self.finishButton.y = self.extraInfoView.maxY + 25.0;
    }
}

- (void)setPriceStr:(NSString *)priceStr
{
    _priceStr = priceStr;
    self.priceLabel.text = priceStr;
}

@end
