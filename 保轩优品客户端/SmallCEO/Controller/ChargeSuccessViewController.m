//
//  ChargeSuccessViewController.m
//  SmallCEO
//
//  Created by quanmai on 15/9/10.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//


#import "ChargeSuccessViewController.h"
#import "ShareView.h"

@interface ChargeSuccessViewController () <UIAlertViewDelegate>
@end

@implementation ChargeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"充值";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftNavBtn setImage:[[UIImage imageNamed:@"zaiNav_back.png"] imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    [self creatView];
    [self creatBottomView];
    
    // Do any additional setup after loading the view.
}

-(void)popViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)creatView
{
    UIImageView * finishImageView = [[UIImageView alloc] init];
    finishImageView.frame = CGRectMake((UI_SCREEN_WIDTH-150)/2.0, 44 , 150, 150);
    finishImageView.layer.cornerRadius = 75;
    [self.view addSubview:finishImageView];
    
    UILabel * finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, UI_SCREEN_WIDTH, 30)];
    finishLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:finishLabel];
    
    switch (self.chargeStatusType) {
        case ChargeStatusTypeFail:
        {
            finishLabel.text = @"充值失败";
            finishImageView.image =  [UIImage imageNamed:@"logo_failpay.png"];
        }
            break;
        case ChargeStatusTypeSuccess:
        {
            finishLabel.text = @"充值成功";
            finishImageView.image =  [UIImage imageNamed:@"s_payFinish.png"];
        }
            break;
        case ChargeStatusTypeCancel:
        {
            finishLabel.text = @"充值取消";
            finishImageView.image =  [UIImage imageNamed:@"logo_failpay.png"];
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

- (void)creatBottomView
{
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 46 - 64, UI_SCREEN_WIDTH, 46)];
    [self.view addSubview:_buttomView];
    
    NSArray * titleArray = @[@"返回首页", @"查看账单"];
    for (int i = 0; i < titleArray.count; i++) {
        
        self.twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 * i, 0, UI_SCREEN_WIDTH / 2, 46)];
        self.twoLabel.text = [titleArray objectAtIndex:i];
        _twoLabel.tag = 101 + i;
        [_buttomView addSubview:self.twoLabel];
        
        _twoLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
        [_twoLabel addGestureRecognizer:tap];
        _twoLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0) {
            self.twoLabel.textColor = App_Main_Color;
        }
        
        if (i == 1) {
            self.twoLabel.textColor = [UIColor whiteColor];
            self.twoLabel.backgroundColor = App_Main_Color;
        }
    }
}
- (void)doClick:(id)sender
{
    UILabel * label = (UILabel *)[sender view];
    if ([label.text isEqualToString:@"查看账单"]) {
        BillsViewController * orderVC = [[BillsViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
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

-(void)clickShare:(UIButton*)btn
{
    [[PreferenceManager sharedManager] setPreference:self.shareOrderId forKey:@"orderTitle"];
    [self tellfriendGetData:btn.tag+1];
}

-(void)tellfriendGetData:(NSInteger)type
{
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
        }else if (type == 2)
        {
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
- (void) shareWeixin:(NSDictionary *)response
{
    NSLog(@"微信分享");
    /* [SVProgressHUD dismiss];
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
     
     [WXApi sendReq:req];*/
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
    if (buttonIndex == 0)
    {
        [self getCoupon];
    }
}

#pragma mark -
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

