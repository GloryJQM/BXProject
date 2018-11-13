//
//  SGBaiduLocationSearch.m
//  Jiang
//
//  Created by quanmai on 2016/10/2.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "SGBaiduLocationService.h"
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

static SGBaiduLocationService *share;

@interface SGBaiduLocationService ()<BMKCloudSearchDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    
}

@property(nonatomic, strong) BMKLocationService *locationService;


@property(nonatomic, strong) BMKPoiSearch *search;
@property(nonatomic, strong) BMKGeoCodeSearch *geoSearcher;

@property(nonatomic, strong) NSArray * result;

@end

@implementation SGBaiduLocationService






+(instancetype)shareInstance{
    if (share==nil) {
        share = [[[self class] alloc] init];
    }
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _search = [[BMKPoiSearch alloc] init];
        _search.delegate = self;
    }
    return self;
}

#pragma mark - 定位
-(void)baiduLoadLocation{
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    if ([self isLocationEnable]) {

    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if ([self isLocationEnable]) {
        NSString *oldGps = [[PreferenceManager sharedManager] preferenceForKey:@"gps"];
        //第一次打开定位 还没有gps信息
        NSString *myGPS = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
        [[PreferenceManager sharedManager] setPreference:myGPS forKey:@"gps"];
        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        [[PreferenceManager sharedManager] setPreference:longitude forKey:@"longitude"];
        [[PreferenceManager sharedManager] setPreference:latitude forKey:@"latitude"];

        
        
        DLog(@"%@",myGPS);
        if (oldGps == nil) {
            //第一次定位成功 更新首页距离数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FirstLocationSuccess" object:nil];
            [self showWithlocation:userLocation.location.coordinate];

        }
        
        [_locationService stopUserLocationService];
        _locationService.delegate = nil;
    }
}


- (void)showWithlocation:(CLLocationCoordinate2D)location {
    
    _geoSearcher =[[BMKGeoCodeSearch alloc]init];
    _geoSearcher.delegate = self;
    
//    发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = location;
    BOOL flag = [_geoSearcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
    
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
//      在此处理正常结果
      NSString *cityStr = result.addressDetail.city;
      NSString *provicestr = result.addressDetail.province;
      NSString *address = result.address;
      
      [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",cityStr] forKey:@"city"];
      [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",provicestr] forKey:@"province"];
      [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@",address] forKey:@"address"];
      DLog(@"location Success:cityStr(city_name):%@  provicestr(city_id):%@",cityStr,provicestr);
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    DLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSString *oldGps = [[PreferenceManager sharedManager] preferenceForKey:@"gps"];
    if (oldGps == nil) {
        [[PreferenceManager sharedManager] setPreference:@"120.092847,30.286795" forKey:@"gps"];
    }
    DLog(@"location error");
}

-(BOOL)isLocationEnable{
    BOOL systemEnable = [CLLocationManager locationServicesEnabled];
    BOOL appEnable = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
    return systemEnable && appEnable;
}

#pragma mark - 预搜索
- (void)searchWithText:(NSString *)text
{
    NSString *city = [[PreferenceManager sharedManager] preferenceForKey:@"city"];
    if (city == nil) {
        city = @"杭州市";
    }
    //发起检索
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 20;
    option.city = city;
    option.keyword = text;
    BOOL flag = [_search poiSearchInCity:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

- (void)searchWithPoiUID:(NSString *)uid
{
    BMKPoiDetailSearchOption *option = [BMKPoiDetailSearchOption new];
    option.poiUid = uid;
    BOOL flag = [_search poiDetailSearch:option];
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        DLog(@"result:%@",poiResultList.poiInfoList);
        self.result = poiResultList.poiInfoList;
        
        if (_finishBlock) {
            _finishBlock(self.result);
        }
        for (NSInteger i = 0; i < poiResultList.poiInfoList.count; i ++) {
            BMKPoiInfo *info = [poiResultList.poiInfoList objectAtIndex:i];
            DLog(@"poi.name%@ poi.pt:%f",info.name,info.pt.longitude);
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
        if (_finishBlock) {
            _finishBlock(@[]);
        }
    } else {
        NSLog(@"抱歉，未找到结果");
        if (_finishBlock) {
            _finishBlock(@[]);
        }
    }
}

- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (self.getPoiDetailsBlock)
        {
            self.getPoiDetailsBlock(poiDetailResult);
        }
    }
    else
    {
        if (self.getPoiDetailsBlock)
        {
            self.getPoiDetailsBlock(nil);
        }
        DLog(@"抱歉，未找到结果");
    }
}

@end
