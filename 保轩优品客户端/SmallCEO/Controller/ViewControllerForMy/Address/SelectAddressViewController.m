//
//  SelectAddressViewController.m
//  Jiang
//
//  Created by huang on 17/1/5.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "SelectAddressViewController.h"

#import "NavigationItemButton.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "SelectAddressMapView.h"
#import "UIScrollView+EmptyDataSet.h"
@interface SelectAddressViewController () <UITableViewDataSource, UITableViewDelegate, BMKPoiSearchDelegate, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *resultTableView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) SelectAddressMapView *mapView;

@property (nonatomic, strong) BMKPoiSearch *poiSearch;
@property (nonatomic, copy)   NSArray <BMKPoiInfo *> *poiInfoList;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) BMKGeoCodeSearch *centerGeoCodeSearch;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@end

@implementation SelectAddressViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"选择地址";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];

    self.poiSearch = [[BMKPoiSearch alloc] init];
    self.poiSearch.delegate = self;

    
    self.centerGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    self.centerGeoCodeSearch.delegate = self;
    
    [self p_setupMainView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//取消键盘
-(void)missKeyBoard{
    [self.view endEditing:YES];
}

- (void)keyboardAction:(NSNotification*)sender{
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        self.resultTableView.y = 60;
    }else{
        self.resultTableView.y = self.mapView.maxY;
    }
}
#pragma mark - Private methods
- (void)p_setupMainView {
    NavigationItemButton *itemButton = [NavigationItemButton defaultStyleButtonWithTitle:@"确定"];
    [itemButton addTarget:self action:@selector(sureSelectAddress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    
    CGFloat mapViewHeight = IS_IPHONE4 ? 300 : 350;
    self.mapView = [[SelectAddressMapView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, mapViewHeight)];

        BMKCoordinateSpan theSpan;
        theSpan.latitudeDelta = 0.01;
        theSpan.longitudeDelta = 0.01;
        
        BMKCoordinateRegion theRegion;
        theRegion.center = self.centerCoordinate;
        theRegion.span = theSpan;
        [self.mapView setRegion:theRegion animated:YES];
    
    
    self.mapView.zoomLevel = 15.0;
    self.mapView.delegate = self;
    __weak __typeof(self)weakSelf = self;
    self.mapView.locationSucceedBlock = ^ (CLLocationCoordinate2D coordinate) {
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeoCodeSearchOption.reverseGeoPoint = coordinate;
        [weakSelf.centerGeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    };
    [self.view addSubview:self.mapView];
    
    UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 21)];
    locationImageView.center = self.mapView.center;
    locationImageView.image = [UIImage imageNamed:@"30px1"];
    [self.mapView addSubview:locationImageView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, UI_SCREEN_WIDTH, 50)];
    [textField addTarget:self action:@selector(searchTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.font = [UIFont systemFontOfSize:15.0];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"输入要搜索的地址";
    UIView *leftBackspaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15.0, textField.height)];
    textField.leftView = leftBackspaceView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.mapView addSubview:textField];
    self.searchTextField = textField;
    
    UITableView *resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mapView.maxY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.mapView.height - HeightForNagivationBarAndStatusBar)];
    resultTableView.backgroundColor = [UIColor whiteColor];
    resultTableView.layer.cornerRadius = 5.0;
    resultTableView.clipsToBounds = YES;
    resultTableView.dataSource = self;
    resultTableView.delegate = self;
    resultTableView.tableFooterView = [UIView new];
    resultTableView.emptyDataSetSource = self;
    [self.view addSubview:resultTableView];
    self.resultTableView = resultTableView;
    DLog(@"%@",[[PreferenceManager sharedManager]allData]);
    if ([self.selectCity isEqualToString:[[PreferenceManager sharedManager]preferenceForKey:@"cityname"]]) {
        [self geoSearch];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"选择位置与定位城市不同,是否切换到定位位置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    [self.mapView.locationButton addTarget:self action:@selector(openLocationMapView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)openLocationMapView {
    [self.mapView openLocation];
    
    self.selectedIndex = 0;
    if (_searchTextField.text.length == 0) return;
    
    [self p_searchPoiWithText:_searchTextField.text];
}

- (void)geoSearch {
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = self.mapView.centerCoordinate;
    [self.centerGeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    
    [self.searchTextField resignFirstResponder];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self geoSearch];
    }else {
        [_mapView openLocation];
    }
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"搜索结果为空"
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],
                                                        NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)p_searchPoiWithText:(NSString *)text {
    NSString *defaultCity = [[PreferenceManager sharedManager] preferenceForKey:@"cityname"];
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 20;
    option.city = [self.currentCity isValid] ? self.currentCity : defaultCity;
    option.keyword = text;
    
    [self.poiSearch poiSearchInCity:option];
}

#pragma mark - TextFiled text changed method
- (void)searchTextFieldValueChanged:(UITextField *)textField {
    self.resultTableView.contentOffset = CGPointZero;
    self.selectedIndex = 0;
    if (textField.text.length == 0) return;
    
    [self p_searchPoiWithText:textField.text];
}

#pragma mark - UIScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTextField resignFirstResponder];
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (_searchTextField.text.length) {
        return;
    }
    
    if (error == BMK_SEARCH_NO_ERROR) {
        self.currentCity = result.addressDetail.city;
        self.poiInfoList = result.poiList;
        self.selectedIndex = 0;
    }else {
        self.poiInfoList = @[];
    }
    [self.resultTableView reloadData];
}

#pragma mark - BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.resultTableView.contentOffset = CGPointZero;
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = mapView.centerCoordinate;
    [self.centerGeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        self.poiInfoList = poiResult.poiInfoList;
    }else {
        self.poiInfoList = @[];
        DLog(@"抱歉，未找到结果");
    }
    [self.resultTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poiInfoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellStr = @"SelectAddressCellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BMKPoiInfo *poiInfo = self.poiInfoList[indexPath.row];
    cell.textLabel.text = poiInfo.name;
    cell.detailTextLabel.text = poiInfo.address;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [[UIImage imageNamed:@"ic_address_selected.png"] imageWithMinimumSize:CGSizeMake(14, 14)];
    cell.accessoryView = indexPath.row == self.selectedIndex ? imageView : nil;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    BMKPoiInfo *pointInfo = self.poiInfoList[self.selectedIndex];
    self.searchTextField.text = pointInfo.name;
    [self.resultTableView reloadData];
}

#pragma mark - UIButton action methods
- (void)sureSelectAddress {
    if (self.poiInfoList.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    
    if (self.sureSelectAddressBlock) {
        self.sureSelectAddressBlock(self.poiInfoList[self.selectedIndex]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
