//
//  FielMangerViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "FielMangerViewController.h"
#import "FielMangerCell.h"
#import "ShareView.h"
#import "WXApi.h"

@interface FielMangerViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate,ShareViewDelegate>
{
    UILabel * noDataWarningLabel;
}

@property (nonatomic, strong)UITableView * tab;
@property (nonatomic, strong)NSDictionary *shareDic;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)NSMutableArray * storedImagesArray;
@property (nonatomic, assign)NSInteger        currentStoredImageIndex;

@end

@implementation FielMangerViewController
-(void)dealloc
{
    [self.headView free];
    [self.footView free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.curPage = 1;
    if (self.flag == 1) {
        self.title = @"分享";
         [self postFielManiger];
        
    }else if(self.flag == 2){
        self.title = @"文案中心";
        [self postFielCenter];
    }else{
        self.title = @"邀请文案";
        [self postFenxiaoShang];
    }
    [self.view addSubview:self.tab];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.storedImagesArray = [NSMutableArray arrayWithCapacity:0];
    self.currentStoredImageIndex = 0;
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_tab;
    self.headView.delegate=self;
    
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_tab;
    self.footView.delegate=self;
   
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无文案";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    noDataWarningLabel.hidden = YES;
    [_tab addSubview:noDataWarningLabel];
    
    // Do any additional setup after loading the view.
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

    if (refreshView == _headView) {
        self.curPage = 1;
        if (self.flag == 2) {
             [self postFielCenter];
        }else if (self.flag == 1){
            [self postFielManiger];
        }else{
            [self postFenxiaoShang];
        }
       
    }else{
        self.curPage++;
        if (self.flag == 2) {
            [self postFielCenter];
        }else if (self.flag == 1){
            [self postFielManiger];
        }else{
            [self postFenxiaoShang];
        }
    }
}
#pragma mark - 懒加载
-(UITableView *)tab
{
    if (!_tab) {
        self.tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.backgroundColor = WHITE_COLOR;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tab;
}
#pragma mark - UITableViewDataSource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断数组返回的值是否为空
    if ([self.dataArray isKindOfClass:[NSMutableArray class]]) {
         return self.dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"cell";
    FielMangerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[FielMangerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateWith:[self.dataArray objectAtIndex:indexPath.row]];
    
    cell.textCopyBtn.tag=indexPath.row;
    cell.saveBtn.tag=indexPath.row;
    cell.shareBtn.tag=indexPath.row;

    [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.textCopyBtn addTarget:self action:@selector(copyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)shareBtnClick:(UIButton *)btn{
    int index=(int)btn.tag;
    if (index>=self.dataArray.count) {
        return;
    }
    [self shareOrSaveQRCode];
    
    NSString *description=[[self.dataArray objectAtIndex:index] valueForKey:@"content"];
    NSString *href=[[self.dataArray objectAtIndex:index] valueForKey:@"href_share"];
    NSString *picurl=[[self.dataArray objectAtIndex:index] valueForKey:@"picurl"];
    self.shareDic = @{@"picurl":picurl,@"content":description,@"link":href};
   
}
-(void)copyBtnClick:(UIButton *)btn{
    
    int index=(int)btn.tag;
    if (index>=self.dataArray.count) {
        return;
    }
    NSString *description=[[self.dataArray objectAtIndex:index] valueForKey:@"content"];
    NSString *href=[[self.dataArray objectAtIndex:index] valueForKey:@"href"];
    NSString *copyString=[NSString stringWithFormat:@"%@%@",description,href];
    
    
    [[UIPasteboard generalPasteboard] setPersistent:YES];
    [[UIPasteboard generalPasteboard] setValue:copyString forPasteboardType:[UIPasteboardTypeListString  objectAtIndex:0]];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"复制成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
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
    if (index == 1) {
        [self shareWeixin:self.shareDic];
    }else {
        [self tellWeixinFriends:self.shareDic];
    }
}
#pragma mark - 微信分享和朋友圈的方法
- (void) shareWeixin:(NSDictionary *)response
{
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

-(void)saveBtnClick:(UIButton *)btn{
    
    int index=(int)btn.tag;
    
    NSArray *imgArr=[[self.dataArray objectAtIndex:index ] valueForKey:@"picarr"];
    if (imgArr.count==0) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"没有图片可供保存" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

    if (index>=self.dataArray.count) {
        return;
    }
    
    if (self.storedImagesArray.count != 0)
    {
        [self.storedImagesArray removeAllObjects];
    }
    
    [SVProgressHUD showWithStatus:@"保存图片中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *imageUrlArr=[[self.dataArray objectAtIndex:index ] valueForKey:@"picarr"];
        NSMutableArray *imageArr=[[NSMutableArray alloc] initWithCapacity:0];
        if (imageUrlArr.count!=0) {
            LeMuJiImageCache *cache=[[LeMuJiImageCache alloc] init];
            
            for (int i=0; i<imageUrlArr.count; i++) {
                NSString *urlString=[[imageUrlArr objectAtIndex:i] valueForKey:@"picurl"];
                UIImage *cachedImage = [cache objectForKey:urlString];
                if(cachedImage!=nil){
                    [self.storedImagesArray addObject:cachedImage];
                }else{
                    cachedImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
                    if (cachedImage) {
                        [self.storedImagesArray addObject:cachedImage];
                    }
                }
            }
        }
        
        [self UIImageSavedToPhotosAlbum];
    });
}

- (void)UIImageSavedToPhotosAlbum
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImageWriteToSavedPhotosAlbum([self.storedImagesArray objectAtIndex:self.currentStoredImageIndex], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        if (self.currentStoredImageIndex != self.storedImagesArray.count - 1)
        {
            self.currentStoredImageIndex++;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImageWriteToSavedPhotosAlbum([self.storedImagesArray objectAtIndex:self.currentStoredImageIndex], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            });
        }
        else
        {
            [SVProgressHUD dismissWithSuccess:@"保存图片成功"];
            self.currentStoredImageIndex = 0;
        }
    }
    else
    {
        if (error.code == -3310)
        {
            [SVProgressHUD dismissWithError:@"无权限访问相册,请前往设置中心设置"];
        }
        else
        {
            [SVProgressHUD dismissWithError:@"保存图片失败"];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.dataArray objectAtIndex:indexPath.row];
    
    NSString *titleStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    CGFloat titleHight = [self getLengthWithStr:titleStr with:CGSizeMake(UI_SCREEN_WIDTH - 85, MAXFLOAT) font:13];
    
    
    NSString *contentStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    CGFloat contentHight = [self getLengthWithStr:contentStr with:CGSizeMake(UI_SCREEN_WIDTH - 85, MAXFLOAT) font:13];
    
    CGFloat startHight = 10 + contentHight + titleHight + 5;
    
    if (startHight < 75) {
        startHight = 75;
    }
    
    CGFloat off = 3;
    CGFloat width = (UI_SCREEN_WIDTH - 85 - 2*off) / 3;
    CGFloat hightForImg = 0;
    
    if ([[dic valueForKey:@"picarr"] isKindOfClass:[NSArray class]]) {
        NSArray *imageArr=[dic valueForKey:@"picarr"];
        CGFloat num = imageArr.count/3;
        CGFloat rem = imageArr.count%3;
        if (rem != 0) {
            num = num + 1;
        }
        if (num > 1) {
            hightForImg = width*num+off*(num-1);
        }else  {
            hightForImg = width*num;
        }
    }
    
    return startHight+hightForImg+50+5*2;
}
- (float)getLengthWithStr:(NSString *)str with:(CGSize)size font:(CGFloat)font{
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return ceilf(rect.size.height);
}


#pragma mark - http
-(void)postFenxiaoShang
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"p=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"user_invite_doc.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSArray *fileDataArray = [responseObject objectForKey:@"doc_list"];
            

            if (self.curPage == 1)
            {
                self.dataArray = [[NSMutableArray alloc] initWithArray:fileDataArray];
            }
            else
            {
                [self.dataArray addObjectsFromArray:fileDataArray];
            }
            noDataWarningLabel.hidden = self.dataArray.count == 0 ? NO : YES;
            [_tab reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

#pragma mark - http
-(void)postFielManiger
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@", self.aID];
    NSString *str=MOBILE_SERVER_URL(@"wenan.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            self.dataArray = [responseObject objectForKey:@"content"];
            noDataWarningLabel.hidden = self.dataArray.count == 0 ? NO : YES;

            [_tab reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}


-(void)postFielCenter
{
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"p=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"myproduct_wenanlist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSArray *fileDataArray = [responseObject objectForKey:@"content"];

            if (self.curPage == 1)
            {
                self.dataArray = [[NSMutableArray alloc] initWithArray:fileDataArray];
            }
            else
            {
                [self.dataArray addObjectsFromArray:fileDataArray];
            }
            noDataWarningLabel.hidden = self.dataArray.count == 0 ? NO : YES;
            [_tab reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

@end


static inline NSString * LeMuJiImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation LeMuJiImageCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
    return [self objectForKey:LeMuJiImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:LeMuJiImageCacheKeyFromURLRequest(request)];
    }
}
@end;
