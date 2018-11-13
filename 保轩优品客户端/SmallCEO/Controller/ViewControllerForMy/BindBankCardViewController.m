//
//  BindBankCardViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankSelectView.h"
#import "BindBankCardViewController.h"
#import "GeneralInfoTableViewCell.h"

@interface BindBankCardViewController () <UITextFieldDelegate, BankSelectViewDelegate>

@property (nonatomic, copy)   NSMutableArray *textFiledArray;
@property (nonatomic, copy)   NSArray *bankInfoArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) GeneralInfoTableViewCell *cell;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"绑定银行卡";
    self.selectedIndex = -1;
    _textFiledArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self createMainView];
}

- (void)createMainView
{
    CGFloat gapFromEdge = 15.0;
    CGFloat gapDistance = 15.0;
    CGFloat cellHeight = 44;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar);
    [self.view addSubview:self.scrollView];
    [self.scrollView addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    GeneralInfoTableViewCell *cell = [[GeneralInfoTableViewCell alloc] initWithFrame:CGRectMake(0, gapDistance, UI_SCREEN_WIDTH, cellHeight)];
    cell.backgroundColor = [UIColor whiteColor];
    cell.leftTextLabel.text = @"所属银行";
    cell.detailTextLabel.text = @"请选择您的银行卡";
    cell.leftTextLabel.font = [UIFont systemFontOfSize:15.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
    cell.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    CGRect frameForCell = cell.detailTextLabel.frame;
    frameForCell.origin.x = CGRectGetMaxX(cell.leftTextLabel.frame) + gapDistance;
    cell.detailTextLabel.frame = frameForCell;
    [cell addTarget:self action:@selector(cellDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:cell];
    self.cell = cell;
    
    NSArray *textArray = [NSArray arrayWithObjects:@"卡号", @"预留手机号", @"持卡人", nil];
    NSArray *placeHolderTextArray = [NSArray arrayWithObjects:@"请输入正确的银行卡卡号", @"请输入您在银行预留的手机号", @"请输入持卡人姓名", nil];
    for (int i = 0; i < textArray.count; i++) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, (i + 1) * cellHeight + (i + 2) * gapDistance, UI_SCREEN_WIDTH, cellHeight)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [backgroundView addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:backgroundView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [textArray objectAtIndex:i];
        CGSize sizeForLabel = [label sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, cellHeight)];
        label.frame = CGRectMake(gapFromEdge, 0, sizeForLabel.width, cellHeight);
        [backgroundView addSubview:label];
        label.font = [UIFont systemFontOfSize:15.0];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + gapDistance, CGRectGetMinY(label.frame), UI_SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 2 * gapDistance, cellHeight)];
        textField.placeholder = [placeHolderTextArray objectAtIndex:i];
        textField.font = [UIFont systemFontOfSize:14.0];
        if (i != 2)
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        textField.delegate = self;
        [backgroundView addSubview:textField];
        
        [_textFiledArray addObject:textField];
    }
    
    CGFloat heightForBottomView = 44+15;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - heightForBottomView - HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, heightForBottomView)];
    [self.scrollView addSubview:bottomView];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(15, 0, UI_SCREEN_WIDTH-30, 44);
    [saveButton setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    saveButton.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    saveButton.layer.borderWidth = 1;
    [saveButton addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:saveButton];
}

- (void)createBankSelectView
{
    [BankSelectView sharedView].delegate = self;
    [BankSelectView setBankInfoArray:_bankInfoArray];
    [BankSelectView show];
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == [_textFiledArray objectAtIndex:2])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
    else if (textField == [_textFiledArray objectAtIndex:1])
    {
        [self.scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - BankSelectViewDelegate
- (void)bankSelectView:(BankSelectView *)view didSelectAtIndex:(NSInteger)index
{
    self.selectedIndex = index + 1;
    self.cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[_bankInfoArray objectAtIndex:index] objectForKey:@"name"]];
    self.cell.detailTextLabel.textColor = [UIColor blackColor];
}

#pragma mark - 按钮点击方法
-(void)missKeyBoard
{
    [self.view endEditing:YES];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)cellDidClick:(id)sender
{
    [self.view endEditing:YES];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [self getBankInfo];
}

- (void)saveBtnClick
{
    for (UITextField *textField in _textFiledArray) {
        if ([textField.text isEqualToString:@""])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    
    if (self.selectedIndex == -1)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UITextField *textFieldForCardNum = [_textFiledArray objectAtIndex:0];
    if (textFieldForCardNum.text.length < 16 ||
        textFieldForCardNum.text.length >19)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入正确的银行卡位数" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UITextField *textFieldForPhoneNum = [_textFiledArray objectAtIndex:1];
    if (textFieldForPhoneNum.text.length != 11)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self bindBankCard];
}

- (void)getBankInfo
{
    NSString *str = MOBILE_SERVER_URL(@"bank.php");
    NSString *bodyStr = [NSString stringWithFormat:@"type=1"];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               _bankInfoArray = [responseObject objectForKey:@"content"];
                               if ([_bankInfoArray isKindOfClass:[NSArray class]]) {
                                   [self createBankSelectView];
                               }
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

- (void)bindBankCard
{
    UITextField *cardNumberTextField = [_textFiledArray objectAtIndex:0];
    UITextField *phoneNumberTextField = [_textFiledArray objectAtIndex:1];
    UITextField *nameTextField = [_textFiledArray objectAtIndex:2];
    
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"bank.php");
    NSString *bodyStr = [NSString stringWithFormat:@"type=2&bank_id=%d&phone_num=%@&card=%@&name=%@", self.selectedIndex, phoneNumberTextField.text, cardNumberTextField.text, nameTextField.text];
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
                               
                               if (self.addBankCardBlock)
                               {
                                   self.addBankCardBlock();
                               }
                               
                               [self.navigationController popViewControllerAnimated:YES];
                               [SVProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"info"]]];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
