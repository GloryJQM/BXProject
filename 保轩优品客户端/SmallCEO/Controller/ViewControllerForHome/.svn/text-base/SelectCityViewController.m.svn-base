//
//  SelectCityViewController.m
//  WanHao
//
//  Created by Cai on 14-8-21.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "SelectCityViewController.h"

#import "CCustomSelectView.h"

@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,CCustomSelectViewDelegate> {
    UITableView     *_cityTable;
    NSArray         *_provinces;
    NSMutableString    *_localArea;
    BOOL            _islocation;
    
    UIView *_loactionView;
    
    UIView      *_hotView;
    
    CCustomSelectView   *_areaSelview;
    
    NSMutableArray      *_areaArr;
    
    NSInteger                 _selCitySectionIndex;
    NSInteger                 _selCityRowIndex;
}
@end

@implementation SelectCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"选择城市";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (C_IOS7){
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    _localArea = [[NSMutableString alloc] initWithCapacity:0];
    _islocation = YES;
    
    if ([[PreferenceManager sharedManager] preferenceForKey:@"currentcity"]) {
        [_localArea setString:[[PreferenceManager sharedManager] preferenceForKey:@"currentcity"]];
    }else{
        [_localArea setString:@""];
    }
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * plistpath = [paths objectAtIndex:0];
    _provinces = [[NSArray alloc] initWithContentsOfFile:[plistpath stringByAppendingPathComponent:@"SelectCityName.plist"]];
    
    _cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64.0) style:UITableViewStylePlain];
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cityTable];
    
    _areaArr = [[NSMutableArray alloc] initWithCapacity:0];

    _areaSelview  = [[CCustomSelectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_HEIGHT) content:_areaArr];
    _areaSelview.backgroundColor = [UIColor clearColor];
    _areaSelview.ccselViewDelegate = self;
    _areaSelview.tag = 54231;
    _areaSelview.hidden = YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.window addSubview:_areaSelview];
    [delegate.window bringSubviewToFront:_areaSelview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![_localArea isEqualToString:@""]) {
        return [_provinces count]+1;
    }else{
        return [_provinces count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![_localArea isEqualToString:@""]) {
        if (section == 0) {
            return 1;
        }else{
            NSArray *_city = [[_provinces objectAtIndex:section-1] objectForKey:@"cities"];
            return _city.count;
        }
    }else{
        NSArray *_city = [[_provinces objectAtIndex:section] objectForKey:@"cities"];
        return _city.count;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (![_localArea isEqualToString:@""]) {
        if (section == 0) {
            return @"当前位置";
        }else{
            return [[_provinces objectAtIndex:section-1] objectForKey:@"zimu"];
        }
    }else{
    
        return [[_provinces objectAtIndex:section] objectForKey:@"zimu"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellind = @"selectCity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellind];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellind];
        UILabel *linelab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 43.5, self.view.frame.size.width, 0.5)];
        linelab.backgroundColor = App_Main_Color;
        [cell addSubview:linelab];
    }
    if (![_localArea isEqualToString:@""]) {
        if (indexPath.section == 0 ) {
            cell.textLabel.text = _localArea;
        }else{
            NSArray *city = [[_provinces objectAtIndex:indexPath.section-1] objectForKey:@"cities"];
            cell.textLabel.text = [[city  objectAtIndex:indexPath.row]objectForKey:@"name"];
        }
    }else{
        NSArray *city = [[_provinces objectAtIndex:indexPath.section] objectForKey:@"cities"];
        cell.textLabel.text = [[city  objectAtIndex:indexPath.row]objectForKey:@"name"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![_localArea isEqualToString:@""]) {
        if (indexPath.section == 0) {
            [[PreferenceManager sharedManager] setPreference:_localArea forKey:@"cityname"];
            //省
            NSString *curpro = [NSString stringWithFormat:@"%@",[[PreferenceManager sharedManager] preferenceForKey:@"currentProvice"]];
            [[PreferenceManager sharedManager] setPreference:curpro forKey:@"cityid"];
            //区
            NSString *curarea = [NSString stringWithFormat:@"%@",[[PreferenceManager sharedManager] preferenceForKey:@"currentArea"]];
            
            [[PreferenceManager sharedManager] setPreference:curarea forKey:@"area"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadhomecustom" object:nil];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSArray *tempArr = [NSArray arrayWithArray:[[[[_provinces objectAtIndex:indexPath.section-1] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"area"]];
            if (tempArr.count > 0) {
                
                _selCitySectionIndex = indexPath.section - 1;
                _selCityRowIndex = indexPath.row;
                
                _areaSelview.hidden = NO;
                [_areaArr removeAllObjects];
                [_areaArr addObjectsFromArray:tempArr];
                [_areaSelview updataUIWithArr:_areaArr title:@"请选择相应的区"];
            }else{
                NSString *temp=[[[[_provinces objectAtIndex:indexPath.section-1] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"name"];
                NSString *tempid=[[[[_provinces objectAtIndex:indexPath.section-1] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"id"];
                [[PreferenceManager sharedManager] setPreference:temp forKey:@"cityname"];
                [[PreferenceManager sharedManager] setPreference:tempid forKey:@"cityid"];
                
                //没有区的时候存@“”为area
                [[PreferenceManager sharedManager] setPreference:@"" forKey:@"area"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadhomecustom" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        
    }else{
        NSArray *tempArr = [NSArray arrayWithArray:[[[[_provinces objectAtIndex:indexPath.section] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"area"]];
        if (tempArr.count > 0) {
        
            _selCitySectionIndex = indexPath.section;
            _selCityRowIndex = indexPath.row;
            
            _areaSelview.hidden = NO;
            [_areaArr removeAllObjects];
            [_areaArr addObjectsFromArray:tempArr];
            [_areaSelview updataUIWithArr:_areaArr title:@"请选择相应的区"];
            
        }else{
            NSString *temp=[[[[_provinces objectAtIndex:indexPath.section] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"name"];
            NSString *tempid=[[[[_provinces objectAtIndex:indexPath.section] objectForKey:@"cities"] objectAtIndex: indexPath.row] objectForKey:@"id"];
            [[PreferenceManager sharedManager] setPreference:temp forKey:@"cityname"];
            [[PreferenceManager sharedManager] setPreference:tempid forKey:@"cityid"];
            
            //没有区的时候存@“”为area
            [[PreferenceManager sharedManager] setPreference:@"" forKey:@"area"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadhomecustom" object:nil];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}


- (void)loadLocation {
    if ([CLLocationManager locationServicesEnabled] &&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        if ( self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 1000.0f;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        }
        [self.locationManager startUpdatingLocation];
    }else{
        DLog(@"开启定位功能");
    }
}

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocationDegrees latitude = _locationManager.location.coordinate.latitude; //float也行，获得当前位置的纬度.location属性获
    CLLocationDegrees longitude = _locationManager.location.coordinate.longitude;
    mylocation.latitude=latitude;
    mylocation.longitude=longitude;
    [self showWithlocation:mylocation];
}


- (void)showWithlocation:(CLLocationCoordinate2D)location {
    Geocoder=[[CLGeocoder alloc]init];
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        for (CLPlacemark *placemark in place) {
            NSString *cityStr=[placemark.addressDictionary objectForKey:@"City"];
            [_localArea setString:cityStr];
            if (_islocation) {
                [_cityTable reloadData];
                _islocation = NO;
            }
            break;
        }
    };
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in _provinces) {
        [array addObject:[dict objectForKey:@"zimu"]];
    }
    return  array;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 20.0)];
    vi.backgroundColor = App_Main_Color;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, UI_SCREEN_WIDTH, 20.0)];
    lab.backgroundColor=[UIColor clearColor];
    if (![_localArea isEqualToString:@""]) {
        if (section == 0) {
            lab.text =  @"定位城市";
        }else{
           lab.text =  [[_provinces objectAtIndex:section-1] objectForKey:@"zimu"];
        }
    }else{
        lab.text = [[_provinces objectAtIndex:section] objectForKey:@"zimu"];
    }
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor clearColor];
    [vi addSubview:lab];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (void)CCustomSelectViewCancel {
    _areaSelview.hidden = YES;
}

- (void)CCustomSelectViewCellDidSelect:(int)cellindex customview:(CCustomSelectView *)selView {
    _areaSelview.hidden = YES;
    NSString *temp=[[[[_provinces objectAtIndex:_selCitySectionIndex] objectForKey:@"cities"] objectAtIndex: _selCityRowIndex] objectForKey:@"name"];
    NSString *tempid=[[[[_provinces objectAtIndex:_selCitySectionIndex] objectForKey:@"cities"] objectAtIndex: _selCityRowIndex] objectForKey:@"id"];
    
    [[PreferenceManager sharedManager] setPreference:temp forKey:@"cityname"];
    [[PreferenceManager sharedManager] setPreference:tempid forKey:@"cityid"];
    NSMutableString *tempZone = [NSMutableString stringWithCapacity:0];
    [tempZone setString:@""];
    if (cellindex < _areaArr.count) {
        [tempZone setString:[NSString stringWithFormat:@"%@",[_areaArr objectAtIndex:cellindex]]];
    }
    [[PreferenceManager sharedManager] setPreference:tempZone forKey:@"area"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadhomecustom" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
