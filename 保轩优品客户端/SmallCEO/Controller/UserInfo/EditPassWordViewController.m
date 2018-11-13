//
//  EditPassWordViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "EditPassWordViewController.h"
#import "PutInView.h"

@interface EditPassWordViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)UIScrollView* mainView;
@property (nonatomic,strong)PutInView* putView;
@property (nonatomic,strong)UIButton* getTwoCode;
@property (nonatomic,strong)NSTimer* timer;
@property (nonatomic,assign)int sens;
@end

@implementation EditPassWordViewController

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.sens = 60;
    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,11,20.5)];
    [leftNavBtn setImage:[[UIImage imageNamed:@"login_back.png"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    // Do any additional setup after loading the view.
    [self createMainView];
}

-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *del=(AppDelegate *)[UIApplication sharedApplication].delegate;
    del.curViewController=self;
}

-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate *del=(AppDelegate *)[UIApplication sharedApplication].delegate;
    del.curViewController=nil;
}

-(void)createMainView
{
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    self.mainView.backgroundColor = WHITE_COLOR;
    
    if(IS_IPHONE4)
    {
        self.mainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 600);
    }else {
        self.mainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT+20);
    }
    [self.view addSubview:self.mainView];
    
    UITapGestureRecognizer* tapEndEditing = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKeyBoard)];
    [self.mainView addGestureRecognizer:tapEndEditing];
    
    //    UIImageView* cancelBtn = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 20, 20)];
    //    cancelBtn.image = [UIImage imageNamed:@"gj_cancel_xx.png"];
    //    [self.mainView addSubview:cancelBtn];
    //    cancelBtn.userInteractionEnabled = YES;
    //    UITapGestureRecognizer* tapClose = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(closeVc)];
    //    [cancelBtn addGestureRecognizer:tapClose];
    
    //    UILabel* titleLab = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-50, 25, 100, 20)];
    //    titleLab.textAlignment = NSTextAlignmentCenter;
    //    titleLab.text = @"找回密码";
    //    titleLab.font = [UIFont boldSystemFontOfSize:18];
    //    titleLab.textColor = BLACK_COLOR;
    //    [self.mainView addSubview:titleLab];
    
    UIImageView* headImgVi = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-85.0/2, 80, 85, 85)];
    headImgVi.image = [UIImage imageNamed:@"1201.png"];
    headImgVi.layer.cornerRadius = 85.0/2;
    headImgVi.layer.masksToBounds = YES;
    headImgVi.backgroundColor = [UIColor lightGrayColor];
    //    [self.mainView addSubview:headImgVi];
    
    NSArray* viewNames = [NSArray array];
    viewNames = @[@"手机号",@"新密码",@"确认新密码",@"验证码"];
    
    self.putView = [[PutInView alloc]initWithFrame:CGRectMake(20, 27, UI_SCREEN_WIDTH-40, 0) and:viewNames];
    self.putView.userInteractionEnabled = YES;
    [self.mainView addSubview:self.putView];
    
    
    self.putView.phoneNumTf.keyboardType = UIKeyboardTypePhonePad;
    self.putView.phoneNumTf.delegate = self;
    
    self.putView.passWordTf.secureTextEntry = YES;
    self.putView.passWordTf.delegate = self;
    
    self.putView.surePwdTf.secureTextEntry = YES;
    self.putView.surePwdTf.delegate = self;
    
    self.putView.twoCodeTf.keyboardType = UIKeyboardTypePhonePad;
    self.putView.twoCodeTf.delegate = self;
    
    self.phoneNumTf = self.putView.phoneNumTf;
    self.passWordTf = self.putView.passWordTf;
    self.surePwdTf = self.putView.surePwdTf;
    self.twoCodeTf = self.putView.twoCodeTf;
    
    self.getTwoCode = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-20-85-5, 23+(viewNames.count - 1)*62 + 2 , 85, 30)];
    [self.getTwoCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getTwoCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.getTwoCode.titleLabel.font = [UIFont systemFontOfSize:14];
    self.getTwoCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _getTwoCode.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    _getTwoCode.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    _getTwoCode.layer.borderWidth = 1;
    [self.mainView addSubview:self.getTwoCode];
    
    [self.getTwoCode addTarget:self action:@selector(getTwoCodeClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat off_Y = 0;
    if (IS_IPHONE4) {
        off_Y = 150;
    }else {
        off_Y = 100;
    }
    UIButton* loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 465-off_Y, UI_SCREEN_WIDTH-50, 47)];
    loginBtn.layer.cornerRadius = 47/2;
    [loginBtn setTitle:@"确认找回" forState:UIControlStateNormal];
    [loginBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(goEditPwd) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    loginBtn.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    loginBtn.layer.borderWidth = 2;
    [self.mainView addSubview:loginBtn];
    
    UILabel* loginLab = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(loginBtn.frame)+23, UI_SCREEN_WIDTH-50, 16)];
    [self.mainView addSubview:loginLab];
    
    NSString* registerTitle = @"记得密码?登录";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:registerTitle attributes:nil];
    [str addAttribute:NSForegroundColorAttributeName value:REMIND_COLOR range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"444444"] range:NSMakeRange(5,2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,registerTitle.length)];
    loginLab.textAlignment = NSTextAlignmentCenter;
    loginLab.attributedText = str;
    
    loginLab.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeVc)];
    [loginLab addGestureRecognizer:tap];
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
        self.sens--;
    }else
    {
        [self.timer invalidate];
        self.getTwoCode.userInteractionEnabled = YES;
        [self.getTwoCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getTwoCode setTitleColor:App_Main_Color forState:UIControlStateNormal];
    }
}

-(void)getTwoCodeClick
{
    if(self.phoneNumTf.text.length!=11)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self postTwoCode];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 50*textField.tag);
    [UIView commitAnimations];
}

-(void)missKeyBoard
{
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}

-(void)closeVc
{
    if(self.wp == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)postTwoCode
{
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"register.php1 成功~~");
            [self goGetTwoCode];
            [SVProgressHUD dismissWithSuccess:@"发送成功"];
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

-(void)postEdit
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&phone_num=%@&step=2&password=%@&code=%@",self.phoneNumTf.text, [NSString md5:self.surePwdTf.text],self.twoCodeTf.text];
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

-(void)goEditPwd
{
    if([self.phoneNumTf.text length] != 11)
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }else if([self.passWordTf.text isEqualToString:@""])
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
    }else if([self.twoCodeTf.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self postEdit];
}

- (void)motifyPassword
{
    UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alv.tag = 100;
    [alv show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
