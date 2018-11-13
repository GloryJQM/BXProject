//
//  RegisterViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "RegisterViewController.h"
#import "PutInView.h"
#import "PersonalInfoSettingsViewController.h"
#import "ProductDetailsViewController.h"
#import "CircysView.h"
#import "EnterphonenumberView.h"
#import "CaptchaView.h"
#import "PasswordView.h"
#import "FindPassewordView.h"
#import "FindphonenumberView.h"
@interface RegisterViewController ()<EnterphonenumberViewDelegate>

@end

@implementation RegisterViewController
@synthesize type,isRegist;

-(void)dealloc{
    NSLog(@"registrationViewController delloc!");
    [_labelArray removeAllObjects];
    [_circyArray removeAllObjects];
    [_viewArray removeAllObjects];
    [_strArray removeAllObjects];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationController.navigationBarHidden=NO;
        // Custom initialization
    }
    return self;
}

-(id)initAsRegisterWindow
{
    self = [super init];
    if (self) {
        self.title = @"注册";
        self.navigationController.navigationBarHidden=NO;
        // Custom initialization
    }
    return self;
}

-(id)initAsFindPasswordWindow
{
    if (self) {
        self.title = @"找回密码";
        self.navigationController.navigationBarHidden=NO;
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //因为构架中大多数还是需要使用navigationBar所以首页使用隐藏navigationBar来达到效果
    self.navigationController.navigationBarHidden=NO;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    [backBtn setImage:[UIImage imageNamed:@"NewNav_back_white.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

-(void)showServiceWeb{
    
    ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] initWithType:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    NSString *url = MOBILE_SERVER_URL(@"tiaokuan.php");
    [viewController loadWebView:url];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    [backBtn setImage:[UIImage imageNamed:@"NewNav_back_white.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    viewController.navigationItem.leftBarButtonItem = backItem;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backPop:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"是不是注册：%d",self.isRegist);
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*3, C_VC_2ndREALHEIGHT)];
    //   scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(0 ,0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    // scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    page = 0;
    _labelArray = [[NSMutableArray alloc]init];
    _circyArray = [[NSMutableArray alloc]init];
    _viewArray = [[NSMutableArray alloc]init];
    _strArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<4; i++) {
        [_strArray addObject:@""];
    }
    
    UIView *btnbackView = [[UIView alloc]initWithFrame:CGRectMake(0,C_IOS7_HEIGHT, self.view.frame.size.width, 45.0)];
    btnbackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:btnbackView];
    
    NSArray *titleArray1 = @[@"输入手机号",@"输入验证码",@"设置密码"];
    NSArray *titleArray2 = @[@"输入手机号",@"输入验证码",@"重置密码"];
    NSArray *titleArray;
    if (isRegist==0) {
        titleArray=titleArray1;
    }
    else{
        titleArray=titleArray2;
    }
    
    for (int i=0; i<3; i++) {
        UILabel *btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+(self.view.frame.size.width/3.0+1)*i, 0, (self.view.frame.size.width-2)/3.0, 44.0)];
        btnLabel.backgroundColor = [UIColor whiteColor];
        btnLabel.textAlignment = NSTextAlignmentCenter;
        btnLabel.tag = i;
        btnLabel.clipsToBounds = NO;
        btnLabel.text = [titleArray objectAtIndex:i];
        btnLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [btnbackView addSubview:btnLabel];
        [_labelArray addObject:btnLabel];
        [btnbackView addSubview:btnLabel];
        btnLabel.userInteractionEnabled = NO;
        
        CircysView *circyView = [[CircysView alloc]initWithFrame:CGRectMake(0, 0, 25.0, 25.0)];
        circyView.backgroundColor = [UIColor clearColor];
        circyView.numberText = [NSString stringWithFormat:@"%d",i+1];
        [btnbackView addSubview:circyView];
        [_circyArray addObject:circyView];
        circyView.center = CGPointMake((self.view.frame.size.width/3.0+1)*i+btnLabel.frame.size.width/2.0, btnLabel.frame.size.height);
        
        UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [btnLabel addGestureRecognizer:tap];
    }
    ((CircysView*)[_circyArray objectAtIndex:0]).select = YES;
    ((UILabel*)[_labelArray objectAtIndex:0]).userInteractionEnabled = YES;
    
    if (isRegist==0) {
        self.title = @"注册";
        enterphonenumber = [[EnterphonenumberView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45) ];
        enterphonenumber.delegate=self;
        [enterphonenumber addEnterPhonenumberSelect:self selector:@selector(enterphonumber:)];
        enterphonenumber.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:enterphonenumber];
        [_viewArray addObject:enterphonenumber];
        CaptchaView *captchaView = [[CaptchaView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 45.0, self.view.frame.size.width,  self.view.frame.size.height-45)];
        captchaView.backgroundColor = [UIColor whiteColor];
        [captchaView addCapchaSelector:self selector:@selector(captchViewSelct:)];
        captchaView.delegate = self;
        [_scrollView addSubview:captchaView];
        [_viewArray addObject:captchaView];
        
        PasswordView *passwordView = [[PasswordView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 45.0, self.view.frame.size.width,  self.view.frame.size.height-45)];
        [passwordView addPassWordViewSelector:self selector:@selector(passwordSelect:)];
        passwordView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:passwordView];
        [_viewArray addObject:passwordView];
        
    }else{
        self.title = @"找回密码";
        FindphonenumberView *enterphonenumber1 = [[FindphonenumberView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45) ];
        [enterphonenumber1 addEnterPhonenumberSelect:self selector:@selector(enterphonumber:)];
        enterphonenumber1.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:enterphonenumber1];
        [_viewArray addObject:enterphonenumber1];
        CaptchaView *captchaView = [[CaptchaView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 45.0, self.view.frame.size.width,  self.view.frame.size.height-45)];
        captchaView.backgroundColor = [UIColor whiteColor];
        [captchaView addCapchaSelector:self selector:@selector(captchViewSelct:)];
        captchaView.delegate = self;
        [_scrollView addSubview:captchaView];
        [_viewArray addObject:captchaView];
        FindPassewordView *passwordView = [[FindPassewordView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 45.0, self.view.frame.size.width,  self.view.frame.size.height-45)];
        [passwordView addPassWordViewSelector:self selector:@selector(passwordSelect:)];
        passwordView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:passwordView];
        [_viewArray addObject:passwordView];
        
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    CaptchaView *view = (CaptchaView*)[_viewArray objectAtIndex:1];
    [view.timer setFireDate:[NSDate distantPast]];
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    CaptchaView *view = (CaptchaView*)[_viewArray objectAtIndex:1];
    [view.timer setFireDate:[NSDate distantFuture]];
    
}


-(void)enterphonumber:(NSString*)phonenumber{
    [_strArray replaceObjectAtIndex:0 withObject:phonenumber];
    if (!isRegist)
        [_strArray replaceObjectAtIndex:3 withObject:enterphonenumber._recommendTextfield.text];
    [self loadUrl:1];
}
-(void)captchViewSelct:(NSString*)str{
    [_strArray replaceObjectAtIndex:1 withObject:str];
    [self loadUrl:2];
}

-(void)passwordSelect:(NSString*)str{
    [_strArray replaceObjectAtIndex:2 withObject:str];
    [self loadUrl:3];
}

-(void)captchagain:(BOOL)againb{
    if (againb == YES) {
        [self loadUrl:1];
    }
    
}

-(void)loadUrl:(NSInteger)step{
    
    [SVProgressHUD show];
    
    NSString *urlStr;
    if (isRegist==0) {
        urlStr= MOBILE_SERVER_URL(@"register.php");
    } else {
        urlStr= MOBILE_SERVER_URL(@"findPassword.php");
    }
    
    TokenURLRequest *request = [[TokenURLRequest alloc]initWithLoginURL:[NSURL URLWithString:urlStr]];
    NSString *md5Pass = [NSString md5:[_strArray objectAtIndex:2]];
    NSString *body = [NSString stringWithFormat:@"step=%ld&phone_num=%@&code=%@&password=%@&yaoqingma=%@",step,[_strArray objectAtIndex:0],[_strArray objectAtIndex:1],md5Pass,[_strArray objectAtIndex:3]];
    NSLog(@"body:%@",body);
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (step<3&&[[responseObject objectForKey:@"status"]intValue] == 1) {
            [self selectViewPage:step];
            [SVProgressHUD dismissWithSuccess:[responseObject objectForKey:@"info"]];
        }else if(step == 3&&[[responseObject objectForKey:@"status"]intValue] == 1){
            [SVProgressHUD dismissWithSuccess:[responseObject objectForKey:@"info"]];
            
            if (self.navigationController.viewControllers.count >1) {
                [self autologin];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            [SVProgressHUD dismissWithError:[responseObject objectForKey:@"info"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error!,operation:%@",operation.responseString);
        if (operation.response.statusCode != 200 ) {
            [SVProgressHUD dismissWithError:@"网络连接错误!"];
        }else{
            //[SVProgressHUD dismissWithSuccess:[responseObject objectForKey:@"info"]];
            if(self.isRegist) {
                [SVProgressHUD dismissWithError:@"注册失败!"];
            }else {
                [SVProgressHUD dismissWithError:@"找回密码失败!"];
            }
        }
    }];
    [op start];
}



-(void)tap:(UIGestureRecognizer*)tap{
    page = tap.view.tag;
    if (page == 0) {
        for (int i=0; i<3; i++) {
            [_strArray addObject:@""];
        }
    }
    [self selectViewPage:page];
}

-(void)selectViewPage:(int)tag{
    page =tag;
    if (page == 1) {
        ((UILabel*)[_labelArray objectAtIndex:0]).userInteractionEnabled = YES;
        [((CaptchaView*)[_viewArray objectAtIndex:1]) timerStar];
    }else{
        ((UILabel*)[_labelArray objectAtIndex:2]).userInteractionEnabled = NO;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(self.view.frame.size.width*page,-C_IOS7_HEIGHT);
    }];
    
    for (int i=0; i<3; i++) {
        [[_viewArray objectAtIndex:i] removeKeyBoard];
        ((CircysView*)[_circyArray objectAtIndex:i]).select = NO;
    }
    ((CircysView*)[_circyArray objectAtIndex:page]).select = YES;
    
}


-(void)autologin
{
    if (_registBlock) {
        NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:[_strArray objectAtIndex:0],@"username",[_strArray objectAtIndex:2],@"userpwd", nil];
        _registBlock(YES,infoDic);
    }
}

@end



