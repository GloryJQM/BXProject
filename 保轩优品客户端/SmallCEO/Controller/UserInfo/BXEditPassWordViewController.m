//
//  BXEditPassWordViewController.m
//  SmallCEO
//
//  Created by ni on 17/2/25.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BXEditPassWordViewController.h"
#import "Custom_TextField.h"

@interface BXEditPassWordViewController ()<UIAlertViewDelegate>

{
    NSMutableArray *textfieldArray;
    CGFloat keybordHeight;

}
@property (nonatomic,strong)UIScrollView* mainView;

@property (nonatomic,strong)NSTimer* timer;
@property (nonatomic,assign)int sens;

@property (nonatomic, strong) UILabel *getcodeView;


@end

@implementation BXEditPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = WHITE_COLOR;
    self.sens = 60;
    if (C_IOS7) {
        self.edgesForExtendedLayout=UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets=YES;
        self.navigationController.navigationBar.translucent=NO;
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 15, 29)];
    if(C_IOS7){
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    [backBtn setImage:[UIImage imageNamed:@"Button-fanhui@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem= leftItem;

    [self createMainView];
}
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createMainView
{
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    self.mainView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.mainView];
    
    UITapGestureRecognizer* tapEndEditing = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKeyBoard)];
    [self.mainView addGestureRecognizer:tapEndEditing];
    
    
    CGFloat height = 20;
    NSArray * tfPlaceTitles= @[@"请输入您的手机号码",@"请输入手机验证码",@"请输入您的新密码"];
    for (int i = 0; i < tfPlaceTitles.count ; i ++) {
        
        Custom_TextField *customTextField= [[Custom_TextField alloc]initWithFrame:CGRectMake(15, (UI_SCREEN_HEIGHT/15+20)*i+height, UI_SCREEN_WIDTH-30.0, UI_SCREEN_HEIGHT/15)];
        customTextField.textfield.placeholder = tfPlaceTitles[i];
        customTextField.textfield.tag = i;
        customTextField.layer.borderWidth = 0;
        customTextField.textfield.font = [UIFont systemFontOfSize:14];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(customTextField.x, customTextField.maxY, customTextField.width, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.mainView addSubview:line];
        
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        customTextField.textfield.inputAccessoryView=btnT;
        
        if (i == 0) {
            customTextField.textfield.keyboardType = UIKeyboardTypePhonePad;
            self.phoneNumTf = customTextField.textfield;
        }
        if (i == 1) {
            customTextField.textfield.keyboardType = UIKeyboardTypeNumberPad;
            self.getCodeTf = customTextField.textfield;
            UILabel *getcodeView = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 90, UI_SCREEN_HEIGHT/15)];
            getcodeView.backgroundColor = [UIColor clearColor];
            getcodeView.text = @"获取验证码";
            getcodeView.textColor = App_Main_Color;
            getcodeView.textAlignment = NSTextAlignmentRight;
            getcodeView.font = [UIFont systemFontOfSize:14];
            getcodeView.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getTwoCodeClick)];
            [getcodeView addGestureRecognizer:tap];
            self.getcodeView = getcodeView;
            
            customTextField.textfield.rightView = getcodeView;
            customTextField.textfield.rightViewMode = UITextFieldViewModeAlways;
        }
        [self.mainView addSubview:customTextField];
        if (i == 2) {
            self.passWordTf = customTextField.textfield;
            self.passWordTf.secureTextEntry = NO;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(UI_SCREEN_WIDTH - 40, customTextField.minY + 10, 30, 30);
            [button setImage:[UIImage imageNamed:@"眼睛"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"眼睛关闭"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleSecure:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainView addSubview:button];
        }
        [textfieldArray addObject:customTextField];
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15,height+(UI_SCREEN_HEIGHT/15+20)*tfPlaceTitles.count, UI_SCREEN_WIDTH-30, 40)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = App_Main_Color;
    btn.layer.cornerRadius = 3;
    [btn addTarget:self action:@selector(goEditPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];

    
    UIFont *font = [UIFont systemFontOfSize:12.0];
    
    UILabel *prefixTextLabel = [UILabel new];
    prefixTextLabel.font = font;
    prefixTextLabel.textColor = [UIColor lightGrayColor];
    prefixTextLabel.text = @"记得密码?";
    [self.mainView addSubview:prefixTextLabel];
    
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:App_Main_Color,
                                 NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
    NSMutableAttributedString *userProtocolStr;
    userProtocolStr = [[NSMutableAttributedString alloc] initWithString:@"登录"];
    [userProtocolStr addAttributes:attributes range:NSMakeRange(0, userProtocolStr.length)];
    UILabel *userProtocolLabel = [UILabel new];
    userProtocolLabel.attributedText = userProtocolStr;
    [userProtocolLabel sizeToFit];
    [self.mainView addSubview:userProtocolLabel];
    prefixTextLabel.frame = CGRectMake(UI_SCREEN_WIDTH/2-50, btn.maxY+10, 60, 15);
    userProtocolLabel.frame = CGRectMake(prefixTextLabel.maxX, btn.maxY+10, userProtocolLabel.width, 15);
    userProtocolLabel.userInteractionEnabled = YES;
    [userProtocolLabel addTarget:self action:@selector(clickUsreProtocol) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUsreProtocol)];
    [userProtocolLabel addGestureRecognizer:tap];
    
    
    self.mainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH,btn.maxY);
    
}

- (void)handleSecure:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passWordTf.secureTextEntry = sender.selected;
}
- (void)clickUsreProtocol {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneNumTf) {
        if (textField.text.length >= 11) {
            textField.text = [textField.text substringToIndex:11];
            [self.getCodeTf becomeFirstResponder];
        }
    }else  if (textField == self.getCodeTf) {
        if (textField.text.length >= 4) {
            textField.text = [textField.text substringToIndex:4];
            [self.passWordTf becomeFirstResponder];
        }
    }else  if (textField == self.passWordTf) {
        if (textField.text.length >= 20) {
            textField.text = [textField.text substringToIndex:20];
        
        }
    }
}
-(void)goGetTwoCode
{
    self.sens = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timercount) userInfo:nil repeats:YES];
    self.getcodeView.userInteractionEnabled = NO;
    [self.timer fire];
    
    [self.getCodeTf becomeFirstResponder];
}

-(void)timercount
{
    if(self.sens>=0)
    {
        NSString* str = [NSString stringWithFormat:@"%ds重新获取",self.sens];
        self.getcodeView.text = str;
        self.getcodeView.textColor = REMIND_COLOR;
        self.sens--;
    }else
    {
        [self.timer invalidate];
        self.getcodeView.userInteractionEnabled = YES;
        self.getcodeView.text = @"获取验证码";
        self.getcodeView.textColor = App_Main_Color;
    }
}

-(void)getTwoCodeClick
{
    DLog(@"%@",self.phoneNumTf.text);
    if(self.phoneNumTf.text.length !=11)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self getvertifyCodeforPwd];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    Custom_TextField *customtextfield = [textfieldArray objectAtIndex:textField.tag];
    CGPoint textFieldOriginInsuperview= [customtextfield convertPoint:textField.frame.origin toView:[[[UIApplication sharedApplication] delegate] window]];
    keybordHeight = 350 -(UI_SCREEN_HEIGHT-textFieldOriginInsuperview.y-textField.frame.size.height);
    if (keybordHeight<=0) {
        return;
    }else{
        [UIView animateWithDuration:0.375 animations:^{
            CGRect rect = self.view.frame;
            rect.origin.y -= keybordHeight;
            rect.size.height += keybordHeight;
            self.view.frame = rect;
        }];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (keybordHeight<=0) {
        return;
    }
    [UIView animateWithDuration:0.375 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y += keybordHeight;
        rect.size.height -= keybordHeight;
        self.view.frame = rect;
    }];
}
-(void)missKeyBoard {
    [self.view endEditing:YES];
    [self performSelector:@selector(textViewDidEndEditing) withObject:nil afterDelay:0];
}

- (void)textViewDidEndEditing {
    
}

-(void)getvertifyCodeforPwd {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&act=1",self.phoneNumTf.text];
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
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [self goGetTwoCode];
            [SVProgressHUD dismissWithSuccess:@"发送成功"];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送失败,请重试!"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)postEdit {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&act=2&password=%@&verification_code=%@&confirm_password=%@",self.phoneNumTf.text,[NSString md5:self.passWordTf.text],self.getCodeTf.text,[NSString md5:self.passWordTf.text]];
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
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [self motifyPassword];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [AlertLab showTitle:[responseObject valueForKey:@"info"]];
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

-(void)goEditPwd
{
    if([self.phoneNumTf.text length] != 11){
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([self.getCodeTf.text isEqualToString:@""]) {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([self.passWordTf.text isEqualToString:@""]) {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if(self.passWordTf.text.length<6 || self.passWordTf.text.length > 20) {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入6-20位密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self postEdit];
}

- (void)motifyPassword
{
    [self.view endEditing:YES];
    UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"密码修改成功\n点击登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alv.tag = 100;
    [alv show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            [self popViewController];
        }
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



@end
