//
//  SettingsViewController.m
//  SmallCEO
//
//  Created by huang on 15/10/13.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

static const CGFloat consumerHotlineViewHeight = 40.0;

#import "AbountViewController.h"
#import "HelpAndFeedbackViewController.h"
#import "PersonalInfoSettingsViewController.h"
#import "SettingsViewController.h"
#import "ShareView.h"
#import "WXApi.h"
#import "SDImageCache.h"
#import "APService.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate,ShareViewDelegate>

@property (nonatomic, copy) NSArray *sectionDetailArray;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = BACK_COLOR;
    
    self.sectionDetailArray = @[@"个人资料设置", @"关于淘不出手", @"清理缓存"];
    
    [self createMainView];
}

- (void)createMainView
{
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - consumerHotlineViewHeight - HeightForNagivationBarAndStatusBar)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.scrollEnabled = NO;
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:mainTableView];
    mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView = mainTableView;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTableView.frame), UI_SCREEN_WIDTH, consumerHotlineViewHeight)];
    [bottomView addTarget:self action:@selector(makeCell) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
    
    UILabel *customerHotlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, (consumerHotlineViewHeight - 28) / 2, 200, 28)];
    customerHotlineLabel.text = [NSString stringWithFormat:@"客服电话: %@", self.customServicePhoneStr];
    CGSize size = [customerHotlineLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 28)];
    CGRect frame = customerHotlineLabel.frame;
    frame.size = CGSizeMake(size.width, 28);
    frame.origin.x = (UI_SCREEN_WIDTH - size.width - 28) / 2;
    customerHotlineLabel.frame = frame;
    [bottomView addSubview:customerHotlineLabel];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(customerHotlineLabel.frame)+2, (consumerHotlineViewHeight - 20) / 2, 20, 20)];
    phoneImageView.image = [UIImage imageNamed:@"phone.png"];
    [bottomView addSubview:phoneImageView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionDetailArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellStrForSettingsVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.sectionDetailArray objectAtIndex:indexPath.row];
    if (indexPath.row == 1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@", IosAppVersion];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    else if (indexPath.row == 2)
    {
//        UIDevice *device = [[UIDevice alloc] init];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM", [[SDImageCache sharedImageCache] getSize]/ 1024.0 / 1024.0];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            PersonalInfoSettingsViewController *personalInfoSettingsVC = [[PersonalInfoSettingsViewController alloc] init];
            [self.navigationController pushViewController:personalInfoSettingsVC animated:YES];
            break;
        }
        case 1:
        {
            AbountViewController *aboutVC = [[AbountViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
        }
        case 2: {
            UIDevice *device=[[UIDevice alloc] init];
            [device removeCache];
            
            [[SDImageCache sharedImageCache] clearDisk];
            DLog(@"cache:%f",[device getCache]);
            [self.mainTableView reloadData];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"清除缓存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44+25+20+UI_SCREEN_WIDTH-140-IPHONE4HEIGHT(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44+25+20+UI_SCREEN_WIDTH-140-IPHONE4HEIGHT(40))];
    footerView.backgroundColor = BACK_COLOR;
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(35, 25, UI_SCREEN_WIDTH - 70, 44);
    [logoutBtn setTitle:@"注销登录" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:App_Main_Color];
    [logoutBtn addTarget:self action:@selector(leaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.layer.cornerRadius = 3;
    logoutBtn.clipsToBounds = YES;
    [footerView addSubview:logoutBtn];

    UIImageView *qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70+IPHONE4HEIGHT(20), CGRectGetMaxY(logoutBtn.frame)+20, UI_SCREEN_WIDTH-140-IPHONE4HEIGHT(40), UI_SCREEN_WIDTH-140-IPHONE4HEIGHT(40))];
    qrImageView.userInteractionEnabled = YES;
    [qrImageView sd_setImageWithURL:[NSURL URLWithString:self.QRUrlStr]];
//    [footerView addSubview:qrImageView];
     UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareOrSaveQRCode)];
    [qrImageView addGestureRecognizer:imgTap];
    
    return footerView;
}
#pragma mark - 二维码点击方法
- (void)shareOrSaveQRCode
{
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信", @"朋友圈"];
    ShareView *shareView = [[ShareView alloc] initWithShareButtonNameArray:sharePlace animation:YES];
    shareView.delegate = self;
    [shareView show];
}

#pragma mark - ShareViewDelegate
- (void)shareView:(ShareView *)shareView clickButtonAtIndex:(NSInteger)index
{
    if (index == 0) {
        [self tellWeixinFriends:self.shareDic];
    }else {
        [self shareWeixin:self.shareDic];
    }
}
#pragma mark - 微信分享和朋友圈的方法
- (void) shareWeixin:(NSDictionary *)response
{
    WXMediaMessage *message = [WXMediaMessage message];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"picurl"]]]];
    message.title = [response objectForKey:@"content"];
    [message setThumbImage:[UIImage imageWithData:data]];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [response objectForKey:@"link"];
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 1;
    
    [WXApi sendReq:req];
}

- (void)tellWeixinFriends:(NSDictionary *)response
{
    NSDictionary *sharedic = [[NSDictionary alloc] initWithDictionary:response];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [sharedic objectForKey:@"content"];
    message.description = [sharedic objectForKey:@"content"];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[sharedic objectForKey:@"picurl"]]]];
    
    
    [message setThumbImage:[UIImage imageWithData:data]];
    WXWebpageObject *ext = [WXWebpageObject object];
    
    ext.webpageUrl = [sharedic objectForKey:@"link"];
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 0;
    
    [WXApi sendReq:req];
}

#pragma mark - 退出登录点击方法
- (void)leaveBtnClick
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"确认退出当前账户?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self logoutwithnet];
    }
}
-(void)logoutwithnet{
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"logout.php");
    TokenURLRequest *requset = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [requset setHTTPMethod:@"POST"];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:requset];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            [SVProgressHUD dismissWithSuccess:@"注销成功"];
            NSNumber *rememberKeyWordValue = [[PreferenceManager sharedManager] preferenceForKey:@"rememberKeyWord"];
            if (!rememberKeyWordValue.boolValue)
            {
                [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"rememberKeyWord"];
//                [[PreferenceManager sharedManager]setPreference:@"" forKey:@"username"];
                [[PreferenceManager sharedManager]setPreference:@"" forKey:@"keyword"];
            }
            [[PreferenceManager sharedManager]setPreference:nil forKey:@"didLogin"];
            [[PreferenceManager sharedManager]setPreference:nil forKey:@"token"];
            [[PreferenceManager sharedManager] setPreference:nil forKey:@"isvip"];
            [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"AutoKeyWord"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"openid"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"avatar"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"alias"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"access_token"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"type"];
            [[PreferenceManager sharedManager] setPreference:nil forKey:@"pushId"];
            [APService setAlias:@"" callbackSelector:nil object:self];
            
            [self showHomeView];
        }else{
            [SVProgressHUD dismissWithError:@"注销失败"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismissWithError:@"网络错误"];
        DLog(@"errorStrign:%@  \nerror:%@",operation.responseString,error);
    }];
    [op start];
}
- (void)showHomeView {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomTabBarController *tab = delegate.tabBarController;
    [tab setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
#pragma mark - 拨打电话方法
- (void)makeCell
{
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.customServicePhoneStr]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}

@end
