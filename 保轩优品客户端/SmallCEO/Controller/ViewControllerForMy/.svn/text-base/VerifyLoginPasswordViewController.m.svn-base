//
//  VerifyLoginPasswordViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/31.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "EditPwdWithOldPwdViewController.h"
#import "VerifyLoginPasswordViewController.h"

@interface VerifyLoginPasswordViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton    *verifyButton;
@property (nonatomic, strong) UITextField *passwordTextFiled;

@end

@implementation VerifyLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"校验登录密码";
    
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self createMainView];
    // Do any additional setup after loading the view.
}

- (void)createMainView
{
    CGFloat heightFromTop = 35.0;
    CGFloat heightForView = 49.0;
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, heightFromTop, UI_SCREEN_WIDTH, 20)];
    warningLabel.text = @"为了保障账户安全,请校验登录密码";
    warningLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:warningLabel];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(warningLabel.frame) + 7.5, UI_SCREEN_WIDTH, heightForView)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    passwordLabel.text = @"登录密码";
    CGSize sizeForPasswordLabel = [passwordLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, heightForView)];
    passwordLabel.frame = CGRectMake(15, 0, sizeForPasswordLabel.width, heightForView);
    [backgroundView addSubview:passwordLabel];
    
    UILabel *bottomSeparatedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, heightForView - 1, UI_SCREEN_WIDTH, 1)];
    bottomSeparatedLine.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
    [backgroundView addSubview:bottomSeparatedLine];

    UILabel *topSeparatedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    topSeparatedLine.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
    [backgroundView addSubview:topSeparatedLine];
    
    self.passwordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordLabel.frame) + 20, 0, UI_SCREEN_WIDTH - CGRectGetMaxX(passwordLabel.frame) - 20 - 15, heightForView)];
    self.passwordTextFiled.placeholder = @"请输入登录密码";
    self.passwordTextFiled.delegate = self;
    self.passwordTextFiled.secureTextEntry = YES;
    [backgroundView addSubview:self.passwordTextFiled];
    [self.passwordTextFiled addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [verifyButton setTitle:@"确认校验" forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor colorFromHexCode:@"a4a4a8"] forState:UIControlStateNormal];
    [verifyButton setBackgroundColor:[UIColor colorFromHexCode:@"e5e5e5"]];
    verifyButton.frame = CGRectMake(20, CGRectGetMaxY(backgroundView.frame) + 15.0, UI_SCREEN_WIDTH - 40, heightForView);
    [verifyButton addTarget:self action:@selector(verifyButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:verifyButton];
    self.verifyButton = verifyButton;
}

- (void)textFieldValueDidChange:(UITextField *)textField
{
    if (self.passwordTextFiled.text.length > 0)
    {
        [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.verifyButton setBackgroundColor:App_Main_Color];
    }
    else
    {
        [self.verifyButton setTitleColor:[UIColor colorFromHexCode:@"a4a4a8"] forState:UIControlStateNormal];
        [self.verifyButton setBackgroundColor:[UIColor colorFromHexCode:@"e5e5e5"]];
    }
}

#pragma mark - 点击事件方法
- (void)verifyButtonClick
{
    if (![self.passwordTextFiled.text isValid])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self.view endEditing:YES];
    [self requestVerifyLoginPwd];
}

-(void)missKeyBoard
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 网络请求方法
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
                               EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
                               editPwdVC.type = [returnState isEqualToString:@"1"] ? EditPasswordTypePayPassword : EditPasswordTypePayPasswordWithoutVerifyCode;
                               editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
                               [self.navigationController pushViewController:editPwdVC animated:YES];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

- (void)requestVerifyLoginPwd
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"login.php");
    NSString *bodyStr = [NSString stringWithFormat:@"&username=%@&password=%@&type=0", [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"], [NSString md5:self.passwordTextFiled.text]];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"] &&
                                   ![[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"info"]] isValid])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               else if (![returnState isEqualToString:@"1"] &&
                                        [[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"info"]] isValid])
                               {
                                   [SVProgressHUD dismissWithError:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"info"]]];
                                   return;
                               }
                               
                               [SVProgressHUD dismiss];
                               [self requestPayPwdSettingsStatus];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
