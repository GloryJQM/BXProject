//
//  EditPwdWithOldPwdViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/30.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "EditPwdWithOldPwdViewController.h"

@interface EditPwdWithOldPwdViewController () <UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UIScrollView* mainView;
@property (nonatomic,strong)UIButton* getTwoCode;
@property (nonatomic,strong)NSTimer* timer;
@property (nonatomic,assign)int sens;

@property (nonatomic,strong)UITextField* passWordTf;
@property (nonatomic,strong)UITextField* surePwdTf;
@property (nonatomic,strong)UITextField* twoCodeTf;
@end

@implementation EditPwdWithOldPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sens = 60;
    if (self.type == EditPasswordTypeDefault)
    {
        self.title = @"登录密码修改";
    }
    else if (self.type == EditPasswordTypePayPasswordWithoutVerifyCode)
    {
        self.title = @"设置支付密码";
        
    }else if (self.type == EditPasswordTypePayPassword)
    {
        self.title = @"支付密码修改";
    }
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKeyBoard)];
    [self.view addGestureRecognizer:tap];
    [self createMainView];
}

-(void)missKeyBoard
{
    [self.view endEditing:YES];
    Animation_Appear .2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}

-(void)createMainView
{
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    self.mainView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:self.mainView];
    
    UILabel* useCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, UI_SCREEN_WIDTH - 40, 20)];
    //    useCountLabel.backgroundColor = [UIColor redColor];
    useCountLabel.text = [NSString stringWithFormat:@"您的账号为：%@", self.phoneNum];
    useCountLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    useCountLabel.font = LMJ_XT 15];
    [self.mainView addSubview:useCountLabel];
    
    CGFloat originalY = CGRectGetMaxY(useCountLabel.frame);
    if (self.type != EditPasswordTypePayPasswordWithoutVerifyCode)
    {
        UIView* verifyCodeView = [[UIView alloc]initWithFrame:CGRectMake(-1, CGRectGetMaxY(useCountLabel.frame), UI_SCREEN_WIDTH + 2, 50)];
        verifyCodeView.backgroundColor = WHITE_COLOR;
        verifyCodeView.layer.borderColor = [UIColor colorFromHexCode:@"dedede"].CGColor;
        verifyCodeView.layer.borderWidth = 1.0;
        
        UILabel* verifyCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 50, 50)];
        verifyCodeLabel.text = @"验证码";
        verifyCodeLabel.textColor = [UIColor blackColor];
        verifyCodeLabel.font = LMJ_XT 15];
        [verifyCodeView addSubview:verifyCodeLabel];
        
        UITextField* textF = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 150, 50)];
        textF.textColor = [UIColor blackColor];
        UIColor *color = [UIColor colorFromHexCode:@"686868"];
        textF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写验证码" attributes:@{NSForegroundColorAttributeName: color}];
        textF.font = [UIFont systemFontOfSize:14];
        textF.delegate = self;
        textF.secureTextEntry = NO;
        textF.keyboardType = UIKeyboardTypeNumberPad;
        self.twoCodeTf = textF;
        [verifyCodeView addSubview:textF];
        
        [self.mainView addSubview:verifyCodeView];
        
        self.getTwoCode = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-10-80, 9 , 85, 30)];
        [self.getTwoCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getTwoCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.getTwoCode.titleLabel.font = [UIFont systemFontOfSize:14];
        self.getTwoCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.getTwoCode.backgroundColor = App_Main_Color;
        [self.getTwoCode addTarget:self action:@selector(getTwoCodeClick) forControlEvents:UIControlEventTouchUpInside];
        self.getTwoCode.layer.cornerRadius = 3;
        self.getTwoCode.clipsToBounds = YES;
        [verifyCodeView addSubview:self.getTwoCode];
        
        originalY += 50;
    }
    
    UILabel* pwdTypeWarningLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, originalY + 10, UI_SCREEN_WIDTH - 40, 20)];
    if (self.type == EditPasswordTypeDefault)
    {
        pwdTypeWarningLabel.text = @"请重新设置登录密码";
    }
    else if (self.type == EditPasswordTypePayPassword)
    {
        pwdTypeWarningLabel.text =  @"请重新设置你的钱包支付密码";
        
    }else if (self.type == EditPasswordTypePayPasswordWithoutVerifyCode) {
        
        pwdTypeWarningLabel.text = @"请设置你的钱包支付密码";
    }
    pwdTypeWarningLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    pwdTypeWarningLabel.font = LMJ_XT 15];
    [self.mainView addSubview:pwdTypeWarningLabel];
    
    NSArray *editPwd = @[@"设置新密码",@"确认新密码"];
    NSArray *placeH = @[@"6-20位字母、数字组合",@"6-20位字母、数字组合"];
    for(int i = 0; i < placeH.count; i++)
    {
        UIView* vi = [[UIView alloc]initWithFrame:CGRectMake(-1, CGRectGetMaxY(pwdTypeWarningLabel.frame) + i * 50 + 10, UI_SCREEN_WIDTH+2, 50)];
        vi.backgroundColor = WHITE_COLOR;
        vi.layer.borderColor = [UIColor colorFromHexCode:@"dedede"].CGColor;
        vi.layer.borderWidth = 1.0;
        
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
        lab.text = editPwd[i];
        lab.textColor = [UIColor blackColor];
        lab.font = LMJ_XT 15];
        [vi addSubview:lab];
        
        UITextField* textF = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, 200, 50)];
        textF.textColor = [UIColor colorFromHexCode:@"B9B9B9"];
        textF.secureTextEntry = YES;
        //        textF.placeholder = placeH[i];
        
        UIColor *color = [UIColor colorFromHexCode:@"686868"];
        textF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", placeH[i]] attributes:@{NSForegroundColorAttributeName: color}];
        
        textF.font = [UIFont systemFontOfSize:14];
        textF.font = [UIFont systemFontOfSize:14];
        textF.tag = i;
        textF.delegate = self;
        [vi addSubview:textF];
        
        [self.mainView addSubview:vi];
        
        if (i == 0)
        {
            self.passWordTf = textF;
        }
        else if (i == 1)
        {
            self.surePwdTf = textF;
        }
    }
    
    UIButton* sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 300, UI_SCREEN_WIDTH-50, 47)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    sureBtn.backgroundColor = App_Main_Color;
    [sureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [sureBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(goEditPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:sureBtn];
}

-(void)getTwoCodeClick
{
    if (self.type == EditPasswordTypeDefault)
    {
        [self postTwoCode];
    }
    else if (self.type == EditPasswordTypePayPassword)
    {
        [self getPayPasswordVerifyCode];
    }
}

-(void)postTwoCode
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&step=1",self.phoneNum];
    NSString *str=MOBILE_SERVER_URL(@"findPassword.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [self goGetTwoCode];
            [SVProgressHUD dismiss];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)goGetTwoCode
{
    self.sens = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timercount) userInfo:nil repeats:YES];
    self.getTwoCode.userInteractionEnabled = NO;
    [self.timer fire];
}

-(void)timercount
{
    if(self.sens>=0)
    {
        NSString* str = [NSString stringWithFormat:@"%ds重新获取",self.sens];
        [self.getTwoCode setTitle:str forState:UIControlStateNormal];
        [self.getTwoCode setTitleColor:REMIND_COLOR forState:UIControlStateNormal];
        [self.getTwoCode setBackgroundColor:[UIColor colorFromHexCode:@"e5e5e5"]];
        self.sens--;
    }else
    {
        [self.timer invalidate];
        self.getTwoCode.userInteractionEnabled = YES;
        [self.getTwoCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getTwoCode setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self.getTwoCode setBackgroundColor:App_Main_Color];
    }
    
}

-(void)goEditPwd
{
    if([self.passWordTf.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([self.surePwdTf.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请再次输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if(self.passWordTf.text.length<6)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入6位以上字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if(![self.passWordTf.text isEqualToString:self.surePwdTf.text])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"两次输入的密码不同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([self.twoCodeTf.text isEqualToString:@""] &&
             self.type != EditPasswordTypePayPasswordWithoutVerifyCode)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    
    if (self.type == EditPasswordTypeDefault)
    {
        [self postEdit];
    }
    else if (self.type == EditPasswordTypePayPassword)
    {
        [self requestModifyMyPayPwd];
    }
    else if (self.type == EditPasswordTypePayPasswordWithoutVerifyCode)
    {
        [self requestModifyMyPayPwdWithoutVerifyCode];
    }
}

#pragma mark - 网络请求
- (void)requestModifyMyPayPwd
{
    [SVProgressHUD show];
    NSString *md5PayPassword = [NSString md5:self.passWordTf.text];
    NSString *str = MOBILE_SERVER_URL(@"user_pay_password.php");
    [RequestManager startRequestWithUrl:str
                                   body:[NSString stringWithFormat:@"act=fix_pay_password&new_pay_password=%@&code=%@", md5PayPassword, self.twoCodeTf.text]
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               
                               [SVProgressHUD dismissWithSuccess:@"修改支付密码成功"];
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [self.navigationController popViewControllerAnimated:YES];
                               });
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

- (void)requestModifyMyPayPwdWithoutVerifyCode
{
    [SVProgressHUD show];
    NSString *md5PayPassword = [NSString md5:self.passWordTf.text];
    NSString *str = MOBILE_SERVER_URL(@"user_pay_password.php");
    [RequestManager startRequestWithUrl:str
                                   body:[NSString stringWithFormat:@"act=set_pay_password&pay_password=%@", md5PayPassword]
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               
                               [SVProgressHUD dismissWithSuccess:@"设置支付密码成功"];
                               if (self.SetPayPasswordSuccessBlock)
                               {
                                   self.SetPayPasswordSuccessBlock();
                                   return;
                               }
                               
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [self.navigationController popViewControllerAnimated:YES];
                               });
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

- (void)getPayPasswordVerifyCode
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_pay_password.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=get_code"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               [self goGetTwoCode];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

-(void)postEdit
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&step=2&password=%@&code=%@",self.phoneNum,[NSString md5:self.surePwdTf.text],self.twoCodeTf.text];
    NSString *str=MOBILE_SERVER_URL(@"findpassword_mycenter.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [SVProgressHUD dismiss];
            [self motifyPassword];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

#pragma mark -
- (void)motifyPassword
{
    UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alv.tag = 9876;
    [alv show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 9876) {
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(BOOL)isPwd:(NSString*)passWord inLength:(int)length
{
    NSString *testString = passWord;
    
    if(passWord.length<length)
    {
        return NO;
    }
    
    int alength = (int)[testString length];
    
    BOOL hasNum = NO;
    BOOL hasEng = NO;
    
    
    for (int i = 0; i<alength; i++)
    {
        
        char commitChar = [testString characterAtIndex:i];
        
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        
        const char *u8Temp = [temp UTF8String];
        
        if (3==strlen(u8Temp))
        {
            return NO;
        }else if((commitChar>64)&&(commitChar<91))
        {
            hasEng = YES;
        }else if((commitChar>96)&&(commitChar<123))
        {
            hasEng = YES;
        }else if((commitChar>47)&&(commitChar<58))
        {
            hasNum = YES;
        }else
        {
            return NO;
        }
    }
    if(hasNum && hasEng)
    {
        return YES;
    }else
    {
        return NO;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    Animation_Appear .2];
    self.mainView.contentOffset = CGPointMake(0, textField.tag*50+20);
    [UIView commitAnimations];
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
