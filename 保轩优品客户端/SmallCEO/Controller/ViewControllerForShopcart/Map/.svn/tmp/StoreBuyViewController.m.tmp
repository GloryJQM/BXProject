//
//  StoreBuyViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "StoreBuyViewController.h"

//#import <CoreLocation/CoreLocation.h>
//#import <MapKit/MapKit.h>

//#import "DiTuVCViewController.h"
//#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"

#import "CloudStoreCalloutView.h"
#import "CloudStoreAnnotationView.h"
#import "CloudStoreSearchBar.h"
#import "SearchCloudStoreViewController.h"
#import "CityListViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

@interface StoreBuyViewController () <UIActionSheetDelegate,CloudStoreCalloutViewDelegate, UISearchBarDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
//{
//    CLLocationManager *_locationManager;
//    
//    MKMapView *_mapView;
//}

@property (nonatomic,strong)UITableView* tab;
@property (nonatomic,strong) NSMutableArray* storeArray;
@property (nonatomic,strong) NSMutableArray* totalStoreArray;

@property(nonatomic,assign) CLLocationCoordinate2D startCoor ;
@property(nonatomic,assign)  CLLocationCoordinate2D endCoor;

@property (nonatomic,strong)NSDictionary *cityList;
@property (nonatomic,strong)NSArray *coverCityList;
@property (nonatomic,strong)NSArray *firstCharacterList;
@property (nonatomic, copy) NSString *locatedAddress;

@property (nonatomic, strong)UIButton * barBtn;
@property (nonatomic, strong)NSString * tempStr;

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UILabel * tiLabel;
@property (nonatomic, strong)NSMutableArray *annotationsArray;
@property (nonatomic, strong)NSMutableArray *allAnnotations;
@property (nonatomic, assign)NSInteger mapType;

@property (nonatomic, strong) CustomAnnotation *searchedAnnotation;

@property (nonatomic, strong) CloudStoreSearchBar *searchBar;

//地图加载完成后
@property (nonatomic, assign) BOOL isLoadView;
//是否正在做请求
@property (nonatomic, assign) BOOL isRequesting;
//记录地图标注数组经纬度
@property (nonatomic, strong) NSString *preItemString;

@property (nonatomic,strong) BMKMapView *mapView;//地图视图

@property (nonatomic,strong) BMKLocationService *service;//定位服务

@property (nonatomic,assign) BOOL isFirst;//第一次进入mapview

@property (nonatomic, strong) BMKPoiSearch *poiSearch;

@property (nonatomic, strong) BMKCitySearchOption *option;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation StoreBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storeArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.totalStoreArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.mapType = 0;
    self.isFirst = YES;
    

    
    self.view.backgroundColor = NAVI_COLOR;
    self.title = [self.linkValue isValid] ? @"周边店铺" : @"店铺地址";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
 
    
    
    
    //初始化地图
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate =self;
    //设置地图的显示样式
    self.mapView.mapType = BMKMapTypeStandard;//卫星地图
    
    //设定地图是否打开路况图层
    self.mapView.trafficEnabled = YES;
    //底图poi标注
    //self.mapView.showMapPoi = yes;
    //在手机上当前可使用的级别为3-21级
    self.mapView.zoomLevel = 21;
    //设定地图View能否支持旋转
    self.mapView.rotateEnabled = NO;
    //设定地图View能否支持用户移动地图
    self.mapView.scrollEnabled = YES;
    //添加到view上
    [self.view addSubview:self.mapView];
    
    
    //初始化定位
    self.service = [[BMKLocationService alloc] init];
    //设置代理
    self.service.delegate = self;
    //开启定位
    [self.service startUserLocationService];
    
    
    
    NSString *citystring = [[PreferenceManager sharedManager] preferenceForKey:@"cityname"];
    if ([citystring isValid]) {
        self.poiSearch = [[BMKPoiSearch alloc] init];
        self.poiSearch.delegate = self;
        self.option = [[BMKCitySearchOption alloc]init];
        self.option.pageIndex = 0;
        self.option.pageCapacity = 5;
        self.option.city = citystring;
        self.option.keyword = citystring;
        [self.poiSearch poiSearchInCity:self.option];
        [SVProgressHUD show];
    }
    
    //作为底层使用
    UIView * label = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 93, 25)];
    label.userInteractionEnabled = YES;
    //右边城市label
    self.tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    _tiLabel.userInteractionEnabled = YES;
    [_tiLabel addTarget:self action:@selector(getCityList) forControlEvents:UIControlEventTouchUpInside];
    _tiLabel.font = [UIFont systemFontOfSize:15];
    
    if ([citystring isValid]) {
        _tiLabel.text = citystring;
    }else {
        _tiLabel.text = @"未定位";
    }
    _tiLabel.textAlignment = NSTextAlignmentRight;
    [label addSubview:_tiLabel];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 8, 13, 8)];
    rightImageView.userInteractionEnabled = YES;
    [rightImageView addTarget:self action:@selector(getCityList) forControlEvents:UIControlEventTouchUpInside];
    rightImageView.image = [UIImage imageNamed:@"down.png"];
    [label addSubview:rightImageView];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.rightBarButtonItem = rightItem;


    self.annotationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.allAnnotations = [[NSMutableArray alloc] initWithCapacity:0];
    //[self postStore:temp];
    
    _timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(judgeTheMap) userInfo:nil repeats:YES];
    [_timer fire];
    //[self getAllStoreData];
    
    
//    //没有数据的默认页面
//    _noDataImageV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
//    _noDataImageV.backgroundColor=[UIColor whiteColor];
//    _noDataImageV.layer.cornerRadius=0;
//    _noDataImageV.hidden=YES;
//    _noDataImageV.contentMode=UIViewContentModeCenter;
//    _noDataImageV.image=[UIImage imageNamed:@"NoServicePoint.png"];
//    [self.view addSubview:_noDataImageV];
    
    //搜索店铺
    CloudStoreSearchBar *searchBar = [[CloudStoreSearchBar alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    searchBar.delegate = self;
    searchBar.userInteractionEnabled = NO;
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}
- (void)addAnnotationWithShopInfo:(NSArray *)shopArray {
    if (self.annotationsArray.count != 0) {
        [self.annotationsArray removeAllObjects];
    }
    
    for (int i = 0; i < shopArray.count; i++) {
        NSDictionary *dic = [shopArray objectAtIndex:i];
        CustomAnnotation *item = [[CustomAnnotation alloc] init];
        
        if ([shopArray[i]objectForKey:@"latitude"] == NULL || [[shopArray[i]objectForKey:@"latitude"] isKindOfClass:[NSNull class]] ||[shopArray[i]objectForKey:@"longitude"] == NULL || [[shopArray[i]objectForKey:@"longitude"] isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        CGFloat latitude = [[shopArray[i] objectForKey:@"latitude"] doubleValue];
        CGFloat longitude = [[shopArray[i] objectForKey:@"longitude"] doubleValue];
        item.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        item.title = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"area_name"],[dic objectForKey:@"address"]];
        item.subtitle = [NSString stringWithFormat:@"联系人:%@%@",[dic objectForKey:@"shopper_name"],[dic objectForKey:@"contact_tel"]];
        item.shopName = [dic objectForKey:@"shop_name"];
        item.contactInformation = [dic objectForKey:@"shopper_name"];
        item.index = i;
        [self.annotationsArray addObject:item];
        [_mapView addAnnotation:item];
    }
}

//当前地址页面的数据
-(void)getCityList {
    CityListViewController *city = [CityListViewController new];
    city.selectCityBlock = ^(NSString *selectCity){
        self.tiLabel.text = selectCity;
        NSString *temp = selectCity;
        NSString*body=[NSString stringWithFormat:@"act=get_shop_list&city_name=%@",temp];
        NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
        TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [op.securityPolicy setAllowInvalidCertificates:YES];
        [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        DLog(@"body is%@",body);
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            DLog(@"responseObject:%@",responseObject);
            if ([[responseObject objectForKey:@"list"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"该城市不支持到店取货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else {
                self.option.city = selectCity;
                self.option.keyword = selectCity;
                [self.poiSearch poiSearchInCity:self.option];
                [SVProgressHUD show];
                [self.mapView removeAnnotations:self.annotationsArray];
                
                NSArray *my_contact = [responseObject objectForKey:@"list"];
                self.totalStoreArray = [NSMutableArray arrayWithArray:my_contact];
                [self addAnnotationWithShopInfo:self.totalStoreArray];
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"请求发生的错误是:%@",error);
            DLog(@"返回的数据:%@",operation.responseString);
            self.isRequesting=NO;
        }];
        [op start];
    };
         
    [self.navigationController pushViewController:city animated:YES];
    

}

//地图
-(void)navBtnClick:(UIButton *)btn{
    if (btn.tag<self.storeArray.count) {
        NSDictionary *tempDic=[self.storeArray objectAtIndex:btn.tag];
        NSString *gps=[[PreferenceManager sharedManager] preferenceForKey:@"gps"];
        NSArray *tempGps=[gps componentsSeparatedByString:@","];
        if (tempGps.count==2) {
            
            CLLocationCoordinate2D from;
            from.longitude=[[tempGps objectAtIndex:0] doubleValue];
            from.latitude=[[tempGps objectAtIndex:1] doubleValue];
            
            CLLocationCoordinate2D tolocation;
            _locatedAddress = [NSString stringWithFormat:@"%@", [tempDic valueForKey:@"address"]];
            tolocation.longitude=[[tempDic valueForKey:@"longitude"] doubleValue];
            tolocation.latitude=[[tempDic valueForKey:@"latitude"] doubleValue];
            
            [self navFrom:from toLocation:tolocation];
        }
        else{
            return;
        }

    }
}

-(void)getAllStoreData {
    //self.isRequesting=YES;
    NSString *temp=[[PreferenceManager sharedManager] preferenceForKey:@"cityname"];
    NSString*body=[NSString stringWithFormat:@"act=get_shop_list&city_name=%@",temp];
    NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isLoadView=YES;
        });
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            NSArray *my_contact = [responseObject objectForKey:@"list"];
            self.totalStoreArray = [NSMutableArray arrayWithArray:my_contact];
            self.isRequesting = NO;
            
            [self addAnnotationWithShopInfo:self.totalStoreArray];
            
            self.searchBar.userInteractionEnabled = YES;
        }else{
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        self.isRequesting=NO;
    }];
    [op start];
}

- (void)navFrom:(CLLocationCoordinate2D )froml  toLocation:(CLLocationCoordinate2D)toLocation{
    self.startCoor=froml;
    self.endCoor=toLocation;
    [self showActionSheet];
}

-(void)showActionSheet{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/direction"]]) {
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图",@"系统地图",@"高德地图", nil];
            actionSheet.tag=300;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }else{
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图",@"系统地图", nil];
            actionSheet.tag=100;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }
    }else{
        //1  百度  2 系统
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"高德地图",@"系统地图", nil];
            actionSheet.tag=200;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }else{
            [self guide:2];
        }
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==100) {
        if (buttonIndex==0) {
            //百度
            [self guide:1];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
    }
    if (actionSheet.tag==200) {
        if(buttonIndex==0){
            //高德
            [self guide:3];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
    }
    if (actionSheet.tag==300) {
        if(buttonIndex==0){
            //百度
            [self guide:1];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
        if(buttonIndex==2){
            //高德
            [self guide:3];
        }
    }
}
- (void)guide:(NSInteger)mapType {
    CLLocationCoordinate2D startCoor;
    CLLocationCoordinate2D endCoor;
    if (mapType == 1)
    {
        startCoor = self.startCoor;
        endCoor = self.endCoor;
    }
    else
    {
        self.mapType = mapType;
        NSString *locationString = [NSString stringWithFormat:@"%lf,%lf", self.endCoor.longitude, self.endCoor.latitude];
        NSArray *locationArray = [NSArray arrayWithObject:locationString];
        [self convertBaiduLocationToGaode:locationArray];
        return;
    }
    
    if (mapType==1) {
        double startLong=startCoor.longitude;
        double startLa=startCoor.latitude ;
        
        double endLong=endCoor.longitude;
        double endLa=endCoor.latitude ;
        
        NSString *originValue=[NSString stringWithFormat:@"%f,%f",startLa,startLong];
        NSString *endValue=[NSString stringWithFormat:@"%f,%f",endLa,endLong];
        
        NSString *urlString=[NSString stringWithFormat:@"baidumap://map/direction?origin=%@&destination=%@&mode=driving&src=%@",originValue,endValue,AppScheme];
        NSLog(@"usrlString:%@",urlString);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

#pragma mark - 转换百度坐标点到高德坐标点
- (void)convertBaiduLocationToGaode:(NSArray *)baiduLocationArray {
    [self getRequestConvertLocation:baiduLocationArray];
}

-(void)getRequestConvertLocation:(NSArray *)baiduLocationArray {

    NSString *locationsString = [baiduLocationArray componentsJoinedByString:@";"];
    NSString *str = [NSString stringWithFormat:@"http://restapi.amap.com/v3/assistant/coordinate/convert?key=73f3f23ff6658464e67bb494b6a2c149&coordsys=baidu&locations=%@", locationsString];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"GET"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];

    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        self.isRequesting=NO;
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            
            NSString *locations = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"locations"]];
            NSArray *locationsArray = [locations componentsSeparatedByString:@";"];
            CLLocationCoordinate2D newLocation;
            
            if (self.mapType == 0) {
                return;
            }
            else {
                NSString *locationString = [locationsArray objectAtIndex:0];
                NSArray *locationArray = [locationString componentsSeparatedByString:@","];
                newLocation = CLLocationCoordinate2DMake([[locationArray objectAtIndex:1] doubleValue], [[locationArray objectAtIndex:0] doubleValue]);
            }
            
            if (self.mapType==2) {
                if(C_IOS7){
                    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:newLocation addressDictionary:nil]];
                    toLocation.name = _locatedAddress;
                    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                }
            }
            
            if (self.mapType==3) {
                NSString *urlString=[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=0",AppScheme,AppScheme,[NSString stringWithFormat:@"%f",newLocation.latitude],[NSString stringWithFormat:@"%f",newLocation.longitude]];
                NSLog(@"usrlString:%@",urlString);
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         self.isRequesting=NO;
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        //[SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode == BMK_SEARCH_NO_ERROR){
        if (poiResult.poiInfoList.count > 0)
        {
            BMKPoiInfo *poiInfo = poiResult.poiInfoList[0];
            self.mapView.centerCoordinate = poiInfo.pt;
            self.mapView.zoomLevel = 15;
        }
    }
    [SVProgressHUD dismiss];
}
#pragma mark - CloudStoreCalloutViewDelegate
- (void)didClickView:(CloudStoreCalloutView *)view withButtonWithType:(CalloutViewButtonType)buttonType {
    
    if (buttonType == CalloutViewButtonTypeSure) {
        self.searchedAnnotation = nil;
        if (self.returnBlock) {
            NSDictionary* dic = [self.storeArray objectAtIndex:view.shopInfoIndex];
            self.returnBlock(dic, view.shopInfoIndex);
        }
        
        if ([self.linkValue isValid]) {
            return;
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (buttonType == CalloutViewButtonTypeNavigation) {
        
        NSDictionary *tempDic = [self.storeArray objectAtIndex:view.shopInfoIndex];
        NSString *gps=[[PreferenceManager sharedManager] preferenceForKey:@"gps"];
        NSArray *tempGps=[gps componentsSeparatedByString:@","];
        if (tempGps.count==2)
        {
            CLLocationCoordinate2D from;
            from.longitude=[[tempGps objectAtIndex:0] doubleValue];
            from.latitude=[[tempGps objectAtIndex:1] doubleValue];
            
            CLLocationCoordinate2D tolocation;
            _locatedAddress = [NSString stringWithFormat:@"%@", [tempDic valueForKey:@"address"]];
            tolocation.longitude=[[tempDic valueForKey:@"longitude"] doubleValue];
            tolocation.latitude=[[tempDic valueForKey:@"latitude"] doubleValue];
            [self navFrom:from toLocation:tolocation];
        }
    }
}

#pragma mark - 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mapView removeAnnotations:self.annotationsArray];
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
    [_mapView removeFromSuperview];
    _mapView = nil;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    SearchCloudStoreViewController *vc = [SearchCloudStoreViewController new];
    vc.annotations = [self.annotationsArray copy];
    for (int i = 0; i < self.annotationsArray.count; i ++) {
        CustomAnnotation *custom = self.annotationsArray[i];
        [_mapView deselectAnnotation:custom animated:NO];
    }
    vc.selectBlock = ^(CustomAnnotation *customAnnotation) {
        //设置中心点
        DLog(@"%f    %f",customAnnotation.coordinate.latitude,customAnnotation.coordinate.longitude);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.mapView.centerCoordinate = customAnnotation.coordinate;
            self.mapView.zoomLevel = 15;
        });
    };
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

#pragma mark - 隐藏键盘
-(void)missKeyBoard {
    [self.view endEditing:YES];
}

#pragma mark - 选择相应的店铺
- (void)gotoChose:(UIButton *)btn{
    DLog(@"%ld",(long)btn.tag);
    NSDictionary *dic = self.totalStoreArray[btn.tag];
    
    if (self.returnBlock) {
        NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
        dics[@"contacts_tel"] = dic[@"contact_tel"];
        dics[@"contacts_name"] = dic[@"shopper_name"];
        self.returnBlock(dics,btn.tag);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 定时判定地图是否加载
- (void)judgeTheMap {
    if (_mapView) {
        [_timer invalidate];
        _timer = nil;
        [self getAllStoreData];
    }
}
#pragma mark - 百度地图各种代理
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    //如果是注释点
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.animatesDrop = YES;
        newAnnotationView.annotation = annotation;
        //这里我根据自己需要，继承了BMKPointAnnotation，添加了标注的类型等需要的信息
        CustomAnnotation *custom = (CustomAnnotation *)annotation;
        
        newAnnotationView.image= [UIImage imageNamed:@"pointAddressImage@2x"];
        
        
        //设定popView的高度，根据是否含有缩略图
        double popViewH = 90;

        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-100, popViewH)];
        popView.backgroundColor = [UIColor whiteColor];
        [popView.layer setMasksToBounds:YES];
        [popView.layer setCornerRadius:3.0];
        popView.alpha = 0.9;
        
        //自定义气泡的内容，添加子控件在popView上
        UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, popView.width-16, 35)];
        driverName.text = custom.title;
        driverName.backgroundColor = [UIColor clearColor];
        driverName.font = [UIFont systemFontOfSize:14];
        driverName.textColor = [UIColor blackColor];
        driverName.numberOfLines = 0;
        [popView addSubview:driverName];
        
        UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(8, 40, popView.width-16, 20)];
        carName.text = custom.subtitle;
        carName.backgroundColor = [UIColor clearColor];
        carName.font = [UIFont systemFontOfSize:11];
        carName.textColor = [UIColor lightGrayColor];
        carName.textAlignment = NSTextAlignmentLeft;
        [popView addSubview:carName];
        
        if (custom.subtitle != nil) {
            UIButton *searchBn = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, popView.width, 30)];
            [searchBn setTitle:@"选择到该店取货" forState:UIControlStateNormal];
            searchBn.backgroundColor = Red_Color;
            searchBn.titleLabel.font = [UIFont systemFontOfSize:15];
            searchBn.titleLabel.numberOfLines = 0;
            searchBn.tag = custom.index;
            [searchBn addTarget:self action:@selector(gotoChose:) forControlEvents:UIControlEventTouchUpInside];
            [popView addSubview:searchBn];
        }
        
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
        pView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH-100, popViewH);
        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = nil;
        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = pView;
        return newAnnotationView;
        
    }
    
    return nil;
}
@end
