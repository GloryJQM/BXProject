//
//  InviteViewController.m
//  SmallCEO
//
//  Created by ni on 17/3/16.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "InviteViewController.h"
#import "ShareView.h"
#import "WXApi.h"
@interface InviteViewController ()<ShareViewDelegate>
@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation InviteViewController
//取消键盘
-(void)missKeyBoard{
    [self.view endEditing:YES];
}
- (BOOL)isMatchString:(NSString *)str {
    NSString *regex = @"[A-Za-z0-9]{6}";
    NSPredicate *mat = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mat evaluateWithObject:str];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [shareBtn setImage:[UIImage imageNamed:@"分享22@2x"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = barbtn;
    [self createView];
}
//分享
- (void)shareAction {
    
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信", @"朋友圈"];
    ShareView *shareView = [[ShareView alloc] initWithShareButtonNameArray:sharePlace animation:YES];
    shareView.delegate = self;
    [shareView show];
}

- (void)saveQRCodeToPhotosAlbum {
    [SVProgressHUD show];
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD dismissWithSuccess:@"保存到相册成功"];
    }else {
        [SVProgressHUD dismissWithError:@"保存到相册失败"];
    }
}

- (void)shareView:(ShareView *)shareView clickButtonAtIndex:(NSInteger)index {
    [self shareAppWithType:index + 1];
}

- (void)shareAppWithType:(NSInteger)type {
    if (type == 3){
        [self saveQRCodeToPhotosAlbum];
        return;
    }
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"inviteCodeApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = @"act=2";
    [request  setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
    [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //先判断微信是否安装或者支持
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            [SVProgressHUD showSuccessWithStatus:@"正在前往微信支付"];
            if (type == 1){
                [self tellWeixinFriends:responseObject[@"share"]];
            }else if (type == 2){
                [self shareWeixin:responseObject[@"share"]];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"请先安装微信"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op_yue start];
}

- (void) shareWeixin:(NSDictionary *)response {
    WXMediaMessage *message = [WXMediaMessage message];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"picurl"]]]];
    message.title = [NSString stringWithFormat:@"%@", [response objectForKey:@"subject"]];
    message.description = [NSString stringWithFormat:@"%@", [response objectForKey:@"content"]];
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

- (void)tellWeixinFriends:(NSDictionary *)response {
    NSDictionary *sharedic = [[NSDictionary alloc] initWithDictionary:response];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [sharedic objectForKey:@"subject"];
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

//修改邀请码
- (void)changeCode {
    if (![self isMatchString:_textF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位邀请码13"];
        return;
    }
    if (_textF.isEnabled == NO) {
        return;
    }
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"inviteCodeApi.php");
    TokenURLRequest *requset = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [requset setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"act=1&invite_code=%@",_textF.text];
    [requset setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:requset];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@", responseObject[@"info"]);
        if ([responseObject[@"is_success"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改完成"];
            _textF.enabled = NO;
            [self.navigationController popViewControllerAnimated:YES];
            [self missKeyBoard];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
            _textF.text = @"";
            [self missKeyBoard];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        _textF.text = @"";
        [self missKeyBoard];
    }];
    [op start];
}
//确认修改
- (void)changeStart {
    _textF.enabled = YES;
    _textF.text = @"";
    [_textF becomeFirstResponder];
}

- (void)createView {
    self.title = @"邀请码";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, UI_SCREEN_WIDTH, 20)];
    headLabel.text = @"分享邀请码,邀请好友!";
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:17];
    [self.view addSubview:headLabel];
    
    _textF = [[UITextField alloc]initWithFrame:CGRectMake(0, headLabel.maxY + 20, UI_SCREEN_WIDTH, 25)];
    _textF.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    _textF.enabled = NO;
    _textF.textAlignment = NSTextAlignmentCenter;
    _textF.text = self.code;
    [_textF addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textF];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-40, headLabel.maxY+50, 80, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-50, line.maxY+5, 100, 20)];
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"点击修改" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName : [UIFont fontWithName:@"Thonburi" size:12]}];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 150) / 2, line.maxY + 30, 150, 150)];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    UILabel *promptTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY+5, UI_SCREEN_WIDTH, 20)];
    promptTextLabel.text = @"点击分享或保存二维码";
    promptTextLabel.textColor = [UIColor colorFromHexCode:@"848689"];
    promptTextLabel.textAlignment = NSTextAlignmentCenter;
    promptTextLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:promptTextLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [_imageView addGestureRecognizer:tap];
    
    
    UILabel *labe1 = [[UILabel alloc] initWithFrame:CGRectMake(15, promptTextLabel.maxY, UI_SCREEN_WIDTH - 30, 20)];
    labe1.text = @"好友注册成功并全额消费即可获得消费总额1%奖金";
    labe1.font = [UIFont systemFontOfSize:14.0];
    labe1.numberOfLines = 0;
    labe1.textAlignment = NSTextAlignmentCenter;
    CGSize sizeL = [labe1 sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 30, 20)];
    labe1.frame = CGRectMake(15, promptTextLabel.maxY, UI_SCREEN_WIDTH - 30, sizeL.height);
    labe1.textColor = [UIColor colorFromHexCode:@"848689"];
    [self.view addSubview:labe1];
    
    line.hidden = YES;
    
    [self getData];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, labe1.maxY+20, UI_SCREEN_WIDTH-24, 40)];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"确定" forState:UIControlStateNormal];
    shareBtn.backgroundColor = App_Main_Color;
    [shareBtn addTarget:self action:@selector(changeCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    if ([self.isCanEditInviteCode integerValue] == 0) {
        btn.hidden = YES;
        shareBtn.hidden = YES;
       
    }else if ([self.isCanEditInviteCode integerValue] == 1){
        btn.hidden = NO;
        shareBtn.hidden = NO;
        line.hidden = NO;
    }
}

- (void)textField:(UITextField *)textField {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
}

- (void)handleGesture:(UITapGestureRecognizer *)gesture {
    NSArray* sharePlace = [NSArray array];
    sharePlace = @[@"微信", @"朋友圈", @"保存到相册"];
    ShareView *shareView = [[ShareView alloc] initWithShareButtonNameArray:sharePlace animation:YES];
    shareView.delegate = self;
    [shareView show];
}

#pragma mark - 网络请求方法
- (void)getData {
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"codeshare.php");
    [RequestManager startRequestWithUrl:str
                                   body:@""
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"qrcode"]]]];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
