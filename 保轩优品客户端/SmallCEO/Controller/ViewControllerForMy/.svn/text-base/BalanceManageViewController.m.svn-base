//
//  BalanceManageViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BalanceManageViewController.h"
#import "BindAlipayAccountViewController.h"
#import "GeneralInfoTableViewCell.h"
#import "VerifyLoginPasswordViewController.h"
#import "IntegrationViewController.h"
#import "CouponViewController.h"
#import "BankCardManageViewController.h"
@interface BalanceManageViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) GeneralInfoTableViewCell *balanceCellView;
@property (nonatomic, assign) BOOL isShowTixian;
@end

@implementation BalanceManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"我的钱包";
    
    [self createMainView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMyBalanceInfo];
}

- (void)createMainView
{
    CGFloat cellHeight = 49;
    NSArray *textArray = [@[] copy];
    if ([[PreferenceManager sharedManager] preferenceForKey:@"isShowTixian"]) {
        textArray = @[@"账户余额",@"可提现金额", @"积分",@"优惠券",@"提现方式管理",@"充值", @"余额转出(提现)", @"支付密码修改"];
        self.isShowTixian = YES;
    }else{
        textArray = @[@"账户余额", @"积分",@"优惠券",@"充值", @"支付密码修改"];
        self.isShowTixian = NO;
    }
    for (int i = 0; i < textArray.count; i++) {
        CGFloat distanceFromTop = 10;
        GeneralInfoTableViewCell *cell = [[GeneralInfoTableViewCell alloc] initWithFrame:CGRectMake(0, distanceFromTop + cellHeight * i, UI_SCREEN_WIDTH, cellHeight)];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tag = i;
        cell.leftTextLabel.text = [textArray objectAtIndex:i];
        [cell addTarget:self action:@selector(cellDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
        
        NSInteger num = 0;
        if (self.isShowTixian) {
            num = 1;
        }
        if (i == 0)
        {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", self.yuEString];
            cell.rightImageView.hidden = YES;
            CGSize sizeForTextLabel = [cell.detailTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 15)];
            cell.detailTextLabel.frame = CGRectMake(UI_SCREEN_WIDTH-sizeForTextLabel.width-10, 15, sizeForTextLabel.width, 19);
        }
        if (i == 1 && self.isShowTixian)
        {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", self.canTixianMoney];;
            CGSize sizeForTextLabel = [cell.detailTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 15)];
            cell.detailTextLabel.frame = CGRectMake(UI_SCREEN_WIDTH-sizeForTextLabel.width-10, 15, sizeForTextLabel.width, 19);
            cell.rightImageView.hidden = YES;
        }
        if (i == 1+num)
        {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
            cell.detailTextLabel.text = self.jiFenString;
        }
        if (i == 2+num)
        {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
            cell.detailTextLabel.text = self.couponString;
        }

        [self.view addSubview:cell];
    }

}

#pragma mark - cell点击事件
- (void)cellDidClick:(GeneralInfoTableViewCell *)cell
{
    if (self.isShowTixian) {
        if (cell.tag == 2) {
            IntegrationViewController*VC = [[IntegrationViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (cell.tag == 3) {
            CouponViewController*VC = [[CouponViewController alloc] init];
            VC.isFromWallet = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (cell.tag == 4) {
            BankCardManageViewController *verifyLoginPwdVC = [[BankCardManageViewController alloc] init];
            [self.navigationController pushViewController:verifyLoginPwdVC animated:YES];
        }
        
        if (cell.tag == 5) {
            /*充值*/
            ChargeViewController *vc = [[ChargeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (cell.tag == 6) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择提现方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"提现到银行卡", @"提现到支付宝", nil];
            [actionSheet showInView:self.view];
        }
        if (cell.tag == 7) {
            VerifyLoginPasswordViewController  *verifyLoginPwdVC = [[VerifyLoginPasswordViewController alloc] init];
            [self.navigationController pushViewController:verifyLoginPwdVC animated:YES];
        }
    }else {
        if (cell.tag == 1) {
            IntegrationViewController*VC = [[IntegrationViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (cell.tag == 2) {
            CouponViewController*VC = [[CouponViewController alloc] init];
            VC.isFromWallet = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (cell.tag == 3) {
            /*充值*/
            ChargeViewController *vc = [[ChargeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (cell.tag == 4) {
            VerifyLoginPasswordViewController  *verifyLoginPwdVC = [[VerifyLoginPasswordViewController alloc] init];
            [self.navigationController pushViewController:verifyLoginPwdVC animated:YES];
        }
 
    }
    
}
#pragma mark - 网络请求
-(void)getBankInfo
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=status"];
    NSString *str=MOBILE_SERVER_URL(@"user_tixian.php");
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
        if ([[responseObject objectForKey:@"is_already_bind_bank"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSArray *tempArr=[responseObject valueForKey:@"bank_list"] ;
            if (tempArr.count>0) {
                TixianViewController *vc=[[TixianViewController alloc] init];
                vc.bankDic = responseObject;
                vc.bankCardDic = [tempArr objectAtIndex:0];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else{
            [SVProgressHUD dismiss];
            
            BindBankCardViewController *vc=[[BindBankCardViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)getBankInfoForAlipayWithData:(NSDictionary *)data
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=status"];
    NSString *str=MOBILE_SERVER_URL(@"user_tixian.php");
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
            DLog(@"成功~~");
            [SVProgressHUD dismiss];

            TixianViewController *vc=[[TixianViewController alloc] init];
            vc.alipayAccountDic = data;
            vc.type = TixianTypeAliPay;
            vc.bankDic = responseObject;
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            if ([responseObject valueForKey:@"info"] != nil)
            {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }
            else
            {
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

- (void)getAlipayAccountData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"zhifubao.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"type=1"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               [SVProgressHUD dismiss];
                               if ([[responseObject objectForKey:@"status"] intValue] == 1)
                               {
                                   [self getBankInfoForAlipayWithData:[responseObject objectForKey:@"content"]];
                               }
                               else
                               {
                                   BindAlipayAccountViewController *bindAlipayAccountVC = [[BindAlipayAccountViewController alloc] init];
                                   bindAlipayAccountVC.type = BindAlipayVCTypeAdd;
                                   [self.navigationController pushViewController:bindAlipayAccountVC animated:YES];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

- (void)getMyBalanceInfo
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_tixian.php");
    NSString *bodyStr = [NSString stringWithFormat:@"act=status"];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                               }
                               
                               NSString *balanceMoneyStr = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"yue"]];
                               if ([balanceMoneyStr isValid])
                               {
                                   self.balanceCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@元", balanceMoneyStr];
                               }
                               else
                               {
                                   self.balanceCellView.detailTextLabel.text = @"0.00元";
                               }
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self getBankInfo];
    }
    else if (buttonIndex == 1)
    {
        [self getAlipayAccountData];
    }
}

@end
