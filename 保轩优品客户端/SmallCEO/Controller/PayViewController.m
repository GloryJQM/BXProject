//
//  PayViewController.m
//  Lemuji
//
//  Created by gaojun on 15-7-16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "PayViewController.h"
#import "OrderViewController.h"
#import "ShareView.h"
#import "APService.h"
#import "BillsViewController.h"
#import "ProductDetailsViewController.h"

@interface PayViewController () <UIAlertViewDelegate>{
    UIView *_backView;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backWhite;
    self.title = @"支付";
    [self creatView];
    [self creatBottomView];
}


-(void)popViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)creatView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    UIImageView * finishImageView = [[UIImageView alloc] init];
    finishImageView.frame = CGRectMake((UI_SCREEN_WIDTH - 44)/2.0, 20, 44, 44);
    finishImageView.layer.cornerRadius = 30;
    [_backView addSubview:finishImageView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, finishImageView.maxY + 12, UI_SCREEN_WIDTH, 20)];
    priceLabel.textAlignment=NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor colorFromHexCode:@"#3C3C3E"];
    priceLabel.font = [UIFont boldSystemFontOfSize:20];
    [_backView addSubview:priceLabel];
    
    UILabel *finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, priceLabel.maxY + 3, UI_SCREEN_WIDTH, 30)];
    finishLabel.textAlignment=NSTextAlignmentCenter;
    finishLabel.textColor = [UIColor colorFromHexCode:@"#3C3C3E"];
    finishLabel.font = [UIFont systemFontOfSize:15];
    [_backView addSubview:finishLabel];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, finishLabel.maxY + 30, UI_SCREEN_WIDTH - 30, 20)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor colorFromHexCode:@"#3C3C3E"];
    statusLabel.font = [UIFont boldSystemFontOfSize:20];
    [_backView addSubview:statusLabel];
    
    switch (self.payStatusType) {
        case PayStatusTypeFail:{
            finishLabel.text = @"支付失败";
            finishImageView.image =  [UIImage imageNamed:@"logo_failpay.png"];
            _backView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 300);
        }
            break;
        case PayStatusTypeSuccess: {
            finishLabel.text = @"支付完成";
            finishImageView.image =  [UIImage imageNamed:@"s_payFinish.png"];
            
            if ([self.is_luckydraw isEqualToString:@"1"]) {
                _backView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 300);
                UIButton * drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                drawBtn.frame = CGRectMake(0, _backView.maxY + 30, UI_SCREEN_WIDTH, 100);
                [drawBtn setImage:[UIImage imageNamed:@"立即抽奖@2x.png"] forState:UIControlStateNormal];
                [drawBtn addTarget:self action:@selector(handleDrawBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:drawBtn];
            }
        }
            break;
        case PayStatusTypeCancel: {
            finishLabel.text = @"支付取消";
            finishImageView.image =  [UIImage imageNamed:@"logo_failpay.png"];
            _backView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64);
        }
            break;
        default:
            break;
    }
    
    

    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    titleBtn.frame = CGRectMake(0, 248, UI_SCREEN_WIDTH, 15.5);
    [titleBtn setTitle:@"向朋友们炫耀吧~分享到" forState:UIControlStateNormal];
    [titleBtn setTitleColor:SUB_TITLE forState:UIControlStateNormal];
    [self.view addSubview:titleBtn];
    titleBtn.hidden = YES;
    
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信",@"朋友圈"];
    for(int i =0;i<sharePlace.count;i++)
    {
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(15+i*(115.0/2+20), 277, 115.0/2, 115.0/2)];
        btn.center = CGPointMake(UI_SCREEN_WIDTH / 3 * (i + 1), btn.center.y);
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"gj_wechat%d.png",i]] forState:UIControlStateNormal];
        
        UILabel* nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15+i*(115.0/2+20), 277+60, 115.0/2, 20)];
        nameLab.center = CGPointMake(UI_SCREEN_WIDTH / 3 * (i + 1), nameLab.center.y);
        nameLab.text = sharePlace[i];
        nameLab.textAlignment = NSTextAlignmentCenter;
        
        [btn addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        [self.view addSubview:nameLab];
        btn.hidden = YES;
        nameLab.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCouponAfterShareSuccess) name:@"shareSuccessAfterPay" object:nil];
}

//点击抽奖
- (void)handleDrawBtn:(UIButton *)sender {
    NSMutableArray *array = [NSMutableArray array] ;
    [array addObject:self.navigationController.viewControllers.firstObject];
    ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
    [array addObject:viewController];
    [self.navigationController setViewControllers:array animated:YES];
   
    [viewController loadWebView:@"http://app.bxuping.com/mobile/prize/index.php"];
}

- (void)creatBottomView {
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, 300 - 80, UI_SCREEN_WIDTH, 40)];
    [self.view addSubview:_buttomView];
    
    NSArray * titleArray;
    if (self.payType == PayDeafult) {
        titleArray = @[@"返回首页", @"查看订单"];
    }else if (self.payType == PayShop) {
        switch (self.payStatusType) {
            case PayStatusTypeFail:
            {
                titleArray = @[@"返回首页", @"继续支付"];
            }
                break;
            case PayStatusTypeSuccess:
            {
                titleArray = @[@"返回首页", @"查看消费详情"];
            }
                break;
            case PayStatusTypeCancel:
            {
                titleArray = @[@"返回首页", @"继续支付"];
            }
                break;
            default:
                break;
        }
    }
    
    for (int i = 0; i < titleArray.count; i++) {
        
        self.twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 + ((UI_SCREEN_WIDTH - 120) / 2 + 40) * i, 0, (UI_SCREEN_WIDTH - 120) / 2, 40)];
        self.twoLabel.layer.cornerRadius = 20;
        self.twoLabel.layer.masksToBounds = YES;
        self.twoLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.twoLabel.layer.borderWidth = 1;
        self.twoLabel.text = [titleArray objectAtIndex:i];
        self.twoLabel.font = [UIFont systemFontOfSize:14];
        self.twoLabel.textColor = [UIColor blackColor];
        _twoLabel.tag = 101 + i;
        [_buttomView addSubview:self.twoLabel];
        
        _twoLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
        [_twoLabel addGestureRecognizer:tap];
        _twoLabel.textAlignment = NSTextAlignmentCenter;
        
    }
}
- (void)doClick:(id)sender
{
    UILabel * label = (UILabel *)[sender view];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.navigationController.viewControllers.firstObject];
    if ([label.text isEqualToString:@"查看订单"]) {
        OrderViewController * orderVC = [[OrderViewController alloc] init];
        [array addObject:orderVC];
        [self.navigationController setViewControllers:array animated:YES];
    }else if ([label.text isEqualToString:@"继续支付"]){
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([label.text isEqualToString:@"查看消费详情"]){
        BillsViewController *bill = [[BillsViewController alloc]init];
        [array addObject:bill];
        [self.navigationController setViewControllers:array animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self tellfriendGetData:1];
        return;
    }else if (buttonIndex == 1){
        [self tellfriendGetData:2];
        return;
    }
}

-(void)clickShare:(UIButton*)btn {
    [[PreferenceManager sharedManager] setPreference:self.shareOrderId forKey:@"orderTitle"];
    [self tellfriendGetData:btn.tag+1];
}

-(void)tellfriendGetData:(NSInteger)type {
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"shareorder.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"order_title=%@",self.shareOrderId];
    NSLog(@"body%@",body);
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
    [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"tellPaymentTypegetMyContact_responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        [_shareDic setObject:[NSDictionary dictionaryWithDictionary:responseObject] forKey:@"sharedata"];
        if (type == 1) {
            [self tellWeixinFriends:responseObject];
        }else if (type == 2) {
            [self shareWeixin:responseObject];
        }
        [self.alview cancelClick];
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@   responseString:%@",error,operation.responseString);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op_yue start];
}

//微信朋友圈
- (void) shareWeixin:(NSDictionary *)response {
    NSLog(@"微信分享");
    [SVProgressHUD dismiss];
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



//微信好友
- (void)tellWeixinFriends:(NSDictionary *)response
{
    NSLog(@"告诉微信朋友");
    //     NSDictionary *sharedic = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://www.4228999.com/?u_register-",@"appIOS", @"http://www.4228999.com/?u_register-",@"link",@"http://www.4228999.com/templet/admin2014/images/logo.png",@"picurl",@"我注册了App_Product_Name，现在邀请你来一起淘,点击链接，即可获得会员红包。",@"content",App_Product_Name,@"title",nil];
    NSDictionary *sharedic = [[NSDictionary alloc] initWithDictionary:response];
    
   /* WXMediaMessage *message = [WXMediaMessage message];
    message.title = [sharedic objectForKey:@"content"];
    //    message.title = App_Product_Name;
    //    message.description = @"App_Product_Name,你值得拥有,赶紧去下载吧";
    
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
    
    [WXApi sendReq:req];*/
}

#pragma mark - 优惠券获得接口
- (void)addCouponAfterShareSuccess
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.delegate = self;
    [alertView show];
}

- (void)getCoupon
{
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"sharegetquan.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"order_title=%@",self.shareOrderId];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
    [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue] == 1)
        {
            [SVProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"info"]]];
        }
        else
        {
            [SVProgressHUD dismiss];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@   responseString:%@",error,operation.responseString);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op_yue start];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 987)
    {
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"didLogin"];
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"token"];
        [[PreferenceManager sharedManager] setPreference:nil forKey:@"isvip"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"username"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"keyword"];
        [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"rememberKeyWord"];
        [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"AutoKeyWord"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"openid"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"avatar"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"alias"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"access_token"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"type"];
        [[PreferenceManager sharedManager] setPreference:nil forKey:@"pushId"];
        [APService setAlias:@"" callbackSelector:nil object:self];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        CustomTabBarController *tab = delegate.tabBarController;
        [tab setSelectedIndex:0];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else {
        [self getCoupon];
    }
}
#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
