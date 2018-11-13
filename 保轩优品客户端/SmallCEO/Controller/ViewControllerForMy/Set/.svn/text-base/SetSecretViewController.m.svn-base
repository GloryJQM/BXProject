//
//  SetSecretViewController.m
//  Jiang
//
//  Created by Cai on 16/10/25.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "SetSecretViewController.h"
//#import "SetRquest.h"
//#import "GetCodeNumberRequest.h"
//#import "GetPhoneNumber.h"
#import "UIButton+countDown.h"

@interface SetSecretViewController ()
@property (nonatomic, strong) NSMutableArray *logTextFiledArray;
@property (nonatomic, strong) NSMutableArray *tradeTextFiledArray;
//只是为了显示作用 相当于sting
@property (nonatomic, strong) UILabel *phoneTestLabel;

@end

@implementation SetSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logTextFiledArray = [NSMutableArray array];
    _tradeTextFiledArray = [NSMutableArray array];
    
    [self.view addTarget:self action:@selector(hideKeyBord) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.SecretType == SetLogInSecretType) {
        self.title = @"修改登录密码";
    }else
    {
        self.title = @"设置交易密码";
    }
    [self creatMainView];
    //[self getPhoneNumber];
    //创建显示手机号码的label 隐藏此label 为了拿到用户手机号码手机号码
    _phoneTestLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 80, 20)];
    _phoneTestLabel.hidden = YES;
    [self.view addSubview:_phoneTestLabel];
}
- (void)creatMainView
{
    if (self.SecretType == SetLogInSecretType) {
        NSArray *placeHolderTextArray = [NSArray arrayWithObjects:@"请输入您的短信验证码", @"设置新密码（6-16位数字、字母）", nil];
        for (int i = 0; i < placeHolderTextArray.count; i++) {
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(12, 30+64*i, UI_SCREEN_WIDTH-24, UI_SCREEN_HEIGHT/15)];
            backView.backgroundColor = [UIColor clearColor];
            backView.userInteractionEnabled = YES;
            [self.view addSubview:backView];
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, UI_SCREEN_WIDTH-55, UI_SCREEN_HEIGHT/15-20)];
            textField.placeholder = [placeHolderTextArray objectAtIndex:i];
            textField.textAlignment = NSTextAlignmentLeft;
            textField.font = [UIFont systemFontOfSize:15.0];
            textField.textColor = [UIColor grayColor];
            [backView addSubview:textField];
            [_logTextFiledArray addObject:textField];
            if (i==0) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.frame = CGRectMake(15, 10, UI_SCREEN_WIDTH-150, UI_SCREEN_HEIGHT/15-20);
                UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [saveButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                saveButton.frame = CGRectMake(CGRectGetMaxX(textField.frame),10 , 80, UI_SCREEN_HEIGHT/15-20);
                [saveButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
                saveButton.layer.cornerRadius = 5;
                saveButton.layer.masksToBounds = YES;
                saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
                [saveButton addTarget:self action:@selector(getLogCode:) forControlEvents:UIControlEventTouchUpInside];
                
                [backView addSubview:saveButton];
            }
            if (i==1) {
                textField.secureTextEntry = YES;
                UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [saveButton setTitle:@"确认" forState:UIControlStateNormal];
                saveButton.frame = CGRectMake(15, CGRectGetMaxY(backView.frame)+20, UI_SCREEN_WIDTH-30, 40);
                [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                saveButton.backgroundColor = App_Main_Color;
                saveButton.layer.cornerRadius = 3;
                [saveButton addTarget:self action:@selector(setLogInAction) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:saveButton];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT/15 - 1, UI_SCREEN_WIDTH - 24, 0.5)];
            label.backgroundColor = [UIColor lightGrayColor];
            [backView addSubview:label];
        }
    }else if(self.SecretType == SetTradeSecretType){
        NSArray *placeHolderTextArray = [NSArray arrayWithObjects:@"请输入您的短信验证码", @"设置新密码（6位数字）", nil];
        for (int i = 0; i < placeHolderTextArray.count; i++) {
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(12, 30+64*i, UI_SCREEN_WIDTH-24, UI_SCREEN_HEIGHT/15)];
//            backView.backgroundColor = [UIColor clearColor];
//            backView.layer.cornerRadius = UI_SCREEN_HEIGHT/30;
//            backView.layer.borderColor = LAYER_COLOR.CGColor;
//            backView.layer.masksToBounds = YES;
//            backView.layer.borderWidth = 1;
            backView.userInteractionEnabled = YES;
            
            [self.view addSubview:backView];
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, UI_SCREEN_WIDTH-55, UI_SCREEN_HEIGHT/15-20)];
            textField.placeholder = [placeHolderTextArray objectAtIndex:i];
            textField.textAlignment = NSTextAlignmentLeft;
            textField.font = [UIFont systemFontOfSize:15.0];
            textField.textColor = [UIColor grayColor];
            [backView addSubview:textField];
            [_tradeTextFiledArray addObject:textField];
            if (i==0) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.frame = CGRectMake(15, 10, UI_SCREEN_WIDTH-150, UI_SCREEN_HEIGHT/15-20);
                UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [saveButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                saveButton.frame = CGRectMake(CGRectGetMaxX(textField.frame),10 , 80, UI_SCREEN_HEIGHT/15-20);
                [saveButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
                saveButton.layer.cornerRadius = 5;
                saveButton.layer.masksToBounds = YES;
                saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
                //saveButton.backgroundColor = [UIColor colorFromHexCode:@"#42aef5"];
                [saveButton addTarget:self action:@selector(getTradeCode:) forControlEvents:UIControlEventTouchUpInside];
                [backView addSubview:saveButton];
            }
            if (i==1) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.secureTextEntry = YES;
                UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [saveButton setTitle:@"确认" forState:UIControlStateNormal];
                saveButton.frame = CGRectMake(15, CGRectGetMaxY(backView.frame)+25, UI_SCREEN_WIDTH-30, UI_SCREEN_HEIGHT/15);
                [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                saveButton.backgroundColor = App_Main_Color;
                saveButton.layer.cornerRadius = UI_SCREEN_HEIGHT/30;
                [saveButton addTarget:self action:@selector(setTradeAction) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:saveButton];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT/15 - 1, UI_SCREEN_WIDTH - 24, 0.5)];
            label.backgroundColor = [UIColor lightGrayColor];
            [backView addSubview:label];
        }
    }
}
- (void)hideKeyBord
{
    [_logTextFiledArray makeObjectsPerformSelector:@selector(resignFirstResponder)];
    [_tradeTextFiledArray makeObjectsPerformSelector:@selector(resignFirstResponder)];
}
#pragma mark clickAction 
//获取验证码
- (void)getLogCode:(UIButton*)sender
{
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_sync(queue, ^{
        [sender startWithTime:60 title:@"获取验证码" countDownTitle:@"s后刷新" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
    });
    [SVProgressHUD show];
    NSString*body=@"act=1";
    NSString *str=MOBILE_SERVER_URL(@"setPasswordApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"is_success"] integerValue] == 1)
        {
            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络失败"];
    }];
    [op start];
}
- (void)getTradeCode:(UIButton*)sender{
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_sync(queue, ^{
        [sender startWithTime:60 title:@"获取验证码" countDownTitle:@"s后刷新" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
    });
    [SVProgressHUD show];
    NSString*body=@"act=1";
    NSString *str=MOBILE_SERVER_URL(@"setPayPasswordApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"is_success"] integerValue] == 1)
        {
            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络失败"];
    }];
    [op start];

}
- (void)setTradeAction {
    for (UITextField *textField in _tradeTextFiledArray) {
        if ([textField.text isEqualToString:@""])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    UITextField *numberTextField = [_tradeTextFiledArray objectAtIndex:0];
    UITextField *secretTextField = [_tradeTextFiledArray objectAtIndex:1];
    if (!(secretTextField.text.length==6)) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位数字"];
        return;
    }
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=2&verification_code=%@&password=%@", numberTextField.text, [NSString md5:secretTextField.text]];
    NSString *str=MOBILE_SERVER_URL(@"setPayPasswordApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"is_success"] integerValue] == 1)
        {
            [SVProgressHUD showSuccessWithStatus:@"设置交易密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if (self.finishBlock) {
                    self.finishBlock();
                }
            });
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}
//设置登录
- (void)setLogInAction {
    for (UITextField *textField in _logTextFiledArray) {
        if ([textField.text isEqualToString:@""])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    UITextField *numberTextField = [_logTextFiledArray objectAtIndex:0];
    UITextField *secretTextField = [_logTextFiledArray objectAtIndex:1];
    if (secretTextField.text.length<6||secretTextField.text.length>16) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16数字、字母"];
        return;
    }
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=2&verification_code=%@&password=%@", numberTextField.text, [NSString md5:secretTextField.text]];
    NSString *str=MOBILE_SERVER_URL(@"setPasswordApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"is_success"] integerValue] == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:@"设置登录密码成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络失败"];
    }];
    [op start];

}
//#pragma mark-获取登录验证码按钮方法
//- (void)getLogCode:(UIButton*)sender
//{
//    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
//    dispatch_sync(queue, ^{
//        [sender startWithTime:60 title:@"获取验证码" countDownTitle:@"s后刷新" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
//    });
//    [SVProgressHUD show];
//    GetCodeNumberRequest*getCodeRequest = [GetCodeNumberRequest new];
//    getCodeRequest.getCodeType = SetLogInSecretRequestType;
//    getCodeRequest.phoneNumber = _phoneTestLabel.text;//用户手机号码
//    [getCodeRequest postWithCompletionBlockWithSuccess:^(BaseRequest *request) {
//        DLog(@"requst %@", request.responseObject);
//        if (request.responseStatusCode == 1)
//        {
//            NSString *returnState = [NSString stringWithFormat:@"%@", [request.responseObject objectForKey:@"is_success"]];
//            if ([returnState isEqualToString:@"1"])
//            {
//                [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}
//#pragma mark-获取交易验证码按钮方法
//- (void)getTradeCode:(UIButton*)sender
//{
//    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
//    dispatch_sync(queue, ^{
//        [sender startWithTime:60 title:@"获取验证码" countDownTitle:@"s后刷新" mainColor:[UIColor colorFromHexCode:@"#42aef5"] countColor:[UIColor lightGrayColor]];
//    });
//    [SVProgressHUD show];
//    GetCodeNumberRequest*getCodeRequest = [GetCodeNumberRequest new];
//    getCodeRequest.getCodeType = SetTradeSecretRequestType;
//    getCodeRequest.phoneNumber = _phoneTestLabel.text;//用户手机号码
//    [getCodeRequest postWithCompletionBlockWithSuccess:^(BaseRequest *request) {
//        DLog(@"requst %@", request.responseObject);
//        if (request.responseStatusCode == 1)
//        {
//            NSString *returnState = [NSString stringWithFormat:@"%@", [request.responseObject objectForKey:@"is_success"]];
//            if ([returnState isEqualToString:@"1"])
//            {
//                [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}
//#pragma mark-登录密码设置方法
//- (void)setLogInAction
//{
//    for (UITextField *textField in _logTextFiledArray) {
//        if ([textField.text isEqualToString:@""])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            return;
//        }
//    }
//    UITextField *numberTextField = [_logTextFiledArray objectAtIndex:0];
//    UITextField *secretTextField = [_logTextFiledArray objectAtIndex:1];
//    if (secretTextField.text.length<6||secretTextField.text.length>16) {
//        [SVProgressHUD showErrorWithStatus:@"请输入6-16数字、字母"];
//        return;
//    }
//    [SVProgressHUD show];
//    SetRquest*setRequest = [SetRquest new];
//    setRequest.setSecretrequestType = SetLogInSecretRequestType;
//    setRequest.codeNum = numberTextField.text;
//    NSString *secretSting = secretTextField.text;
//    NSString *md5SecretSting = [NSString md5:secretSting];
//    setRequest.secretNumber = md5SecretSting;
//    [setRequest postWithCompletionBlockWithSuccess:^(BaseRequest *request) {
//        DLog(@"requst %@", request.responseObject);
//        if (request.responseStatusCode == 1)
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//            [SVProgressHUD showSuccessWithStatus:@"设置登录密码成功"];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}
//#pragma mark-设置交易密码方法
//- (void)setTradeAction
//{
//    for (UITextField *textField in _tradeTextFiledArray) {
//        if ([textField.text isEqualToString:@""])
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            return;
//        }
//    }
//    UITextField *numberTextField = [_tradeTextFiledArray objectAtIndex:0];
//    UITextField *secretTextField = [_tradeTextFiledArray objectAtIndex:1];
//    if (!(secretTextField.text.length==6)) {
//        [SVProgressHUD showErrorWithStatus:@"请输入6位数字"];
//        return;
//    }
//    [SVProgressHUD show];
//    SetRquest*setRequest = [SetRquest new];
//    setRequest.setSecretrequestType = SetTradeSecretRequestType;
//    setRequest.codeNum = numberTextField.text;
//    NSString *secretSting = secretTextField.text;
//    NSString *md5SecretSting = [NSString md5:secretSting];
//    setRequest.secretNumber = md5SecretSting;
//    
//    [setRequest postWithCompletionBlockWithSuccess:^(BaseRequest *request) {
//        DLog(@"requst %@", request.responseObject);
//        if (request.responseStatusCode == 1)
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//            [SVProgressHUD showSuccessWithStatus:@"设置交易密码成功"];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}
//#pragma mark-获取用户手机号码
//- (void)getPhoneNumber
//{
//    GetPhoneNumber *getPhoneRquest = [GetPhoneNumber new];
//    [getPhoneRquest getWithCompletionBlockWithSuccess:^(__kindof BaseRequest *request) {
//        if (request.responseStatusCode == 1)
//        {
//            NSString *returnState = [NSString stringWithFormat:@"%@", [request.responseObject objectForKey:@"is_success"]];
//            if ([returnState isEqualToString:@"1"])
//            {
//                [SVProgressHUD dismiss];
//                DLog(@"%@",request.responseObject);
//                _phoneTestLabel.text =  [NSString stringWithFormat:@"%@",request.responseObject[@"phone_num"]];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}
@end
