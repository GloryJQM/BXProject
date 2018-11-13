//
//  ShareViewController.m
//  WanHao
//
//  Created by Cai on 14-8-6.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ShareViewController.h"
#import "WeiboSDK.h"
#define barHeight   (C_IOS7? 64:44)

@interface ShareViewController ()
{
    UITextView *shawText;
    NSMutableString *_orderNum;
    NSMutableArray *_leftLabelArray;
    NSMutableArray *_rightLabelArray;
    NSArray *_contentArray;
    
}

@end

@implementation ShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"分享";
    }
    return self;
}



-(void)getOrderiD:(NSString *)orderNum
{
    _orderNum = [[NSMutableString alloc] initWithCapacity:0];
    [_orderNum setString:orderNum];
    [self share:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //重要，不加这个属性，如果商品是从首页中的搜索栏中购买的，分享界面的scrollView会上移
    if (C_IOS7){
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    backBtn.imageView.contentMode = UIViewContentModeLeft;
    [backBtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"ico_back"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)share:(UIButton *)btn
{
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"weiboshare.php");
    DLog(@"orderId:%@",_orderNum);
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *body = [NSString stringWithFormat:@"orderid=%@",_orderNum];
    DLog(@"body:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"分享的内容：%@",responseObject);
        if (1 == btn.tag) {
            NSLog(@"微信分享");
            [self shareWeixin:responseObject];
        }else if (2 == btn.tag){
            NSLog(@"微博分享");
            [self shareWeibo:responseObject];
        }else{

            [self showContent:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"getMyContact_error:%@,%@",operation.responseString,error);
        [SVProgressHUD dismissWithError:@"网络中断"];
        
    }];
    [op start];
}

//画界面
- (void) showContent:(NSDictionary *)response
{
    
    //键盘隐藏
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-25);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(canceledit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    //支付成功图片
    UIImage *image = [UIImage imageNamed:@"gou_03.png"];
    UIImageView *imageView =  [[ UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(25, 20.0, imageView.image.size.width, imageView.image.size.height);
    [scrollView addSubview:imageView];
    
    //支付结果
    UILabel *statuLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width + 30, imageView.frame.origin.y + imageView.frame.size.height/2 - 9, 200, 20)];
    statuLabel.text = [response objectForKey:@"status"];
    statuLabel.textColor = [UIColor blackColor];
    statuLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:statuLabel];

    _contentArray = [response objectForKey:@"info"];
    
    NSLog(@"_contentArray:%@",_contentArray);
    int height = imageView.frame.origin.y+imageView.frame.size.height+20;
    //label
    UILabel *leftLabel;
    UILabel *rightLabel;
    for (int i = 0; i<_contentArray.count; i++) {
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, height + i*30, 80, 25)];
        leftLabel.text = [NSString stringWithFormat:@"%@ :" ,[[_contentArray objectAtIndex:i] objectForKey:@"title"] ];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.backgroundColor = [UIColor clearColor];
        [leftLabel setFont: [UIFont systemFontOfSize:16]];
        [_leftLabelArray addObject:leftLabel];
        [scrollView addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.frame.origin.x+leftLabel.frame.size.width+5, leftLabel.frame.origin.y, UI_SCREEN_WIDTH-120, 25)];
        rightLabel.textColor = [UIColor grayColor];
        rightLabel.text = [[_contentArray objectAtIndex:i] objectForKey:@"value"];
        if ([[[_contentArray objectAtIndex:i] objectForKey:@"title"] isEqualToString:@"实付金额"]) {
            rightLabel.textColor = [UIColor colorFromHexCode:@"ff6600"];
        }
        
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.font = [UIFont systemFontOfSize:16];
        [_rightLabelArray addObject:rightLabel];
        [scrollView addSubview:rightLabel];
    }
    
    //灰色虚线
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, leftLabel.frame.origin.y+leftLabel.frame.size.height+20, UI_SCREEN_WIDTH-20, 2)];
    label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [scrollView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(120, label.frame.origin.y+label.frame.size.height+25, 65, 30)];
    label1.text = @"分享到:";
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:16];
    label1.backgroundColor = [UIColor clearColor];
    //    label1.enabled = NO;
    [scrollView addSubview:label1];
    
    
    //weixin
    UIButton *shareWeiXin = [[UIButton alloc]init];
    
    if ([WXApi isWXAppInstalled]){
        [scrollView addSubview:shareWeiXin];
    }
    
    shareWeiXin.frame = CGRectMake(245, label.frame.origin.y+label.frame.size.height+15, 45 , 45);
    //    shareWeiXin.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    shareWeiXin.tag = 1;
    [shareWeiXin addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    shareWeiXin.backgroundColor = [UIColor clearColor];
    [shareWeiXin setBackgroundImage:[UIImage imageNamed:@"shareWeixin.png"] forState:UIControlStateNormal];

    
    //weibo
    UIButton *shareWeiBo = [[UIButton alloc]init];
    [scrollView addSubview:shareWeiBo];
    shareWeiBo.frame = CGRectMake(190,label.frame.origin.y+label.frame.size.height+15, 45, 45);
    //    shareWeiBo.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 80);
    shareWeiBo.tag = 2;
    [shareWeiBo addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    shareWeiBo.backgroundColor = [UIColor clearColor];
    [shareWeiBo setBackgroundImage:[UIImage imageNamed:@"shareWeibo.png"] forState:UIControlStateNormal];

    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,shareWeiBo.frame.origin.y+shareWeiBo.frame.size.height+20);
}


- (void) shareWeixin:(NSDictionary *)response
{
    NSLog(@"微信分享");
    [SVProgressHUD dismiss];
    WXMediaMessage *message = [WXMediaMessage message];

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"picurl"]]]];
    message.title = [response objectForKey:@"content"];
    [message setThumbImage:[UIImage imageWithData:data]];
    WXWebpageObject *ext = [WXWebpageObject object];
    if ([[response objectForKey:@"appIOS"] isEqualToString:@""]) {
        ext.webpageUrl = [response objectForKey:@"link"];
    }else{
        ext.webpageUrl = [response objectForKey:@"appIOS"];
    }
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 1;
    
    [WXApi sendReq:req];
}


- (void) shareWeibo:(NSDictionary *)response
{
    NSLog(@"微博分享");
    [SVProgressHUD dismiss];
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:response]];
    [WeiboSDK sendRequest:request];
}

//weibo
- (WBMessageObject *)messageToShare:(NSDictionary *)response
{
    WBMessageObject *message = [WBMessageObject message];
    
    //文字
    message.text = shawText.text;

//    UIImage *img = [UIImage imageNamed:@"57(4).png"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"picurl"]]]];
    //图片
//    WBImageObject *image = [WBImageObject object];
//    image.imageData = data;
//    message.imageObject = image;
    
    //消息
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier2";
    webpage.title = App_Product_Name;
    webpage.description = [response objectForKey:@"content"];
    webpage.thumbnailData = data;
    if ([[response objectForKey:@"appIOS"] isEqualToString:@""]) {
        webpage.webpageUrl = [response objectForKey:@"link"];
    }else{
        webpage.webpageUrl = [response objectForKey:@"appIOS"];
    }
    message.mediaObject = webpage;

    return message;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)canceledit
{
    [self.view endEditing:YES];
}


-(void)backPop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
