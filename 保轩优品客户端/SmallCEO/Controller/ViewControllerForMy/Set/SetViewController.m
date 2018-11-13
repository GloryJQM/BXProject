//
//  SetViewController.m
//  Jiang
//
//  Created by Cai on 16/10/25.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "SetViewController.h"
#import "SetSecretViewController.h"
//#import "User.h"
#import "LoginViewController.h"
#import "LoginNavigationController.h"
#import "AbountViewController.h"
#import "APService.h"
#import "LogInAndLogOut.h"

const NSInteger updateViewTag = 999;
const NSInteger forceUpdateViewTag = 888;
const NSInteger newViewTag = 777;


@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *versionDic;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTabView];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTitle:@"退出登录" forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(15, UI_SCREEN_HEIGHT-120, UI_SCREEN_WIDTH-30, 40);
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 3;
    saveButton.backgroundColor = App_Main_Color;
    [saveButton addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}
#pragma mark-创建表视图
- (void)creatTabView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorFromHexCode:@"#F5F5F5"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    //带有检查更新
    //return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //改变单元格分割线长度
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.frame = CGRectMake(20, 18, 120, 20);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"修改登录密码";
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"关于保轩生活";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"检查更新";
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 20, 16, 5, 9)];
    image.image = [UIImage imageNamed:@"icon-jinru@2x"];
    [cell addSubview:image];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SetSecretViewController *setVc = [[SetSecretViewController alloc]init];
        setVc.SecretType = SetLogInSecretType;
        [self.navigationController pushViewController:setVc animated:YES];
    }else if (indexPath.row ==1)
    {
//        SetSecretViewController *setVc = [[SetSecretViewController alloc]init];
//        setVc.SecretType = SetTradeSecretType;
//        [self.navigationController pushViewController:setVc animated:YES];
        AbountViewController *ab = [AbountViewController new];
        [self.navigationController pushViewController:ab animated:YES];

    }else if (indexPath.row == 2)
    {
        AbountViewController *ab = [AbountViewController new];
        [self.navigationController pushViewController:ab animated:YES];
    }else {
        [self getLastVersion];
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
#pragma mark - 版本更新相关
- (void)getLastVersion
{
    [SVProgressHUD show];
    NSString *body = [NSString stringWithFormat:@""];
    NSString *str = SERVER_URL(@"appVersion.php");
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               [SVProgressHUD dismiss];
                               DLog(@"responseObject:%@",responseObject);
                               self.versionDic = responseObject;
                               [self judgeVersionAndUpdate];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

- (void)judgeVersionAndUpdate
{
    if ([[self.versionDic objectForKey:@"is_have_new_version"] integerValue] == 1) {
        NSDictionary *dic = [self.versionDic objectForKey:@"version_info"];
        NSString *newVersion = [dic objectForKey:@"version_num"];
        [[PreferenceManager sharedManager] setPreference:newVersion forKey:@"newVersion"];
        [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@", [dic objectForKey:@"file_path"]] forKey:@"newVersionUrl"];
        if ([newVersion compare:IosAppVersion options:NSNumericSearch] != NSOrderedDescending)
        {
            return;
        }
        if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"is_forced_update"]] isEqualToString:@"1"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"有新版本，将强制更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.tag = forceUpdateViewTag;
            [alertView show];
        }
        else if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"is_forced_update"]] isEqualToString:@"0"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"有新版本，需要更新吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = updateViewTag;
            [alertView show];
        }
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"当前版本是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = newViewTag;
        [alertView show];
    }
}
#pragma mark-退出登录
- (void)logOutAction {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *dic = [self.versionDic objectForKey:@"version_info"];
    NSString *urlStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"file_path"]];
    if (alertView.tag == forceUpdateViewTag)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"发现新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = forceUpdateViewTag;
        [alertView show];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        return;
    }
    else if (alertView.tag == updateViewTag)
    {
        if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
        return;
    }else if (alertView.tag == newViewTag && buttonIndex == 1) {
        
    }else {
        if (buttonIndex == 1) {
            [LogInAndLogOut LogOutFinishBlock:^{
                [self showHomeView];
            }];
        }
    }
}

- (void)showHomeView {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomTabBarController *tab = delegate.tabBarController;
    [tab setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
@end
