//
//  SubInviteViewController.m
//  Jiang
//
//  Created by ni on 17/5/10.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "SubInviteViewController.h"
#import "InviteViewController.h"

@interface SubInviteViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITextField *field;

@end

@implementation SubInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐人邀请码";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createView];
}

- (void)createView {
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    _field = [[UITextField alloc]initWithFrame:CGRectMake(12, 15, UI_SCREEN_WIDTH-24, 20)];
    _field.text = @"";
    _field.placeholder = @"请输入推荐人邀请码";
    _field.font = [UIFont systemFontOfSize:14];
    [_field addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
    _field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backView addSubview:_field];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(15, backView.maxY + 20, UI_SCREEN_WIDTH - 30, 40);
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor lightGrayColor];
    _button.userInteractionEnabled = NO;
    _button.layer.cornerRadius = 3;
    [_button addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
}

- (void)textField:(UITextField *)textField {
    if (textField.text.length == 6) {
        _button.userInteractionEnabled = YES;
        _button.backgroundColor = App_Main_Color;
    }else{
        _button.userInteractionEnabled = NO;
        _button.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)sureAction {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"是否添加推荐人邀请码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)addPhone {
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"inviteCodeApi.php");
    TokenURLRequest *requset = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [requset setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"act=3&invite_code=%@",_field.text];
    [requset setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:requset];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@", responseObject[@"info"]);
        if ([responseObject[@"is_success"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改完成"];
            [self missKeyBoard];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
            [self missKeyBoard];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [self missKeyBoard];
    }];
    [op start];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self addPhone];
    }
}
- (void)missKeyBoard {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
