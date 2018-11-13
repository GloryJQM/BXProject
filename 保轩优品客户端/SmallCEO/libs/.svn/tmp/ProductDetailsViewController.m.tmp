//
//  ProductDetailsViewController.m
//  WanHao
//
//  Created by wuxiaohui on 14-1-23.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "CommodityDetailViewController.h"
#import "ThirdPartMacros.h"
#import "ShareView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "AccountViewController.h"
#define C_VC_2ndREALHEIGHT          (C_IOS7 ? self.view.frame.size.height - 64 : self.view.frame.size.height - 44)

@interface ProductDetailsViewController ()<ShareViewDelegate>
{
    BOOL        _flagBack;
    float       _curcontentheight;
    BOOL        _isFirstLoad;
}

@end

@implementation ProductDetailsViewController
@synthesize numOfSubUrl;
- (void)dealloc{
    [_arrBrowseHistory removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShoppingCartProductDetails" object:nil];
    NSLog(@"ProductDetailsViewController_dealloc!");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _flagBack = YES;
        
        _isFirstLoad = YES;
        
        self.view.backgroundColor = [UIColor whiteColor];
        _isaddurl = YES;
        numOfSubUrl=0;
        curUrlNum=0;
        isTap=NO;
        
        _arrBrowseHistory = [[NSMutableArray alloc] init];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,UI_SCREEN_HEIGHT - 64)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
        [self.view addSubview:_webView];
        
        UITapGestureRecognizer *temp=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTap)];
        temp.delegate=self;
        [self.view addGestureRecognizer:temp ];
    }
    return self;
}

- (instancetype)initWithType:(BOOL)isFromRegister {
    if (self = [super init]) {
        _webView.frame =  CGRectMake(0, 0, self.view.frame.size.width,UI_SCREEN_HEIGHT - 64);
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)selfTap{
    isTap=YES;
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.isShare) {
        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
        [rightButton setImage:[[UIImage imageNamed:@"sharegray.png"] imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem= rightItem;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _flagBack = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _result = @selector(paymentResult:);
    if (C_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshShopCartView) name:@"ShoppingCartProductDetails" object:nil];
}

- (void)refreshShopCartView {
    if (_arrBrowseHistory.count >= 1) {
        NSString *gouwustr = [NSString stringWithFormat:@"%@",[_arrBrowseHistory lastObject]];
        [self cheackUrl:gouwustr isPushWeb:YES];
        [_arrBrowseHistory removeLastObject];
    }
}
#pragma mark - 分享
- (void)shareBtn {
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信",@"朋友圈"];
    ShareView *shareView = [[ShareView alloc] initWithShareButtonNameArray:sharePlace animation:YES];
    shareView.delegate = self;
    [shareView show];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self tellfriendGetData:1];
        return;
        //            [self tellWeixinFriends];
    }else if (buttonIndex == 1){
        [self tellfriendGetData:2];
        return;
        //            [self tellWeiboFriends];
    }
}

- (void)clickShare:(UIButton*)btn {
    [self tellfriendGetData:btn.tag+1];
}


- (void)tellfriendGetData:(NSInteger)type {
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"sharegoods.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"goods_id=%@",@"aid"];
    NSLog(@"body%@",body);
    [request  setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
    [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"tellPaymentTypegetMyContact_responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        if (type == 1) {
            [self tellWeixinFriends:responseObject];
        }else if (type == 2){
            [self shareWeixin:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"operation:%@  error:%@",operation.responseString,error);
        [SVProgressHUD dismissWithError:@"网络错误"];
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
- (void)tellWeixinFriends:(NSDictionary *)response {
    NSLog(@"告诉微信朋友");
    //     NSDictionary *sharedic = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://www.4228999.com/?u_register-",@"appIOS", @"http://www.4228999.com/?u_register-",@"link",@"http://www.4228999.com/templet/admin2014/images/logo.png",@"picurl",@"我注册了App_Product_Name，现在邀请你来一起淘,点击链接，即可获得会员红包。",@"content",App_Product_Name,@"title",nil];
    NSDictionary *sharedic = [[NSDictionary alloc] initWithDictionary:response];
    
    WXMediaMessage *message = [WXMediaMessage message];
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
    [WXApi sendReq:req];
}


-(void) loadWebView:(NSString *)url{
    url = [url stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    //判断url中是否有问号出现，如果有就表示已经有参数了，则用&跟，如果没有问号，就现示没有参数,用?跟
    NSRange range;
    range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        url = [NSString stringWithFormat:@"%@&noheader=%d",url,1];
    }else{
        url = [NSString stringWithFormat:@"%@?noheader=%d",url,1];
    }
    
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8));
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}

-(void) loadWebView1:(NSString *)url {
    url = [url stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    //判断url中是否有问号出现，如果有就表示已经有参数了，则用&跟，如果没有问号，就现示没有参数,用?跟
    NSRange range;
    range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        url = [NSString stringWithFormat:@"%@&noheader=%d",url,1];
    }else{
        url = [NSString stringWithFormat:@"%@?noheader=%d",url,1];
    }
    
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8));
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
    _webView.frame = CGRectMake(_webView.x, _webView.y, _webView.frame.size.width, self.view.frame.size.height);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad %@  ",webView);
    [SVProgressHUD dismiss];
    
    if (_webView.scrollView.contentSize.height > _curcontentheight+200) {
        
    }else{
        _curcontentheight = _webView.scrollView.contentSize.height-420;
    }
    
    if(isChange){
        _curcontentheight=0;
        isChange=NO;
    }
    if (![self.is64 isEqualToString:@"1"]) {
        [_webView.scrollView setContentOffset:CGPointMake(0, _curcontentheight) animated:NO];
    }
    
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *body = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('phonekongjian').innerHTML"];
    NSLog(@"webViewDidFinishLoad_body:%@",body);
    _rightBtn = nil;
    
    if (![body isEqualToString:@""] && !self.isShare) {
        NSArray *array = [body componentsSeparatedByString:@"||"];
        _function = [array objectAtIndex:2];
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
        [_rightBtn setTitle:[array objectAtIndex:1] forState:UIControlStateSelected];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem2 = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
        self.navigationItem.rightBarButtonItem = buttonItem2;
    }
    self.title = title;
}


-(void)rightBtnClick:(UIButton *)btn{
    btn.selected = ~btn.selected;
    [_webView stringByEvaluatingJavaScriptFromString:_function];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    NSLog(@"error:%@",error);
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
    if (_isFirstLoad) {
        _isFirstLoad = NO;
    }else{
        _curcontentheight = _webView.scrollView.contentSize.height - 200;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (!_flagBack) {
        //避免出现is_child_url=1之后还会出现其他的url 初始化为yes viewdidappear也是为yes 只有出现is_child_url=1同时为clicktype的时候设为no
        return NO;
    }else{
        NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        if ([requestString rangeOfString:@"is_child_url=1"].length > 0) {
            if(navigationType==UIWebViewNavigationTypeLinkClicked){
                [SVProgressHUD show]; 
                ProductDetailsViewController *vc = [[ProductDetailsViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                [vc loadWebView:requestString];
                _flagBack = NO;
                
                return NO;
            }else {
                return YES;
            }
        }else{
            //下面包含两种情况，一是不包含appfunc: 一个是包含appfunc:
            //判断 暂时屏蔽bug
            if([[request.URL absoluteString]rangeOfString:@"#"].length > 0) {
                return NO;
            }
            if(![_arrBrowseHistory containsObject:[request.URL absoluteString]]&&_isaddurl){
                [_arrBrowseHistory addObject:[request.URL absoluteString]];
                
            }
            NSLog(@"request:%@",requestString);
            if ([requestString hasPrefix:@"appfunc:"]) {
                NSLog(@"requestString:%@",requestString);
                NSString *func = [requestString stringByReplacingCharactersInRange:NSMakeRange(0, 8) withString:@""];
                NSLog(@"func:%@",func);
                NSArray *array = [func componentsSeparatedByString:@":"];
                NSLog(@"array:%@",array);
                if ([[array objectAtIndex:0] isEqualToString:@"page"]) {
                    if (array.count > 1) {
                        if ([[array objectAtIndex:1] isEqualToString:@"index"]) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }else if ([[array objectAtIndex:1] isEqualToString:@"points"]) {
                            NSMutableArray *array = [NSMutableArray array] ;
                            [array addObject:self.navigationController.viewControllers.firstObject];
                            AccountViewController *account = [[AccountViewController alloc]init];
                            [array addObject:account];
                            account.type = @"积分";
                            [self.navigationController setViewControllers:array animated:YES];
                        }
                    }
                    
                }
                
                if ([[array objectAtIndex:0] isEqualToString:@"order"]) {
                    [_arrBrowseHistory removeLastObject];

                    
                }
                
                if ([[array objectAtIndex:0] isEqualToString:@"pay"]) {
                    return NO;
                }
                if ([[array objectAtIndex:0] isEqualToString:@"alert"]) {
                    [_arrBrowseHistory removeLastObject];
                    NSString *alertiveStr = [array objectAtIndex:2];
                    _alerturl = [array objectAtIndex:1];
                    UIAlertView *alertive = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:alertiveStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    [alertive show];
                    return NO;
                }
                if ([[array objectAtIndex:0] isEqualToString:@"id"]) {
                    [_arrBrowseHistory removeLastObject];
                    [self loadProductShopDetailWithAid:[[array objectAtIndex:1] intValue]];
                    return NO;
                }
                //cai
                if ([[array objectAtIndex:0] isEqualToString:@"shop_id"]) {
                    [_arrBrowseHistory removeLastObject];

                    
                    return NO;
                }
                if ([[array objectAtIndex:0] isEqualToString:@"login"] || [[array objectAtIndex:0]isEqualToString:@"register"]) {

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [LoginViewController performIfLogin:del.curViewController withShowTab:NO loginAlreadyBlock:^{
                            [self addGoodsToShopCart:[array objectAtIndex:1]];
                        } loginSuccessBlock:nil];
                    });

                    return NO;
                    
                }
                //2014-08-24 chenweidong  充值券
                if ([[array objectAtIndex:0] isEqualToString:@"usergift"]) {
                    NSLog(@"YES");
                    [[PreferenceManager sharedManager] setPreference:[array objectAtIndex:1] forKey:@"usergift"];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要使用该充值券?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
                    alertView.tag = 10000;
                    [alertView show];
                    return NO;
                    
                }
            }else if (navigationType == UIWebViewNavigationTypeLinkClicked){
                NSLog(@"navigation:  Clicked");
                //左右栏切换加载url 加入token 适应需要token机制的url
                TokenURLRequest *req = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:[request.URL absoluteString]]];
                [_webView loadRequest:req];
                isChange=YES;
                return NO;
            }else if (navigationType == UIWebViewNavigationTypeOther){
                //适应类似视频的url加载 例如在线农场
                if ([requestString rangeOfString:@"lemuji"].location == NSNotFound) {
                    isChange=YES;
                }
            }
            /**
             *这段代码会引起菊花一直旋转
             
             [SVProgressHUD show];
             */
            return YES;
        }
    }
}

- (void)addGoodsToShopCart:(NSString *)goods_attribute {
    [SVProgressHUD show];
    NSString *body = [NSString stringWithFormat:@"cart=%@", goods_attribute];
    NSString *str = MOBILE_SERVER_URL(@"mallcart.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            [SVProgressHUD dismissWithSuccess:@"添加成功"] ;
        } else {
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD dismissWithError:[responseObject valueForKey:@"info"]] ;
            } else {
                [SVProgressHUD dismissWithError:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)loadProductShopDetailWithAid:(NSInteger)aid {
    [SVProgressHUD show];
    NSString *body = [NSString stringWithFormat:@"aid=%ld",(long)aid];
    NSString *url = MOBILE_SERVER_URL(@"getSupplierProductNew2.php");
    //NSString *url = MOBILE_SERVER_URL(@"api/productshopdetail.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    //NSString *body = [NSString stringWithFormat:@"type=%ld&shop_id=%ld&aid=%ld",(long)type,(long)shop_id,(long)aid];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)cheackUrl:(NSString *)url isPushWeb:(BOOL) isWebView{
    if (isWebView) {
        _isFirstLoad = YES;
        _curcontentheight = 0.0;
        [self loadWebView:url];
    }else{
        ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController loadWebView:url];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100&&buttonIndex == 1) {

        
    }else if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            //NSString *appScheme = ZhifubaoUrlScheme;
            NSString *appScheme = @"baoxuan";
            NSString* orderInfo = [self getOrderInfo:0];
            NSString* signedStr = [self doRsa:orderInfo];
            
            NSLog(@"%@",signedStr);
            
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                     orderInfo, signedStr, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                DLog(@"result = %@",resultDic);
                
                NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                NSString *str = @"";
                if (resultDic){
                    if ([statusStr isEqualToString:@"9000"]){
                        NSLog(@"success!");
                        str = @"交易成功";
                        /*
                         *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                         */
                    }else if([statusStr isEqualToString:@"6001"]){
                        str = @"交易取消";
                    }else{
                        str = @"交易失败";
                        DLog(@"AlixPayResult_error0!");
                        //交易失败
                    }
                }
                else{
                    str = @"支付宝连接失败";
                    NSLog(@"AlixPayResult_error1!");
                    //失败
                }
                UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alerTivew show];
            }];
            
//            [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
        }
        return;
    }else if (alertView.tag == 10000&&buttonIndex == 1) {

        
    }else if (buttonIndex == 1) {
        [SVProgressHUD show];
        NSString *url = MOBILE_SERVER_URL(_alerturl);
        TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString: url]];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"operation:%@",operation.responseString);
            if ([operation.responseString intValue]== 1) {
                [SVProgressHUD dismissWithSuccess:@"删除成功"];
                _isaddurl = YES;
                [self cheackUrl:[_arrBrowseHistory lastObject] isPushWeb:YES];
            }else{
                [SVProgressHUD dismissWithError:@"删除失败"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@",operation.responseString);
            [SVProgressHUD dismissWithError:@"网络错误"];
            
        }];
        [op start];
        
    }
}

- (void)backPop {
    [self.navigationController popViewControllerAnimated:YES];
    return;
    [SVProgressHUD dismiss];
    NSString *urlstr = [[[_arrBrowseHistory lastObject] componentsSeparatedByString:@"?"] objectAtIndex:0];
    int count = [_arrBrowseHistory count];
    NSArray* reversedArray = [[_arrBrowseHistory reverseObjectEnumerator] allObjects];
    id temp=[_arrBrowseHistory reverseObjectEnumerator];
    if (count  == 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    for (int i = 1; i<count; i++) {
        NSArray *array = [[reversedArray objectAtIndex:i] componentsSeparatedByString:@"?"];
        [_arrBrowseHistory removeLastObject];
        if (![[array objectAtIndex:0] isEqualToString:urlstr]) {
            NSString *url = [reversedArray objectAtIndex:i];
            NSLog(@"A_URL:%@",url);
            TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [_webView loadRequest:request];
            return;
        }
    }
    if ([_webView canGoBack]) {
        [_webView goBack];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }
}

#pragma 支付宝测试接口
//wap回调函数
-(void)paymentResult:(NSString *)resultd {
//    //结果处理
//#if ! __has_feature(objc_arc)
//    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
//#else
//    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
//#endif
//	if (result)
//    {
//		if (result.statusCode == 9000)
//        {
//			/*
//			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//			 */
//            
//            //交易成功
//            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
//			id<DataVerifier> verifier;
//            verifier = CreateRSADataVerifier(key);
//            
//			if ([verifier verifyString:result.resultString withSign:result.signString])
//            {
//                //验证签名成功，交易结果无篡改
//			}
//        }
//        else
//        {
//            //交易失败
//        }
//    }
//    else
//    {
//        //失败
//    }
//    
}

-(NSString*)getOrderInfo:(NSInteger)index {
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    //	Product *product = [_products objectAtIndex:index];
    Order *order = [[Order alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = @"西瓜";//product.subject; //商品标题
	order.productDescription = @"习惯好甜";//product.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
	order.notifyURL = SERVER_URL(@"alipay/notify_url.php"); //回调URL
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.service = @"mobile.securitypay.pay";
	return [order description];
}

- (NSString *)generateTradeNO {
	const int N = 15;
	NSString *sourceString = @"M1394459710";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++) {
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

- (NSString*)doRsa:(NSString*)orderInfo {
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

- (void)paymentResultDelegate:(NSString *)result {
    NSLog(@"%@",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
