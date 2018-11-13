//
//  UnderlinePayViewController.m
//  SmallCEO
//
//  Created by ni on 16/5/25.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "UnderlinePayViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "payRequsestHandler.h"
#import "ThirdPartMacros.h"
#import "WXApi.h"
#import "UPPayHelper.h"
#import "MaskViewForUITextField.h"
#import "ChargeSuccessViewController.h"
#import "EditPwdWithOldPwdViewController.h"
#import "PayPasswordInputView.h"
#import "UnderLinePaySuccessViewController.h"
#import "Order.h"
typedef NS_ENUM(NSUInteger, PayMehod)
{
    PayMehodNone = 0,
    PayMehodBalancePay,
    PayMehodAliPay,
    PayMehodWxPay,
    PayMehodUnionPay
};

@interface UnderlinePayViewController () <UITextFieldDelegate,UPPayPluginDelegate,PayPasswordInputViewDelegate>
{
    UIScrollView *mainScrollView;
    UITextField *moneytextF;
    
}

@property (nonatomic, copy)    NSString *payPassword;
@property (nonatomic ,strong)  NSMutableArray *btns;
@property (nonatomic ,strong)  UILabel  *moneyRelativeLabel;
@property (nonatomic, assign)  PayMehod payMethod;
/** orderID */
@property (nonatomic, copy)    NSString *orderId;
/** orderPrice */
@property (nonatomic, copy)    NSString *orderPrice;

@end


@implementation UnderlinePayViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f8f8f8"];
    self.title = @"超市结算";
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeSuccess) name:@"paySuccessNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeCancel) name:@"payCancelNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chargeFail) name:@"payFailNotification" object:nil];
    
    self.btns = [NSMutableArray new];
    self.payMethod = PayMehodBalancePay;

    
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainScrollView.backgroundColor = [UIColor colorFromHexCode:@"f8f8f8"];
    [self.view addSubview:mainScrollView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKeyBoard)];
    [mainScrollView addGestureRecognizer:tap];

    
    UIView *moneyBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 49.0)];
    moneyBackView.backgroundColor=[UIColor whiteColor];
    [mainScrollView addSubview:moneyBackView];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 49.0)];
    lable.textColor=Red_Color;
    lable.font=[UIFont systemFontOfSize:15];
    lable.text=@"支付金额";
    lable.backgroundColor=[UIColor clearColor];
    [moneyBackView addSubview:lable];
    
    moneytextF=[[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-15-200, 0, 200, 49.0)];
    [moneytextF setBorderStyle:UITextBorderStyleNone];
    moneytextF.delegate=self;
    moneytextF.backgroundColor=[UIColor clearColor];
    moneytextF.textColor=[UIColor blackColor];
    moneytextF.placeholder=@"请输入金额";
    moneytextF.textAlignment=NSTextAlignmentRight;
    moneytextF.keyboardType=UIKeyboardTypeDecimalPad;
    [moneyBackView addSubview:moneytextF];
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
    warningLabel.font = [UIFont systemFontOfSize:14.0];
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.text = @"轻触灰色区域隐藏键盘";
    warningLabel.textColor = [UIColor whiteColor];
    moneytextF.inputAccessoryView = warningLabel;
    
    for (int i=0; i<2; i++) {
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 48.5*i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor=LINE_SHALLOW_COLOR;
        [moneyBackView addSubview:line];
    }
    
    NSArray *payMethodArr=@[@"使用余额支付",@"微信支付",@"支付宝",@"银联支付"];
    NSArray *imageArr=@[@"gj_wechat0.png",@"gj_zhifubao.png",@"icon-unionpay.png"];
    
    UIView *payChoseView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyBackView.frame), UI_SCREEN_WIDTH, (payMethodArr.count+1)*50)];
    payChoseView.backgroundColor=[UIColor whiteColor];
    [mainScrollView addSubview:payChoseView];
    [payChoseView addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *choseLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 49.0)];
    choseLable.textColor=[UIColor darkGrayColor];
    choseLable.font=[UIFont systemFontOfSize:15];
    choseLable.text=@"支付方式";
    choseLable.backgroundColor=[UIColor clearColor];
    [payChoseView addSubview:choseLable];
    
    for (int i=0; i<payMethodArr.count; i++) {
        UIView *tView=[[UIView alloc] initWithFrame:CGRectMake(0, 49.0+50*i, UI_SCREEN_WIDTH, 50)];
        tView.backgroundColor=[UIColor whiteColor];
        tView.tag = i;
        [payChoseView addSubview:tView];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chosePay:)];
        [tView addGestureRecognizer:tap];

        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(75, 0, 100, 49.0)];
        lable.textColor=[UIColor darkGrayColor];
        lable.font=[UIFont systemFontOfSize:13.0];
        lable.text=payMethodArr[i];
        lable.backgroundColor=[UIColor clearColor];
        [tView addSubview:lable];
        
        UIButton *choseBtn=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-15-18, 16, 18, 18)];
        choseBtn .backgroundColor=[UIColor clearColor];
        choseBtn.layer.cornerRadius=0;
        [choseBtn setImage:[UIImage imageNamed:@"gj_pay_is.png"] forState:UIControlStateSelected];
        [choseBtn setImage:[UIImage imageNamed:@"gj_pay_uns.png"] forState:UIControlStateNormal];
        choseBtn.userInteractionEnabled = NO;
        choseBtn.tag = i;
        [tView addSubview:choseBtn];
        [self.btns addObject:choseBtn];
        
        if (i == 0) {
            lable.frame=CGRectMake(32, 15, 90, 20);
            choseBtn.selected=YES;
            UILabel *moneyRelativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(32 + 90, 15, UI_SCREEN_WIDTH /2-20, 20)];
            moneyRelativeLabel.textAlignment = NSTextAlignmentRight;
            moneyRelativeLabel.font = [UIFont systemFontOfSize:13.0];
            moneyRelativeLabel.text = i == 0 ? [NSString stringWithFormat:@"可用余额%.2f元", self.userBalanceValue] : @"";
            moneyRelativeLabel.textColor = choseBtn.selected ? Red_Color : [UIColor colorFromHexCode:@"8e8e93"];
            [tView addSubview:moneyRelativeLabel];
            self.moneyRelativeLabel = moneyRelativeLabel;
        }else {
            UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(32, 12.5, 25, 25)];
            imageV.backgroundColor=[UIColor clearColor];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            imageV.layer.cornerRadius=0;
            imageV.image=[UIImage imageNamed:imageArr[i-1]];
            [tView addSubview:imageV];
        }

        
        if (i==1) {
            lable.frame = CGRectMake(75, 7, 100, 20);
            UILabel *commentInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 27, UI_SCREEN_WIDTH-75-55, 15)];
            commentInfoLabel.text = @"推荐安装微信5.0及以上版本使用";
            commentInfoLabel.font = [UIFont systemFontOfSize:10.0];
            commentInfoLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
            [tView addSubview:commentInfoLabel];
        }
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH-15, 0.5)];
        line.backgroundColor=LINE_SHALLOW_COLOR;
        [tView addSubview:line];
    }
    
    for (int i = 0; i < 2; i ++) {
        UIView *bottomline=[[UIView alloc] initWithFrame:CGRectMake(0, payChoseView.frame.size.height*i, UI_SCREEN_WIDTH, 0.5)];
        bottomline.backgroundColor=LINE_SHALLOW_COLOR;
        [payChoseView addSubview:bottomline];
    }
    
    
    UIButton *chargeBtn=[[UIButton alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(payChoseView.frame)+50*adapterFactor, UI_SCREEN_WIDTH-49.0, 44)];
    chargeBtn.backgroundColor=App_Main_Color;
    chargeBtn.layer.cornerRadius=5;
    chargeBtn.layer.masksToBounds=YES;
    [chargeBtn addTarget:self action:@selector(chargeUp) forControlEvents:UIControlEventTouchUpInside];
    [chargeBtn setTitle:@"支付" forState:UIControlStateNormal];
    [chargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainScrollView addSubview:chargeBtn];
    
    
    mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, CGRectGetMaxY(payChoseView.frame)+50*adapterFactor+44+30+64);
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestPayPwdSettingsStatus];
}
-(void)chosePay:(id)sender {
    UIView* vi = (UIView*)[sender view];
    for(UIButton* btn in self.btns)
    {
        if(btn.tag == vi.tag)
        {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
    }
    UIButton *balancePayBtn=[self.btns objectAtIndex:0];
    UIButton *wxPayBtn=[self.btns objectAtIndex:1];
    UIButton *aliPayBtn=[self.btns objectAtIndex:2];
    UIButton *unionPayBtn=[self.btns objectAtIndex:3];
    
    if (balancePayBtn.selected)
    {
        self.payMethod = PayMehodBalancePay;
    }
    if (aliPayBtn.selected)
    {
        self.payMethod = PayMehodAliPay;
    }
    if (wxPayBtn.selected)
    {
        self.payMethod = PayMehodWxPay;
    }
    if (unionPayBtn.selected)
    {
        self.payMethod = PayMehodUnionPay;
    }
    
    _moneyRelativeLabel.textColor = balancePayBtn.selected ? Red_Color : [UIColor colorFromHexCode:@"8e8e93"];

}


-(void)missKeyBoard{
    [self.view endEditing:YES];
}


-(void)chargeUp
{
    if ([moneytextF.text isEqualToString:@""])
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (moneytextF.text.length != 0 &&
        (moneytextF.text.doubleValue == 0||
         moneytextF.text.doubleValue > 1000000))
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"输入的金额有误(大于0，小于100万)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    NSString * littleNumStr = [NSString stringWithFormat:@"%@",[[moneytextF.text componentsSeparatedByString:@"."] lastObject]];
    if ([moneytextF.text rangeOfString:@"."].length > 0 && littleNumStr.length > 2)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"输入的金额有误,最多2位有效小数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        moneytextF.text = @"";
        return;
    }
    [self chargeVerify];
    
}
#pragma mark - 添加订单
- (void)chargeVerify {
    
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"charge/verify.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *body = [NSString stringWithFormat:@"count=1&price=%@",moneytextF.text];

    DLog(@"body:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject: %@", responseObject);
        NSDictionary* item = (NSDictionary *)responseObject;
        NSString *status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD dismiss];
            _orderId=[NSString stringWithFormat:@"%@",[item objectForKey:@"order_id"]];
            _orderPrice=[NSString stringWithFormat:@"%@",[item objectForKey:@"price"]];
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"订单编号：%@",[item objectForKey:@"order_id"]]  message:[NSString stringWithFormat:@"支付金额：%@",[item objectForKey:@"price"]] delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
            [alerView show];
            alerView.tag = 300;
        }else {
            if ([responseObject valueForKey:@"info"] != nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",operation.responseString);
        if (operation.response.statusCode != 200) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }else {
            [SVProgressHUD dismiss];
        }
    }];
    [op start];
}
#pragma mark - 获取支付密码设置状态
- (void)requestPayPwdSettingsStatus {
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_pay_password.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=status"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               [SVProgressHUD dismiss];
                               
                               if ([returnState isEqualToString:@"1"])
                               {
                                   /*
                                   PayPasswordInputView *inputView = [[PayPasswordInputView alloc] init];
                                   inputView.delegate = self;
                                   [inputView showInView:self.view];
                                    */
                               }
                               else
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"你还未设置支付密码,请先前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                   alertView.tag = 100;
                                   [alertView show];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}
#pragma mark - PayPasswordInputViewDelegate
- (void)inputView:(PayPasswordInputView *)inputView doClickButtonWithType:(ButtonType)type withPassword:(NSString *)password {
    if (type == ButtonTypePay)
    {
        _payPassword = password;
        [self balancePay];
    }
    else if (type == ButtonTypeForgetPassword)
    {
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPassword;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if ( buttonIndex == 1 ) {
            EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
            editPwdVC.type = EditPasswordTypePayPasswordWithoutVerifyCode;
            editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
            [self.navigationController pushViewController:editPwdVC animated:YES];
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }else if (alertView.tag == 300) {
        if (buttonIndex == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
        
        if (self.payMethod == PayMehodAliPay)
        {
            [self commitorder];
        }
        else if(self.payMethod == PayMehodWxPay)
        {
            [self WXPayOrder:_orderPrice orderid:_orderId];
        }
        else if(self.payMethod == PayMehodUnionPay)
        {
            [self uppay];
        }
        else if(self.payMethod == PayMehodBalancePay)
        {
            [self balancePay];
        }
    }
}


#pragma mark - 余额支付
-(void)balancePay
{
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"charge/charger_xianxia.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    NSMutableString *body = [NSMutableString stringWithFormat:@"price=%@&count=1&order_id=%@",_orderPrice,_orderId];
//    self.payMethod != PayMehodBalancePay ? : [body appendFormat:@"&pay_password=%@", _payPassword];

    DLog(@"body:%@",body);
    //    header传token,body post传price，count(数量，默认传1)，kahao,password(md5加密)username
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject: %@", responseObject);
        if ([[responseObject valueForKey:@"status"] intValue]==1) {
            [SVProgressHUD dismiss];
            [self chargeSuccess];
        }
        else{
            if ([responseObject valueForKey:@"info"] != nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@",operation.responseString);
        if (operation.response.statusCode != 200) {
            [SVProgressHUD dismissWithError:@"网络错误"];
        }
        [SVProgressHUD dismiss];
    }];
    [op start];
    
}
#pragma mark - 支付宝支付

//增加确认订单接口
-(void)commitorder
{
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"charge/addxianxia.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *body = [NSString stringWithFormat:@"count=1&price=%@&order_id=%@",_orderPrice,_orderId];
    DLog(@"body:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject: %@", responseObject);
        [self payment:responseObject];
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@",operation.responseString);
        if (operation.response.statusCode != 200) {
            [SVProgressHUD dismissWithError:@"网络错误"];
        }
        [SVProgressHUD dismiss];
    }];
    [op start];
    
}
-(void)payment:(NSDictionary *)orderData
{
    NSString *appScheme = @"baoxuan";//在info中urltypes中添加一条并设置Scheme 这样支付宝才能返回到当前应用中
    NSString* orderInfo = [self getOrderInfo:0];
    NSString* signedStr = [self doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"result = %@",resultDic);
        
        NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        NSString *str = @"";
        if (resultDic)
        {
            if ([statusStr isEqualToString:@"9000"])
            {
                NSLog(@"success!");
                str = @"交易成功";
                [self chargeSuccess];
                return ;
            }else if([statusStr isEqualToString:@"6001"])
            {
                str = @"交易取消";
                [self chargeCancel];
                return ;
            }else
            {
                str = @"交易失败";
                DLog(@"AlixPayResult_error0!");
                [self chargeFail];
                return ;
            }
        }
        else
        {
            str = @"支付宝连接失败";
            NSLog(@"AlixPayResult_error1!");
            //失败
        }
        
        UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alerTivew show];
    }];
    
}

-(NSString*)getOrderInfo:(NSInteger)index
{
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = _orderId;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"充值";//product.subject; //商品标题
    order.productDescription = @"储值帐户充值";//product.body; //商品描述
    order.amount = _orderPrice; //商品价格
    order.notifyURL = SERVER_URL(@"alipay/xianxia_notify_url.php"); //回调URL
    
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.service = @"mobile.securitypay.pay";
    return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

#pragma mark - 微信支付

-(void)WXPayOrder:(NSString *)pricestr orderid:(NSString *)orderid {
    [SVProgressHUD show];
    NSString *price = [NSString stringWithFormat:@"%@",pricestr];
    NSString *productstr = [NSString stringWithFormat:@"订单编号%@",orderid];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/weizhifu/index.php?plat=ios&order_no=%@&product_name=%@&order_price=%@&pay_from=xianxia",NEW_KSERVERADD,orderid,productstr,price];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *tempdic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            [self sendWxPay:tempdic];
        }else{
            UIAlertView *alvi = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未安装微信,暂不能使用微信支付功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alvi show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error----%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}
-(void)sendWxPay:(NSDictionary *)dict
{
    if(dict != nil){
        NSDictionary *tempdict = [NSDictionary dictionaryWithDictionary:dict];
        NSMutableString *retcode = [tempdict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [tempdict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [tempdict objectForKey:@"appid"];
            req.partnerId = MCH_ID;
            req.prepayId            = [tempdict objectForKey:@"prepayid"];
            req.nonceStr            = [tempdict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [tempdict objectForKey:@"package"];
            req.sign                = [tempdict objectForKey:@"sign"];
            [WXApi sendReq:req];
            //日志输出
            DLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD dismissWithError:@"请不要重复提交订单"];
        }
    }else{
        [SVProgressHUD dismissWithError:@"网络延迟"];
        
    }
    
}

#pragma mark - 银联支付
-(void)uppay {
    [SVProgressHUD show];
    NSString *body = [NSString stringWithFormat:@"orderId=%@&txnAmt=%@",_orderId,_orderPrice];
    
    //充值  采购   一键还款 都用这个借口 传得参数一样  支付是没有_chongzhi的
    NSString *str=[NSString stringWithFormat:@"%@/upacp_sdk_php/demo/gbk/xianxia_yinlian.php",NEW_KSERVERADD];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSString *tn=[responseObject valueForKey:@"tn"];
        if (tn) {
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [UPPayHelper startWithTn:tn tmode:[responseObject valueForKey:@"tmode"] viewController:del.tabBarController delegate:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
    
}
-(void)UPPayPluginResult:(NSString *)result{
    //    success、fail、cancel
    if ([result isEqualToString:@"success"])
    {
        [self chargeSuccess];
    }
    if([result isEqualToString:@"fail"])
    {
        [self chargeFail];
        
    }
    if([result isEqualToString:@"cancel"])
    {
        [self chargeCancel];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    MaskViewForUITextField *maskView = [[MaskViewForUITextField alloc] init];
    maskView.textFiled = moneytextF;
    [maskView showMaskView];
    return YES;
}

#pragma mark - 支付状态
- (void)chargeSuccess
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *newClock = [formatter stringFromDate:[NSDate date]];
        
        UnderLinePaySuccessViewController *vc=[[UnderLinePaySuccessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.moneyString=[NSString stringWithFormat:@"%@元",_orderPrice];
        vc.orderIdString=_orderId;
        vc.timeString=newClock;
    });
}
- (void)chargeFail
{
    UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"交易失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alerTivew show];
}
- (void)chargeCancel
{
    UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"交易取消" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alerTivew show];
}
#pragma mark -
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payFailNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payCancelNotification" object:nil];
}

@end
