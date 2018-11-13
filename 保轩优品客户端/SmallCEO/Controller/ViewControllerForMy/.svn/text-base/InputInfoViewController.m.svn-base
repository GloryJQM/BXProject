//
//  InputInfoViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

const NSInteger lineHeight = 1;

#import "InputInfoViewController.h"

@interface InputInfoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField* userNameTextField;

@end

@implementation InputInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"个人资料设定";
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [self createMainView];
    // Do any additional setup after loading the view.
}

- (void)createMainView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 18 + lineHeight, UI_SCREEN_WIDTH, 45)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, UI_SCREEN_WIDTH, lineHeight)];
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 45 + 18, UI_SCREEN_WIDTH, lineHeight)];
    topLine.backgroundColor = LINE_SHALLOW_COLOR;
    bottomLine.backgroundColor = LINE_SHALLOW_COLOR;
    [self.view addSubview:topLine];
    [self.view addSubview:bottomLine];
    
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 18, UI_SCREEN_WIDTH - 20, 45)];
    if (self.type == InputInfoTypeName)
    {
        self.userNameTextField.placeholder = @"请输入真实姓名";
    }
    else if (self.type == InputInfoTypePhone)
    {
        self.userNameTextField.placeholder = @"请输入手机号或座机";
        self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    self.userNameTextField.delegate = self;
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.userNameTextField becomeFirstResponder];
    self.userNameTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.userNameTextField];
    
    CGFloat heightForBottomView = 50;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userNameTextField.frame) + 20, UI_SCREEN_WIDTH, heightForBottomView)];
    [self.view addSubview:bottomView];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.bounds = CGRectMake(0, 0, 280, 40);
    [saveButton setBackgroundColor:App_Main_Color];
    saveButton.center = CGPointMake(bottomView.center.x, heightForBottomView / 2);
    [saveButton addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:saveButton];
}

#pragma mark - 发送请求方法
- (void)saveInputInfo
{
    if ([self.userNameTextField.text isEqualToString:@""]) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self.view endEditing:YES];
    NSString *type=@"alias";
    if (self.type==InputInfoTypeName) {
        type=@"alias";
    }
    if (self.type==InputInfoTypePhone) {
        type=@"tel";
    }
    
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"edituserinfo_res.php");
    //NSString *str = [NSString stringWithFormat:@"%@/mobile/api/edituserinfo_res.php",NEW_KSERVERADD];
    NSString *bodyStr = [NSString stringWithFormat:@"type=%@&value=%@",type, self.userNameTextField.text];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"] &&
                                   [responseObject valueForKey:@"info"] != nil)
                               {
                                   [SVProgressHUD dismissWithError:[responseObject valueForKey:@"info"]];
                                   return;
                               }
                               else if (![returnState isEqualToString:@"1"] &&
                                        [responseObject valueForKey:@"info"] == nil)
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               
                               [self.navigationController popViewControllerAnimated:YES];
                               [SVProgressHUD dismissWithSuccess:[responseObject valueForKey:@"info"]];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark - 按钮点击方法
- (void)saveBtnClick
{
    [self saveInputInfo];
}

-(void)missKeyBoard
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
