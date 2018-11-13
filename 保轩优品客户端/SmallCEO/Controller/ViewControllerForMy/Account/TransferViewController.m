//
//  TransferViewController.m
//  SmallCEO
//
//  Created by peterwang on 17/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "TransferViewController.h"
#import "BQCoinFailViewController.h"
#import "BQCoinSuccessViewController.h"
#import "CumulativeGainViewController.h"

@interface TransferViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIScrollView* mainView;
@property (nonatomic,strong) UILabel *titleLabel;//我的。。。
@property (nonatomic,strong) UILabel *moneyLabel;//数量
@property (nonatomic,strong) UILabel *maxLabel;//可转数量
@property (nonatomic,strong) UILabel *tipLabel;//操作提示
@property (nonatomic,strong) UITextField *inputTextfield;
@property (nonatomic,strong) NSMutableArray *fieldArray;
@property (nonatomic,strong) UILabel *getcodeLabel;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int sens;
@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIView *bottom;
@property (nonatomic, copy) NSString *phoneStr;
@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    [self createView];
    [self initData];
}
- (void)createView {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    self.mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.mainView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainView];

    _back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 220 - 30)];
    _back.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:_back];
    
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, 10, UI_SCREEN_WIDTH-80, UI_SCREEN_WIDTH/5)];
    titleImage.image = [UIImage imageNamed:@"pho-zhuanzhang@2x"];
    [_mainView addSubview:titleImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleImage.maxY+10, UI_SCREEN_WIDTH, 20)];
    _titleLabel.text = [NSString stringWithFormat:@"我的%@",self.type];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [_mainView addSubview:_titleLabel];
    
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.maxY + 5, UI_SCREEN_WIDTH, 25)];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.font = [UIFont systemFontOfSize:25];
    _moneyLabel.text = @"0.00";
    [_mainView addSubview:_moneyLabel];
    
    _maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _moneyLabel.maxY+10, UI_SCREEN_WIDTH, 20)];
    _maxLabel.textAlignment = NSTextAlignmentCenter;
    _maxLabel.textColor = [UIColor lightGrayColor];
    _maxLabel.font = [UIFont systemFontOfSize:15];
    _maxLabel.text = @"当前最多可转出积分0.00";
    [_mainView addSubview:_maxLabel];
    
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _back.maxY+10, UI_SCREEN_WIDTH, 20)];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor redColor];
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.text = @"对不起:转出的数量超出额度";
    _tipLabel.hidden = YES;
    [_mainView addSubview:_tipLabel];
    NSArray *prefixAr = @[@"转出金额",@"转入帐户",@"验证码"];
    NSArray *placeholdeAr = @[@"输入金额",@"请写您要转入的手机号码",@"点击按钮获取验证码"];
    _fieldArray = [NSMutableArray new];
    _bottom = [[UIView alloc]initWithFrame:CGRectMake(0, _back.maxY + 5, UI_SCREEN_WIDTH, 3 * 55)];
    _bottom.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:_bottom];
    for (int i = 0; i<3; i++) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, i*55, UI_SCREEN_WIDTH-20, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [_bottom addSubview:backView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 65, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = prefixAr[i];
        [backView addSubview:label];
        
        
        _inputTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.maxX, 15, 200, 20)];
        _inputTextfield.tag = i+1;
        _inputTextfield.delegate = self;
        _inputTextfield.font = [UIFont systemFontOfSize:15];
        _inputTextfield.placeholder = placeholdeAr[i];
        [_inputTextfield setValue:[UIFont systemFontOfSize:15]forKeyPath:@"_placeholderLabel.font"];
        
        [backView addSubview:_inputTextfield];
        
        //加入一个收起键盘按钮
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        _inputTextfield.inputAccessoryView=btnT;
        
        if (i == 0) {
            _inputTextfield.frame = CGRectMake(label.maxX, 15, UI_SCREEN_WIDTH - label.maxX - 20, 20);
            _inputTextfield.font = [UIFont systemFontOfSize:20];
            _inputTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
             _inputTextfield.font = [UIFont systemFontOfSize:15];
            
            [_inputTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            _inputTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        }
        if (i == 1) {
            _inputTextfield.keyboardType = UIKeyboardTypePhonePad;
            _inputTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
        if (i == 2) {
            _inputTextfield.frame = CGRectMake(label.maxX, 15, 140, 20);
            _inputTextfield.keyboardType = UIKeyboardTypeNumberPad;
            _inputTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            _getcodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-100, 15, 70, 20)];
            _getcodeLabel.text = @"获取验证码";
            _getcodeLabel.textAlignment = NSTextAlignmentCenter;
            _getcodeLabel.layer.cornerRadius = 10;
            _getcodeLabel.layer.masksToBounds = YES;
            _getcodeLabel.font = [UIFont systemFontOfSize:13];
            _getcodeLabel.textColor = App_Main_Color;
            _getcodeLabel.userInteractionEnabled = YES;
            [backView addSubview:_getcodeLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(getVertifyCode)];
            [_getcodeLabel addGestureRecognizer:tap];
        }
        
        //field放入熟组
        
        [_fieldArray addObject:_inputTextfield];
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, UI_SCREEN_HEIGHT-80-64, UI_SCREEN_WIDTH-20, 45)];
    btn.backgroundColor = App_Main_Color;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [_mainView addSubview:btn];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    [self.mainView addGestureRecognizer:tap];
}

#pragma  mark  点击背景
-(void)tap:(id)sender
{
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}
#pragma  mark 私有
-(void)missKeyBoard
{
    [self.view endEditing:YES];
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}
- (void)confirm{
    UITextField *field = _fieldArray[0];
    if([field.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入转账金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    if ([field.text floatValue]>[_moneyLabel.text floatValue]) {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"转出的数量超过额度" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    UITextField *field1 = _fieldArray[1];
    if (![self validateMobile:field1.text]) {
        return;
    }
    
    if ([field1.text isEqualToString:self.phoneStr]) {
        [SVProgressHUD showErrorWithStatus:@"不能给自己转账"];
        return;
    }
    
    
    UITextField *field2 = _fieldArray[2];
    if([field2.text isEqualToString:@""])
    {
        UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alv show];
        return;
    }
    [self transferAccount];
}

// 验证手机号
- (BOOL)validateMobile:(NSString* )mobileNumber {
    if ([mobileNumber length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return NO;
    }
    
    if ([mobileNumber length] != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确格式的手机号码"];
        return NO;
    }
    return YES;
}

- (void)ShowAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}
- (void)FailtoTransfer {
    BQCoinFailViewController *fail = [BQCoinFailViewController new];
    fail.type = _type;
    [self.navigationController pushViewController:fail animated:YES];
}
#pragma -mark 开始倒计时
-(void)setCountDown
{
    self.sens = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timercount) userInfo:nil repeats:YES];
    _getcodeLabel.userInteractionEnabled = NO;
    [self.timer fire];
    [self missKeyBoard];
}
-(void)timercount
{
    if(self.sens>=0)
    {
        NSString* str = [NSString stringWithFormat:@"%ds重新获取",self.sens];
        _getcodeLabel.text = str;
        _getcodeLabel.textColor = REMIND_COLOR;
        self.sens--;
    }else
    {
        [self.timer invalidate];
        _getcodeLabel.userInteractionEnabled = YES;
        _getcodeLabel.text = @"获取验证码";
        _getcodeLabel.textColor = App_Main_Color;
    }
}
#pragma  mark textfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    Animation_Appear 0.2];
    self.mainView.contentOffset = CGPointMake(0, 60*textField.tag);
    [UIView commitAnimations];
}
//判断输入的金额是否过大
-(void)textFieldDidChange :(UITextField *)theTextField{
    /*正常金额验证避免多个. */
    NSString *str = theTextField.text;
    NSInteger d = 0;//作为多个.的标识
    for(int i =0; i < str.length; i++)
    {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"."]) {
            d++;
        }
    }
    if (str.length>1) {
        if ([[str substringFromIndex:str.length-1] isEqualToString:@"."]&&d > 1) {
            theTextField.text = [str substringToIndex:str.length - 1];
        }
    }
    
    DLog(@"%@",theTextField.text);
    if ([theTextField.text floatValue] >[_moneyLabel.text floatValue]){
        _tipLabel.hidden = NO;
        _bottom.frame = CGRectMake(0, _back.maxY + 40, UI_SCREEN_WIDTH, 3 * 55);
    }else {
        _tipLabel.hidden = YES;
        _bottom.frame = CGRectMake(0, _back.maxY + 5, UI_SCREEN_WIDTH, 3 * 55);
    }
}
#pragma  mark http
- (void)initData {
    [SVProgressHUD show];
    NSString *str;
    if ([_type isEqualToString:@"金币"]) {
        str =  MOBILE_SERVER_URL(@"goldApi.php");
    }else if ([_type isEqualToString:@"积分"]){
        str =  MOBILE_SERVER_URL(@"pointsApi.php");
    }
    NSString *bodyStr = [NSString stringWithFormat:@"act=2"];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   self.phoneStr = [NSString stringWithFormat:@"%@", responseObject[@"customer_name"]];
                                   if ([_type isEqualToString:@"金币"]) {
                                       _moneyLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"curr_gold_number"]];
                                   }else {
                                       _moneyLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"curr_points_number"]];
                                   }
                                   _maxLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"transfer_txt"]];
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                                   }
                               }
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
- (void)getVertifyCode {
    UITextField *field1 = _fieldArray[1];
    if (![self validateMobile:field1.text]) {
        return;
    }
    
    [SVProgressHUD show];
    NSString *str;
    if ([_type isEqualToString:@"金币"]) {
        str =  MOBILE_SERVER_URL(@"goldApi.php");
    }else if ([_type isEqualToString:@"积分"]){
        str =  MOBILE_SERVER_URL(@"pointsApi.php");
    }
    NSString *bodyStr = [NSString stringWithFormat:@"act=3"];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   [self setCountDown];
                                   
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
- (void)transferAccount{
    [SVProgressHUD show];
    NSString *str;
    NSString *bodyStr;
    UITextField *number = _fieldArray[0];
    UITextField *name = _fieldArray[1];
    UITextField *code = _fieldArray[2];
    //构建请求体
    if ([_type isEqualToString:@"金币"]) {
        str =  MOBILE_SERVER_URL(@"goldApi.php");
        bodyStr = [NSString stringWithFormat:@"act=4&i_username=%@&verification_code=%@&gold_number=%@",name.text,code.text,number.text];
    }else if ([_type isEqualToString:@"积分"]){
        str =  MOBILE_SERVER_URL(@"pointsApi.php");
        bodyStr = [NSString stringWithFormat:@"act=4&i_username=%@&verification_code=%@&points_number=%@",name.text,code.text,number.text];
    }
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   //跳转到成功界面
                                   BQCoinSuccessViewController *sucess = [BQCoinSuccessViewController new];
                                   sucess.dataDic = responseObject;
                                   sucess.type = _type;
                                   [self.navigationController pushViewController:sucess animated:YES];
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                                   }
                                   [self FailtoTransfer];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               [self FailtoTransfer];
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
