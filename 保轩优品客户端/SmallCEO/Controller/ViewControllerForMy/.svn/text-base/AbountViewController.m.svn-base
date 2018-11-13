//
//  AbountViewController.m
//  SmallCEO
//
//  Created by huang on 15/10/13.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "AbountViewController.h"
#import "ProductDetailsViewController.h"
#import "Reachability.h"
#import "ShareView.h"
#import "WXApi.h"

@interface AbountViewController () <ShareViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *QRCodeImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView * separateline;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introductionLable;
@property (nonatomic, strong) UIButton *userPrivacyDelegateBtn;
@property (nonatomic, strong) UILabel *rightreservedLabel;
@property (nonatomic, strong) UILabel *promptTextLabel;

@end

@implementation AbountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于保轩生活";
    self.view.backgroundColor = WHITE_COLOR;
    
    [self createMainView];
    [self getData];
}

- (void)createMainView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
    scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar);
    [self.view addSubview:scrollView];
    scrollView.userInteractionEnabled = YES;
    self.scrollView = scrollView;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 80) / 2, 10, 80, 80)];
    [self.scrollView addSubview:logoImageView];
    self.logoImageView = logoImageView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 10, UI_SCREEN_WIDTH, 15)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [UIColor blackColor];
    self.titleLabel = titleLabel;
    
    [self.scrollView addSubview:titleLabel];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5 , UI_SCREEN_WIDTH, 15)];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:15.0];
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.text = [NSString stringWithFormat:@"v%@", IosAppVersion];
    [self.scrollView addSubview:versionLabel];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(versionLabel.frame) + 10, UI_SCREEN_WIDTH - 20, 1)];
    line.backgroundColor = LINE_SHALLOW_COLOR;
    [self.scrollView addSubview:line];
    self.separateline = line;
    
    UILabel *introductionLable=[[UILabel alloc] init];
    introductionLable.textColor=[UIColor blackColor];
    introductionLable.font=[UIFont systemFontOfSize:14];
    introductionLable.backgroundColor=[UIColor clearColor];
    introductionLable.numberOfLines=0;
    introductionLable.textAlignment = NSTextAlignmentCenter;
    introductionLable.lineBreakMode=NSLineBreakByWordWrapping;
    [self.scrollView addSubview:introductionLable];
    self.introductionLable = introductionLable;
    
    UIImageView *QRCodeImageView = [[UIImageView alloc] init];
    QRCodeImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:QRCodeImageView];
    self.QRCodeImageView = QRCodeImageView;
    
    UILabel *promptTextLabel = [[UILabel alloc] init];
    promptTextLabel.text = @"点击分享或保存二维码";
    promptTextLabel.textColor = [UIColor colorFromHexCode:@"848689"];
    promptTextLabel.textAlignment = NSTextAlignmentCenter;
    promptTextLabel.font = [UIFont systemFontOfSize:14.0];
    [self.scrollView addSubview:promptTextLabel];
    self.promptTextLabel = promptTextLabel;
    
    
}

-(void)cheackUrl:(NSString *)url{
    //8.4
    [SVProgressHUD show];
    Reachability* reach = [Reachability reachabilityWithHostName:@"app.lemuji.com"];
    if ([reach currentReachabilityStatus] != NotReachable)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController loadWebView:url];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismissWithError:@"网络错误"];
        });
    }
}

- (void)showUserPrivacyDelegateInfo
{
    NSString *str = MOBILE_SERVER_URL(@"tiaokuan.php");
    [self cheackUrl:str];
}

#pragma mark - 网络请求方法
- (void)getData {
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"aboutshare.php");
    [RequestManager startRequestWithUrl:str
                                   body:@""
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               [self.QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"qrcode"]]]];
                               [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"picurl"]]]];
                               self.titleLabel.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"title"]];
                               self.introductionLable.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"content"]];
                               [self layoutSubviews];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark -
- (void)layoutSubviews {
    CGSize introductionLableSize = [self.introductionLable sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 30, CGFLOAT_MAX)];
    self.introductionLable.frame = CGRectMake(0, CGRectGetMaxY(self.separateline.frame)+10, UI_SCREEN_WIDTH, introductionLableSize.height);

    self.QRCodeImageView.frame = CGRectMake((UI_SCREEN_WIDTH - 150) / 2, CGRectGetMaxY(self.introductionLable.frame) + 10, 150, 150);
    [self.QRCodeImageView addTarget:self action:@selector(shareOrSaveQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.promptTextLabel.frame = CGRectMake(0, CGRectGetMaxY(self.QRCodeImageView.frame), UI_SCREEN_WIDTH, 16);
    
    UILabel *labe1 = [[UILabel alloc] initWithFrame:CGRectMake(15, _promptTextLabel.maxY, UI_SCREEN_WIDTH - 30, 20)];
    labe1.text = @"好友注册成功并全额消费即可获得消费总额1%奖金";
    labe1.font = [UIFont systemFontOfSize:14.0];
    labe1.numberOfLines = 0;
    labe1.textAlignment = NSTextAlignmentCenter;
    CGSize sizeL = [labe1 sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 30, 20)];
    labe1.frame = CGRectMake(15, _promptTextLabel.maxY, UI_SCREEN_WIDTH - 30, sizeL.height);
    labe1.textColor = [UIColor colorFromHexCode:@"848689"];
    [self.scrollView addSubview:labe1];

    self.userPrivacyDelegateBtn.frame = CGRectMake(0, CGRectGetMaxY(self.promptTextLabel.frame) + 10, UI_SCREEN_WIDTH, 20);
    
    self.rightreservedLabel.frame = CGRectMake(0, CGRectGetMaxY(self.userPrivacyDelegateBtn.frame) + 10, UI_SCREEN_WIDTH, 20);

    
    CGFloat maxPositionHeight = CGRectGetMaxY(self.rightreservedLabel.frame);
    if (maxPositionHeight > self.scrollView.frame.size.height)
    {
        self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, maxPositionHeight);
    }
    else
    {
        self.userPrivacyDelegateBtn.frame = CGRectMake(0, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - 30 - 20, UI_SCREEN_WIDTH, 20);
        
        self.rightreservedLabel.frame = CGRectMake(0, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - 30, UI_SCREEN_WIDTH, 20);
    }
}

#pragma mark - 二维码点击方法
- (void)shareOrSaveQRCode
{
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信", @"朋友圈", @"保存到相册"];
    ShareView *shareView = [[ShareView alloc] initWithShareButtonNameArray:sharePlace animation:YES];
    shareView.delegate = self;
    [shareView show];
}

#pragma mark - ShareViewDelegate
- (void)shareView:(ShareView *)shareView clickButtonAtIndex:(NSInteger)index
{
    [self shareAppWithType:index + 1];
}

#pragma mark -
-(void)shareAppWithType:(NSInteger)type
{
    if (type == 3)
    {
        [self saveQRCodeToPhotosAlbum];
        return;
    }
    
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"aboutshare.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = @"";
    [request  setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
    [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (type == 1)
        {
            [self tellWeixinFriends:responseObject];
        }
        else if (type == 2)
        {
            [self shareWeixin:responseObject];
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op_yue start];
}

- (void)saveQRCodeToPhotosAlbum
{
    [SVProgressHUD show];
    UIImageWriteToSavedPhotosAlbum(self.QRCodeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        [SVProgressHUD dismissWithSuccess:@"保存到相册成功"];
    }
    else
    {
        [SVProgressHUD dismissWithError:[error description]];
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

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
