//
//  ApplicationReturnsViewController.m
//  Lemuji
//
//  Created by huang on 15/8/11.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ApplicationReturnsViewController.h"
#import "OrderViewController.h"

@interface ApplicationReturnsViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) NSArray *reasonArray;

@end

@implementation ApplicationReturnsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    curSelectRow=0;
    self.title = @"申请退货";
    self.view.backgroundColor = BACK_COLOR;
    
    allScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    allScrollView.scrollEnabled = NO;
    allScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:allScrollView];
    
    UIButton *btnI=[[UIButton alloc] initWithFrame:allScrollView.bounds];
    btnI.backgroundColor=[UIColor clearColor];
    btnI.layer.cornerRadius=0;
    [btnI addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [allScrollView addSubview:btnI];
    
    UIView *actualReturnedMoneyView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, UI_SCREEN_WIDTH, 51.5)];
    actualReturnedMoneyView.backgroundColor = [UIColor whiteColor];
    
    UILabel *actualReturnedMoneyTextLabel = [[UILabel alloc] init];
    actualReturnedMoneyTextLabel.text = @"实际退款金额:";
    actualReturnedMoneyTextLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    actualReturnedMoneyTextLabel.font = [UIFont systemFontOfSize:17.0];
    CGSize size = [actualReturnedMoneyTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    actualReturnedMoneyTextLabel.frame = CGRectMake(20, 15, size.width, 21.5);
    [actualReturnedMoneyView addSubview:actualReturnedMoneyTextLabel];
    
    UILabel *actualReturnedMoneyCountLabel = [[UILabel alloc] init];
    actualReturnedMoneyCountLabel.textColor = [UIColor colorFromHexCode:@"EB6100"];
    actualReturnedMoneyCountLabel.font = [UIFont systemFontOfSize:15.0];
    actualReturnedMoneyCountLabel.text = [NSString stringWithFormat:@"%@元", self.returnMoney];
    actualReturnedMoneyCountLabel.textAlignment = NSTextAlignmentRight;
    CGSize sizeForMoneyLabel = [actualReturnedMoneyCountLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 21.5)];
    actualReturnedMoneyCountLabel.frame = CGRectMake(UI_SCREEN_WIDTH - sizeForMoneyLabel.width - 30, 15, sizeForMoneyLabel.width, 21.5);
    [actualReturnedMoneyView addSubview:actualReturnedMoneyCountLabel];
    [allScrollView addSubview:actualReturnedMoneyView];
    
    UILabel *reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(actualReturnedMoneyView.frame), UI_SCREEN_WIDTH - 40, 39.5)];
    reasonLabel.text = @"退货原因";
    reasonLabel.font = [UIFont systemFontOfSize:16.0];
    reasonLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    [allScrollView addSubview:reasonLabel];
    
    UIView *selectReasonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(reasonLabel.frame), UI_SCREEN_WIDTH, 47)];
    selectReasonView.backgroundColor = [UIColor whiteColor];
    
    selectReasonTextLabel = [[UITextField alloc] init];
    selectReasonTextLabel.text = @"请选择退货原因";
    selectReasonTextLabel.delegate=self;
    selectReasonTextLabel.inputView=[self getReasonPickerView];
    selectReasonTextLabel.inputAccessoryView=[self getToolBar];
    selectReasonTextLabel.textColor = [UIColor colorFromHexCode:@"EB6100"];
    selectReasonTextLabel.font = [UIFont systemFontOfSize:18.0];
    CGSize sizeForSelectLabel = [selectReasonTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    selectReasonTextLabel.frame = CGRectMake(20, 16, sizeForSelectLabel.width, 18.5);
    [selectReasonView addSubview:selectReasonTextLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 30, 0, 20, 47)];
    arrowImageView.image = [UIImage imageNamed:@"iconfont-xiala.png"];
    arrowImageView.contentMode=UIViewContentModeCenter;
    [selectReasonView addSubview:arrowImageView];
    
    [selectReasonView addTarget:self action:@selector(showReasonPickerView) forControlEvents:UIControlEventTouchUpInside];
    [allScrollView addSubview:selectReasonView];
    
    UILabel *explanationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(selectReasonView.frame), UI_SCREEN_WIDTH - 40, 39.5)];
    explanationLabel.text = @"退货说明(选填)";
    explanationLabel.font = [UIFont systemFontOfSize:16.0];
    explanationLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    [allScrollView addSubview:explanationLabel];
    
    UIView *explanationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(explanationLabel.frame), UI_SCREEN_WIDTH, 200)];
    explanationView.backgroundColor = [UIColor whiteColor];
    explanationTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 15, UI_SCREEN_WIDTH - 40, 170)];
    explanationTextField.delegate = self;
    explanationTextField.placeholder = @"请输入其他退款说明";
    explanationTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [explanationView addSubview:explanationTextField];
    [allScrollView addSubview:explanationView];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-64-40, UI_SCREEN_WIDTH, 40)];
    [sureButton setTitle:@"确认退货" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setBackgroundColor:App_Main_Color];
    [sureButton addTarget:self action:@selector(sureApplicationReturns) forControlEvents:UIControlEventTouchUpInside];
    [allScrollView addSubview:sureButton];
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    cancelLabel.backgroundColor = [UIColor clearColor];
    cancelLabel.font = [UIFont systemFontOfSize:15];
    cancelLabel.text = @"取消";
    cancelLabel.textColor = WHITE_COLOR; 
    CGSize sizeForCancel = [cancelLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    cancelLabel.frame = CGRectMake(0, 0, sizeForCancel.width, 20);
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelLabel];
    self.navigationItem.leftBarButtonItem = cancelBarButton;

    [cancelLabel addTarget:self action:@selector(popCurrentViewContorller) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view.
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _reasonArray.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_reasonArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    curSelectRow=row;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==selectReasonTextLabel) {
        [allScrollView setContentOffset:CGPointMake(0, 30) animated:YES];
    }
    if (textField==explanationTextField) {
        [allScrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}



#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self postApplyBackCom];
    }
}

#pragma mark - 申请退货
-(void)postApplyBackCom
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=7&order_title=%@&reason=%@&other=%@", self.orderId, selectReasonTextLabel.text, explanationTextField.text];
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo_lemuji.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismissWithSuccess:@"提交成功"];
            for (UIViewController* vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[OrderViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];                    
                }
            }
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

#pragma mark - Sure Button Click Method
- (void)sureApplicationReturns
{
    if([selectReasonTextLabel.text isEqualToString:@""] ||
       [selectReasonTextLabel.text isEqualToString:@"请选择退货原因"])
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请选择退货原因" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认退货？此操作不可撤销" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

#pragma mark - Select Reason View Click Method

-(void)showReasonPickerView{
    [selectReasonTextLabel becomeFirstResponder];
}

- (UIPickerView *)getReasonPickerView
{
    _reasonArray = [[NSArray alloc] initWithObjects:@"商品破损", @"商品错发", @"商品需要维修", @"发票问题", @"收到商品不符", @"我不需要了", @"商品质量问题",nil];
    
    if (reasonPickerView==nil) {
        reasonPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200)];
        reasonPickerView.dataSource = self;
        reasonPickerView.delegate = self;
        reasonPickerView.backgroundColor=[UIColor whiteColor];
    }
    return reasonPickerView;
}

- (UIView *)getToolBar
{
    UIView *tempToolBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
    tempToolBar.backgroundColor=LINE_SHALLOW_COLOR;
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, 44, 30)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor clearColor];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    [tempToolBar addSubview:btn];
    
    
    UIButton *btn1=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-10-44, 0, 44, 30)];
    [btn1 setTitle:@"完成" forState:UIControlStateNormal];
    [btn1 setTitleColor:App_Main_Color forState:UIControlStateNormal];
    btn1.backgroundColor=[UIColor clearColor];
    btn1.titleLabel.font=[UIFont systemFontOfSize:14];
     [btn1 addTarget:self action:@selector(finishSelect) forControlEvents:UIControlEventTouchUpInside];
    [tempToolBar addSubview:btn1];
    
    return tempToolBar;
}

-(void)cancelSelect{
    [self.view endEditing:YES];
    [allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)finishSelect{
    [self.view endEditing:YES];
    [allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    if (curSelectRow<_reasonArray.count) {
        curString=[_reasonArray objectAtIndex:curSelectRow];
    }
    selectReasonTextLabel.text=curString;
}


-(void)missKeyBoard{
    [self.view endEditing:YES];
    [allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Pop Current View Controller
- (void)popCurrentViewContorller
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
