//
//  AppDelegate.m
//  SmallCEO
//
//  Created by huang on 15/8/17.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "HomeViewController.h"
#import "CouponViewController.h"
//微信支付配置文件 包含app_id

#import "ProductDetailsViewController.h"
#import "Reachability.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "SGBaiduLocationService.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "SGPlatformHelper.h"

#import "payRequsestHandler.h"

#import "CommodityDetailViewController.h"

#import "OrderListDetailsViewController.h"

#import "JudgeEdition.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wxf71e9c874c9cde95";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */

NSString * const WXAppKey = @"dr2lSa0GW8Fg3EzevTgmnAkZXAZCeF8fasYPKts5GHxKzmxFdjeSGoWDAFGB18xY5KbOulwmrNpStdOTYvEOJrt07iWBd2IYaRGKTjj9FxxCtTnugbWjlABgMkdWqKtB";

/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"cbc7ac871611243b992c7cfdaf170b40";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @"fe137247c2b193342f0c9b59b787dd7c";
/**
 *  微信公众平台商户模块生成的ID
 */
NSString * const WXPartnerId = @"1219945101";


const NSInteger jPsuhAlertViewTag = 7777;
const NSInteger locationAlertViewTag = 6666;

@interface AppDelegate ()<WXApiDelegate> {
    BOOL _isMustUpdate;
}

@property (nonatomic, strong) UIImageView *placeImageV;
@end

@implementation AppDelegate

-(void)dealloc {
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

- (BOOL)isNetworkReachable{
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
#ifndef __OPTIMIZE__
    switch (netStatus) {
        case NotReachable:
            DLog(@"Network is not reachable");
            break;
        case ReachableViaWiFi:
            DLog(@"Network is WiFi");
            break;
        case ReachableViaWWAN:
            DLog(@"Network is WWAN");
            break;
        default:
            break;
    }
#endif
    if(netStatus == NotReachable) {
        return NO;
    }
    return YES;
}

-(void)showUserPrivacyDelegateInfo:(NSNotification *)sender{
    DLog(@"asdf:%@",[sender object]);
    UITextField *textField=[sender object];
    
    if ([textField isKindOfClass:[UITextField class]]) {
        if([textField.hideStatus isEqualToString:@"1"]){
            return;
        }
        
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        if(textField.inputAccessoryView==nil){
            textField.inputAccessoryView=btnT;
        }
        [btnT addControlblock:^{
            DLog(@"hide;");
            NSArray *selArr=@[@"missKeyBoard",@"missKeyboard",@"hideKeyBoard",@"hideKeyboard"];
            for (int i=0; i<selArr.count; i++) {
                if (self.curViewController!=nil&&[self.curViewController respondsToSelector:NSSelectorFromString([selArr objectAtIndex:i])]) {
                    [self.curViewController performSelector:NSSelectorFromString([selArr objectAtIndex:i])];
                }
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)loadLocations {
    [self loadLocation];
    /**百度地图*/
    [SGPlatformHelper registerAppkeyWithLaunchOptions:nil];
    [[SGBaiduLocationService shareInstance]baiduLoadLocation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    UINavigationController *nav=[[UINavigationController alloc] init];
    nav.navigationBarHidden=YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(loadLocations) name:@"loadLocation" object:nil];
    DLog(@"sandbox:%@",NSHomeDirectory());
    
    _isshowLocation = YES;
    _isFirstLaunch = [[PreferenceManager sharedManager] preferenceForKey:@"isFirst"] ? NO : YES;
    //获取tabbaritem图片
    [self thirdPart:launchOptions];
    [self updateSelectCityName];
    [self getTabbarItemImgRequest];
    
    //微博分享
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:weiboAppKey];

    NSString *type = [[PreferenceManager sharedManager] preferenceForKey:@"type"];
    if ([[[PreferenceManager sharedManager] preferenceForKey:@"AutoKeyWord"] boolValue]){
        [self checkLoad:[type intValue]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUserPrivacyDelegateInfo:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    if (_isFirstLaunch) {
        DLog(@"firstlaunch");
        [self getIntroduceImages];
    }
    
    return YES;
}


-(void)checkLoad:(int) type{
    
    //[SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"login.php");
    
    //第三方登录获取的openId
    NSString *openID = [[PreferenceManager sharedManager]preferenceForKey:@"openid"];
    NSString *name = [[PreferenceManager sharedManager]preferenceForKey:@"username"];
    NSString *key = [[PreferenceManager sharedManager]preferenceForKey:@"keyword"];
    NSString *accesstoken = [[PreferenceManager sharedManager] preferenceForKey:@"access_token"];
    [[PreferenceManager sharedManager] setPreference:name forKey:@"username"];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *body;
    if (0 == type)
    {
        //普通登录的自动登录 type为0
        body = [NSString stringWithFormat:@"username=%@&password=%@&type=%d",name , [NSString md5:key],type];
    }
    else
    {
        //QQ登录、微信登录的自动登录
        body = [NSString stringWithFormat:@"openid=%@&access_token=%@&type=%d",openID,accesstoken,type];
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
        DLog(@"error:%@",error);
        [self loginFailed:@"自动登录失败，请稍后再试"];
    }];
    [op start];
}

- (void)loginFailed:(NSString *)info
{
    [SVProgressHUD dismissWithError:info];
}


- (void)didLogin:(id)response
{
    [SVProgressHUD dismiss];
    
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"avatar"] forKey:@"avatar"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"alias"] forKey:@"alias"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"token"] forKey:@"token"];
    [[PreferenceManager sharedManager] setPreference:[response objectForKey:@"username"] forKey:@"pushId"];
    [[PreferenceManager sharedManager] setPreference:@(YES) forKey:@"didLogin"];
    
}

-(void)updateSelectCityName{
    
    //NSString *url = MOBILE_SERVER_URL(@"getcitylist_08.php");
    NSString *url = MOBILE_SERVER_URL(@"getCityApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *body = [NSString stringWithFormat:@"act=1"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString * path = [paths objectAtIndex:0];
        NSString *filename=[path stringByAppendingPathComponent:@"SelectCityName.plist"];
        [responseObject writeToFile:filename  atomically:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"gengxinshibai");
    }];
    [op start];
}

-(void)getTabbarItemImgRequest {
    //tabbar图片请求
    NSString *str=MOBILE_SERVER_URL(@"app_footicon.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    //DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 1) {
            NSArray *tabbarTempArr = [[responseObject objectForKey:@"content"] objectForKey:@"content"];
            NSArray *userArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar_ItemImgs"];
            NSString *isChange = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"content"] objectForKey:@"change"]];
            DLog(@"tabbarTempArr %@",tabbarTempArr);
            DLog(@"%@",responseObject);
            if ([isChange isEqualToString:@"1"] || userArr.count <= 0) {
                [[PreferenceManager sharedManager] setPreference:@(-1) forKey:@"tabbarType"];
                [[PreferenceManager sharedManager] setPreference:@(-1) forKey:@"shopcarType"];
                [self setTabbarItemImgsToDocument:tabbarTempArr];
            }else {
                if (!_isFirstLaunch) {
                    //不需要缓存,加载tabbar
                    [self getAddImages];
                }
            }
        }else {
            if (!_isFirstLaunch) {

                [self getAddImages];
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (!_isFirstLaunch) {
                [self getAddImages];
        }
    }];
    [op start];
}
// 删除沙盒里的文件
-(void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"pin.png"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
    }
}
-(void)setTabbarItemImgsToDocument:(NSArray *)imgArr
{
    NSArray *tempArr = [[NSArray alloc] initWithArray:imgArr];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:imgArr forKey:@"tabbar_ItemImgs"];
    [userDefault synchronize];
    NSMutableArray *tabbarNormalUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *tabbarSelectedUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
 
    for (int i = 0; i < tempArr.count; i ++) {
        NSDictionary *dic  = tempArr[i];
        [tabbarNormalUrlArr addObject:[dic objectForKey:@"before_des_picurl"]];
        [tabbarSelectedUrlArr addObject:[dic objectForKey:@"after_des_picurl"]];
        
         NSNumber *type = [NSNumber numberWithInt:i];
        if ([dic[@"type"] intValue] == 6) {
            [[PreferenceManager sharedManager] setPreference:type forKey:@"tabbarType"];
        }
        if ([dic[@"type"] intValue] == 4) {
            [[PreferenceManager sharedManager] setPreference:type forKey:@"shopcarType"];
        }
    }
    
    
    //创建一个图片管理类，提前下载图片，这样后面加载的时候，速度会快一些
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    for (int i = 0; i < tabbarNormalUrlArr.count; i++) {
        NSURL *norurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[tabbarNormalUrlArr objectAtIndex:i] ]];
        UIImage *norcachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[manager cacheKeyForURL:norurl]];
        if (norcachedImage)
        {
            //如果缓存有，就可以直接来处理图片了，设置imageView...
            DLog(@"已经存在该普通图片");
        }
        
        else
        { //否则就下载
            [manager downloadImageWithURL:norurl options:SDWebImageRetryFailed|SDWebImageHighPriority progress:^(NSInteger receivedSize , NSInteger expectedSize){
                
            } completed:^(UIImage *image,NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
                DLog(@"普通图片缓存完成");
            }];
        }
        
        NSURL *selurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[tabbarSelectedUrlArr objectAtIndex:i] ]];
        UIImage *selcachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[manager cacheKeyForURL:selurl]];
        if (selcachedImage)
        {
            //如果缓存有，就可以直接来处理图片了，设置imageView...
            DLog(@"已经存在该高亮图片");
            
        }
        else
        { //否则就下载
            [manager downloadImageWithURL:selurl options:SDWebImageRetryFailed|SDWebImageHighPriority progress:^(NSInteger receivedSize , NSInteger expectedSize){
                
            } completed:^(UIImage *image,NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
                DLog(@"高亮图片缓存完成");
            }];
        }
    }
    
    if (!_isFirstLaunch) {
        //缓存完成,加载tabbar
        [self removeLauchImageScrollView];
        [self inittabBarController];
    }
}
#pragma mark - 广告
-(void)getAddImages
{
    NSString*body=[NSString stringWithFormat:@""];
    NSString *str=MOBILE_SERVER_URL(@"mallstartad_lemuji.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            
            NSMutableArray *temp=[responseObject valueForKey:@"cont"];
            if ([temp isKindOfClass:[NSArray class]]) {
                
                addImageArr = temp;
                [self loadAddImages];
            }else {
                [self removeLauchIamge];
            }
            
        }else{
             [self removeLauchIamge];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
         [self removeLauchIamge];
    }];
    [op start];
}
-(void)loadAddImages{
    if(addImageArr.count<1){
        [self removeLauchIamge];
        return;
    }
  
    adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
    adScrollView.contentSize = CGSizeMake(self.window.frame.size.width * addImageArr.count, self.window.frame.size.height);
    adScrollView.scrollEnabled = YES;
    adScrollView.pagingEnabled = YES;
    adScrollView.tag = 12345;
    adScrollView.delegate=self;
    adScrollView.showsHorizontalScrollIndicator=YES;
    adScrollView.backgroundColor = [UIColor whiteColor];
    
    
    for (int i = 0; i < addImageArr.count; i++) {
        UIImageView *contentimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.window.frame.size.width*i, 0, self.window.frame.size.width, self.window.frame.size.height)];
        NSString *imgstr = [NSString stringWithFormat:@"%@",[[addImageArr objectAtIndex:i] objectForKey:@"picurl"]];
        [contentimg c_setImageWithUrl:imgstr];
        contentimg.clipsToBounds = YES;
        contentimg.contentMode = UIViewContentModeScaleAspectFill;
        [adScrollView addSubview:contentimg];
        

        UIButton *adbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        adbtn.frame = CGRectMake(self.window.frame.size.width*addImageArr.count-50.0-50.0, self.window.frame.size.height-30-30.0, 70.0, 30.0);
        adbtn.backgroundColor =App_Main_Color;
        adbtn.layer.borderColor = [UIColor whiteColor].CGColor;
        adbtn.layer.borderWidth = 0.5;
        adbtn.layer.cornerRadius = 5.0;
        [adbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [adbtn addTarget:self action:@selector(removeAdScrollView) forControlEvents:UIControlEventTouchUpInside];
        [adbtn setTitle:@"进入>>" forState:UIControlStateNormal];
        [adScrollView addSubview:adbtn];
        
    }
    
    [self.window addSubview:adScrollView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(onTimer) userInfo:nil repeats:YES]; 
}
- (void)onTimer {
    int index=(adScrollView.contentOffset.x+10)/adScrollView.frame.size.width+1;
    if (index==addImageArr.count) {
        [timer invalidate];
        timer = nil;
        
        [self removeAdScrollView];
    }
    else{
        [UIView animateWithDuration:0.35 animations:^{
            [adScrollView setContentOffset:CGPointMake(index*adScrollView.frame.size.width, 0)];
        }];
    }
}
- (void)removeLauchIamge {
    if (lauchImageView!=nil) {
        [lauchImageView removeFromSuperview];
    }
    [self inittabBarController];
}

- (void)removeAdScrollView {
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
    if (lauchImageView!=nil) {
        [lauchImageView removeFromSuperview];
    }
    [UIView animateWithDuration:0.38 animations:^{
        adScrollView.alpha=0.0;
    } completion:^(BOOL finished) {
        [adScrollView removeFromSuperview];
    }];

    [self inittabBarController];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //应到页  最后一页不显示pagec
    if (scrollView.tag!=12345) {
        if (scrollView.contentOffset.x>scrollView.contentSize.width-scrollView.frame.size.width*2) {
            self.pageControl.hidden=NO;
        }else{
            self.pageControl.hidden=NO;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag==12345) {
        [timer invalidate];
        timer=nil;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag==12345) {
        timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    }
}
-(void)getIntroduceImages {
    _placeImageV = [[UIImageView alloc]initWithFrame:self.window.bounds];
    if (IS_IPHONE4) {
        _placeImageV.image = [UIImage imageNamed:@"pho-640x960@2x"];
    }else if (IS_IPHONE5){
        _placeImageV.image = [UIImage imageNamed:@"pho-640x1136@2x"];
    }else if (IS_IPHONE6){
        _placeImageV.image = [UIImage imageNamed:@"pho-750x1334@2x"];
    }else{
        _placeImageV.image = [UIImage imageNamed:@"pho-1242x2208@3x"];
    }
    [self.window addSubview:_placeImageV];
    
    NSArray *imageArray = @[@"first", @"second", @"third", @"fourth"];
    adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
    adScrollView.contentSize = CGSizeMake(self.window.frame.size.width * imageArray.count, self.window.frame.size.height);
    adScrollView.scrollEnabled = YES;
    adScrollView.delegate = self;
    adScrollView.pagingEnabled = YES;
    adScrollView.tag = 800000;
    adScrollView.showsHorizontalScrollIndicator=NO;
    adScrollView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *contentimg = [[UIImageView alloc] initWithFrame:CGRectMake(i * UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        contentimg.backgroundColor = [UIColor whiteColor];

        contentimg.image = [UIImage imageNamed:imageArray[i]];
        [adScrollView addSubview:contentimg];
        
        if (i == imageArray.count -1 ) {
            UIButton *adbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            adbtn.frame = CGRectMake(self.window.frame.size.width*(imageArray.count-1)+UI_SCREEN_WIDTH/6,UI_SCREEN_HEIGHT*0.8, UI_SCREEN_WIDTH*2/3, 50);
            [adbtn setTitle:@"开启我的新消费时代" forState:UIControlStateNormal];
            [adbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            adbtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
            adbtn.layer.cornerRadius = 20;
            adbtn.layer.masksToBounds = YES;
            [adbtn addTarget:self action:@selector(removeLauchImageScrollView) forControlEvents:UIControlEventTouchUpInside];
            [adScrollView addSubview:adbtn];
        }
    }
    [self.window addSubview:adScrollView];
    
}

- (void)downLoadIntroduceImages:(NSArray *)introduceImages index:(NSInteger)index {

    if (index>introduceImages.count) {
        [self removeLauchImageScrollView];
        return;
    }
    //图片全部加载完后到首页  并显示引导页
    if (index==(introduceImages.count)) {
        [self loadIntroduceImages:[NSArray arrayWithArray:introduceImages]];
        return;
    }

    NSString *urlString=[[introduceImages objectAtIndex:index] valueForKey:@"picurl"];
    DLog(@"PIC %@",urlString);
    [[CImageCache sharedInstance ] cacheNetImageWithUrl:urlString success:^(UIImage *image) {
        [self downLoadIntroduceImages:[NSArray arrayWithArray:introduceImages] index:index+1];
    } fail:^{
    }];
}


- (void)loadIntroduceImages:(NSArray *)introduceImages {
    if (introduceImages.count==0) {
        [self removeLauchImageScrollView];
        return;
    }
    //下载好了图片后移除占位图
    if (_placeImageV!=nil) {
        [_placeImageV removeFromSuperview];
    }
    
    adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
    adScrollView.contentSize = CGSizeMake(self.window.frame.size.width * introduceImages.count, self.window.frame.size.height);
    adScrollView.scrollEnabled = YES;
    adScrollView.delegate = self;
    adScrollView.pagingEnabled = YES;
    adScrollView.tag = 800000;
    adScrollView.showsHorizontalScrollIndicator=NO;
    adScrollView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < introduceImages.count; i++) {
        
        float height=0;
        float yOffset=0;
        if (UI_SCREEN_HEIGHT==480) {
            height=44;
            yOffset=22;
            if (i==introduceImages.count-1) {
                yOffset=44;
            }
        }
        
        UIImageView *contentimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.window.frame.size.width*i, 0-yOffset, self.window.frame.size.width, self.window.frame.size.height+2*height)];
        contentimg.backgroundColor = [UIColor whiteColor];
        [contentimg sd_setImageWithURL:[NSURL URLWithString:[[introduceImages objectAtIndex:i] valueForKey:@"picurl"]] placeholderImage:nil];
  
        [adScrollView addSubview:contentimg];

        if (i == introduceImages.count -1 ) {
            UIButton *adbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            adbtn.frame = CGRectMake(self.window.frame.size.width*(introduceImages.count-1)+UI_SCREEN_WIDTH/6,UI_SCREEN_HEIGHT*0.8, UI_SCREEN_WIDTH*2/3, 50);
            [adbtn setTitle:@"开启我的新消费时代" forState:UIControlStateNormal];
            [adbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            adbtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
            adbtn.layer.cornerRadius = 20;
            adbtn.layer.masksToBounds = YES;
            [adbtn addTarget:self action:@selector(removeLauchImageScrollView) forControlEvents:UIControlEventTouchUpInside];
            [adScrollView addSubview:adbtn];
        }
    }
    
    [self.window addSubview:adScrollView];
}

- (void)removeLauchImageScrollView{
    if (lauchImageView!=nil) {
        [lauchImageView removeFromSuperview];
    }
    [UIView animateWithDuration:0.38 animations:^{
        adScrollView.alpha=0.0;
        self.pageControl.alpha=0.0;
    } completion:^(BOOL finished) {
        [adScrollView removeFromSuperview];
        [self inittabBarController];
    }];
    
}

- (void)inittabBarController{
    
    NSArray *tabbarArr =[[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar_ItemImgs"];
    NSMutableArray *viewControllerClass = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i < tabbarArr.count; i ++) {
        NSDictionary *dic  = tabbarArr[i];
        NSInteger type = [[dic objectForKey:@"type"] integerValue];
        switch (type) {
            case 1:
                [viewControllerClass addObject:@"HomeViewController"];
                break;
            case 2:
                [viewControllerClass addObject:@"ClassifyViewController"];
                break;
            case 3:
                [viewControllerClass addObject:@"OrderViewController"];
                break;
            case 4:
                [viewControllerClass addObject:@"ShopCartViewController"];
                break;
            case 5:
                [viewControllerClass addObject:@"MyInfoViewController"];
                break;
            case 6:
                [viewControllerClass addObject:@"IntroduceHomeViewController"];
                break;
                
            default:
                break;
        }
    }
    if (!viewControllerClass.count) {
        [viewControllerClass addObject:@"HomeViewController"];
         [viewControllerClass addObject:@"ClassifyViewController"];
         [viewControllerClass addObject:@"OrderViewController"];
        [viewControllerClass addObject:@"ShopCartViewController"];
        [viewControllerClass addObject:@"MyInfoViewController"];
    }
    NSMutableArray *navigationControllers = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *className in viewControllerClass) {
        UIViewController *viewController = [[NSClassFromString(className) alloc] init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        [navigationControllers addObject:nav];
        nav.navigationBar.translucent = NO;//使用属性是的ios7和ios6所有尺寸相同
        nav.name = className;
    }
    
    if (_placeImageV != nil) {
        [_placeImageV removeFromSuperview];
    }
    
    _tabBarController = [[CustomTabBarController alloc] init];
    _tabBarController.viewControllers = navigationControllers;
    
    
    [[PreferenceManager sharedManager] setPreference:@"1" forKey:@"isFirst"];
    _isFirstLaunch = NO;
    
    self.window.rootViewController = _tabBarController;
    [navigationControllers removeAllObjects];
    
    [JudgeEdition JudgeEditionWithSuccess:^{
        _isMustUpdate = YES;
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == jPsuhAlertViewTag && buttonIndex == 1) {
        if ([contentDic isKindOfClass:[NSDictionary class]]) {
            NSString *type=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"type"]];
            NSString *info=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"info"]];
            
            NSInteger typeIndex=[type integerValue];
            
            //1001 首页
            if (typeIndex==1001) {
                [self gotoHomeViewCoontroller];
            }
            //1002 网页
            if (typeIndex==1002) {
                [self goWebWithUrl:info];
            }
            //3001 商品详情
            if (typeIndex==3001) {
                [self productshopdetailWithAid:info];
            }
            //3002 订单列表
            if (typeIndex == 3002) {
                [self orderList];
            }
            //3003 优惠券
            if (typeIndex == 3003) {
                [self gotoCoupViewCoontroller];
            }
            //3004 订单详情
            if (typeIndex == 3004) {
                [self orderdetailWithAid:info];
            }
            //3003 跳转到个人中心
            if (typeIndex == 3101) {
                [self gotoPersonViewCoontroller];
            }
        }
        
    }else if (alertView.tag == locationAlertViewTag && buttonIndex == 1) {
        [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",_cityLocationStr] forKey:@"cityname"];
        [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",_proviceLocationStr] forKey:@"cityid"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cityreloadhomecustom" object:nil];
    }
}

#pragma mark - 第三方API接入
- (void)thirdPart:(NSDictionary *)launchOptions {
    [self umAnalysis];
    [self jpush:[NSDictionary dictionaryWithDictionary:launchOptions]];
    [WXApi registerApp:APP_ID withDescription:@"WanHao"];

}

#pragma mark - 定位
-(void)loadLocation {
    if ([CLLocationManager locationServicesEnabled] &&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        if ( self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 1000.0f;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= C_IOS8_VALUE
            
            [self.locationManager requestWhenInUseAuthorization];
#else
            
#endif
  
        }
        
        [self.locationManager startUpdatingLocation];
    }else{
        DLog(@"开启定位功能");
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations firstObject];
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f",location.coordinate.longitude,location.coordinate.latitude];
    NSLog(@"当前的经纬度是%@",locationStr);
    [[PreferenceManager sharedManager] setPreference:locationStr forKey:@"gps"];
    [self.locationManager stopUpdatingLocation];
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; //指定需要的精度级别
    _locationManager.distanceFilter = kCLDistanceFilterNone; //设置距离筛选器 ，动1000米才有反应

    CLLocationDegrees latitude = _locationManager.location.coordinate.latitude; //float也行，获得当前位置的纬度.location属性获
    
    CLLocationDegrees longitude = _locationManager.location.coordinate.longitude;
    
    CLLocationCoordinate2D mylocation;
    mylocation.latitude=latitude;
    
    mylocation.longitude=longitude;
    [self showWithlocation:mylocation];
}

- (void)showWithlocation:(CLLocationCoordinate2D)location {
    
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        for (CLPlacemark *placemark in place) {
            DLog(@"placemark.addressDictionary --%@",placemark.addressDictionary );
            DLog(@"name,%@",placemark.addressDictionary[@"Name"]);   // 位置名
            DLog(@"State,%@",placemark.addressDictionary[@"State"]); // 省
            DLog(@"City,%@",placemark.addressDictionary[@"City"]); // 市
            DLog(@"subLocality,%@",placemark.addressDictionary[@"SubLocality"]);// 区
            DLog(@"thoroughfare,%@",placemark.addressDictionary[@"Thoroughfare"]); // 街道
            DLog(@"subThoroughfare,%@",placemark.addressDictionary[@"Street"]); // 子街道
            DLog(@"FormattedAddressLines,%@",placemark.addressDictionary[@"FormattedAddressLines"][0]); // 详细
            DLog(@"%@",[[PreferenceManager sharedManager]allData]);
            
            NSString *cityStr=[placemark.addressDictionary objectForKey:@"City"];
            NSString *provicestr = [placemark.addressDictionary objectForKey:@"State"];
            NSString *zoneStr= [placemark.addressDictionary objectForKey:@"SubLocality"];
            //区
            if(cityStr==nil||provicestr==nil){
                return ;
            }
            _cityLocationStr      = cityStr;
            _proviceLocationStr   = provicestr;
            _areaLoactionStr      = zoneStr;
            
            [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",_cityLocationStr] forKey:@"currentcity"];
            [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",_proviceLocationStr] forKey:@"currentProvice"];
            [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",_areaLoactionStr] forKey:@"currentArea"];
            
            if ([[PreferenceManager sharedManager] preferenceForKey:@"cityname"] && ![[[PreferenceManager sharedManager] preferenceForKey:@"cityname"] isEqualToString:@""]) {
                if (![[[PreferenceManager sharedManager] preferenceForKey:@"cityname"] isEqualToString:cityStr]&&![[[PreferenceManager sharedManager] preferenceForKey:@"cityid"] isEqualToString:provicestr]) {
                    if (_isshowLocation) {
                        [self loadRemindLocation];
                    }
                }
            }else{
                [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",cityStr] forKey:@"cityname"];
                [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",provicestr] forKey:@"cityid"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cityreloadhomecustom" object:nil];
            }
            break;
        }
    };
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    DLog(@"定位失败的原因是%@",[error localizedDescription]);
    
    switch ([error code]) {
        case kCLErrorDenied:
            DLog(@"重新开启定位功能");
            break;
        case kCLErrorLocationUnknown:
            DLog(@"定位功能不能使用");
            break;
            
        default:
            DLog(@"定位失败");
            break;
    }
}

- (void)loadRemindLocation {
    _isshowLocation = NO;
    [SVProgressHUD dismiss];
    UIAlertView *vi = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:[NSString stringWithFormat:@"定位到您当前在%@，需要切换城市吗？",_cityLocationStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即切换", nil];
    vi.tag = locationAlertViewTag;
    [vi show];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //程序进入后台
    flag = NO;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_isMustUpdate) {
        [JudgeEdition JudgeEditionWithSuccess:^{
        }];
    }
    
    NSUserDefaults *user1 =[NSUserDefaults standardUserDefaults];
    [user1 removeObjectForKey:@"is404"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        flag = YES;
    });
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma mark - JPush 推送
- (void)jpush:(NSDictionary *)dic {
    NSDictionary *launchOptions=[NSDictionary dictionaryWithDictionary:dic];
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
    [self loadAPService];
}

- (void)loadAPService {
    NSString *temp = [[PreferenceManager sharedManager] preferenceForKey:@"pushId"];
    if (temp != nil && temp.length > 0) {
        [APService setAlias:temp callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    DLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
//后台或者关闭接收到消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSInteger badgeNum=[[UIApplication sharedApplication] applicationIconBadgeNumber];
    if (badgeNum>0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    alertStr = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    contentDic = [userInfo objectForKey:@"content"];
    if ([contentDic isKindOfClass:[NSDictionary class]]) {
        NSString *type=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"type"]];
        NSString *info=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"info"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goPushWithType:type info:info];
        });
    }

    // Required
    [APService handleRemoteNotification:userInfo];
}
//前台接受到消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    
    NSInteger badgeNum=[[UIApplication sharedApplication] applicationIconBadgeNumber];
    
    if (badgeNum>0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    alertStr = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    contentDic = [userInfo objectForKey:@"content"];
    
    if ([contentDic isKindOfClass:[NSDictionary class]]) {
        NSString *type=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"type"]];
        NSString *info=[NSString stringWithFormat:@"%@",[contentDic valueForKey:@"info"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goPushWithType:type info:info];
        });
    }

    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark - 推送跳转

- (void)goPushWithType:(NSString *)type info:(NSString *)info{
    
    if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        return;
    }
    if (flag == YES && [alertStr isValid]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:alertStr delegate:self cancelButtonTitle:@"等会再说" otherButtonTitles:@"去看看", nil];
        alert.tag = jPsuhAlertViewTag;
        [alert show];
        return;
    }
    
    
    NSInteger typeIndex=[type integerValue];
    
    //1001 首页
    if (typeIndex==1001) {
        [self gotoHomeViewCoontroller];
    }
    //1002 网页
    if (typeIndex==1002) {
        [self goWebWithUrl:info];
    }
    //3001 商品详情
    if (typeIndex==3001) {
        [self productshopdetailWithAid:info];
    }
    //3002 订单列表
    if (typeIndex == 3002) {
        [self orderList];
    }
    //3003 优惠券
    if (typeIndex == 3003) {
        [self gotoCoupViewCoontroller];
    }
    //3004 订单详情
    if (typeIndex == 3004) {
        [self orderdetailWithAid:info];
    }
    //3003 跳转到个人中心
    if (typeIndex == 3101) {
        [self gotoPersonViewCoontroller];
    }
    
}

- (void)gotoHomeViewCoontroller{
    AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (del.tabBarController.viewControllers.count>=1) {
        del.tabBarController.selectedIndex = 0;
    }
}

- (void)gotoPersonViewCoontroller{
    AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (del.tabBarController.viewControllers.count>=5) {
        del.tabBarController.selectedIndex = 4;
    }
}

- (void)gotoCoupViewCoontroller{
    AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    CouponViewController *viewController = [[CouponViewController alloc] init];
    [[del.tabBarController.viewControllers objectAtIndex:del.tabBarController.selectedIndex] pushViewController:viewController animated:YES];
}

-(void)goWebWithUrl:(NSString *)urlString {
    AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
    [[del.tabBarController.viewControllers objectAtIndex:del.tabBarController.selectedIndex] pushViewController:viewController animated:YES];
    [viewController loadWebView:urlString];
}
/*商品详情接口*/
- (void)productshopdetailWithAid:(NSString *)aid {
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    [RCLAFNetworking postWithUrl:@"getSupplierProductNew2.php" BodyString:body isPOST:YES success:^(id responseObject) {
        NSDictionary *contDic=[responseObject valueForKey:@"cont"];
        if ([contDic isKindOfClass:[NSDictionary class]]) {
            CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
            vc.comDetailDic=contDic;
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[del.tabBarController.viewControllers objectAtIndex:del.tabBarController.selectedIndex] pushViewController:vc animated:YES];
            });
        }
    } fail:nil];
}

//订单列表
- (void)orderList {
    AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (del.tabBarController.viewControllers.count>=3) {
        del.tabBarController.selectedIndex = 2;
    }
}

//订单详情
- (void)orderdetailWithAid:(NSString *)order_id {
    NSString *body=[NSString stringWithFormat:@"act=4&order_id=%@", order_id];
    [RCLAFNetworking postWithUrl:@"orderForUserNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
        OrderListDetailsViewController *vc = [[OrderListDetailsViewController alloc] init];
        vc.dataDic = responseObject[@"order"];
        AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[del.tabBarController.viewControllers objectAtIndex:del.tabBarController.selectedIndex] pushViewController:vc animated:YES];
        });
    } fail:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.absoluteString rangeOfString:@"wx"].length > 0) {
        //微信
        NSRange range = [url.absoluteString rangeOfString:@"code"];
        if (range.location > 0) {
            //微信登录
            NSArray *array1 = [url.absoluteString componentsSeparatedByString:@"&"];
            NSArray *array2 = [[array1 objectAtIndex:0] componentsSeparatedByString:@"="];
            NSLog(@"CODE:%@",[array2 objectAtIndex:1]);
            [[PreferenceManager sharedManager] setPreference:[array2 objectAtIndex:1] forKey:@"code"];
            NSLog(@"微信登录");
        }
        [WXApi handleOpenURL:url delegate:self];
    }else if([url.absoluteString rangeOfString:@"tencent"].length > 0){
        return [TencentOAuth HandleOpenURL:url];
    }else if([url.absoluteString rangeOfString:@"wb"].length > 0){
        return [WeiboSDK handleOpenURL:url delegate:self];
    }

    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             DLog(@"result = %@", resultDic);
             NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
             NSString *str = @"";
             if (resultDic) {
                 if ([statusStr isEqualToString:@"9000"]) {
                     NSLog(@"success!");
                     str = @"交易成功";
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccessNotification" object:resultDic];
                     return ;
                 }else if([statusStr isEqualToString:@"6001"]) {
                     str = @"交易取消";
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"payCancelNotification" object:resultDic];
                     return ;
                 }else {
                     str = @"交易失败";
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"payFailNotification" object:resultDic];
                     DLog(@"AlixPayResult_error0!");
                     return ;
                 }
             }else {
                 str = @"支付宝连接失败";
                 NSLog(@"AlixPayResult_error1!");
                 //失败
             }
             UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
             [alerTivew show];
         }];
    }
    
    return YES;
}

#pragma mark - 微信代理
- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]){//微信分享
        if (resp.errCode == 0) {
            NSString *orderTitle = [NSString stringWithFormat:@"%@", [[PreferenceManager sharedManager] preferenceForKey:@"orderTitle"]];
            if (![orderTitle isEqualToString:@""]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccessAfterPay" object:nil];
            }else {
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }else if (resp.errCode == -2) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"分享取消" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertView show];
        }else{
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"分享失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        [[PreferenceManager sharedManager] setPreference:@"" forKey:@"orderTitle"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {//微信支付
        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccessNotification" object:nil];
        }else if (resp.errCode == -2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"payCancelNotification" object:nil];
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"payFailNotification" object:nil];
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){//微信登录
        NSString *strTitle = [NSString stringWithFormat:@"温馨提示"];
        if (resp.errCode == 0) {
            //发通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weixin" object:nil ];
        }else if (resp.errCode == -2) {
            [self ShowAlertViewWithTitle:strTitle message:@"登录取消" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }else{
            [self ShowAlertViewWithTitle:strTitle message:@"微信登录失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SVDismissNotification" object:nil userInfo:nil];
    }

}
#pragma -mark 微博WeiboSDKDelegate代理方法
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {

    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        if (0 == response.statusCode) {
            [self ShowAlertViewWithTitle:@"分享结果" message:@"微博分享成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }else if (-1 == response.statusCode)
            [self ShowAlertViewWithTitle:@"分享结果" message:@"分享取消" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        else if (1 == response.statusCode) {
            [self ShowAlertViewWithTitle:@"分享结果" message:@"微博分享失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        if (0 == response.statusCode){
            [[PreferenceManager sharedManager] setPreference:[(WBAuthorizeResponse *)response accessToken] forKey:@"access_token"];
            [[PreferenceManager sharedManager] setPreference:[(WBAuthorizeResponse *)response userID] forKey:@"openid"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weibo" object:nil];
            
        }else if (-1 == response.statusCode)
            [self ShowAlertViewWithTitle:@"温馨提示" message:@"登录取消" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        else if (1 == response.statusCode) {
            [self ShowAlertViewWithTitle:@"温馨提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
    }
}

- (void)ShowAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles {
    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}
#pragma mark - application
//竖屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)umAnalysis{
    NSString *version = [[[NSBundle mainBundle]
                          infoDictionary]
                         objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:NO];
    UMConfigInstance.appKey = @"595e16717f2c7405e9001511";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];
}

#pragma mark - scrollview delegate
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPageNum = scrollView.contentOffset.x / self.window.frame.size.width;
    self.pageControl.currentPage = currentPageNum;
}

@end
