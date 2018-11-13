//
//  LoginBindViewController.m
//  WanHao
//
//  Created by Cai on 14-9-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "LoginBindViewController.h"
#import "LoginViewController.h"
#import "AlixPayResult.h"


@interface LoginBindViewController ()

@end

@implementation LoginBindViewController

-(void)dealloc{
    [_arrBrowseHistory removeAllObjects];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBarHidden=NO;
        
        _arrBrowseHistory = [[NSMutableArray alloc] init];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
        [self.view addSubview:_webView];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    [backBtn setImage:[UIImage imageNamed:@"NewNav_back_white.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (C_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

-(void) loadWebView:(NSString *)url{
    url = [url stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    //判断url中是否有问号出现，如果有就表示已经有参数了，则用&跟，如果没有问号，就现示没有参数,用?跟
    
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8));
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *body = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('phonekongjian').innerHTML"];
    NSLog(@"webViewDidFinishLoad_body:%@",body);
    
    self.navigationItem.rightBarButtonItem = nil;
    self.title = title;

}




-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    NSLog(@"error:%@",error);
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if([[request.URL absoluteString]rangeOfString:@"#"].length > 0)//判断 屏蔽bug
    {
        return NO;
    }
    
    NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    DLog(@"request:%@",requestString);
    
    if ([requestString hasPrefix:@"appfunc:"]) {
        NSLog(@"requestString:%@",requestString);
        
        NSString *func = [requestString stringByReplacingCharactersInRange:NSMakeRange(0, 8) withString:@""];
        DLog(@"func:%@",func);
        if ([func rangeOfString:@"zhuce"].length > 0) {
            NSString *zheceStr = [func stringByReplacingCharactersInRange:NSMakeRange(0, 6) withString:@""];
            DLog(@"最终的字符串是%@",zheceStr);
            
            NSData *da= [zheceStr dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:da  options:NSJSONReadingAllowFragments error:&error];
            DLog(@"类型是%@------内容是%@",jsonObject,[jsonObject class]);
            NSDictionary *itemdic = [[NSDictionary alloc] initWithDictionary:jsonObject];
            [self registerUserID:1 urlStr:@"zhucelast" userInfoDic:itemdic];
        }else if ([func rangeOfString:@"bangding"].length > 0) {
            NSString *bangStr = [func stringByReplacingCharactersInRange:NSMakeRange(0, 9) withString:@""];
            DLog(@"最终的字符串是%@",bangStr);
            
            NSData *bangda= [bangStr dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *berror = nil;
            
            id bangjsonObject = [NSJSONSerialization JSONObjectWithData:bangda  options:NSJSONReadingAllowFragments error:&berror];
            DLog(@"类型是%@------内容是%@",bangjsonObject,[bangjsonObject class]);
            NSDictionary *bitemdic = [[NSDictionary alloc] initWithDictionary:bangjsonObject];
            [self registerUserID:2 urlStr:@"zhanghaoshengji" userInfoDic:bitemdic];
        }
//        NSArray *funcArr = [[NSArray alloc] initWithArray:[func componentsSeparatedByString:@","]];
//        NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//        DLog(@"funcArr数组是%@",funcArr);
//        for (int i = 0; i < funcArr.count; i++) {
//            NSString *funcstr = [NSString stringWithFormat:@"%@",[funcArr objectAtIndex:i]];
//            NSArray *arr = [funcstr componentsSeparatedByString:@":"];
//            if (arr.count == 2) {
//                [itemDic setObject:[arr objectAtIndex:1] forKey:[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]]];
//            }
//            
//        }
        
        return NO;
    }
    
    [SVProgressHUD show];
    
    return YES;
}




-(void)cheackUrl:(NSString *)url isPushWeb:(BOOL) isWebView{
    
    if (isWebView) {
        [self loadWebView:url];
    }
}

- (void)backPop
{
    
    [SVProgressHUD dismiss];
    
    if ([_webView canGoBack]) {
        [_webView goBack];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }
    
}

-(void)registerUserID:(NSInteger)type urlStr:(NSString *)appendStr userInfoDic:(NSDictionary *)infoDic
{
    [SVProgressHUD show];
    NSDictionary *userinfodic = [[NSDictionary alloc] initWithDictionary:infoDic];
    NSString *appUrlStr = [NSString stringWithFormat:@"?%@",appendStr];
    NSString *url=SERVER_URL(appUrlStr);
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSMutableString *body = [[NSMutableString alloc] initWithCapacity:0];
    
    if (1 == type) {//普通登录，type为0
        //mobilePhone，mobileVerifCode，type=QQ_TBCS(定值),from,nick_name,avatar,openid
        
        [body setString: [NSString stringWithFormat:@"mobilePhone=%@&mobileVerifCode=%@&type=QQ_TBCS&from=%@&nick_name=%@&avatar=%@&openid=%@&pwd=%@",[userinfodic objectForKey:@"mobilePhone"],[userinfodic objectForKey:@"mobileVerifCode"],[userinfodic objectForKey:@"from"],[userinfodic objectForKey:@"nick_name"],[userinfodic objectForKey:@"avatar"],[userinfodic objectForKey:@"openid"],[userinfodic objectForKey:@"loginpwd"]]];
    }else{//QQ、微信、微博登录，type分别为1、2、3
       [body setString: [NSString stringWithFormat:@"loginname=%@&loginpwd=%@&from=%@&nick_name=%@&avatar=%@&openid=%@",[userinfodic objectForKey:@"loginname"],[userinfodic objectForKey:@"loginpwd"],[userinfodic objectForKey:@"from"],[userinfodic objectForKey:@"nick_name"],[userinfodic objectForKey:@"avatar"],[userinfodic objectForKey:@"openid"]]];
    }
    DLog(@"body:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            [self loginFailed:[responseObject objectForKey:@"info"]];
        }else if ([[responseObject objectForKey:@"status"] intValue] == 1){
            
            [self didLogin:responseObject];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        [self loginFailed:@"登录失败！"];
        [SVProgressHUD dismiss];
    }];
    [op start];

}

- (void)didLogin:(id)response
{
    
    
    [SVProgressHUD dismissWithSuccess:@"登录成功！"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"avatar"] forKey:@"avatar"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"username"] forKey:@"chargeUserID"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"alias"] forKey:@"alias"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"token"] forKey:@"token"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"username"] forKey:@"tuisongID"];
    [[PreferenceManager sharedManager] setPreference:@(YES) forKey:@"didLogin"];
    
    
    NSDictionary *infoDic = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithDictionary:response]];
    if (_loginbingBlock) {
        _loginbingBlock(YES,infoDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)loginFailed:(NSString *)info
{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:info];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
