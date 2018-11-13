//
//  BankCardDetailsViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankCardDetailsViewController.h"
#import "BankCardManagerTableViewCell.h"

extern const CGFloat bankCardManagerCellHeight;

@interface BankCardDetailsViewController () <UIActionSheetDelegate>

@end

@implementation BankCardDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"银行卡详情";
    
    [self createNagivationBarView];
    [self createMainView];
    // Do any additional setup after loading the view.
}

- (void)createNagivationBarView
{
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(deleteBankCardClick)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
}

- (void)createMainView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, bankCardManagerCellHeight)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [imageView af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_bankCardInfoDic objectForKey:@"picurl"]]]];
    [mainView addSubview:imageView];
    
    UILabel *bankNameLabel = [[UILabel alloc] init];
    bankNameLabel.text = [NSString stringWithFormat:@"%@", [_bankCardInfoDic objectForKey:@"bank_name"]];
    CGSize sizeForNameLabel = [bankNameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    bankNameLabel.frame = CGRectMake(15 + CGRectGetMaxX(imageView.frame), CGRectGetMinY(imageView.frame), sizeForNameLabel.width, 20);
    [mainView addSubview:bankNameLabel];
    
    UILabel *detailInfoLabel = [[UILabel alloc] init];
    NSString *bankCardNumStr = [NSString stringWithFormat:@"%@", [_bankCardInfoDic objectForKey:@"card"]];
    if (bankCardNumStr.length > 4)
    {
        detailInfoLabel.text = [NSString stringWithFormat:@"尾号%@", [bankCardNumStr substringFromIndex:bankCardNumStr.length - 4]];
    }
    else
    {
        detailInfoLabel.text = bankCardNumStr;
    }
    detailInfoLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
    CGSize sizeForDetailInfoLabel = [detailInfoLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
    detailInfoLabel.frame = CGRectMake(15 + CGRectGetMaxX(imageView.frame), CGRectGetMaxY(bankNameLabel.frame), sizeForDetailInfoLabel.width, 20);
    detailInfoLabel.font = [UIFont systemFontOfSize:15.0];
    [mainView addSubview:detailInfoLabel];
    
    UIView *userNameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mainView.frame) + 10, UI_SCREEN_WIDTH, 50)];
    UILabel *cardHolderLabel = [[UILabel alloc] init];
    cardHolderLabel.text = @"持卡人";
    CGSize sizeForCardHolderLabel = [cardHolderLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 30)];
    cardHolderLabel.frame = CGRectMake(15, 10, sizeForCardHolderLabel.width, 30);
    [userNameView addSubview:cardHolderLabel];
    
    UILabel *cardHolderNameLabel = [[UILabel alloc] init];
    cardHolderNameLabel.text = [NSString stringWithFormat:@"%@", [_bankCardInfoDic objectForKey:@"bank_username"]];
    CGSize sizeForCardHolderNameLabel = [cardHolderNameLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 30)];
    cardHolderNameLabel.frame = CGRectMake(20 + CGRectGetMaxX(cardHolderLabel.frame), 10, sizeForCardHolderNameLabel.width, 30);
    [userNameView addSubview:cardHolderNameLabel];
    
    userNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userNameView];
}

#pragma mark - 删除指定银行卡
- (void)requestDeleteBankCard
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_unbind_bank.php");
    NSString *bodyStr = [NSString stringWithFormat:@"bind_id=%@", [_bankCardInfoDic objectForKey:@"bind_id"]];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"删除银行卡失败"];
                               }
                               if (self.deleteBankCardBlock)
                               {
                                   self.deleteBankCardBlock();
                               }
                               [self.navigationController popViewControllerAnimated:YES];
                               [SVProgressHUD dismissWithSuccess:@"删除银行卡成功"];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}


#pragma mark - 按钮点击方法
- (void)deleteBankCardClick
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self requestDeleteBankCard];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
