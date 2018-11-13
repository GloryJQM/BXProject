//
//  PayOrderViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PayOrderViewController.h"
#import "XMLDictionary.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PaymentResultViewController.h"
@interface PayOrderViewController (){
    NSString *_status;
    NSString *_finishStr;
    UIButton *_payButton;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, copy) NSString *order_id;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payCancel:) name:@"payCancelNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:@"payFailNotification" object:nil];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 8.5, 14)];
    [leftButton addTarget:self action:@selector(handleLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"Button-fanhui@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (![self.user_points isBlankString]) {
        self.user_points = @"0";
    }
    
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
    titleLabel.text = @"订单提交成功";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textColor = App_Main_Color;
    [imageView addSubview:titleLabel];
    
    
    NSString *total_money;
    if (_isVoucher) {
        total_money = [NSString stringWithFormat:@"%@", self.dataDic[@"total_money_coupon"]];
    }else {
        total_money = [NSString stringWithFormat:@"%@", self.dataDic[@"total_money"]];
    }
    
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + 10, UI_SCREEN_WIDTH, 20)];
    if (self.freight > 0) {
        priceLabel.text = [NSString stringWithFormat:@"实付金额 %@(运费¥%.2f)", [total_money moneyPoint:self.is_point_type], self.freight];
    }else {
        priceLabel.text = [NSString stringWithFormat:@"实付金额 %@", [total_money moneyPoint:self.is_point_type]];
    }
    
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = Color74828B;
    [imageView addSubview:priceLabel];
    
    if (self.isVoucher) {
        priceLabel.text = @"现金+代金券";
        
        NSString *coupon = [NSString stringWithFormat:@"%@", self.dataDic[@"total_money_coupon"]];
        UILabel *total_money_coupon = [[UILabel alloc] initWithFrame:CGRectMake(0, priceLabel.maxY + 4, UI_SCREEN_WIDTH, 20)];
        total_money_coupon.text = [NSString stringWithFormat:@"实付金额 %@", [coupon money]];
        total_money_coupon.textAlignment = NSTextAlignmentCenter;
        total_money_coupon.font = [UIFont systemFontOfSize:15];
        total_money_coupon.textColor = Color74828B;
        [imageView addSubview:total_money_coupon];
        
        NSString *money = [NSString stringWithFormat:@"%@", self.dataDic[@"total_money"]];
        NSString *moneyStr = [NSString stringWithFormat:@"原价 %@", [money money]];
        UILabel *total_money = [[UILabel alloc] initWithFrame:CGRectMake(0, total_money_coupon.maxY + 4, UI_SCREEN_WIDTH, 20)];
        NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,moneyStr.length)];
        
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
    
    
    CGFloat payViewY = 0;
    if (self.is_point_type == 1 && self.freight > 0) {
        
    }else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, UI_SCREEN_WIDTH - 30, 30)];
        label.text = @"请选择支付方式";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = Color3D4E56;
        [view addSubview:label];
        
        payViewY = label.maxY + 10;
    }
    
    
    NSArray *payment_modeAry = self.dataDic[@"payment_mode"];
    
    NSInteger index;
    if (self.is_point_type == 1) {
        index = self.freight > 0 ? payment_modeAry.count : 1;
    }else {
        index = payment_modeAry.count;
    }
    
    if (index == 1) {
        payViewY = 0;
    }
    
    for (int i = 0; i < index; i++) {
        NSDictionary *dic = payment_modeAry[i];
        
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
        
        if (i != payment_modeAry.count - 1) {
            [payView addLineWithY:75.5 X:15 width:UI_SCREEN_WIDTH - 30];
        }
        if (self.isVoucher) {
            if (![dic[@"name"] isEqualToString:@"金币"]) {
                payViewY = payView.maxY;
            }
            
        }else {
            payViewY = payView.maxY;
        }
        
        if (self.is_point_type == 1 && [dic[@"name"] isEqualToString:@"积分"]) {
            seleButton.hidden = YES;
            
            NSString *payString =  [NSString stringWithFormat:@"%@(剩余%@)", dic[@"name"], [self.user_points moneyPoint:self.is_point_type]];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:payString];
            NSRange range = [payString rangeOfString:[NSString stringWithFormat:@"(剩余%@)", [self.user_points moneyPoint:self.is_point_type]]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
            [attr addAttribute:NSForegroundColorAttributeName value:ColorB0B8BA range:range];
            payLabel.attributedText = attr;
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, payView.maxY, UI_SCREEN_WIDTH, 10)];
            line.backgroundColor = WHITE_COLOR2;
            [view addSubview:line];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 130, 23, 105, 30)];
            priceLabel.text = [NSString stringWithFormat:@"%@", total_money];
            priceLabel.textAlignment = NSTextAlignmentRight;
            priceLabel.font = [UIFont systemFontOfSize:15];
            priceLabel.textColor = Color3D4E56;
            [payView addSubview:priceLabel];
            
            payView.userInteractionEnabled = NO;
            
            payViewY = line.maxY + 10;
            if (self.is_point_type == 1 && self.freight > 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, line.maxY + 10, UI_SCREEN_WIDTH - 30, 30)];
                label.text = @"请选择运费支付方式";
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = Color3D4E56;
                [view addSubview:label];
                
                payViewY = label.maxY;
            }
            
            
        }else if ([dic[@"name"] isEqualToString:@"金币"]) {
            NSString *payString =  [NSString stringWithFormat:@"%@(剩余%@金币)", dic[@"name"], self.user_points];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:payString];
            NSRange range = [payString rangeOfString:[NSString stringWithFormat:@"(剩余%@金币)", self.user_points]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
            [attr addAttribute:NSForegroundColorAttributeName value:ColorB0B8BA range:range];
            payLabel.attributedText = attr;
        }
        
        if (index == 1) {
            self.button = seleButton;
        }
        
    }
    
    view.frame = CGRectMake(0, line.maxY, UI_SCREEN_WIDTH, payViewY);
    _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, view.maxY);
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(15, _mainScrollView.maxY, UI_SCREEN_WIDTH - 30, 50);
    [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    if (index > 1) {
        _payButton.backgroundColor = ColorB0B8BA;
        _payButton.userInteractionEnabled = NO;
    }else {
        _payButton.backgroundColor = App_Main_Color;
        _payButton.userInteractionEnabled = YES;
    }
    
    [_payButton addTarget:self action:@selector(payButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payButton];
}

- (void)handleButton:(UIButton *)sender {
    _payButton.backgroundColor = App_Main_Color;
    _payButton.userInteractionEnabled = YES;

    UIButton *btn = [sender viewWithTag:10 + sender.tag];
    self.button.selected = !self.button.selected;
    self.button = btn;
    btn.selected = !btn.selected;
}

- (void)payButton {
//    RCLAlertView *rclAlerView = [[RCLAlertView alloc]initWithTitle:App_Alert_Notice_Title contentText:@"确认支付" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
//    rclAlerView.rightBlock = ^(){
//        [self payButton1];
//    };
//    [rclAlerView show];
    [self payButton1];
}

- (void)payButton1 {
    
    NSArray *payment_modeAry = self.dataDic[@"payment_mode"];
    NSDictionary *dic = payment_modeAry[self.button.tag - 10];

    NSString *receiving_method = [NSString stringWithFormat:@"%ld", (long)self.receiving_method]; //提货方式 1:到店取货 2:快递
    NSString *pay_method = [NSString stringWithFormat:@"%@", dic[@"type"]];//支付方式
    NSString *goods_attr_ids = self.goods_attr_ids;
    

    NSString *bodyStr;
    if (self.isShopCart) {
      bodyStr = [NSString stringWithFormat:@"act=2&receiving_method=%@&contacts_id=%@&pay_method=%@&is_invoice=0&ids=%@&goods_id=%@&goods_num=%ld&use_coupon=%@&is_point_type=%ld", receiving_method,self.contacts_id,pay_method,goods_attr_ids,self.goods_id, (long)self.goods_num, self.use_coupon,(long)self.is_point_type];
    }else {
       bodyStr = [NSString stringWithFormat:@"act=1&receiving_method=%@&contacts_id=%@&pay_method=%@&is_invoice=0&goods_attr_ids=%@&goods_id=%@&goods_num=%ld&use_coupon=%@&is_point_type=%ld", receiving_method,self.contacts_id,pay_method,goods_attr_ids,self.goods_id, (long)self.goods_num,self.use_coupon,(long)self.is_point_type];
    }
    
    NSString *body;
    if (self.order_id.length > 0 && [self.order_id isBlankString]) {
        body = [NSString stringWithFormat:@"act=3&order_id=%@&pay_method=%@", self.order_id,pay_method];
    }else {
        body = bodyStr;
    }
    
    [RCLAFNetworking postWithUrl:@"payOrderApiNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        self.dic = responseObject;
        self.order_id = [NSString stringWithFormat:@"%@", responseObject[@"order_id"]];
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

- (void)paymentResultViewController {
    PaymentResultViewController *vc = [[PaymentResultViewController alloc] init];
    vc.resultStr = _status;
    vc.infoStr = _finishStr;
    vc.payMoney = self.dic;
    vc.is_point_type = self.is_point_type;
    [self.navigationController pushViewController:vc animated:YES];
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
