//
//  AddAddressViewController.m
//  Lemuji
//
//  Created by gaojun on 15-7-16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PersonInforView.h"
#import "AddressSingleton.h"

#import "SGBaiduLocationService.h"
#import "SelectAddressViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AddAddressViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate,UITextViewDelegate,UITextFieldDelegate,BMKPoiSearchDelegate>
{
    NSArray *provinces, *cities, *areas;
    UIView *adrDetailView;
    UITextField *addressTextView;
    UITextField *addressTextfield;
    UIView *DetailView;
    UIView *adrDetailLine;
    
}

@property (nonatomic,strong)NSMutableArray* shengArr;
@property (nonatomic,strong)NSMutableArray* shiArr;
@property (nonatomic,strong)NSMutableArray* quArr;

@property (nonatomic,assign)int shengId;
@property (nonatomic,assign)int shiId;
@property (nonatomic,assign)int quId;

@property (nonatomic,strong)NSString* shengName;
@property (nonatomic,strong)NSString* shiName;
@property (nonatomic,strong)NSString* quName;

@property (nonatomic,strong)UITextField* nameTf;
@property (nonatomic,strong)UITextField* phoneTf;

@property (nonatomic, strong)UILabel * areaLabel;

@property (nonatomic,assign)int isDefult;

@property (nonatomic,assign)BOOL isSame;

@property (nonatomic,strong)NSString *returnCity;

@property (nonatomic, strong) BMKPoiSearch *poiSearch;

@property (nonatomic, assign) CLLocationCoordinate2D selectedCoordinate;

@end

@implementation AddAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shengArr = [NSMutableArray arrayWithCapacity:0];
    self.shiArr = [NSMutableArray arrayWithCapacity:0];
    self.quArr = [NSMutableArray arrayWithCapacity:0];
    self.isSame = NO;
    //初始化百度地图搜索
    self.poiSearch = [[BMKPoiSearch alloc] init];
    self.poiSearch.delegate = self;
    
    //初始化视图
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新增收货地址";
    if (self.wp == 2) {
        self.title = @"编辑收货地址";
        self.isSame = YES;
    }
    
//    UIView * barLine = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
//    barLine.backgroundColor = LINE_DEEP_COLOR;
//    
//    [self.view addSubview:barLine];
    
    //将触摸事件添加到当前view
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(missKeyBoard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    [self creatView];
    [self initAddressProperties];
}


- (void)initAddressProperties
{
    provinces = [NSArray arrayWithArray:[AddressSingleton sharedManager].sonAddressArray];
    AddressModel *model = (AddressModel *)provinces[0];
    AddressModel *a = (AddressModel *)model.sonAddressArray[0];
    DLog(@" 数据:%@     %@", model.name,a.name);
    DLog(@"%@",self.dataDic);
    CLLocationCoordinate2D cll;
    cll.latitude = [self.dataDic[@"latitude"] floatValue];
    cll.longitude = [self.dataDic[@"longitude"] floatValue];
    
    self.selectedCoordinate = cll;

    if (provinces.count > 0)
    {
        self.shengName = [NSString stringWithFormat:@"%@", ((AddressModel *)[provinces objectAtIndex:0]).name];
        self.shengId = [[NSString stringWithFormat:@"%@", ((AddressModel *)[provinces objectAtIndex:0]).majorID] intValue];
        cities = ((AddressModel *)[provinces objectAtIndex:0]).sonAddressArray;
        
        DLog(@" 数据:%@", self.shengName);
    }
    
    if (cities.count > 0)
    {
        self.shiName = [NSString stringWithFormat:@"%@", ((AddressModel *)[cities objectAtIndex:0]).name];
        self.shiId = [((AddressModel *)[cities objectAtIndex:0]).majorID intValue];
        areas = ((AddressModel *)[cities objectAtIndex:0]).sonAddressArray;
    }
    
    if (areas.count > 0)
    {
        self.quId = [((AddressModel *)[areas objectAtIndex:0]).majorID intValue];
        self.quName = [NSString stringWithFormat:@"%@", ((AddressModel *)[areas objectAtIndex:0]).name];
    }
    
    //self.shiName = [self.dataDic objectForKey:@"city_name"];
}

//取消键盘
-(void)missKeyBoard{
    [self.view endEditing:YES];
}
- (void)creatView
{
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 37)];
    [self.view addSubview:topView];
    
    self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 70, 36)];
    _areaLabel.text = @"所在地区";
    _areaLabel.font = LMJ_CT 14];
    _areaLabel.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    [topView addSubview:_areaLabel];
    
    
    self.areaAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 0, 200, 36)];
    _areaAllLabel.font = LMJ_CT 14.5];
    _areaAllLabel.textAlignment = NSTextAlignmentLeft;
    _areaAllLabel.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    _areaAllLabel.text = @"省/市/区";
    if(self.wp == 2)
    {
        _areaAllLabel.text = [NSString stringWithFormat:@"%@", [self.dataDic objectForKey:@"area_name"]];
        self.quId = [[self.dataDic objectForKey:@"area_id"] intValue];
        self.shiId =  [[self.dataDic objectForKey:@"city_id"] intValue];
        self.quName = [self.dataDic objectForKey:@"area_name"];

    }
    
    
    [topView addSubview:_areaAllLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popPickerView)];
    [topView addGestureRecognizer:tap];
    
    
    
    UIImageView * nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_jt_right.png"]];
    nextImageView.frame = CGRectMake(300 * adapterFactor, 14, 5, 8);
    [topView addSubview:nextImageView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 36, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
    [self.view addSubview:line];
    
    
    NSArray * inforArray = @[@"联系电话", @"联系人"];
    for (int i = 0; i < inforArray.count; i++) {
        
        self.personInformationView = [[PersonInforView alloc] initWithFrame:CGRectMake(0, 37 + 37 * i,UI_SCREEN_WIDTH, 37)];
        
        self.personInformationView.informationLabel.text = [inforArray objectAtIndex:i];
        self.personInformationView.informationLabel.font = LMJ_CT 14];
        self.personInformationView.informationLabel.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
        self.personInformationView.informationField.delegate = self;
        
        if(i==0) {
            self.phoneTf = self.personInformationView.informationField;
            self.phoneTf.keyboardType=UIKeyboardTypeNumberPad;
            _phoneTf.placeholder = @"收货人电话";
        }else if(i==1) {
            self.nameTf = self.personInformationView.informationField;
            _nameTf.placeholder = @"姓名";
        }
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:self.personInformationView.informationField.placeholder];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:14.5]
                            range:NSMakeRange(0, self.personInformationView.informationField.placeholder.length)];
        self.personInformationView.informationField.attributedPlaceholder = placeholder;
        [self.view addSubview:_personInformationView];
    }
    //选择地址框
    adrDetailView = [[UIView alloc] initWithFrame:CGRectMake( 0, 37+38*2, UI_SCREEN_WIDTH, 38)];
    adrDetailView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:adrDetailView];
    
    UILabel *adrDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, 65, 20)];
    adrDetailLab.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    adrDetailLab.text = @"地址";
    adrDetailLab.font = LMJ_CT 14];
    [adrDetailView addSubview:adrDetailLab];
    
    addressTextView = [[UITextField alloc] initWithFrame:CGRectMake(13+65, 0, UI_SCREEN_WIDTH-65-26, 36)];
    addressTextView.delegate = self;
    addressTextView.font = LMJ_XT 14.5];
    addressTextView.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    addressTextView.delegate = self;

    addressTextView.placeholder = @"选择地址";
    [adrDetailView addSubview:addressTextView];
    
    adrDetailLine = [[UIView alloc] initWithFrame:CGRectMake(14, 37, UI_SCREEN_WIDTH - 28, 1)];
    adrDetailLine.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
    [adrDetailView addSubview:adrDetailLine];
    
    //选择地址框
    DetailView = [[UIView alloc] initWithFrame:CGRectMake( 0, 37+38*3, UI_SCREEN_WIDTH, 38)];
    DetailView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:DetailView];
    
    UILabel *DetailLab = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, 65, 20)];
    DetailLab.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    DetailLab.text = @"门牌号";
    DetailLab.font = LMJ_CT 14];
    [DetailView addSubview:DetailLab];
    
    addressTextfield = [[UITextField alloc] initWithFrame:CGRectMake(13+65, 0, UI_SCREEN_WIDTH-65-26, 36)];
    addressTextfield.delegate = self;
    addressTextfield.font = LMJ_XT 14.5];
    addressTextfield.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    addressTextfield.delegate = self;
    addressTextfield.placeholder = @"详细地址";
    [DetailView addSubview:addressTextfield];
    
    UIView * lines = [[UIView alloc] initWithFrame:CGRectMake(0, 37+38*4, UI_SCREEN_WIDTH, 1)];
    lines.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
    [self.view addSubview:lines];
    //设置隐藏按钮
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
    btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
    [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
    btnT.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnT addTarget:self action:@selector(hideTextView) forControlEvents:UIControlEventTouchUpInside];
    if(addressTextfield.inputAccessoryView==nil){
        addressTextfield.inputAccessoryView=btnT;
    }
    
    
    if(self.wp == 2)
    {
        addressTextView.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"address"]];
        addressTextfield.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"house_number"]];
        int width = (int)[self getLengthWithStr:addressTextView.text];
        int tvWidth = UI_SCREEN_WIDTH-70-26-15;
        int num = width/tvWidth;
//        if (num >= 1) {
////            adrDetailView.frame = CGRectMake( 0, 66+38*2, UI_SCREEN_WIDTH, 38+20*num);
////            addressTextView.frame = CGRectMake(13+70, 0, UI_SCREEN_WIDTH-70-26, 37+20*num);
////            adrDetailLine.frame = CGRectMake(14, 37+20*num, UI_SCREEN_WIDTH - 28, 1);
//            adrDetailView.frame = CGRectMake( 0, 66+38*2, UI_SCREEN_WIDTH, 38+20);
//            addressTextView.frame = CGRectMake(13+70, 0, UI_SCREEN_WIDTH-70-26, 37+20);
//            adrDetailLine.frame = CGRectMake(14, 37+20, UI_SCREEN_WIDTH - 28, 1);
//        }
        self.nameTf.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"contact_name"]];
        self.phoneTf.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"phone_num"]];
    }
    //设置保存按钮
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 44 - 64, UI_SCREEN_WIDTH, 44);
    saveBtn.backgroundColor = App_Main_Color;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = LMJ_CT 15.5];
    saveBtn.titleLabel.textColor = [UIColor colorFromHexCode:@"#FFFFFF"];
    [saveBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    //设置选择地区按钮
    [self creatPickView];
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    int width = (int)[self getLengthWithStr:addressTextView.text];
    int tvWidth = UI_SCREEN_WIDTH-70-26-15;
    int num = width/tvWidth;
    if (num >= 1) {
        adrDetailView.frame = CGRectMake( 0, 37+38*2, UI_SCREEN_WIDTH, 38+20*num);
        addressTextView.frame = CGRectMake(13+70, 0, UI_SCREEN_WIDTH-65-26, 37+20*num);
        adrDetailLine.frame = CGRectMake(14, 37+20*num, UI_SCREEN_WIDTH - 28, 1);
    }else {
        adrDetailView.frame = CGRectMake( 0, 37+38*2, UI_SCREEN_WIDTH, 38);
        addressTextView.frame = CGRectMake(13+70, 0, UI_SCREEN_WIDTH-65-26, 37);
        adrDetailLine.frame = CGRectMake(14, 37, UI_SCREEN_WIDTH - 28, 1);
    }
}
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return ceilf(rect.size.width);
}
- (void)hideTextView {
    [self.view endEditing:YES];
}
-(void)saveBtnClick
{
    self.nameTf.text=[self.nameTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    addressTextView.text=[addressTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _areaAllLabel.text=[_areaAllLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.phoneTf.text=[self.phoneTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([_areaAllLabel.text isEqualToString:@""] ||
        [addressTextView.text isEqualToString:@""] ||
        [self.nameTf.text isEqualToString:@""] ||
        [self.phoneTf.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title
                                                        message:@"请选择完整信息"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if([self.phoneTf.text isBeginsWith:@"1"]){
        if (self.phoneTf.text.length !=11 ) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"手机号格式错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    
    if (self.phoneTf.text.length < 4)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"联系电话不规范" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if ([addressTextView.text isEqualToString:@""])
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if ([addressTextfield.text isEqualToString:@""])
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"请输入详细地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if(self.wp == 0)
    {
        if (_isSame) {
            [self postUpAddAdr];
        }else {
            [SVProgressHUD showErrorWithStatus:@"您选择的详细地址与门店地址不在同一城市，请重选!"];
        }
    }else if(self.wp == 2)
    {
        if (_isSame) {
            [self postEditAdr:self.isCurrent];
        }else {
            [SVProgressHUD showErrorWithStatus:@"您选择的详细地址与门店地址不在同一城市，请重选!"];
        }
    }
}

//取消键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //     [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == addressTextView) {
        
        if ([self.areaAllLabel.text isEqualToString:@"省/市/区"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请先选择城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else {
            BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
            option.pageIndex = 0;
            option.pageCapacity = 5;
            
            if (self.wp == 0) {
                if ([self.shengName isEqualToString:@"台湾省"] ||
                    [self.shengName isEqualToString:@"香港特别行政区"] ||
                    [self.shengName isEqualToString:@"澳门特别行政区"] ||
                    [self.shengName isEqualToString:@"北京市"]||
                    [self.shengName isEqualToString:@"天津市"] ||
                    [self.shengName isEqualToString:@"上海市"] ||
                    [self.shengName isEqualToString:@"重庆市"])
                {
                    option.city = [NSString stringWithFormat:@"%@,%@", self.shengName, self.quName];
                    if ([self.quName isEqualToString:@"市辖区"]) {
                        option.keyword = self.shengName;
                    }else {
                        option.keyword = self.quName;
                    }
                }else{
    
                    option.city = [NSString stringWithFormat:@"%@,%@", self.shiName, self.quName];
                    if ([self.quName isEqualToString:@"市辖区"]) {
                        option.keyword = self.shiName;
                    }else {
                        option.keyword = self.quName;
                    }
                    
                }
            }else if (self.wp == 2){
                DLog(@"%@", self.dataDic);
                NSString *pname = self.dataDic[@"province_name"];
                if ([pname isEqualToString:@"台湾省"] ||
                    [pname isEqualToString:@"香港特别行政区"] ||
                    [pname isEqualToString:@"澳门特别行政区"] ||
                    [pname isEqualToString:@"北京市"]||
                    [pname isEqualToString:@"天津市"] ||
                    [pname isEqualToString:@"上海市"] ||
                    [pname isEqualToString:@"重庆市"])
                {
                    option.city = [NSString stringWithFormat:@"%@,%@", self.shengName, self.quName];
                    if ([self.quName isEqualToString:@"市辖区"]) {
                        option.keyword = self.shengName;
                    }else {
                        option.keyword = self.quName;
                    }
                }else{
                    option.city = [NSString stringWithFormat:@"%@,%@", self.shiName, self.quName];
                    if ([self.quName isEqualToString:@"市辖区"]) {
                        option.keyword = self.shiName;
                    }else {
                        option.keyword = self.quName;
                    }
                }
            }

            
         BOOL isBool =  [self.poiSearch poiSearchInCity:option];
            
            [textField resignFirstResponder];
            [self missKeyBoard];
            [SVProgressHUD show];
        }
        return NO;
    }
    return YES;
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        SelectAddressViewController *vc = [SelectAddressViewController new];
        if (poiResult.poiInfoList.count > 0) {
            BMKPoiInfo *poiInfo = poiResult.poiInfoList[0];
            vc.centerCoordinate = poiInfo.pt;
        }
        //变动城市
        if (self.wp == 0) {
            if ([self.shengName isEqualToString:@"台湾省"] ||
                [self.shengName isEqualToString:@"香港特别行政区"] ||
                [self.shengName isEqualToString:@"澳门特别行政区"] ||
                [self.shengName isEqualToString:@"北京市"]||
                [self.shengName isEqualToString:@"天津市"] ||
                [self.shengName isEqualToString:@"上海市"] ||
                [self.shengName isEqualToString:@"重庆市"]){
                vc.selectCity = self.shengName;
            }else{
                vc.selectCity = self.shiName;
                vc.currentCity = self.quName;
            }
        }else if (self.wp == 2){
            NSString *pname = self.dataDic[@"province_name"];
            NSString *sname = self.dataDic[@"city_name"];
            if ([pname isEqualToString:@"台湾省"] ||
                [pname isEqualToString:@"香港特别行政区"] ||
                [pname isEqualToString:@"澳门特别行政区"] ||
                [pname isEqualToString:@"北京市"]||
                [pname isEqualToString:@"天津市"] ||
                [pname isEqualToString:@"上海市"] ||
                [pname isEqualToString:@"重庆市"]) {
                vc.selectCity = pname;
            }else{
                vc.selectCity = sname;
                vc.currentCity = self.quName;
            }
        }
        
        vc.sureSelectAddressBlock = ^ (BMKPoiInfo *poiInfo) {
            self.selectedCoordinate = poiInfo.pt;

            addressTextView.text = poiInfo.name;
            self.returnCity = poiInfo.city;
            
            //变动城市
            NSString *str;
            if (self.wp == 0) {
                if ([self.shengName isEqualToString:@"台湾省"] ||
                    [self.shengName isEqualToString:@"香港特别行政区"] ||
                    [self.shengName isEqualToString:@"澳门特别行政区"] ||
                    [self.shengName isEqualToString:@"北京市"]||
                    [self.shengName isEqualToString:@"天津市"] ||
                    [self.shengName isEqualToString:@"上海市"] ||
                    [self.shengName isEqualToString:@"重庆市"]) {
                    str = self.shengName;
                }else{
                    str = self.shiName;
                }
            }else if (self.wp == 2){
                NSString *pname = self.dataDic[@"province_name"];
                NSString *sname = self.dataDic[@"city_name"];
                if ([pname isEqualToString:@"台湾省"] ||
                    [pname isEqualToString:@"香港特别行政区"] ||
                    [pname isEqualToString:@"澳门特别行政区"] ||
                    [pname isEqualToString:@"北京市"]||
                    [pname isEqualToString:@"天津市"] ||
                    [pname isEqualToString:@"上海市"] ||
                    [pname isEqualToString:@"重庆市"])
                {
                    str = pname;
                }else{
                    str = sname;
                }
            }


            if (![str containsString:poiInfo.city]) {
                [SVProgressHUD showErrorWithStatus:@"您选择的详细地址与门店地址不在同一城市，请确认!"];
                self.isSame = NO;
            }else {
                self.isSame = YES;
            }
        };
        
        [self.navigationController pushViewController:vc animated:YES];

    }else {
        DLog(@"抱歉，未找到结果");
    }
    [SVProgressHUD dismiss];
}

#pragma mark - UIPickerView的创建
- (void)creatPickView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _backView.backgroundColor = MONEY_COLOR;
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickerView)];
    [_backView addGestureRecognizer:tap];
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 260)];
    [_backView addSubview:_areaView];
    
    //添加关闭和完成的视图
    UIView * fiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    fiView.backgroundColor = WHITE_COLOR;
    [_areaView addSubview:fiView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorFromHexCode:@"c8c8c8"];
    [_areaView addSubview:line];
    //关闭
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(0, 5, 80, 33);
    [closeButton setTitleColor:[UIColor colorFromHexCode:@"969696"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [fiView addSubview:closeButton];
    
    //完成
    UIButton * finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
    finishButton.frame = CGRectMake(UI_SCREEN_WIDTH - 110, 5, 102, 33);
    [finishButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
    
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishChose) forControlEvents:UIControlEventTouchUpInside];
    [fiView addSubview:finishButton];
    
    
    self.areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, UI_SCREEN_WIDTH, 168)];
    _areaPickerView.dataSource = self;
    _areaPickerView.delegate = self;
    _areaPickerView.backgroundColor = WHITE_COLOR;
    [_areaView addSubview:_areaPickerView];
    
}

-(void)finishChose
{
    if (self.wp == 0) {
        _areaAllLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.shengName,self.shiName,self.quName];
        [self hidePickerView];
    }else if (self.wp == 2){
        _areaAllLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.shengName,self.shiName,self.quName];
        [self hidePickerView];
    }
    
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return provinces.count;
    }
    else if (component == 1)
    {
        return cities.count;
    }
    else if( component == 2)
    {
        return areas.count;
    }
    
    return 0;
}

//将数据显示到pickerView上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (component == 0)
    {
        return [NSString stringWithFormat:@"%@", ((AddressModel *)[provinces objectAtIndex:row]).name];
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"%@", ((AddressModel *)[cities objectAtIndex:row]).name];
    }
    else if (component == 2)
    {
        return [NSString stringWithFormat:@"%@", ((AddressModel *)[areas objectAtIndex:row]).name];
    }
    
    return @"";
}

//改变pickView上的字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        AddressModel *provinceModel = [provinces objectAtIndex:row];
        cities = provinceModel.sonAddressArray;
        DLog(@"%@",cities);
        self.shengName = [NSString stringWithFormat:@"%@", provinceModel.name];
        self.shengId = [[NSString stringWithFormat:@"%@", provinceModel.majorID] intValue];
        
        if (cities.count > 0)
        {
            [pickerView selectRow:0 inComponent:1 animated:NO];
            areas = ((AddressModel *)[cities objectAtIndex:0]).sonAddressArray;
            if (areas.count > 0)
            {
                self.quName = [NSString stringWithFormat:@"%@", ((AddressModel *)[areas objectAtIndex:0]).name];
                self.quId = [((AddressModel *)[areas objectAtIndex:0]).majorID intValue];
                [pickerView selectRow:0 inComponent:2 animated:NO];
            }
            self.shiName = [NSString stringWithFormat:@"%@", ((AddressModel *)[cities objectAtIndex:0]).name];
            self.shiId = [((AddressModel *)[cities objectAtIndex:0]).majorID intValue];
        }
        else if (cities.count == 0)
        {
            self.shiName = [NSString stringWithFormat:@""];
            self.quName = [NSString stringWithFormat:@""];
            self.shiId = 0;
            self.quId = 0;
            areas = nil;
        }
        [self.areaPickerView reloadComponent:1];
        [self.areaPickerView reloadComponent:2];
    }
    else if (component == 1 && row < cities.count)
    {
        AddressModel *cityModel = [cities objectAtIndex:row];
        areas = cityModel.sonAddressArray;
        [self.areaPickerView reloadComponent:2];
        self.shiName = [NSString stringWithFormat:@"%@", cityModel.name];
        self.shiId = [cityModel.majorID intValue];
        
        if (areas.count > 0)
        {
            [pickerView selectRow:0 inComponent:2 animated:NO];
            [self.areaPickerView reloadComponent:2];
            self.quId = [((AddressModel *)[areas objectAtIndex:0]).majorID intValue];
            self.quName = [NSString stringWithFormat:@"%@", ((AddressModel *)[areas objectAtIndex:0]).name];
        }
        else if (areas.count == 0)
        {
            self.quName = [NSString stringWithFormat:@""];
        }
    }
    else if (component == 2 && row < areas.count)
    {
        self.quName = [NSString stringWithFormat:@"%@", ((AddressModel *)[areas objectAtIndex:row]).name];
    }
    
    
    if (self.returnCity) {
        //变动城市
        NSString *str;
        if (self.wp == 0) {
            if ([self.shengName isEqualToString:@"台湾省"] ||
                [self.shengName isEqualToString:@"香港特别行政区"] ||
                [self.shengName isEqualToString:@"澳门特别行政区"] ||
                [self.shengName isEqualToString:@"北京市"]||
                [self.shengName isEqualToString:@"天津市"] ||
                [self.shengName isEqualToString:@"上海市"] ||
                [self.shengName isEqualToString:@"重庆市"])
            {
                str = self.shengName;
            }else{
                str = self.shiName;
            }
        }else if (self.wp == 2){
            
            NSString *pname = self.dataDic[@"province_name"];
            NSString *sname = self.dataDic[@"city_name"];
            if ([pname isEqualToString:@"台湾省"] ||
                [pname isEqualToString:@"香港特别行政区"] ||
                [pname isEqualToString:@"澳门特别行政区"] ||
                [pname isEqualToString:@"北京市"]||
                [pname isEqualToString:@"天津市"] ||
                [pname isEqualToString:@"上海市"] ||
                [pname isEqualToString:@"重庆市"])
            {
                str = self.shengName;
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
                dic[@"province_name"] = self.shengName;
                dic[@"city_name"] = self.shiName;
                self.dataDic = dic;
            }else{
                str = self.shiName;
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
                dic[@"province_name"] = self.shengName;
                dic[@"city_name"] = self.shiName;
                self.dataDic = dic;
            }
        }
        
        if ([str containsString:self.returnCity]) {
            _isSame = YES;
        }else {
            _isSame = NO;
        }
    }else {
        NSString *str;
        NSString *selectStr;
        if (self.wp == 2){
            NSString *pname = self.dataDic[@"province_name"];
            NSString *sname = self.dataDic[@"city_name"];
            if ([pname isEqualToString:@"台湾省"] ||
                [pname isEqualToString:@"香港特别行政区"] ||
                [pname isEqualToString:@"澳门特别行政区"] ||
                [pname isEqualToString:@"北京市"]||
                [pname isEqualToString:@"天津市"] ||
                [pname isEqualToString:@"上海市"] ||
                [pname isEqualToString:@"重庆市"])
            {
                str = pname;
                
            }else{
                str = sname;
            }
            self.returnCity = str;
            if ([self.shengName isEqualToString:@"台湾省"] ||
                [self.shengName isEqualToString:@"香港特别行政区"] ||
                [self.shengName isEqualToString:@"澳门特别行政区"] ||
                [self.shengName isEqualToString:@"北京市"]||
                [self.shengName isEqualToString:@"天津市"] ||
                [self.shengName isEqualToString:@"上海市"] ||
                [self.shengName isEqualToString:@"重庆市"])
            {
                selectStr = self.shengName;
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
                dic[@"province_name"] = self.shengName;
                dic[@"city_name"] = self.shiName;
                self.dataDic = dic;
            }else{
                selectStr = self.shiName;
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
                dic[@"province_name"] = self.shengName;
                dic[@"city_name"] = self.shiName;
                self.dataDic = dic;
            }

            if ([selectStr containsString:self.returnCity]) {
                _isSame = YES;
            }else {
                _isSame = NO;
            }
        }
    }
}

#pragma mark - 弹出和消失PickerView
- (void)popPickerView
{
    [self.view endEditing:YES];
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 260, UI_SCREEN_WIDTH, 260);
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 260);
    [UIView commitAnimations];
    
    [self performSelector:@selector(back) withObject:nil afterDelay:0.3];
    
}
- (void)back
{
    self.backView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
}

#pragma mark - HTTP Request


-(void)postUpAddAdr
{
    [SVProgressHUD show];
    NSString*body;
    NSString *lat = [NSString stringWithFormat:@"%f",self.selectedCoordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f",self.selectedCoordinate.longitude];
    if ([self.shengName isEqualToString:@"台湾省"] ||
        [self.shengName isEqualToString:@"香港特别行政区"] ||
        [self.shengName isEqualToString:@"澳门特别行政区"])
    {
        body = [NSString stringWithFormat:@"&act=add&area_name=%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d&house_number=%@&latitude=%@&longitude=%@",self.shengName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shengId,self.shengId,self.isDefult,addressTextfield.text,lat,lng];
    }
    else
    {
        body=[NSString stringWithFormat:@"&act=add&area_name=%@%@%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d&h5_uid=1409&house_number=%@&latitude=%@&longitude=%@", self.shengName, self.shiName, self.quName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shiId,self.quId,self.isDefult,addressTextfield.text,lat,lng];
    }
    NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

- (void)postEditAdr:(int)isDefult {
    [SVProgressHUD show];
    NSString *body;
    NSString *lat = [NSString stringWithFormat:@"%f",self.selectedCoordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f",self.selectedCoordinate.longitude];

    body = [NSString stringWithFormat:@"&act=edit&contact_id=%d&area_name=%@%@%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d&house_number=%@&latitude=%@&longitude=%@",self.adrId,self.shengName, self.shiName, self.quName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shiId,self.quId,isDefult,addressTextfield.text,lat,lng];
    
    NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
            DLog(@"修改成功~~");
            [SVProgressHUD dismiss];
            if(self.myBlock) {
                NSDictionary *dataDic = @{@"area_name" : [NSString stringWithFormat:@"%@%@%@", self.shengName, self.shiName,            self.quName],
                                          @"phone_num" : self.phoneTf.text,
                                          @"contact_name" : self.nameTf.text,
                                          @"address" : addressTextView.text,
                                          @"area_id" : [NSString stringWithFormat:@"%d", self.quId],
                                          @"city_id" : [NSString stringWithFormat:@"%d", self.shiId],
                                          @"city_name" : self.shiName,
                                          @"province_id" : [NSString stringWithFormat:@"%d", self.shengId],
                                          @"province_name" : self.shengName,
                                          @"is_default" : [NSString stringWithFormat:@"%d", isDefult]};
                
                self.myBlock(self.currentIndex, dataDic);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}
@end
