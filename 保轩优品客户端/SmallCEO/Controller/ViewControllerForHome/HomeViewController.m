//
//  HomeViewController.m
//  SmallCEO
//
//  Created by quanmai on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"
#import "ProductDetailsViewController.h"
#import "WXApi.h"
#import "CustomTypeImageView.h"
#import "HomeCusViewBanner.h"
#import "HomeCusViewItem.h"
#import "GeneralPageViewController.h"
#import "QRCodeScanViewController.h"
#import "LoginViewController.h"
#import "OtherShopListController.h"
#import "CommodityDetailViewController.h"


//调试
#import "CustomSearchTextField.h"
#import "CityListViewController.h"
#import "SearchViewController.h"
#import "PointMallViewController.h"
#import "UIView+EaseBlankPage.h"
#define HEAD_VIEW_TAG 9990

const NSInteger updateAlertViewTag = 9999;
const NSInteger forceUpdateAlertViewTag = 8888;

typedef NS_ENUM(NSUInteger, AletrtViewType)
{
    AletrtViewTypeCaiGou = 0,
    AletrtViewTypeTaoPay,
};

@interface HomeViewController ()<CustomTypeImageViewDelegate,HomeCusViewBannerDelegate,HomeCusViewItemDelegate,TipViewDelegate,UIScrollViewDelegate>{

    XLCycleScrollView *baner;
    
    UIScrollView    *_allScrollView;
    UIView *nagView;
    UILabel *locationLabel;
    UIButton *CodeButton;
    CustomSearchTextField *searchTextField;
    
    //海报
    UIImageView *homeBgImageView;
    UIView *shareDetailView;
    UIView *shareDetailViewBg;
    NSDictionary *poster;

    BOOL isOutContentHeight;
    BOOL isContentAdd;
    CGFloat  moveHeight;
    int      sideAble;
    CGFloat  lastPosition;
    NSInteger  jumpAppid;

    
    UITapGestureRecognizer *scrollviewTap;
    
    //是否在view willappear调用刷新请求；默认no；
    BOOL isNeedRedrawHomePage;
}

@property (nonatomic, strong) NSDictionary *versionDic;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        scrollviewTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeBgImageTap:)];
        
    }
    return self;
}

- (void)gotoSearchListView {
    SearchViewController *search = [[SearchViewController alloc]init];
    BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:search];
    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    search.shouldRequest = YES;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

//定位
- (void)showLocation:(id)gesture {
    CityListViewController *city = [[CityListViewController alloc]init];
    city.selectCityBlock = ^(NSString *selectCity){
        locationLabel.text = selectCity;
    };
    [self.navigationController pushViewController:city animated:YES];

}

//二维码扫瞄
- (void)ZXingBtn:(UIButton*)btn {
    if ([[PreferenceManager sharedManager] preferenceForKey:@"didLogin"] == nil || [[PreferenceManager sharedManager] preferenceForKey:@"token"] == nil ){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [LoginViewController performIfLogin:del.curViewController withShowTab:NO loginAlreadyBlock:^{
                    QRCodeScanViewController *widController = [[QRCodeScanViewController alloc]init];
                    [self.navigationController pushViewController:widController animated:YES];
            } loginSuccessBlock:^(BOOL login){
                if (login) {
                    QRCodeScanViewController *widController = [[QRCodeScanViewController alloc]init];
                    [self.navigationController pushViewController:widController animated:YES];
                }
            }];
        });
    }else {
        QRCodeScanViewController *widController = [[QRCodeScanViewController alloc]init];
        [self.navigationController pushViewController:widController animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHomeCustomView) name:@"reloadhomecustom" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityreloadHomeView) name:@"cityreloadhomecustom" object:nil];
    self.customViews=[[NSMutableArray alloc] initWithCapacity:0];
    self.itemsArray=[[NSMutableArray alloc] initWithCapacity:0];
    _timersArray = [[NSMutableArray alloc] initWithCapacity:0];

    //_clockTickers存放的是以数组形式组装一起的时、分、秒的一个个SBTickerView对象  countdownRecord存放的是每一个SBTickerView对象对应的倒计时的时间
    self.clockTickers = [[NSMutableArray alloc] init];
    self.countdownRecord = [[NSMutableArray alloc] init];
    
    nagView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
    nagView.backgroundColor= WHITE_COLOR_3;
    UITapGestureRecognizer *locationGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocation:)];
    locationGesture.numberOfTapsRequired=1;
    self.navigationItem.titleView = nagView;
    
    UIImage *ZImage=[[UIImage imageNamed:@"button-shaomiao@2x"] imageWithColor:[UIColor blackColor]];
    UIImage *smallImage=[[UIImage imageNamed:@"Button-dinweixuanze@2x"] imageWithColor:[UIColor blackColor]];

    UIButton *locationlabelBtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 8, 120, 14  )];
    locationlabelBtn.backgroundColor = [UIColor clearColor];
    [locationlabelBtn addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
    [nagView addSubview:locationlabelBtn];
    
    locationLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 8, 40, 14  )];
    locationLabel.backgroundColor=[UIColor clearColor];
    
    NSString *cityString=(NSString *)[[PreferenceManager sharedManager] preferenceForKey:@"cityname"];
    locationLabel.text= [cityString isValid]? cityString:@"未定位";
    //定位文本
    locationLabel.font=[UIFont systemFontOfSize:13];
    locationLabel.tag=20000;
    //    CGSize size=[locationLabel sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
    //[locationLabel sizeToFit];
    locationLabel.textAlignment=NSTextAlignmentLeft;
    [nagView addSubview:locationLabel];
    [locationLabel addGestureRecognizer:locationGesture];
    //定位小图片
    UIImageView *small = [[UIImageView alloc]initWithImage:smallImage];
    small.frame = CGRectMake(CGRectGetMaxX(locationLabel.frame)+5, 13, small.size.width, small.size.height);
    [nagView addSubview:small];
    
    //扫描按钮
    CodeButton=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 36, 3, 24,24)];
    CodeButton.tag=20001;
    CodeButton.backgroundColor = [UIColor clearColor];
    [CodeButton setImage:ZImage forState:UIControlStateNormal];
    [CodeButton addTarget:self action:@selector(ZXingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [nagView addSubview:CodeButton];
    
    searchTextField = [[CustomSearchTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(small.frame)+5, 0, CodeButton.minX - small.maxX - 10, 30)];
    searchTextField.placeholder = @" 输入商品名称";
    [nagView addSubview:searchTextField];
    
    UIButton *tfBtn = [[UIButton alloc] initWithFrame:searchTextField.bounds];
    tfBtn.backgroundColor = [UIColor clearColor];
    [tfBtn addTarget:self action:@selector(gotoSearchListView) forControlEvents:UIControlEventTouchUpInside];
    [searchTextField addSubview:tfBtn];
    
    //海报
    homeBgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-64-51)];
    homeBgImageView.hidden=YES;
    [self.view addSubview:homeBgImageView];
    
    //分享按钮
    UIButton *temp=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    temp.center=CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT-64-50-51);
    [temp setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateNormal];
    [homeBgImageView addSubview:temp];
    
    if (!ISShowShareFunction) {
        temp.hidden=YES;
    }
    
    _allScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-64-51)];
    _allScrollView.delegate=self;
    _allScrollView.backgroundColor =[UIColor clearColor];
    _allScrollView.showsVerticalScrollIndicator = NO;
    _allScrollView.alwaysBounceVertical=YES;
    [self.view addSubview:_allScrollView];
    
    header=[[MJRefreshHeaderView alloc] init];
    header.delegate=self;
    header.scrollView=_allScrollView;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *_window=delegate.window;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView:)];
    tapGesture.numberOfTapsRequired=1;
    shareDetailViewBg=[[UIView alloc] initWithFrame:self.view.bounds];
    shareDetailViewBg .backgroundColor=[UIColor grayColor];
    shareDetailViewBg.hidden=YES;
    shareDetailViewBg.alpha=0.6;
    [self.view addSubview:shareDetailViewBg];
    [shareDetailViewBg addGestureRecognizer:tapGesture];
    
    
    shareDetailView=[[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH,160)];
    shareDetailView.tag=5000;
    shareDetailView .backgroundColor=[UIColor whiteColor];
    [_window addSubview:shareDetailView];
    [_window bringSubviewToFront:shareDetailView];
    
    UILabel *shareTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20  )];
    shareTitleLabel.backgroundColor=[UIColor whiteColor];
    shareTitleLabel.textColor=[UIColor blackColor];
    shareTitleLabel.center=CGPointMake(UI_SCREEN_WIDTH/2, 15);
    shareTitleLabel.text=@"分享到";
    shareTitleLabel.textAlignment=NSTextAlignmentCenter;
    [shareDetailView addSubview:shareTitleLabel];
    
    int dis1=(UI_SCREEN_WIDTH-3*50)/4;
    NSArray *shareImages=[NSArray arrayWithObjects:@"Weiboicon.png",@"Weixinicon.png",@"shareWeixin.png", nil];
    NSArray *shareText=[NSArray arrayWithObjects:@"新浪微博",@"微信好友",@"微信朋友圈", nil];
    for (int i=0; i<3; i++) {
        UIButton *temp=[[UIButton alloc] initWithFrame:CGRectMake(dis1+(50+dis1)*i, 30, 50, 50)];
        temp.layer.borderWidth=0.5;
        temp.layer.borderColor=myRGBA(50, 50, 50, 0.4).CGColor;
        temp.layer.cornerRadius=3;
        temp.tag=90000+i;
        [temp addTarget:self action:@selector(shareToFriends:) forControlEvents:UIControlEventTouchUpInside];
        [temp setImage:[UIImage imageNamed:[shareImages objectAtIndex:i]] forState:UIControlStateNormal];
        [shareDetailView addSubview:temp];
        
        UILabel *tempLabel=[[UILabel alloc] initWithFrame:CGRectMake(dis1+(50+dis1)*i-15, 90, 80, 20)];
        tempLabel.text=[shareText objectAtIndex:i];
        tempLabel.textAlignment=NSTextAlignmentCenter;
        tempLabel.font=[UIFont systemFontOfSize:15];
        tempLabel.textColor=[UIColor blackColor];
        tempLabel.backgroundColor=[UIColor whiteColor];
        [shareDetailView addSubview:tempLabel];
    }
    
    UIButton *cancelShareButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-30, 30)];
    cancelShareButton.layer.borderWidth=0.5;
    cancelShareButton.layer.cornerRadius=3;
    cancelShareButton.layer.borderColor=myRGBA(50, 50, 50, 0.4).CGColor;
    cancelShareButton.backgroundColor=[UIColor whiteColor];
    [cancelShareButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelShareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelShareButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [cancelShareButton addTarget:self action:@selector(hideShareView:) forControlEvents:UIControlEventTouchUpInside];
    cancelShareButton.center=CGPointMake(UI_SCREEN_WIDTH/2,140 );
    [shareDetailView addSubview:cancelShareButton];
    
    [self requestdata];
}

- (void)hideShareView:(id)button {
    shareDetailViewBg.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=shareDetailView.frame;
        rect.origin.y+=shareDetailView.frame.size.height;
        shareDetailView.frame=rect;
    }];
    
}

- (void)homeBgImageTap:(UIGestureRecognizer  *)ges {
    NSLog(@"homeBgImageTap");
    NSString *link_value = [NSString stringWithFormat:@"%@",[poster objectForKey:@"link_value"]];
    if (IS_IPHONE5) {
        link_value=[NSString stringWithFormat:@"%@",[poster objectForKey:@"ios5_link_value"]];
    }else if (IS_IPHONE6) {
        if ([poster objectForKey:@"ios6_link_value"]) {
            link_value = [NSString stringWithFormat:@"%@",[poster objectForKey:@"ios6_link_value"]];
        }
    }else if (IS_IPHONE6PLUS) {
        if ([poster objectForKey:@"ios6plus_link_value"]) {
            link_value = [NSString stringWithFormat:@"%@",[poster objectForKey:@"ios6plus_link_value"]];
        }
    }
    
    if (link_value.length > 0) {
        [self cheackUrl:link_value];
    }
}

#pragma mark - 分享
- (void)shareToFriends:(UIButton *)button {
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"newindex_08.php");
    //每次请求request的alloc会产生0.1mb的内存
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"type=%@",@"myapp"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"share"];
        NSLog(@"首页分享内容:%@",dict);
        long index=(long)button.tag-90000;
        if (index==0) {
            NSLog(@"分享到微博：");
            [self shareWeibo:dict];
        }
        if (index==1) {
            NSLog(@"分享到微信好友：");
            [self tellWeixinFriends:dict];
        }
        if (index==2) {
            NSLog(@"分享到微信朋友圈：");
            [self shareWeixin:dict];
        }
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
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

//微博朋友圈
- (void)shareWeibo:(NSDictionary *)response {
    NSLog(@"微博分享");
    [SVProgressHUD dismiss];
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:response]];
    [WeiboSDK sendRequest:request];
}

//weibo
- (WBMessageObject *)messageToShare:(NSDictionary *)response {
    WBMessageObject *message = [WBMessageObject message];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"picurl"]]]];
    
    //消息
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier3";
    webpage.title = App_Product_Name;
    webpage.description = [response objectForKey:@"content"];
    webpage.thumbnailData = data;
    webpage.webpageUrl = [response objectForKey:@"link"];
    message.mediaObject = webpage;
    return message;
}

//微信好友
- (void)tellWeixinFriends:(NSDictionary *)response {
    NSDictionary *sharedic = [[NSDictionary alloc] initWithDictionary:response];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [sharedic objectForKey:@"content"];
    message.description = [NSString stringWithFormat:@"%@,你值得拥有,赶紧去下载吧",App_Product_Name];
    
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


- (void)reloadHomeCustomView {
    [_itemsArray removeAllObjects];
    [self requestdata];
}

- (void)cityreloadHomeView {
    NSString *cityString=(NSString *)[[PreferenceManager sharedManager] preferenceForKey:@"cityname"];
    locationLabel.text=cityString;
    [locationLabel sizeToFit];
    searchTextField.frame=CGRectMake(CGRectGetMaxX(locationLabel.frame)+5, 0, (UI_SCREEN_WIDTH-CGRectGetMaxX(locationLabel.frame)-10-19-20), 30);
    CodeButton.frame=CGRectMake(CGRectGetMaxX(searchTextField.frame)+5, 5,21, 21);
    
    [_itemsArray removeAllObjects];
    [self requestdata];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    [self requestdata];
}

- (void)removeNavigationbarLine:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if (subview.frame.size.height<=1.5) {
            [subview removeFromSuperview];
        }
        if (subview.subviews.count>0) {
            [self removeNavigationbarLine:subview];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"loadLocation" object:nil userInfo:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"first"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"second"];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomTabBarController *tab = delegate.tabBarController;
    [tab showTabView:YES animated:YES];
    
    if (!_HomeCountDownTimer) {
        _HomeCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    }
    
    [self removeNavigationbarLine:self.navigationController.navigationBar];
    
    if(isNeedRedrawHomePage){
        [self requestdata];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    if (_HomeCountDownTimer) {
        [_HomeCountDownTimer invalidate];
        _HomeCountDownTimer = nil;
    }
    if (_itemsArray.count > 0) {
        for (int i = 0; i <_itemsArray.count; i++) {
            NSDictionary *itemtempdic = [NSDictionary dictionaryWithDictionary:[_itemsArray objectAtIndex:i]];
            int type = [[itemtempdic objectForKey:@"type"] intValue];
            if (type == 1) {
                HomeCusViewOne *vi1 = (HomeCusViewOne *)[itemtempdic objectForKey:@"item"];
                [vi1 stopCountDownTimer];
            }
        }
    }
}

#pragma mark - http
- (void)requestdata {
    isNeedRedrawHomePage=NO;
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"newindex_08.php");
    //每次请求request的alloc会产生0.1mb的内存
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"type=%@",@"myapppage"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@", responseObject);
        [header endRefreshing];
        [SVProgressHUD dismiss];

        //海报背景
        poster=[responseObject objectForKey:@"posters"];
        NSString *icon_url0 = [NSString stringWithFormat:@"%@",[poster objectForKey:@"picurl"]];
        if (IS_IPHONE5) {
                icon_url0 = [NSString stringWithFormat:@"%@",[poster objectForKey:@"ios5_picurl"]];
        }else if (IS_IPHONE6) {
            if ([poster objectForKey:@"ios6_picurl"]) {
                icon_url0 = [NSString stringWithFormat:@"%@",[poster objectForKey:@"ios6_picurl"]];
            }
        }else if (IS_IPHONE6PLUS) {
            if ([poster objectForKey:@"ios6plus_picurl"]) {
                icon_url0 = [NSString stringWithFormat:@"%@",[poster objectForKey:@"ios6plus_picurl"]];
            }
        }
        
        [homeBgImageView sd_setImageWithURL:[NSURL URLWithString:icon_url0]];
        
        [self createCustomView:[responseObject objectForKey:@"content"]];
        id backgroundColor = [responseObject objectForKey:@"background_color"];
        if (backgroundColor != nil) {
            _allScrollView.backgroundColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@", backgroundColor]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [header endRefreshing];
        [self.view configBlankPage:EaseBlankPageTypeRefresh hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestdata];
        }];
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
    [op start];
    
}

-(void)createCustomView:(NSArray *)goodsAllArray {
    for (int i=0; i<_customViews.count; i++) {
        UIView *view=[_customViews objectAtIndex:i];
        if (view!=nil) {
            [view removeFromSuperview];
        }
    }
    _goodsAllArray = goodsAllArray;
    //用于再次请求时候更改界面内容
    [_itemsArray removeAllObjects];
    //界面内容改变后更改界面高度
    [_customViews removeAllObjects];
    
    float curorigin_y = 0;
    
    for (int i = 0; i < goodsAllArray.count; i++ ) {
        if (![[goodsAllArray objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        NSDictionary *tempdic = [goodsAllArray objectAtIndex:i];
        int curtype = [[tempdic objectForKey:@"type"] intValue];
        if (curtype == 24) {
            NSArray *contentArr=[tempdic objectForKey:@"content"];
            if (contentArr!=nil&&contentArr.count>0) {
                float height=[[tempdic valueForKey:@"height"] floatValue];
                float width=[[tempdic valueForKey:@"width"] floatValue];
                float x=[[tempdic valueForKey:@"x"] floatValue];
                float y=[[tempdic valueForKey:@"y"] floatValue];
                float gap=[[tempdic valueForKey:@"gap"] floatValue];
                HomeCusViewBanner *banner=[[HomeCusViewBanner alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, height*UI_SCREEN_WIDTH/width)];
                banner.offsetFromO=CGPointMake(x, y);
                banner.gapDis=gap;
                banner.delegate=self;
                [banner SetDataSourceArr:contentArr];
                [_allScrollView addSubview:banner];
                [_customViews addObject:banner];
                curorigin_y += banner.frame.size.height+gap;
                UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-gap, UI_SCREEN_WIDTH, gap)];
                gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
                [_allScrollView addSubview:gapView];
                [_customViews addObject:gapView];
                
                
                NSString *curtypestr = [NSString stringWithFormat:@"%d",curtype];
                NSDictionary *itemtempdic = [NSDictionary dictionaryWithObjectsAndKeys:banner,@"item",curtypestr,@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
                [_itemsArray addObject:itemtempdic];
            }
        } else if (curtype == 25) {
            //这个值是用于  appid = 10 或者11的时候  HomeCusViewItem调用gototheme  而不是linktype linkvalue的方式  所以需要在改类保存
            _appDit = [NSDictionary dictionaryWithDictionary:tempdic];
            
            float gap = [[tempdic valueForKey:@"gap"] floatValue];
            HomeCusViewItem *item = [[HomeCusViewItem alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 73.5) dataDic:tempdic];
            item.delegate = self;
            [_allScrollView addSubview:item];
            [_customViews addObject:item];
            curorigin_y += item.frame.size.height+gap;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-gap, UI_SCREEN_WIDTH, gap)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            [_customViews addObject:gapView];
            
            NSString *curtypestr = [NSString stringWithFormat:@"%d",curtype];
            NSDictionary *itemtempdic = [NSDictionary dictionaryWithObjectsAndKeys:item,@"item",curtypestr,@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic];
        } else if (curtype == 22) {
            float custom_w =[[NSString stringWithFormat:@"%@",[tempdic objectForKey:@"width"]] floatValue]/2.0 ;
            float custom_h =[[NSString stringWithFormat:@"%@",[tempdic objectForKey:@"height"]] floatValue]/2.0 ;
            CustomTypeImageView *vi22 = [[CustomTypeImageView alloc] initWithFrame:CGRectMake(0, curorigin_y, custom_w * adapterFactor, custom_h * adapterFactor) ContentDic:tempdic];
            vi22.custypeDelegate = self;
            vi22.backgroundColor = [UIColor whiteColor];
            vi22.tag = i+1;
            [_allScrollView addSubview:vi22];
            curorigin_y += (custom_h * adapterFactor);
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            NSDictionary *itemtempdic22 = [NSDictionary dictionaryWithObjectsAndKeys:vi22,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic22];
            [_customViews addObject:vi22];
        }
        if (curtype == 1) {
            HomeCusViewOne *vi1 = [[HomeCusViewOne alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 145.0) Items:tempdic];
            vi1.cusfirstDelegate = self;
            [vi1 firstViewLaodDatas:tempdic];
            vi1.tag = i+1;
            [_allScrollView addSubview:vi1];
            
            curorigin_y += vi1.frame.size.height + 5.0;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            
            NSString *curtypestr = [NSString stringWithFormat:@"%d",curtype];
            NSDictionary *itemtempdic = [NSDictionary dictionaryWithObjectsAndKeys:vi1,@"item",curtypestr,@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic];
            
            [_customViews addObject:vi1];
            [_customViews addObject:gapView];
        }else if (curtype == 2) {
            HomeCusViewSec *vi2 = [[HomeCusViewSec alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 120)];
            vi2.cussecondDelegate = self;
            [vi2 secondViewLaodDatas:tempdic];
            vi2.tag = i+1;
            [_allScrollView addSubview:vi2];
            curorigin_y += 120.0 + 5.0;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            NSDictionary *itemtempdic1 = [NSDictionary dictionaryWithObjectsAndKeys:vi2,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic1];
            
            [_customViews addObject:vi2];
            [_customViews addObject:gapView];
            
        }else if (curtype == 3) {
            HomeCustViewThree *vi3 = [[HomeCustViewThree alloc] initWithFrame:CGRectMake(0,curorigin_y, UI_SCREEN_WIDTH, 120)];
            vi3.custhreeDelegate = self;
            [vi3 threeViewLaodDatas:tempdic];
            vi3.tag = i+1;
            [_allScrollView addSubview:vi3];
            curorigin_y += 120.0 + 5.0;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            
            NSDictionary *itemtempdic2 = [NSDictionary dictionaryWithObjectsAndKeys:vi3,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic2];
            
            [_customViews addObject:vi3];
            [_customViews addObject:gapView];
        }else if (curtype == 4) {
            HomeCusViewFour *vi4 = [[HomeCusViewFour alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 130)];
            vi4.cusfourDelegate = self;
            [vi4 fourViewLaodDatas:tempdic];
            vi4.tag = i+1;
            [_allScrollView addSubview:vi4];
            curorigin_y += 130.0 + 5.0;
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            NSDictionary *itemtempdic3 = [NSDictionary dictionaryWithObjectsAndKeys:vi4,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic3];
            
            [_customViews addObject:vi4];
            [_customViews addObject:gapView];
        }else if (curtype == 5) {
            HomeCusViewFive *vi5 = [[HomeCusViewFive alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 92.0+14.0) tbackcolor:@"#3acac1" imgbackcolor:@"#3acac1" contentDic:tempdic];
            vi5.cusfiveDelegate = self;
            [vi5 fiveViewLaodDatas:tempdic];
            vi5.tag = i+1;
            [_allScrollView addSubview:vi5];
            
            curorigin_y += 92.0+5.0+14.0;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            NSDictionary *itemtempdic4 = [NSDictionary dictionaryWithObjectsAndKeys:vi5,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic4];
            
            [_customViews addObject:vi5];
            [_customViews addObject:gapView];
            
        }else if (curtype == 6) {
            HomeCusViewSix *vi6 = [[HomeCusViewSix alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 92.0+14.0) tbackcolor:@"#3acac1" imgbackcolor:@"#3acac1" contentDic:tempdic];
            vi6.cussixDelegate = self;
            [vi6 sixViewLaodDatas:tempdic];
            vi6.tag = i+1;
            [_allScrollView addSubview:vi6];
            curorigin_y += 92.0+5.0+14.0;
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            
            NSDictionary *itemtempdic5 = [NSDictionary dictionaryWithObjectsAndKeys:vi6,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic5];
            [_customViews addObject:vi6];
            [_customViews addObject:gapView];
            
        }else if (curtype == 7) {
            float origin_x = 10.0;
            float origin_y = 0.0;
            UIView  *backvi = [[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 25.0)];
            backvi.backgroundColor = [UIColor whiteColor];
            [_allScrollView addSubview:backvi];
            [_customViews addObject:backvi];

            NSMutableDictionary *itemtempdic6 = [NSMutableDictionary dictionaryWithCapacity:0];
            NSString *left_logo = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"logo"]];
            if (left_logo != nil && left_logo.length > 0) {
                UIImageView  *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(origin_x, 3.0, 35.0, 20.0)];
                leftImgView.backgroundColor = [UIColor clearColor];
                leftImgView.contentMode = UIViewContentModeScaleAspectFit;
                [leftImgView sd_setImageWithURL:[NSURL URLWithString:left_logo]];
                [backvi addSubview:leftImgView];
                origin_x += 30.0+5.0+2.0;
                origin_y += 25.0;
                [itemtempdic6 setObject:leftImgView forKey:@"leftimgview"];
                [itemtempdic6 setObject:@"showimage" forKey:@"leftimg_url"];
            }else{
                [itemtempdic6 setObject:@"no_image" forKey:@"leftimg_url"];
            }
            
            NSString *left_title = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"title"]];
            NSString *left_title_color = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"title_color"]];
            if (left_title != nil && left_title.length > 0) {
                
                UILabel  *leftTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, 0, 120.0, 25)];
                leftTitleLab.text = left_title;
                leftTitleLab.font = [UIFont systemFontOfSize:14.0f];
                leftTitleLab.textColor = [UIColor colorFromHexCode:left_title_color];
                leftTitleLab.backgroundColor = [UIColor clearColor];
                [backvi addSubview:leftTitleLab];
                origin_x = 10.0;
                
                if (origin_y == 0) {
                    origin_y += 25.0;
                }
                [itemtempdic6 setObject:leftTitleLab forKey:@"lefttitle"];
                [itemtempdic6 setObject:@"show_title" forKey:@"lefttitletext"];
            }else{
                [itemtempdic6 setObject:@"no_title" forKey:@"lefttitletext"];
            }
            
            NSString *time_title = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"countdown"]];
            int lefttime = [time_title intValue];
            //lefttime = 20;
            if (lefttime > 0) {
                NSString *left_substr = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"sub_title"]];
                if (left_substr.length > 0) {
                    [self addCountDownView:CGRectMake(self.view.frame.size.width-82.0f, 10, 140, 25) superView:backvi countdown:time_title];
                }else{
                    [self addCountDownView:CGRectMake(self.view.frame.size.width-82.0f, 4.0, 140, 25) superView:backvi countdown:time_title];
                }
                
                //保持存在
                NSString *right_subtitle = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"right_title"]];
                NSString *right_subtitle_color = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"right_title_link_olor"]];
                UILabel *lbl_right_subtitle = [[UILabel alloc] init];
                if (left_substr.length > 0) {
                    lbl_right_subtitle.frame = CGRectMake(self.view.frame.size.width-82.0f-80.0f-2.0, 6.0, 80.0, 25.0);
                }else{
                    lbl_right_subtitle.frame = CGRectMake(self.view.frame.size.width-82.0f-80.0f-2.0, 0, 80.0, 25.0);
                }
                lbl_right_subtitle.textColor = [UIColor colorFromHexCode:right_subtitle_color];
                lbl_right_subtitle.font = [UIFont systemFontOfSize:13.0f];
                lbl_right_subtitle.backgroundColor = [UIColor clearColor];
                if (right_subtitle.length > 0) {
                    lbl_right_subtitle.text = right_subtitle;
                }else{
                    lbl_right_subtitle.text = right_subtitle;
                }
                lbl_right_subtitle.textAlignment = NSTextAlignmentRight;
                [backvi addSubview:lbl_right_subtitle];
                [itemtempdic6 setObject:lbl_right_subtitle forKey:@"right_titlelab"];
                
                NSDictionary *timertempdic = [NSDictionary dictionaryWithObjectsAndKeys:lbl_right_subtitle, @"time_rigth_titlelab",nil];
                [_timersArray addObject:timertempdic];
                
            }else if(lefttime == 0){
                
            }else if (lefttime <0){
                //如果服务器返回 -1, 则显示right_title
                NSString *right_subtitle = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"right_title"]];
                NSString *right_subtitle_color = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"right_title_link_olor"]];
                NSString *left_substr = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"sub_title"]];
                UILabel *lbl_right_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150.0f, 1.0, 140.0f, 25)];
                if (left_substr.length > 0) {
                    lbl_right_subtitle.frame = CGRectMake(self.view.frame.size.width-150.0f, 6.0, 140.0f, 25.0f);
                }else{
                    lbl_right_subtitle.frame = CGRectMake(self.view.frame.size.width-150.0f, 1.0, 140.0f, 25.0f);
                }
                lbl_right_subtitle.textColor = [UIColor colorFromHexCode:right_subtitle_color];
                lbl_right_subtitle.font = [UIFont systemFontOfSize:13.0f];
                lbl_right_subtitle.backgroundColor = [UIColor clearColor];
                lbl_right_subtitle.text = right_subtitle;
                lbl_right_subtitle.textAlignment = NSTextAlignmentRight;
                [backvi addSubview:lbl_right_subtitle];
                [itemtempdic6 setObject:lbl_right_subtitle forKey:@"right_titlelab"];
                
                //处理倒计时
                NSDictionary *timertempdic = [NSDictionary dictionaryWithObjectsAndKeys:lbl_right_subtitle, @"time_rigth_titlelab",nil];
                [_timersArray addObject:timertempdic];
            }
            
            UIButton *morebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            morebtn.backgroundColor = [UIColor clearColor];
            morebtn.frame = CGRectMake(self.view.frame.size.width-150.0f, 0, 140.0f, 25.0f);
            [morebtn addTarget:self action:@selector(morebtnclick:) forControlEvents:UIControlEventTouchUpInside];
            morebtn.tag = 20*(i+1);
            [backvi addSubview:morebtn];

            curorigin_y += 25.0 ;
            
            NSString *left_subtitle = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"sub_title"]];
            if (left_subtitle != nil && left_subtitle.length > 0) {
                UILabel *leftsubtitlelab = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, 25, 200, 25)];
                leftsubtitlelab.textColor = [UIColor lightGrayColor];
                leftsubtitlelab.font = [UIFont systemFontOfSize:13.0f];
                leftsubtitlelab.backgroundColor = [UIColor clearColor];
                leftsubtitlelab.text = left_subtitle;
                [backvi addSubview:leftsubtitlelab];
                curorigin_y += 25.0+2 ;
                [itemtempdic6 setObject:leftsubtitlelab forKey:@"leftsubtitle"];
                [itemtempdic6 setObject:@"show_subtitle" forKey:@"leftsubtitletext"];
                backvi.frame = CGRectMake(0, backvi.frame.origin.y, UI_SCREEN_WIDTH, backvi.frame.size.height+25.0+2);
            }else{
                [itemtempdic6 setObject:@"no_subtitle" forKey:@"leftsubtitletext"];
            }
            [itemtempdic6 setObject:[NSString stringWithFormat:@"%d",curtype] forKey:@"type"];
            [itemtempdic6 setObject:[NSString stringWithFormat:@"%d",i] forKey:@"curindex"];
            
            [_itemsArray addObject:itemtempdic6];
            
            UIImageView *lineimg = [[UIImageView alloc] initWithFrame:CGRectMake(0,backvi.frame.size.height-2.0, UI_SCREEN_WIDTH, 1.0)];
            lineimg.image = [UIImage imageNamed:@"home_new_line.png"];
            [backvi addSubview:lineimg];
        }else if (curtype == 21) {
            HomeCusViewEleven *vi11 = [[HomeCusViewEleven alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 213.0)];
            vi11.cuselevenDelegate = self;
            [vi11 elevenViewLaodDatas:tempdic];
            vi11.tag = i+1;
            [_allScrollView addSubview:vi11];
            
            curorigin_y += 213.0 + 5.0;
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            NSDictionary *itemtempdic11 = [NSDictionary dictionaryWithObjectsAndKeys:vi11,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic11];
            
            [_customViews addObject:vi11];
            [_customViews addObject:gapView];
        }else if (curtype == 12) {
            HomeCusViewTwelve *vi12 = [[HomeCusViewTwelve alloc] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, 92.0) tbackcolor:@"#3acac1" imgbackcolor:@"#3acac1" contentDic:tempdic];
            vi12.custwelveDelegate = self;
            [vi12 twelveViewLaodDatas:tempdic];
            vi12.tag = i+1;
            [_allScrollView addSubview:vi12];
            
            curorigin_y += 92.0+5.0;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-5, UI_SCREEN_WIDTH, 5)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            NSDictionary *itemtempdic4 = [NSDictionary dictionaryWithObjectsAndKeys:vi12,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic4];
            
            [_customViews addObject:vi12];
            [_customViews addObject:gapView];
        }else if (curtype == 26) {
            NSArray *arr=[tempdic valueForKey:@"content"];
            if (arr.count>0) {
                noticeDictionary= (NSDictionary *)[arr objectAtIndex:0];
            }else{
                continue;
            }
            
            NSArray *listArr=(NSArray *)[noticeDictionary valueForKey:@"notice"];
            if (listArr.count==0) {
                //消息数量为0
                continue;
            }
            
            float height=[[noticeDictionary valueForKey:@"view"]  floatValue];
            float gap=[[tempdic valueForKey:@"gap"]  floatValue];
            NSString *bgColor=[noticeDictionary valueForKey:@"bg_color"];
            
            noticeTipView=[[TipView alloc ] initWithFrame:CGRectMake(0, curorigin_y, UI_SCREEN_WIDTH, height)];
            noticeTipView.backgroundColor=[UIColor colorFromHexCode:bgColor];
            noticeTipView.clipsToBounds=YES;
            noticeTipView.delegate=self;
            [_allScrollView  addSubview:noticeTipView];
            
            [noticeTipView updateUIWithDic:noticeDictionary];
            NSString *urlString=(NSString *)[noticeDictionary valueForKey:@"picurl"];
            [noticeTipView.imageV sd_setImageWithURL:[NSURL URLWithString:urlString]];
            
            curorigin_y += height+gap;
            
            UIView *gapView=[[UIView alloc] initWithFrame:CGRectMake(0, curorigin_y-gap, UI_SCREEN_WIDTH, gap)];
            gapView.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
            [_allScrollView addSubview:gapView];
            
            NSDictionary *itemtempdic4 = [NSDictionary dictionaryWithObjectsAndKeys:noticeTipView,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic4];
            
            [_customViews addObject:noticeTipView];
            [_customViews addObject:gapView];
        }
    }
    _allScrollViewContentOriginH = curorigin_y;
    _allScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _allScrollViewContentOriginH);
}

- (void)addCountDownView:(CGRect)frame superView:(UIView *)superView countdown:(NSString *)countdown {
    if (!_HomeCountDownTimer) {
        _HomeCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    }
    _currentClock = @"000000";
    SBTickerView *clockTickerViewHour1 = [[SBTickerView alloc] initWithFrame:frame];

    SBTickerView *clockTickerViewMinute1 = [[SBTickerView alloc] initWithFrame:CGRectMake(frame.origin.x+26.0f, frame.origin.y, frame.size.width, frame.size.height)];

    SBTickerView *clockTickerViewSecond1 = [[SBTickerView alloc] initWithFrame:CGRectMake(frame.origin.x+52.0f, frame.origin.y, frame.size.width, frame.size.height)];

    NSArray* clockTicersInstance  = [NSArray arrayWithObjects:
                                     clockTickerViewHour1,
                                     clockTickerViewMinute1,
                                     clockTickerViewSecond1,
                                     nil];
    [_clockTickers addObject:clockTicersInstance];
    [_countdownRecord addObject:countdown];
    NSString* strCoutndown = [self parseCountDown:[countdown intValue]];
    int i=0;
    for (SBTickerView *ticker in clockTicersInstance){
        CGRect frame = ticker.frame;
        frame.size.width = 20.0f;
        frame.size.height = 20.0f;
        ticker.frame = frame;
        [ticker setFrontView:[SBTickView tickViewWithTitle:[strCoutndown substringWithRange:NSMakeRange(i*2, 2)] fontSize:14.]];
        if(i<[clockTicersInstance count]-1){
            UILabel *timerSplitter = [[UILabel alloc] initWithFrame:CGRectMake(ticker.frame.origin.x+ticker.frame.size.width+1, frame.origin.y-2, 3, 20)];
            [timerSplitter setText:@":"];
            [superView addSubview:timerSplitter];
        }
        [superView addSubview:ticker];
        i++;
    }
}
#pragma mark - customviewdelegate

- (void)cusfirstitemButton:(UIButton *)curbtn CurView:(HomeCusViewOne *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    NSInteger ind = curbtn.tag - 100;
    if (itemarr.count > ind) {
        NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 100];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[itemdic objectForKey:@"link_value"] title:@""];
    }
}
//大图在左模块
- (void)cusseconditemButton:(UIButton *)curbtn CurView:(HomeCusViewSec *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    NSInteger ind = curbtn.tag - 200;
    if (itemarr.count > ind) {
        NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 200];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[itemdic objectForKey:@"link_value"] title:@""];
    }
}
//大图在右模块
- (void)custhreeitemButton:(UIButton *)curbtn CurView:(HomeCustViewThree *)curVi{
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    NSInteger ind = curbtn.tag - 300;
    if (itemarr.count > ind) {
        NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 300];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[itemdic objectForKey:@"link_value"] title:@""];
    }
}
//聚合模块
- (void)itemButton:(UIButton *)curbtn CurView:(HomeCusViewFour *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    NSInteger ind = curbtn.tag - 400;
    if (itemarr.count > ind) {
        NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 400];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[itemdic objectForKey:@"link_value"] title:@""];
    }
}

- (void)cusfiveitemButton:(UIButton *)curbtn CurView:(HomeCusViewFive *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    if (curbtn.tag == 500) {
        NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"pic_link_value"]];
        int linktype = [[itemsdic objectForKey:@"pic_link_type"] intValue];
        [self gotoGoodsList:linktype linkvale:linkvalue title:@""];
    }else if (curbtn.tag == 501) {
        NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"title_link_value"]];
        int linktype = [[itemsdic objectForKey:@"title_link_type"] intValue];
        NSString *keyword = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"title"]];
        [self gotoGoodsList:linktype linkvale:linkvalue title:keyword];
    }else{
        NSInteger ind = curbtn.tag - 502;
        if (itemarr.count > ind) {
            NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 502];
            NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"link_value"]];
            int linktype = [[itemdic objectForKey:@"link_type"] intValue];
            NSString *keyword = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"title"]];
            [self gotoGoodsList:linktype linkvale:linkvalue title:keyword];
        }
    }
}

- (void)cussixitemButton:(UIButton *)curbtn CurView:(HomeCusViewSix *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    if (curbtn.tag == 607) {
        NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"pic_link_value"]];
        int linktype = [[itemsdic objectForKey:@"pic_link_type"] intValue];
        [self gotoGoodsList:linktype linkvale:linkvalue title:@""];
    }else if (curbtn.tag == 600) {
        NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"title_link_value"]];
        int linktype = [[itemsdic objectForKey:@"title_link_type"] intValue];
        NSString *keyword = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"title"]];
        [self gotoGoodsList:linktype linkvale:linkvalue title:keyword];
    }else{
        NSInteger ind = curbtn.tag - 601;
        if (itemarr.count > ind){
            NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 601];
            NSString *linkvalue = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"link_value"]];
            int linktype = [[itemdic objectForKey:@"link_type"] intValue];
            NSString *keyword = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"title"]];
            [self gotoGoodsList:linktype linkvale:linkvalue title:keyword];
        }
    }
}

- (void)cuselevenitemButton:(UIButton *)curbtn CurView:(HomeCusViewEleven *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemarr = [itemsdic objectForKey:@"content"];
    NSInteger ind = curbtn.tag - 110000;
    if (itemarr.count > ind) {
        NSDictionary *itemdic = [itemarr objectAtIndex:curbtn.tag - 110000];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[itemdic objectForKey:@"link_value"] title:@""];
    }
}

- (void)numberTick:(id)sender {
    
    [_clockTickers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int countdown = [[_countdownRecord objectAtIndex:idx] intValue];
        _currentClock = [self parseCountDown:countdown];
        countdown--;
        if (countdown == 0) {
            NSDictionary *itemtempdic = [NSDictionary dictionaryWithDictionary:[_timersArray objectAtIndex:idx]];
            UILabel *lbl_right_subtitle = (UILabel *)[itemtempdic objectForKey:@"time_rigth_titlelab"];
            lbl_right_subtitle.hidden = NO;
            lbl_right_subtitle.text = @"";
            NSString *newClock = [self parseCountDown:countdown];
            [obj enumerateObjectsUsingBlock:^(id clockobj, NSUInteger cidx, BOOL *stop) {
                [clockobj setFrontView:[SBTickView tickViewWithTitle:[newClock substringWithRange:NSMakeRange(cidx*2, 2)] fontSize:14.]];
            }];
            [_HomeCountDownTimer invalidate];
            _HomeCountDownTimer = nil;
            return;
        }
        NSString *newClock = [self parseCountDown:countdown];
        
        [_countdownRecord replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%d",countdown]];
        [obj enumerateObjectsUsingBlock:^(id clockobj, NSUInteger cidx, BOOL *stop) {
            if (![[_currentClock substringWithRange:NSMakeRange(cidx*2, 2)] isEqualToString:[newClock substringWithRange:NSMakeRange(cidx*2, 2)]]) {
                [clockobj setFrontView:[SBTickView tickViewWithTitle:[newClock substringWithRange:NSMakeRange(cidx*2, 2)] fontSize:14.]];
            }
        }];
    }];
}

- (void)morebtnclick:(UIButton *)btn {
    long curArrTag = (long)btn.tag /20-1;
    NSDictionary *itemsdic = [[NSDictionary alloc] initWithDictionary:[_goodsAllArray objectAtIndex:curArrTag]];
    NSString *right_linktype = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"right_title_link_type"]];
    NSString *right_linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"right_title_link_value"]];
    if (right_linktype.length > 0 && right_linkvalue.length > 0) {
        [self gotoGoodsList:[right_linktype intValue] linkvale:right_linkvalue title:@""];
    }
}

- (NSString *)parseCountDown:(int)countdown {
    if (countdown <= 0) return @"000000";
    
    NSString *hour, *minute, *second;
    int ihour = countdown / 3600;
    int iminute = (countdown /60) % 60;
    int isecond = countdown % 60;
    
    if(ihour > 9){
        hour = [NSString stringWithFormat:@"%d",ihour];
    }else{
        hour = [NSString stringWithFormat:@"0%d",ihour];
    }
    if(iminute > 9){
        minute = [NSString stringWithFormat:@"%d",iminute];
    }else{
        minute = [NSString stringWithFormat:@"0%d",iminute];
    }
    if(isecond > 9){
        second = [NSString stringWithFormat:@"%d",isecond];
    }else{
        second = [NSString stringWithFormat:@"0%d",isecond];
    }
    return [NSString stringWithFormat:@"%@%@%@",hour,minute,second];
}


- (void)shareBtn:(UIButton *)button {
    if (!ISShowShareFunction) {
        return;
    }
    [SVProgressHUD dismiss];
    shareDetailViewBg.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=shareDetailView.frame;
        rect.origin.y-=shareDetailView.frame.size.height;
        shareDetailView.frame=rect;
    }];
    
}
#pragma mark  uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y<=0){
        homeBgImageView.hidden=YES;
    }else {
        homeBgImageView.hidden=YES;
    }
    if (scrollView==_allScrollView) {
        //避免下拉在快速向上的时候的bounds属性导致sideable＝0；
        if (scrollView.contentOffset.y>=_allScrollViewContentOriginH) {
            return;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    isContentAdd=NO;
    if (scrollView==_allScrollView) {
        if (scrollView.contentOffset.y>=_allScrollViewContentOriginH) {
            scrollView.contentSize=CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height+scrollView.frame.size.height);
            isContentAdd=YES;
        }
        scrollView.contentSize=CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView==_allScrollView) {
        int height=_allScrollViewContentOriginH-scrollView.contentOffset.y-scrollView.frame.size.height;
        if (height<0) {
            targetContentOffset->y=scrollView.contentOffset.y;
            isOutContentHeight=YES;
        }else{
            isOutContentHeight=NO;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isOutContentHeight==YES) {
        //向下滚动
        moveHeight=_allScrollViewContentOriginH-scrollView.contentOffset.y;
        if ( (moveHeight>scrollView.frame.size.height-70&&sideAble==1)
            ||(moveHeight>scrollView.frame.size.height-250&&sideAble==0)
            )  {
            [_allScrollView setContentOffset:CGPointMake(0,_allScrollViewContentOriginH-_allScrollView.frame.size.height) animated:YES];
        }else {
            scrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, _allScrollViewContentOriginH+scrollView.frame.size.height);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_allScrollView setContentOffset:CGPointMake(0, _allScrollViewContentOriginH) animated:YES];
            });
        }
    }else {
        _allScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _allScrollViewContentOriginH);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (isContentAdd&&sideAble==0) {
        _allScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _allScrollViewContentOriginH);
    }
}

#pragma mark - CustomTypeImageViewDelegate
- (void)CustomTypeImageViewButton:(int)curbtn CurView:(CustomTypeImageView *)curVi {
    NSInteger curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemArr = [itemsdic objectForKey:@"content"];
    int ind = curbtn - 10;
    if (itemArr.count > ind) {
        NSDictionary *itemdic = [itemArr objectAtIndex:ind];
        NSString *keyword = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"title"]];
        [self gotoGoodsList:[[itemdic objectForKey:@"link_type"] intValue] linkvale:[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"link_value"]] title:keyword];
    }
}

#pragma mark - HomeCusViewBannerDelegate
- (void)clickBannerViewGetUrl:(NSString *)url linkType:(NSString *)type ltitle:(NSString *)linkTitle {
    [self gotoGoodsList:[type intValue] linkvale:url title:linkTitle];
}


#pragma mark -
- (void)gotoGoodsList:(int)type linkvale:(NSString *)lValue title:(NSString *)keyword {
    if (type == 2) {
        OtherShopListController *otherV = [[OtherShopListController alloc]init];
        otherV.isFujing = YES;
        otherV.title = @"附近";
        [self.navigationController pushViewController:otherV animated:YES];
        return;
    }
    if (type == 3) {
        OtherShopListController *otherV = [[OtherShopListController alloc]init];
        otherV.title = @"合作商家";
        [self.navigationController pushViewController:otherV animated:YES];
        return;
    }
    
    if (type == 1) {
        //html网页
        if (lValue.length > 0 && lValue != nil) {
            [self cheackUrl:lValue];
        }
    }else if (type == 3) {
        //商品详情页
        if (lValue.length > 0 && lValue != nil) {
            [self productshopdetailWithAid:[NSString stringWithFormat:@"%@",lValue]];
        }
    }else if (type == 888){
        PointMallViewController *vc = [[PointMallViewController alloc]init];
        vc.p_cid = lValue;
        vc.shouldHideSus = YES;
        vc.hideTab = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else if (type == 4) {
        //分类
        SearchViewController *search = [[SearchViewController alloc]init];
        BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:search];
        navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        search.shouldRequest = YES;
        search.cid = lValue.integerValue;
        [self.navigationController presentViewController:navi animated:YES completion:nil];
    }else if (type == 5) {

    }else if (type == 6) {
        if (lValue.length > 0 && lValue != nil) {
            NSString *tempUrl = [NSString stringWithFormat:@"getapppage.php?pageid=%@",lValue];
            NSString *url = MOBILE_SERVER_URL(tempUrl);
            GeneralPageViewController *vc=[[GeneralPageViewController alloc] init];
            [vc setUrl:url];
            __weak HomeViewController *weakSelf=self;
            vc.successChangeAppPageBlock=^(void){
                [weakSelf requestdata];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (type == 9) {
        //聚合商品
        SearchViewController *search = [[SearchViewController alloc]init];
        BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:search];
        navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //search.shouldRequest = YES;
        [self.navigationController presentViewController:navi animated:YES completion:nil];

    }
}


#pragma mark - 跳到网页
- (void)cheackUrl:(NSString *)url{
    //8.4
    [SVProgressHUD show];
    Reachability* reach = [Reachability reachabilityWithHostName:@"app.lemuji.com"];
    if ([reach currentReachabilityStatus] != NotReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController loadWebView:url];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismissWithError:@"网络错误"];
        });
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag==AletrtViewTypeCaiGou) {
        if (buttonIndex==0) {
            
        }
    }else if (alertView.tag==AletrtViewTypeTaoPay) {
        if (buttonIndex==0) {
            
        }
    }
}

#pragma mark - 详情接口
/*商品详情接口*/
- (void)productshopdetailWithAid:(NSString *)aid {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    NSString *str=MOBILE_SERVER_URL(@"productshopdetail_lemuji.php");
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
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
            [SVProgressHUD dismiss];
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

- (void)dealloc {
    [header free];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadhomecustom" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cityreloadhomecustom" object:nil];
}
@end
