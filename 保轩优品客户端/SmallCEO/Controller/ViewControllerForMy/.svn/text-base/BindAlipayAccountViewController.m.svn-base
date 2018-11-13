//
//  BindAlipayAccountViewController.m
//  SmallCEO
//
//  Created by huang on 15/9/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BindAlipayAccountViewController.h"

@interface BindAlipayAccountViewController ()

@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation BindAlipayAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"绑定支付宝账号";
    
    [self.view addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self createMainView];
}

- (void)createMainView
{
    CGFloat gapFromEdge = 15.0;
    CGFloat gapDistance = 15.0;
    CGFloat cellHeight = 44;
    
    NSArray *textArray = @[@"账号", @"姓名"];
    NSArray *placeHolderTextArray = @[@"请输入支付宝账号", @"请输入支付宝账号对应的姓名"];
    for (int i = 0; i < textArray.count; i++) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, i * cellHeight + (i + 2) * gapDistance, UI_SCREEN_WIDTH, cellHeight)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backgroundView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [textArray objectAtIndex:i];
        CGSize sizeForLabel = [label sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, cellHeight)];
        label.frame = CGRectMake(gapFromEdge, 0, sizeForLabel.width, cellHeight);
        [backgroundView addSubview:label];
        label.font = [UIFont systemFontOfSize:15.0];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + gapDistance, CGRectGetMinY(label.frame), UI_SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 2 * gapDistance, cellHeight)];
        textField.placeholder = [placeHolderTextArray objectAtIndex:i];
        textField.font = [UIFont systemFontOfSize:14.0];
        if (self.type == BindAlipayVCTypeModify)
        {
            textField.text = i == 0 ? [NSString stringWithFormat:@"%@", [self.oldInfoDic objectForKey:@"card"]] : [NSString stringWithFormat:@"%@", [self.oldInfoDic objectForKey:@"name"]];
        }
        
        if (i == 0)
        {
            self.accountTextField = textField;
        }
        else
        {
            self.nameTextField = textField;
        }
        [backgroundView addSubview:textField];
    }

    NSString *buttonStr = self.type == BindAlipayVCTypeAdd ? @"保存" : @"修改";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:buttonStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    button.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    button.layer.borderWidth = 1;
    button.frame = CGRectMake(15, 150, UI_SCREEN_WIDTH - 30, cellHeight);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 按钮点击事件
- (void)missKeyBoard
{
    [self.view endEditing:YES];
}

- (void)buttonClick
{
    if (self.accountTextField.text.length == 0 ||
        self.nameTextField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self saveAliPayAccountData];
}

#pragma mark - 网络请求
- (void)saveAliPayAccountData
{
    [SVProgressHUD show];
    NSString *body = self.type == BindAlipayVCTypeAdd ? [NSString stringWithFormat:@"type=2&card=%@&name=%@", self.accountTextField.text, self.nameTextField.text] : [NSString stringWithFormat:@"type=3&card=%@&name=%@&id=%@", self.accountTextField.text, self.nameTextField.text, [NSString stringWithFormat:@"%@", [self.oldInfoDic objectForKey:@"id"]]];
    NSString *str = MOBILE_SERVER_URL(@"zhifubao.php");
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"status"] intValue] == 1)
                               {
                                   NSString *info = self.type == BindAlipayVCTypeAdd ? @"设置支付宝账号成功" : @"修改成功";
                                   [SVProgressHUD dismissWithSuccess:info];
                                   if (self.type == BindAlipayVCTypeModify &&
                                       self.successBlock != nil)
                                   {
                                       self.successBlock(@{@"card" : self.accountTextField.text , @"name" : self.nameTextField.text});
                                   }
                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                       [self.navigationController popViewControllerAnimated:YES];
                                   });
                               }
                               else
                               {
                                   if ([responseObject valueForKey:@"info"]!=nil)
                                   {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }
                                   else
                                   {
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

@end
