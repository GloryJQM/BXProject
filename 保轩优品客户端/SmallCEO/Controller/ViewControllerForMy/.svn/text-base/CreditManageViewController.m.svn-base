//
//  CreditManageViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

static const NSInteger distanceFromTop = 7.5;

#import "CreditManageViewController.h"
#import "GeneralInfoTableViewCell.h"
#import "ApplyRecordViewController.h"

@interface CreditManageViewController () <UIAlertViewDelegate>

@end

@implementation CreditManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"授信管理";
    
    [self createMainView];
    [self getCreditstatus];
    // Do any additional setup after loading the view.
}

- (void)createMainView
{
    contentViewsArray = [[NSMutableArray alloc] initWithCapacity:0];
    CGFloat cellHeight = 45;
    NSArray *textArray = [NSArray arrayWithObjects:@"申请授信", @"授信申请纪录", nil];
    for (int i = 0; i < textArray.count; i++) {
        GeneralInfoTableViewCell *cell = [[GeneralInfoTableViewCell alloc] initWithFrame:CGRectMake(0, distanceFromTop + cellHeight * i, UI_SCREEN_WIDTH, cellHeight) type:GeneralInfoViewTypeWithDetailLabel];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tag = i;
        cell.leftTextLabel.text = [textArray objectAtIndex:i];
        [cell addTarget:self action:@selector(cellDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
        [self.view addSubview:cell];
        [contentViewsArray addObject:cell];
    }
}

#pragma mark - 授信相关请求
-(void)getCreditstatus
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_credit_apply.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=status"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject:%@",responseObject);
                               GeneralInfoTableViewCell *cell=[contentViewsArray objectAtIndex:0];
                               
                               if ([[responseObject objectForKey:@"is_success"] intValue] == 1)
                               {
                                   isCanPostCredit = [[responseObject objectForKey:@"status"] intValue] == 1;
                                   cell.leftTextLabel.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status_txt"]];
                                   cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status_desc"]];
                                   cell.detailTextLabel.textColor = [UIColor colorFromHexCode:@"aaaaaa"];
                                   [SVProgressHUD dismiss];
                               }
                               else
                               {
                                   [SVProgressHUD dismissWithError:@"获取状态失败"];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

-(void)postUpCredit
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_credit_apply.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=apply"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject:%@",responseObject);
                               if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
                                   [SVProgressHUD dismiss];
                                   [self getCreditstatus];
                               }else {
                                   [SVProgressHUD dismissWithError:@"申请失败"];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

#pragma mark - cell点击事件
- (void)cellDidClick:(GeneralInfoTableViewCell *)cell
{
    if (cell.tag == 0)
    {
        if (isCanPostCredit)
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定申请授信吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"不能重复申请" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    else if (cell.tag == 1)
    {
        ApplyRecordViewController * applyRecordVC = [[ApplyRecordViewController alloc]init];
        [self.navigationController pushViewController:applyRecordVC animated:YES];
        return;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self postUpCredit];
    }
}

@end
