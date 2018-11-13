//
//  TixianViewController.m
//  SmallCEO
//
//  Created by quanmai on 15/8/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankCardManageViewController.h"
#import "EditPwdWithOldPwdViewController.h"
#import "PayPasswordInputView.h"
#import "TixianViewController.h"

@interface TixianViewController () <PayPasswordInputViewDelegate, UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *tipLabel;
@property (nonatomic, strong) UILabel     *bankNameLabel;
@property (nonatomic, strong) UILabel     *bankCardLabel;
@property (nonatomic, strong) UIImageView *bankImageView;

@property (nonatomic, copy)   NSString    *payPassword;

@end

@implementation TixianViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f8f8f8"];
    self.title = @"余额转出";
    
    if (self.type == TixianTypeBankCard)
    {
        [self createMainView];
        [self getBankInfo];
    }
    else
    {
        [self createMainViewForAlipay];
    }
}

- (void)createMainViewForAlipay
{
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    UIView *bankView=[[UIView alloc] initWithFrame:CGRectMake(0, 8, UI_SCREEN_WIDTH, 45)];
    bankView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bankView];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(56, 0, 250, 45)];
    lable.backgroundColor=[UIColor clearColor];
    [bankView addSubview:lable];
    lable.font=[UIFont systemFontOfSize:15];
    lable.textColor=[UIColor blackColor];
    lable.text = [NSString stringWithFormat:@"%@", [self.alipayAccountDic objectForKey:@"card"]];
    
    UIImageView *logoImageV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 8.5, 28, 28)];
    logoImageV.backgroundColor=[UIColor clearColor];
    logoImageV.layer.cornerRadius=0;
    [logoImageV af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.alipayAccountDic objectForKey:@"picurl"]]]];
    [bankView addSubview:logoImageV];
    
    for (int i=0; i<2; i++) {
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 44.5*i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor=LINE_SHALLOW_COLOR;
        if (i==0) {
            line.backgroundColor=LINE_DEEP_COLOR;
        }
        [bankView addSubview:line];
    }
    
    UIView *moneyView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bankView.frame)+8, UI_SCREEN_WIDTH, 40)];
    moneyView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:moneyView];
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5 * i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [moneyView addSubview:line];
    }
    
    UILabel *titleLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 63, 40)];
    titleLable.font=[UIFont systemFontOfSize:13.0];
    titleLable.text=@"转出金额";
    titleLable.backgroundColor=[UIColor clearColor];
    titleLable.textColor=[UIColor blackColor];
    [moneyView addSubview:titleLable];
    
    moneytextF=[[UITextField alloc] initWithFrame:CGRectMake(78, 0, UI_SCREEN_WIDTH-78-15, 40)];
    [moneytextF setBorderStyle:UITextBorderStyleNone];
    moneytextF.delegate=self;
    moneytextF.backgroundColor=[UIColor clearColor];
    moneytextF.textColor=[UIColor blackColor];
    moneytextF.font = [UIFont systemFontOfSize:12.0];
    moneytextF.keyboardType = UIKeyboardTypeDecimalPad;
    [moneyView addSubview:moneytextF];
    
    
    UILabel *tipLable=[[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(moneyView.frame)+8, UI_SCREEN_WIDTH-30, 40)];
    tipLable.font=[UIFont systemFontOfSize:12.0];
    tipLable.numberOfLines = 0;
    tipLable.backgroundColor=[UIColor clearColor];
    tipLable.textColor=[UIColor colorFromHexCode:@"a4a4a8"];
    [self.view addSubview:tipLable];
    self.tipLabel = tipLable;
    
    UIButton *transferBtn=[[UIButton alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(moneyView.frame)+58, UI_SCREEN_WIDTH-50, 44)];
    transferBtn.backgroundColor=App_Main_Color;
    transferBtn.layer.cornerRadius=5;
    transferBtn.layer.masksToBounds=YES;
    [transferBtn addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [transferBtn setTitle:@"确认转出" forState:UIControlStateNormal];
    [transferBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:transferBtn];
    
    [self updateMainViewTextLabelWithbankInfo:self.bankDic bankCardInfo:self.bankCardDic];
}

- (void)createMainView
{
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    UIView *bankView=[[UIView alloc] initWithFrame:CGRectMake(0, 8, UI_SCREEN_WIDTH, 45)];
    bankView.backgroundColor=[UIColor whiteColor];
    [bankView addTarget:self action:@selector(selectBankCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bankView];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 15 - 8, 17.5, 8, 12)];
    arrowImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    [bankView addSubview:arrowImageView];

    for (int i=0; i<2; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(56, 6+18*i, 100, 15)];
        lable.backgroundColor=[UIColor clearColor];
        [bankView addSubview:lable];
        if (i==0) {
            self.bankNameLabel = lable;
            lable.font=[UIFont systemFontOfSize:15];
            lable.textColor=[UIColor blackColor];
        } else {
            self.bankCardLabel = lable;
            lable.font=[UIFont systemFontOfSize:14];
            lable.textColor=[UIColor lightGrayColor];
        }
    }
    
    UIImageView *logoImageV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 8.5, 28, 28)];
    logoImageV.backgroundColor=[UIColor clearColor];
    logoImageV.layer.cornerRadius=0;
    [bankView addSubview:logoImageV];
    self.bankImageView = logoImageV;
    
    
    for (int i=0; i<2; i++) {
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 44.5*i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor=LINE_SHALLOW_COLOR;
        if (i==0) {
            line.backgroundColor=LINE_DEEP_COLOR;
        }
        [bankView addSubview:line];
    }
    
    UIView *moneyView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bankView.frame)+8, UI_SCREEN_WIDTH, 40)];
    moneyView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:moneyView];
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5 * i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [moneyView addSubview:line];
    }
    
    UILabel *titleLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 63, 40)];
    titleLable.font=[UIFont systemFontOfSize:13.0];
    titleLable.text=@"转出金额";
    titleLable.backgroundColor=[UIColor clearColor];
    titleLable.textColor=[UIColor blackColor];
    [moneyView addSubview:titleLable];
    
    
    moneytextF=[[UITextField alloc] initWithFrame:CGRectMake(78, 0, UI_SCREEN_WIDTH-78-15, 40)];
    [moneytextF setBorderStyle:UITextBorderStyleNone];
    moneytextF.delegate=self;
    moneytextF.backgroundColor=[UIColor clearColor];
    moneytextF.textColor=[UIColor blackColor];
    moneytextF.font = [UIFont systemFontOfSize:12.0];
    moneytextF.keyboardType = UIKeyboardTypeDecimalPad;
    [moneyView addSubview:moneytextF];
    
    
    UILabel *tipLable=[[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(moneyView.frame)+8, UI_SCREEN_WIDTH-30, 40)];
    tipLable.font=[UIFont systemFontOfSize:12.0];
    tipLable.numberOfLines = 0;
    tipLable.backgroundColor=[UIColor clearColor];
    tipLable.textColor=[UIColor colorFromHexCode:@"a4a4a8"];
    [self.view addSubview:tipLable];
    self.tipLabel = tipLable;
    
    UIButton *transferBtn=[[UIButton alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(moneyView.frame)+58, UI_SCREEN_WIDTH-50, 44)];
    transferBtn.backgroundColor=App_Main_Color;
    transferBtn.layer.cornerRadius=5;
    transferBtn.layer.masksToBounds=YES;
    [transferBtn addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [transferBtn setTitle:@"确认转出" forState:UIControlStateNormal];
    [transferBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:transferBtn];
    
    [self updateMainViewTextLabelWithbankInfo:self.bankDic bankCardInfo:self.bankCardDic];
}

- (void)updateMainViewTextLabelWithbankInfo:(NSDictionary *)bankInfoDic bankCardInfo:(NSDictionary *)bankCardInfoDic
{
    NSString *maxMoneyStr = [NSString stringWithFormat:@"%@", [bankInfoDic objectForKey:@"tixian_max_money"]];
    moneytextF.placeholder = [NSString stringWithFormat:@"请输入转出金额(最大%.2f元)", [maxMoneyStr doubleValue]];
    
    self.tipLabel.text = [NSString stringWithFormat:@"%@", [bankInfoDic objectForKey:@"prompt_info"]];
    CGSize size = [self.tipLabel sizeThatFits:CGSizeMake(self.tipLabel.frame.size.width, 50)];
    self.tipLabel.frame = CGRectMake(self.tipLabel.frame.origin.x, self.tipLabel.frame.origin.y, UI_SCREEN_WIDTH-30, size.height);
    
    if (self.type != TixianTypeBankCard)
    {
        return;
    }
    
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@", [bankCardInfoDic objectForKey:@"bank_name"]];
    NSString *cardNumStr = [NSString stringWithFormat:@"%@", [bankCardInfoDic objectForKey:@"card"]];
    if (cardNumStr.length > 4)
    {
        cardNumStr = [NSString stringWithFormat:@"尾号%@", [cardNumStr substringFromIndex:(cardNumStr.length - 4)]];
    }
    self.bankCardLabel.text = cardNumStr;
    
    [self.bankImageView af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [bankCardInfoDic objectForKey:@"picurl"]]] placeholderImage:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text rangeOfString:@"."].length >0) {
        NSString *xiaoShu = [[textField.text componentsSeparatedByString:@"."] lastObject];
        if (xiaoShu.length > 2) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"最多可输入两位小数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = @"";
        }
    }
}
#pragma mark - 网络请求方法
-(void)getBankInfo
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_tixian.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=status"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject:%@",responseObject);
                               if ([[responseObject objectForKey:@"is_already_bind_bank"] intValue] == 1)
                               {
                                   [SVProgressHUD dismiss];
                               }
                               else
                               {
                                   if ([responseObject valueForKey:@"info"] != nil)
                                   {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }
                                   else
                                   {
                                       [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

-(void)withdrawMoney
{
    [SVProgressHUD show];
    NSString *bindID = self.type == TixianTypeBankCard ? [self.bankCardDic valueForKey:@"bind_id"] : [NSString stringWithFormat:@"%@", [self.alipayAccountDic objectForKey:@"id"]];
    NSString *body = [NSString stringWithFormat:@"act=tixian&bind_id=%@&money=%@&pay_password=%@", bindID, moneytextF.text, _payPassword];
    if (self.type == TixianTypeAliPay) {
        body = [NSString stringWithFormat:@"%@&type=zhifubao",body];
    }
    NSString *str = MOBILE_SERVER_URL(@"user_tixian.php");
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject:%@",responseObject);
                               if ([[responseObject objectForKey:@"is_success"] intValue] == 1)
                               {
                                   [SVProgressHUD dismissWithSuccess:[responseObject valueForKey:@"info"]];
                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                       [self.navigationController popViewControllerAnimated:YES];
                                   });
                               }
                               else
                               {
                                   if ([responseObject valueForKey:@"info"]!=nil)
                                   {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"] duration:1.25] ;
                                   }
                                   else
                                   {
                                       [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

- (void)requestPayPwdSettingsStatus
{
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
                                   PayPasswordInputView *inputView = [[PayPasswordInputView alloc] init];
                                   inputView.delegate = self;
                                   [inputView showInView:self.view];
                               }
                               else
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"你还未设置支付密码,请先前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPasswordWithoutVerifyCode;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark - PayPasswordInputViewDelegate
- (void)inputView:(PayPasswordInputView *)inputView doClickButtonWithType:(ButtonType)type withPassword:(NSString *)password
{
    if (type == ButtonTypePay)
    {
        _payPassword = password;
        [self withdrawMoney];
    }
    else if (type == ButtonTypeForgetPassword)
    {
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPassword;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark - 按钮点击方法
-(void)transfer
{
    if (moneytextF.text.length == 0 ||
        [moneytextF.text doubleValue] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"转出金额有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self requestPayPwdSettingsStatus];
}

- (void)selectBankCard
{
    BankCardManageViewController *bankCardManageVC = [[BankCardManageViewController alloc] init];
    bankCardManageVC.type = BankCardManageTypeSelect;
    bankCardManageVC.selectBankCardBlock = ^ (NSDictionary *bankInfo, NSDictionary *bankCardInfo) {
        self.bankCardDic = bankCardInfo;
        self.bankDic = bankInfo;
        [self updateMainViewTextLabelWithbankInfo:bankInfo bankCardInfo:bankCardInfo];
    };
    [self.navigationController pushViewController:bankCardManageVC animated:YES];
}

- (void)missKeyBoard
{
    [self.view endEditing:YES];
}

@end
