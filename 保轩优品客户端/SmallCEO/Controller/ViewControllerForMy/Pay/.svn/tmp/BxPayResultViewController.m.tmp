//
//  BxPayResultViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/22.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BxPayResultViewController.h"
#import "XMLDictionary.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PaymentResultViewController.h"
@interface BxPayResultViewController (){
    NSString *_status;
    NSString *_finishStr;
    UIButton *_payButton;
    UILabel *payPriceLabel;
    
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation BxPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payCancel:) name:@"payCancelNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:@"payFailNotification" object:nil];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 8.5, 14)];
    [leftButton addTarget:self action:@selector(handleLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"Button-fanhui@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self creationScrollView];
}

- (void)handleLeftItem {
    RCLAlertView *rclAlerView = [[RCLAlertView alloc]initWithTitle:nil contentText:@"您的订单尚未支付" leftButtonTitle:@"取消" rightButtonTitle:@"继续支付"];
    rclAlerView.leftBlock = ^(){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [rclAlerView show];
}

- (void)creationScrollView {
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64 - 80)];
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH * 180 / 375.0)];
    imageView.image = [UIImage imageNamed:@"payBackGound@2x"];
    [_mainScrollView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 30)];
    titleLabel.text = @"提交成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textColor = App_Main_Color;
    [imageView addSubview:titleLabel];
    
    
    NSString *total_money;
    if (_isVoucher) {
        total_money = self.total_money_coupon;
    }else {
        total_money = self.total_money;
    }
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + 10, UI_SCREEN_WIDTH, 20)];
    priceLabel.text = [NSString stringWithFormat:@"实付金额 %@", [total_money money]];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = Color3D4E56;
    [imageView addSubview:priceLabel];
    
    if (self.isVoucher) {
        priceLabel.text = @"现金+代金券";
        
        NSString *coupon = [NSString stringWithFormat:@"%@", self.total_money_coupon];
        UILabel *total_money_coupon = [[UILabel alloc] initWithFrame:CGRectMake(0, priceLabel.maxY + 4, UI_SCREEN_WIDTH, 20)];
        total_money_coupon.text = [NSString stringWithFormat:@"实付金额 %@", [coupon money]];
        total_money_coupon.textAlignment = NSTextAlignmentCenter;
        total_money_coupon.font = [UIFont systemFontOfSize:15];
        total_money_coupon.textColor = Color3D4E56;
        [imageView addSubview:total_money_coupon];
        
        NSString *moneyStr = [NSString stringWithFormat:@"%@", self.total_money];
        NSString *money1 = [NSString stringWithFormat:@"原价 %@", [moneyStr money]];
        UILabel *total_money = [[UILabel alloc] initWithFrame:CGRectMake(0, total_money_coupon.maxY + 4, UI_SCREEN_WIDTH, 20)];
        
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:money1];
        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,money1.length)];
        
        total_money.attributedText = attributeMarket;
        total_money.textAlignment = NSTextAlignmentCenter;
        total_money.font = [UIFont systemFontOfSize:14];
        total_money.textColor = Color74828B;
        [imageView addSubview:total_money];
    }
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.maxY, UI_SCREEN_WIDTH, 10)];
    line.backgroundColor = WHITE_COLOR2;
    [_mainScrollView addSubview:line];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, UI_SCREEN_WIDTH - 30, 30)];
    label.text = @"请选择支付方式";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = Color3D4E56;
    [view addSubview:label];
    
    CGFloat payViewY = label.maxY + 10;
    
    if (![self.payment_mode isKindOfClass:[NSArray class]] || self.payment_mode == nil) {
        return;
    }
    
    for (int i = 0; i < self.payment_mode.count; i++) {
        NSDictionary *dic = self.payment_mode[i];
        
        UIButton *payView = [[UIButton alloc] initWithFrame:CGRectMake(0, payViewY, UI_SCREEN_WIDTH, 76)];
        payView.backgroundColor = [UIColor whiteColor];
        payView.tag = i;
        [payView addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:payView];
        
        UIImageView *payIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 18, 40, 40)];
        [payIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]]];
        [payView addSubview:payIcon];
        
        UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(payIcon.maxY + 20, 23, UI_SCREEN_WIDTH, 30)];
        payLabel.text = dic[@"name"];
        payLabel.textAlignment = NSTextAlignmentLeft;
        payLabel.font = [UIFont systemFontOfSize:15];
        payLabel.textColor = Color3D4E56;
        [payView addSubview:payLabel];
        
        UIButton *seleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        seleButton.frame = CGRectMake(UI_SCREEN_WIDTH - 45, 28, 20, 20);
        seleButton.tag = 10 + i;
        [seleButton setImage:[UIImage imageNamed:@"CheckboxCopy@2x"] forState:UIControlStateNormal];
        [seleButton setImage:[UIImage imageNamed:@"Checkbox@2x"] forState:UIControlStateSelected];
        seleButton.userInteractionEnabled = NO;
        [payView addSubview:seleButton];
        
        if (i != self.payment_mode.count - 1) {
            [payView addLineWithY:75.5 X:15 width:UI_SCREEN_WIDTH - 30];
        }
        if (self.isVoucher) {
            if (![dic[@"name"] isEqualToString:@"金币"]) {
                payViewY = payView.maxY;
            }
            
        }else {
            payViewY = payView.maxY;
        }
        if ([dic[@"name"] isEqualToString:@"金币"]) {
            payPriceLabel = payLabel;
            [self getGold_num];
            
        }
    }
    
    view.frame = CGRectMake(0, line.maxY, UI_SCREEN_WIDTH, payViewY);
    _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, view.maxY);
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(15, _mainScrollView.maxY, UI_SCREEN_WIDTH - 30, 50);
    [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    _payButton.backgroundColor = ColorB0B8BA;
    _payButton.userInteractionEnabled = NO;
    [_payButton addTarget:self action:@selector(payButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payButton];
}

- (void)payButton {
    [self payButton1];
//    RCLAlertView *rclAlerView = [[RCLAlertView alloc]initWithTitle:App_Alert_Notice_Title contentText:@"确认支付" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
//    rclAlerView.rightBlock = ^(){
//        [self payButton1];
//    };
//    [rclAlerView show];
}

- (void)getGold_num {
    [RCLAFNetworking postWithUrl:@"myCenterApiNew.php" BodyString:@"field=gold_num" isPOST:YES success:^(id responseObject) {
        NSDictionary *user_info = responseObject[@"user_info"];
        
        NSString *user_gold = [NSString stringWithFormat:@"%@", user_info[@"gold_num"]];
        
        NSString *payString =  [NSString stringWithFormat:@"%@(剩余%@金币)", @"金币", user_gold];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:payString];
        NSRange range = [payString rangeOfString:[NSString stringWithFormat:@"(剩余%@金币)", user_gold]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
        [attr addAttribute:NSForegroundColorAttributeName value:ColorB0B8BA range:range];
        payPriceLabel.attributedText = attr;
    } fail:nil];
}



- (void)handleButton:(UIButton *)sender {
    _payButton.backgroundColor = App_Main_Color;
    _payButton.userInteractionEnabled = YES;
    
    UIButton *btn = [sender viewWithTag:10 + sender.tag];
    self.button.selected = !self.button.selected;
    self.button = btn;
    btn.selected = !btn.selected;
}

- (void)payButton1 {

    NSDictionary *dic = self.payment_mode[self.button.tag - 10];
    NSString *pay_method = [NSString stringWithFormat:@"%@", dic[@"type"]];//支付方式

    
    if (![pay_method isBlankString] || !self.button.selected) {
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
        return;
    }

    NSString *is_use_coupon; //是否使用代金券 1:使用代金券 0:没使用代金券
    if (self.isVoucher) {
        is_use_coupon = @"1";
    }else {
        is_use_coupon = @"0";
    }
    
    NSString *bodyStr = [NSString stringWithFormat:@"act=2&i_uid=%@&sum_money=%@&pay_money=%@&pay_method=%@&is_use_coupon=%@&use_coupon_number=%@", self.i_uid, self.total_money, self.total_money_coupon, pay_method, is_use_coupon, self.use_coupon_number];

    [RCLAFNetworking postWithUrl:@"userOffLinePayApiNew.php" BodyString:bodyStr isPOST:YES success:^(id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        self.dic = responseObject;
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([[dic allKeys] containsObject:@"sign_code"]) {
                [SVProgressHUD showSuccessWithStatus:@"正在前往支付宝进行支付"];
                [self paymentWithOrderSign:[responseObject objectForKey:@"sign_code"]];
            }else if([[dic allKeys] containsObject:@"pay_xml"]){
                //先判断微信是否安装或者支持
                if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
                    [SVProgressHUD showSuccessWithStatus:@"正在前往微信支付"];
                    [self sendWxPayWithDic:responseObject];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"请先安装微信"];
                }
            }else {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]];
                _status = @"支付成功";
                _finishStr = [responseObject valueForKey:@"info"];
                [self paymentResultViewController];
            }
        } else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
            _status = @"支付失败";
            _finishStr = [responseObject valueForKey:@"info"];
            [self paymentResultViewController];
        }
    } fail:nil];
}

- (void)sendWxPayWithDic:(NSDictionary *)dic; {
    NSDictionary *dic1 = [NSDictionary dictionaryWithXMLString:dic[@"pay_xml"]];
    PayReq *req             = [[PayReq alloc] init];
    req.openID              = [dic1 objectForKey:@"appid"];
    req.partnerId           = [dic1 objectForKey:@"partnerid"];
    req.prepayId            = [dic1 objectForKey:@"prepayid"];
    req.nonceStr            = [dic1 objectForKey:@"noncestr"];
    req.timeStamp           = [[dic1 objectForKey:@"timestamp"] integerValue];
    req.package             = [dic1 objectForKey:@"package"];
    req.sign                = [dic1 objectForKey:@"sign"];
    [WXApi sendReq:req];
}

#pragma mark - 微信支付

- (void)onResp:(BaseResp *)resp {
    //接收到微信的回调
    DLog(@"%@", resp);
    if (resp.errCode == WXSuccess) {
        //支付成功
        _status =  @"支付成功";
        [self paymentResultViewController];
    }else {
        _status = @"支付失败";
        _finishStr = resp.errStr;
        [self paymentResultViewController];
        //支付失败
        DLog(@"%@", resp.errStr);
    }
}

#pragma mark - 支付宝支付
- (void)paymentWithOrderSign:(NSString *)sign {//调用支付宝支付接口
    NSString *appScheme = @"baoxuan";//在info中urltypes中添加一条并设置Scheme 这样支付宝才能返回到当前应用中
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"result = %@",resultDic);
        NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        NSString *str = @"";
        if (resultDic) {
            if ([statusStr isEqualToString:@"9000"]) {
                NSLog(@"success!");
                str = @"支付成功";
                _status = str;
                [self paymentResultViewController];
                return ;
            }else if([statusStr isEqualToString:@"6001"]) {
                str = @"支付失败";
                _status = str;
                [self paymentResultViewController];
                return ;
            }else {
                str = @"支付失败";
                _status = str;
                [self paymentResultViewController];
                return ;
            }
        }else{
            str = @"支付宝连接失败";
            _status = @"支付失败";
            _finishStr = str;
            [self paymentResultViewController];
            NSLog(@"AlixPayResult_error1!");
        }
        
        UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alerTivew show];
    }];
}

- (void)paymentResultViewController {
    PaymentResultViewController *vc = [[PaymentResultViewController alloc] init];
    vc.resultStr = _status;
    vc.infoStr = _finishStr;
    vc.payMoney = self.dic;
    if (_isVoucher) {
        vc.money  = self.total_money_coupon;
    }else {
        vc.money  = self.total_money;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)paySuccess {
    _status = @"支付成功";
    [self paymentResultViewController];
}

- (void)payCancel:(NSNotification *)notification {
    _status = @"支付失败";
    NSDictionary *dic = notification.object;
    NSString *memo = [NSString stringWithFormat:@"%@", dic[@"memo"]];
    if ([memo isBlankString]) {
        _finishStr = memo;
    }
    [self paymentResultViewController];
}

- (void)payFail:(NSNotification *)notification {
    _status = @"支付失败";
    NSDictionary *dic = notification.object;
    NSString *memo = [NSString stringWithFormat:@"%@", dic[@"memo"]];
    if ([memo isBlankString]) {
        _finishStr = memo;
    }
    [self paymentResultViewController];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payFailNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payCancelNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
