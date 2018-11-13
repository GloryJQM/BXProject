//
//  BXRegisterViewController.m
//  SmallCEO
//
//  Created by ni on 17/2/25.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BXRegisterViewController.h"
#import "Custom_TextField.h"
#import "ProductDetailsViewController.h"

@interface BXRegisterViewController ()
{
    NSMutableArray *textfieldArray;
}
/** 验证码 */
@property (nonatomic, strong) UILabel *getcodeView;
/** 选择是否遵守协议按钮 */
@property (nonatomic, strong) UIButton *protocolSelectBtn;
@property (nonatomic, assign) BOOL chooseBool;
@property (nonatomic,strong)UIScrollView* mainView;
@property (nonatomic,strong)NSTimer* timer;
@property (nonatomic,assign)int sens;
@property (nonatomic,strong)UIImage* headImg;
@property (nonatomic,strong)NSDictionary* registerDic;

@end

@implementation BXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    
    self.sens = 60;
    self.chooseBool = YES;
    
    if (C_IOS7) {
        self.edgesForExtendedLayout=UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets=NO;
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

    [self creatMainView];
}

- (void)creatMainView {
    self.title = @"注册";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    self.mainView.backgroundColor = WHITE_COLOR;
    self.mainView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainView];

    
    CGFloat height = 30 + 64 ;
    textfieldArray = [[NSMutableArray alloc]init];
    
    NSArray *titleArray = @[@"请输入11位手机号码",@"请输入验证码",@"请输入6-20位密码",@"请输入邀请码(选填)",];
    for (int i=0; i<titleArray.count; i++) {
        
        Custom_TextField *customTextField= [[Custom_TextField alloc]initWithFrame:CGRectMake(15, (UI_SCREEN_HEIGHT/15+20)*i+height, UI_SCREEN_WIDTH-30.0, UI_SCREEN_HEIGHT/15)];
        customTextField.textfield.placeholder = titleArray[i];
        customTextField.layer.borderWidth = 0;
        customTextField.textfield.tag = i;
        customTextField.textfield.delegate = self;
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
            [customTextField.textfield addTarget:self action:@selector(textField1:) forControlEvents:UIControlEventEditingChanged];
        }
        if (i == 1) {
            customTextField.textfield.keyboardType = UIKeyboardTypeNumberPad;
            UILabel *getcodeView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
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
        if (i == 2) {
            customTextField.textfield.secureTextEntry = YES;
        }
        
        if (i == 3) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(customTextField.maxX - 2, customTextField.minY + 2, 12, 12)];
            label.textColor = [UIColor redColor];
            label.text = @"";
            [self.mainView addSubview:label];
            [customTextField.textfield addTarget:self action:@selector(textField3:) forControlEvents:UIControlEventEditingChanged];
            
        }
        
        
        [self.mainView addSubview:customTextField];
        [textfieldArray addObject:customTextField];
    }
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    [self.mainView addGestureRecognizer:tap];
    
    //注册协议按钮选择按钮
    UIButton *ProtocolSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,height+(UI_SCREEN_HEIGHT/15+20)*titleArray.count, 15, 15)];
    [ProtocolSelectBtn setImage:[UIImage imageNamed:@"button-weixuanzhong"] forState:UIControlStateNormal];
    [ProtocolSelectBtn setImage:[UIImage imageNamed:@"button-xuanzhong"] forState:UIControlStateSelected];
    ProtocolSelectBtn.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:ProtocolSelectBtn];
    ProtocolSelectBtn.selected = YES;
    self.protocolSelectBtn = ProtocolSelectBtn;
    [ProtocolSelectBtn addTarget:self action:@selector(SelectProtocol:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"我已阅读并同意保轩生活";
    label.font = [UIFont systemFontOfSize:10];
    CGSize labelSize = [self sizeWithText:label.text font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(CGFLOAT_MAX, 20.5)];
    label.frame = CGRectMake(CGRectGetMaxX(ProtocolSelectBtn.frame)+5,  ProtocolSelectBtn.frame.origin.y, labelSize.width, 20.5);
    label.textColor = GRAY_TITLE;
    [self.mainView addSubview:label];
    
    //注册协议按钮
    UIButton *ProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ProtocolBtn.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, ProtocolSelectBtn.frame.origin.y , 100, 20.5);
    [ProtocolBtn setTitle:@"《用户服务协议》" forState:UIControlStateNormal];
    [ProtocolBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    ProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    ProtocolBtn.backgroundColor = [UIColor clearColor];
    [ProtocolBtn addTarget:self action:@selector(goProtocolDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:ProtocolBtn];
    
    //注册按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15,height+(UI_SCREEN_HEIGHT/15+20)*titleArray.count+40.5, UI_SCREEN_WIDTH-30, 40)];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = App_Main_Color;
    btn.layer.cornerRadius = 3;
    [btn addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
    
    self.mainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, btn.maxY);
}

- (void)textField1:(UITextField *)textField {
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
}

- (void)textField3:(UITextField *)textField {
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
#pragma  mark textfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 60*textField.tag);
    [UIView commitAnimations];
}

//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.phoneNumTf) {
//        if (textField.text.length >= 11) {
//            textField.text = [textField.text substringToIndex:11];
//            [self.getCodeTf becomeFirstResponder];
//        }
//    }else  if (textField == self.getCodeTf) {
////        if (textField.text.length >= 4) {
////            textField.text = [textField.text substringToIndex:4];
////            [self.passWordTf becomeFirstResponder];
////        }
//    }else  if (textField == self.passWordTf) {
//        if (textField.text.length >= 20) {
//            textField.text = [textField.text substringToIndex:20];
//            [self.passWordTf resignFirstResponder];
//        }
//    }
//}

#pragma mark - 返回pop

- (void)popViewController
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark  点击背景
-(void)tap:(id)sender
{
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}
#pragma  mark  收起键盘
-(void)missKeyBoard
{
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}


#pragma -mark 开始倒计时
-(void)setCountDown
{
    self.sens = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timercount) userInfo:nil repeats:YES];
    self.getcodeView.userInteractionEnabled = NO;
    [self.timer fire];
    
    [self missKeyBoard];
//    Custom_TextField *vertifytxf = textfieldArray[1];
//    [vertifytxf becomeFirstResponder];
//    Animation_Appear 0.2];
//    self.mainView.contentOffset = CGPointMake(0, 60);
//    [UIView commitAnimations];
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

#pragma  mark 响应事件
//获取验证码判断
-(void)getTwoCodeClick
{
    Custom_TextField *phonetxf = textfieldArray[0];
    if([phonetxf.textfield.text length] != 11)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    
    [self getvertifyCode];
}

-(void)goRegister
{
    Custom_TextField *phonetxf = textfieldArray[0];
    Custom_TextField *vertifytxf = textfieldArray[1];
    Custom_TextField *passwordtxf = textfieldArray[2];
    Custom_TextField *invitetxf = textfieldArray[3];

    if([phonetxf.textfield.text length] != 11)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if (vertifytxf.textfield.text.length == 0){
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([passwordtxf.textfield.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if(passwordtxf.textfield.text.length<6)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入6位以上字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    } else if (!_chooseBool){
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请勾选协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self registerName];
    
}

- (void)goProtocolDetail {
    ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    NSString *webStr = @"http://app.bxuping.com/touch_tongyong/zhucexieyi.php";
    [viewController loadWebView1:webStr];
    viewController.is64 = @"1";
}

- (void)SelectProtocol:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    NSLog(@"%d",_chooseBool);
    _chooseBool = sender.selected;
    NSLog(@"%d",_chooseBool);
}

#pragma mark - HTTP
-(void)getvertifyCode
{
    [SVProgressHUD show];
    Custom_TextField *phonetxf = textfieldArray[0];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&act=1",phonetxf.textfield.text];
    NSString *str=MOBILE_SERVER_URL(@"register.php");
    
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
            [self setCountDown];
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
- (void)registerName {
    Custom_TextField *phonetxf = textfieldArray[0];
    Custom_TextField *vertifytxf = textfieldArray[1];
    Custom_TextField *passwordtxf = textfieldArray[2];
    Custom_TextField *codetxf = textfieldArray[3];
    
    [SVProgressHUD show];
    NSString *str=MOBILE_SERVER_URL(@"register.php");
    NSString *body;
    if ([codetxf.textfield.text isEqualToString:@""]) {
        body = [NSString stringWithFormat:@"&phone_num=%@&act=2&password=%@&verification_code=%@",phonetxf.textfield.text,[NSString md5:passwordtxf.textfield.text],vertifytxf.textfield.text];
    }else {
        body = [NSString stringWithFormat:@"&phone_num=%@&act=2&password=%@&verification_code=%@&invite_code=%@",phonetxf.textfield.text,[NSString md5:passwordtxf.textfield.text],vertifytxf.textfield.text,codetxf.textfield.text];
    }
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [SVProgressHUD dismissWithSuccess:@"注册成功"];
            Custom_TextField *phonetxf = textfieldArray[0];
            Custom_TextField *passwordtxf = textfieldArray[2];
            if ([self.delegate respondsToSelector:@selector(account:Password:)]) {
                [self.delegate account:phonetxf.textfield.text Password:passwordtxf.textfield.text];
            }
            [self popViewController];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"注册失败,请重试!"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
