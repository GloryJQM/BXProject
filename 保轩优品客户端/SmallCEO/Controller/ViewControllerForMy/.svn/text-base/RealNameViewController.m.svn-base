//
//  RealNameViewController.m
//  SmallCEO
//
//  Created by nixingfu on 16/1/20.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "RealNameViewController.h"
@interface RealNameViewController() {
    UITextField *realNameTF;
    UITextField *cardIdTF;
}

@end


@implementation RealNameViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实名认证";
    
    [self createMainView];
}
- (void)createMainView {
    UILabel *alertLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, UI_SCREEN_WIDTH-30, 20)];
    alertLab.text = @"根据海关规定，身份证信息用于商品入境申报，请上传真实的姓名和身份证信息。错误信息将导致商品无法正常通关，请确保填写正确。";
    alertLab.textColor = [UIColor colorFromHexCode:@"#dc6b96"];
    alertLab.numberOfLines = 0;
    alertLab.font = LMJ_XT 12];
    [self.view addSubview:alertLab];
    
    CGSize size = [alertLab sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH-30, FLT_MAX)];
    alertLab.frame = CGRectMake(15, 15, UI_SCREEN_WIDTH-30, ceil(size.height));
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(alertLab.frame)+15, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = LINE_SHALLOW_COLOR;
    [self.view addSubview:line];

    NSArray * titles = @[@"真实姓名",@"身份证号"];
    for ( int i = 0; i < 2; i ++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+i*45, UI_SCREEN_WIDTH, 45)];
        backView.backgroundColor = WHITE_COLOR;
        [self.view addSubview:backView];
        
        UILabel *leftLab =[[UILabel alloc] initWithFrame:CGRectMake(15, 12, 65, 20)];
        leftLab.text = titles[i];
        leftLab.font = LMJ_XT 15];
        leftLab.textColor = SUB_TITLE;
        [backView addSubview:leftLab];
        leftLab.frame = CGRectMake(15, 11, [leftLab sizeThatFits:CGSizeMake(FLT_MAX, 20)].width, 20);
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLab.frame)+10, 7, UI_SCREEN_WIDTH-CGRectGetMaxX(leftLab.frame)-5-15, 30)];
        [backView addSubview:tf];
        if (i == 0) {
            realNameTF = tf;
        }else {
            cardIdTF = tf;
        }
        
        UIView *backLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44, UI_SCREEN_WIDTH, 1)];
        backLine.backgroundColor = LINE_SHALLOW_COLOR;
        [backView addSubview:backLine];
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-44-64, UI_SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = [UIColor colorFromHexCode:@"ffffff"];
    [self.view addSubview:bottomView];
    
    UIView *bootomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    bootomLine.backgroundColor = LINE_SHALLOW_COLOR;
    [bottomView addSubview:bootomLine];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 4, UI_SCREEN_WIDTH-100, 36)];
    sendBtn.backgroundColor = App_Main_Color;
    sendBtn.titleLabel.font = LMJ_XT 15];
    [sendBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [bottomView addSubview:sendBtn];
    sendBtn.layer.cornerRadius = 36/2;
    sendBtn.layer.masksToBounds = YES;
    [sendBtn addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    if (self.isAlreadyVerify) {
        [sendBtn setTitle:@"修改" forState:UIControlStateNormal];
        realNameTF.text = self.nameStr;
        cardIdTF.text = self.cardIdStr;
    }else {
        [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
}

//身份证号
- (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (void)sendRequest {
    realNameTF.text=[realNameTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    cardIdTF.text=[cardIdTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![realNameTF.text isValid] || ![cardIdTF.text isValid]) {
        [self showAlertWith:@"请选择完整信息!"];
        return;
    }
    
    if (![self validateIdentityCard:cardIdTF.text]) {
        [self showAlertWith:@"请输入正确的身份证号码!"];
        return;
    }
    [self request];
    
}
- (void)showAlertWith:(NSString *)info {
    UIAlertView * alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}
-(void)missKeyBoard
{
    [self.view endEditing:YES];
}

#pragma mark - http
- (void)request
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=add&name=%@&IDCard=%@",realNameTF.text,cardIdTF.text];
    NSString *str=MOBILE_SERVER_URL(@"personverify.php");
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
            DLog(@"成功~~");
            [SVProgressHUD dismissWithSuccess:[responseObject valueForKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

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

@end

