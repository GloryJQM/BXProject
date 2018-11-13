//
//  ConfirmDetailVC.m
//  Lemuji
//
//  Created by gaojun on 15-7-15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ConfirmDetailVC.h"
#import "LogisticsDetailVC.h"
#import "GoodsListViewController.h"
#import "LogisticsDetailCell.h"
#import "ApplicationReturnsViewController.h"
#import <MapKit/MapKit.h>

@interface ConfirmDetailVC ()<UIActionSheetDelegate>

@property (nonatomic, strong)UILabel * jiaGeLabel;

@property (nonatomic, strong)UILabel * yunFeiLabel;

@property (nonatomic, strong)UILabel * yingpayLabel;

@property (nonatomic, strong)UIImageView * photoImageView;
@property (nonatomic, strong)UILabel * defultSignLabel;
@property (nonatomic, strong)UIView * photoView;

@property (nonatomic, strong) UILabel *applyApplicationReturnsLabel;
@property (nonatomic, strong) UILabel *applicationReturnsSuccessLabel;
@property (nonatomic, assign) CGFloat extraHeight;
@property (nonatomic, strong) UIImageView *applicationReturnsImageView;
@property (nonatomic, strong) UILabel *applicationReturnsLabel;

@property (nonatomic, strong) UIView *shopInfoView;
@property (nonatomic, assign) CLLocationCoordinate2D startCoor;
@property (nonatomic, assign) CLLocationCoordinate2D endCoor;
@property (nonatomic, copy)   NSString *locatedAddress;
@property (nonatomic, strong) UIView *addressView;
@property (nonatomic, assign) CLLocationCoordinate2D shopLocation;

@property (nonatomic, copy)   NSString *orderIDStr;
@property (nonatomic ,strong)  UITextField  *expressTimeField;

@end

@implementation ConfirmDetailVC
@synthesize allLOgisticView,upTipLabel,downTipLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单详情";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    self.allScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    self.allScrollView.scrollEnabled=NO;
    if (self.userInterfaceType == HaveConfirmUI)
    {
        self.allScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, self.allScrollView.frame.size.height*2);
    }
    else if (self.userInterfaceType == ApplicationReturnsUI)
    {
        self.allScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, self.allScrollView.frame.size.height);
    }
    [self.view addSubview:self.allScrollView];
    
    UIView * barLine = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    barLine.backgroundColor = LINE_DEEP_COLOR;
    [self.allScrollView addSubview:barLine];
    
    
    self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    _backView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    _backView.showsVerticalScrollIndicator=NO;
    _backView.alwaysBounceVertical=YES;
    _backView.delegate=self;
    
    
    upTipLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height, UI_SCREEN_WIDTH, 40)];
    upTipLabel.textColor=BLACK_COLOR;
    upTipLabel.font=[UIFont systemFontOfSize:15];
    upTipLabel.text=@"继续拖动查看商品详情";
    upTipLabel.textAlignment=NSTextAlignmentCenter;
    upTipLabel.backgroundColor=[UIColor clearColor];
    [_backView addSubview:upTipLabel];
    
    self.extraHeight = 0;
    [self creatView];
    [self creatAllLogisticsView];
    
    if (!self.tryOutDetailDic) {
        //我的订单
        [self postConfirmData];
    }else {
        //试用订单
        self.peopleLabel.text = [NSString stringWithFormat:@"%@",[self.tryOutDetailDic valueForKey:@"contact"]];
        self.phoneLabel.text = [NSString stringWithFormat:@"%@",[self.tryOutDetailDic valueForKey:@"phone"]];
        self.addressLabel.text = [NSString stringWithFormat:@"%@",[self.tryOutDetailDic valueForKey:@"address"]];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.tryOutDetailDic objectForKey:@"picurl"]]];
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 60, 60)];
        [self.photoImageView af_setImageWithURL:url];
        [_photoView addSubview:_photoImageView];
        self.jiaGeLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.tryOutDetailDic valueForKey:@"price"] floatValue]];
        self.yingpayLabel.text = @"￥0.00";
        
        self.TimeLabel.text = [NSString stringWithFormat:@"%@", [self.tryOutDetailDic objectForKey:@"create_time"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:self.TimeLabel.text.longLongValue];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.TimeLabel.text = [NSString stringWithFormat:@"下单时间:%@", [dateFormatter stringFromDate:confromTimesp]];
        [self postWuLiuInfo:YES];
        
    }
}
- (void)createBottomView {
    if (self.status == BottomViewStatusNone)  {
        return;
    }else if (self.status == BottomViewStatusDeleteAndService) {
        
//        UIButton* serviceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 47 - 64, UI_SCREEN_WIDTH/2.0, 47)];
//        serviceBtn.backgroundColor = [UIColor whiteColor];
//        [serviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [serviceBtn setTitle:@"申请退货" forState:UIControlStateNormal];
//        [serviceBtn addTarget:self action:@selector(confirmBack) forControlEvents:UIControlEventTouchUpInside];
//        serviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.view addSubview:serviceBtn];
//        
//        UIButton* removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0, UI_SCREEN_HEIGHT - 47 - 64, UI_SCREEN_WIDTH/2.0, 47)];
//        removeBtn.backgroundColor = App_Main_Color;
//        [removeBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
//        [removeBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [removeBtn addTarget:self action:@selector(goPayVC) forControlEvents:UIControlEventTouchUpInside];
//        removeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.view addSubview:removeBtn];
        
    }else  if (self.status == BottomViewStatusDelete) {
//        UIButton* removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 47 - 64, UI_SCREEN_WIDTH, 47)];
//        removeBtn.backgroundColor = App_Main_Color;
//        [removeBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
//        [removeBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [removeBtn addTarget:self action:@selector(goPayVC) forControlEvents:UIControlEventTouchUpInside];
//        removeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.view addSubview:removeBtn];
    }
    
}
-(void)confirmBack
{
    ApplicationReturnsViewController *vc=[[ApplicationReturnsViewController alloc] init];
    vc.returnMoney=self.returnMoneyString;
    vc.orderId=self.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goPayVC
{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"删除之后将无法恢复" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    sheet.tag=1000;
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( (actionSheet.tag==1000) && (buttonIndex == 0)) {
        [self postRemoveData];
        
    }
    if ( (actionSheet.tag==1001) && (buttonIndex == 0)) {
        [self postApplyBackCom];
        
    }
    
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

#pragma mark - 申请退货
-(void)postApplyBackCom
{
    NSString *reasonString=[NSString stringWithFormat:@"不想买了"];
    NSString *otherReasonString=[NSString stringWithFormat:@"我的原因"];
    
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=7&order_title=%@&reason=%@&other=%@",self.ID,reasonString,otherReasonString];
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
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
            [SVProgressHUD dismissWithSuccess:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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


-(void)postRemoveData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=3&order_title=%@",  self.order_str];
    
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
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
            [SVProgressHUD showSuccessWithStatus:@"删除成功"] ;
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


-(void)postConfirmData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=2&order_title=%@",  self.ID];
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
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
            NSDictionary * contentDic = [responseObject objectForKey:@"content"];
            
            self.returnStatus=[NSString stringWithFormat:@"%@", [contentDic objectForKey:@"back_status"]];
            self.returnStateString=[NSString stringWithFormat:@"%@", [contentDic objectForKey:@"is_pay_change"]];
            
            if ([self.returnStatus isEqualToString:@"0"]) {
                //可售后
                self.status = BottomViewStatusDeleteAndService;
                
            }else if ([self.returnStatus isEqualToString:@"1"])
            {
                //退货处理中 没有按钮
                self.status = BottomViewStatusNone;
                self.applicationReturnsLabel.text = @"退货处理中";
                self.allScrollView.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64);
                allLOgisticView.frame=CGRectMake(0, UI_SCREEN_HEIGHT-64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64);
            }
            else if ([self.returnStatus isEqualToString:@"2"])
            {
                //退货成功 只有删除按钮
                self.status = BottomViewStatusDelete;
                self.applicationReturnsLabel.text = @"退货成功";
                self.applicationReturnsImageView.image = [UIImage imageNamed:@"csl_backSuccessNew.png"];
                [self.applicationReturnsLabel superview].backgroundColor = [UIColor colorFromHexCode:@"67c920"];
            }
            else if ([self.returnStatus isEqualToString:@"3"])
            {
                //退货被拒绝 只有删除按钮
                self.status = BottomViewStatusDelete;
                self.applicationReturnsLabel.text = @"退货被拒绝";
                self.applicationReturnsImageView.image = [UIImage imageNamed:@"csl_backFail.png"];
                [self.applicationReturnsLabel superview].backgroundColor = [UIColor colorFromHexCode:@"f82b2b"];
            }
            if (self.isCustomerOrder) {
                self.status = BottomViewStatusNone;
            }
            //创建底部按钮
            [self createBottomView];
            
            if([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"content"] objectForKey:@"post_method"]] intValue] == 1)
            {
                
                
                _locatedAddress = [NSString stringWithFormat:@"%@", [contentDic valueForKey:@"address"]];
                if ([[contentDic objectForKey:@"position"] isKindOfClass:[NSNull class]]) {
                    _shopLocation.longitude = [[[contentDic objectForKey:@"position"] valueForKey:@"longitude"] doubleValue];
                    _shopLocation.latitude = [[[contentDic objectForKey:@"position"] valueForKey:@"latitude"] doubleValue];
                    
                }
                
                if (self.userInterfaceType == HaveConfirmUI)
                {
                    self.shopInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
                }else {
                    self.shopInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, UI_SCREEN_WIDTH, 90)];
                }
                [self.shopInfoView addTarget:self action:@selector(showNagivationView) forControlEvents:UIControlEventTouchUpInside];
                [self.addressView addSubview:self.shopInfoView];
            }
            
            self.orderIDStr =[NSString stringWithFormat:@"%@",[contentDic objectForKey:@"order_id"]];
            self.wuliuStr = [NSString stringWithFormat:@"%@",[contentDic objectForKey:@"wuliu_num"]];
            self.peopleLabel.text = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"contact_name"]];
            
            self.order_str = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"order_title"]];
            self.addressLabel.text = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"address"]];
            
            self.phoneLabel.text = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"phone_num"]];
            
            self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号:%@", [contentDic objectForKey:@"order_title"]];
            
            self.TimeLabel.text = [NSString stringWithFormat:@"下单时间:%@", [contentDic objectForKey:@"create_time"]];
            
            self.payType.text = [NSString stringWithFormat:@"支付方式:%@", [contentDic objectForKey:@"pay_method"]];
            
            if (self.userInterfaceType == ApplicationReturnsUI)
            {
                self.applicationReturnsSuccessLabel.hidden = NO;
                self.applicationReturnsSuccessLabel.text = [NSString stringWithFormat:@"成功退货时间:%@", [contentDic objectForKey:@"back_confirm_time"]];
                self.applyApplicationReturnsLabel.hidden = NO;
                self.applyApplicationReturnsLabel.text = [NSString stringWithFormat:@"申请退货时间:%@", [contentDic objectForKey:@"back_create_time"]];
                
                if (![self.returnStatus isEqualToString:@"2"]) {
                    
                    self.applicationReturnsSuccessLabel.hidden = YES;
                    self.heyueLabel.frame = CGRectMake(18, CGRectGetMaxY(self.applyApplicationReturnsLabel.frame) + 8, 200, 15);
                    self.faPiaoLabel.frame = CGRectMake(18, CGRectGetMaxY(_heyueLabel.frame) + 8, UI_SCREEN_WIDTH - 36, 15);
                }
                
                if ([self.returnStatus isEqualToString:@"3"])
                {
                    self.applicationReturnsSuccessLabel.text = [NSString stringWithFormat:@"退货被拒时间:%@", [contentDic objectForKey:@"back_confirm_time"]];
                    self.applicationReturnsSuccessLabel.hidden = NO;
                }
                
                
                self.yingBackMoney.text = [NSString stringWithFormat:@"￥%@", [contentDic objectForKey:@"actual_pay_money"]];
            }
            
            /*海淘商品,实名认证*/
            NSString *personverifyName = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"personverify_name"]];
            NSString *personverifyIDCard = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"personverify_IDCard"]];
            if ([personverifyName isValid] && [personverifyIDCard isValid]) {
                self.heyueLabel.text = [NSString stringWithFormat:@"真实姓名:%@",personverifyName];
                self.faPiaoLabel.text = [NSString stringWithFormat:@"身份证号:%@",personverifyIDCard];
            }
            /*****--分割--****/
            
            self.jiaGeLabel.text = [NSString stringWithFormat:@"￥%@", [contentDic objectForKey:@"total_price"]];
            if ([[NSString stringWithFormat:@"%@",[contentDic objectForKey:@"order_freight"]] isEqualToString:@""]) {
                self.yunFeiLabel.text = @"￥0";
            }else{
                self.yunFeiLabel.text = [NSString stringWithFormat:@"￥%@", [contentDic objectForKey:@"order_freight"]];
            }
            
            self.yingpayLabel.text = [NSString stringWithFormat:@"￥%@", [contentDic objectForKey:@"actual_pay_money"]];
            self.goodNumLabel.text = [NSString stringWithFormat:@"共%@件",[contentDic objectForKey:@"total_number"]];
            self.returnMoneyString=[NSString stringWithFormat:@"%@", [contentDic objectForKey:@"actual_pay_money"]];
            NSArray * totalNumArray = [contentDic objectForKey:@"goodsinfo"];
            [self addView:totalNumArray];
            
            self.tempArray =  [contentDic objectForKey:@"goodsinfo"];
            
            NSString * _timeSp=[NSString stringWithFormat:@"%@",[contentDic objectForKey:@"post_time"]];
            if (![_timeSp isEqualToString:@"0"] && [_timeSp isValid] ) {
                _expressTimeField.text = _timeSp;
            }else{
                _expressTimeField.text = @"未指定送货时间";
                _expressTimeField.textColor = [UIColor colorFromHexCode:@"8e8e93"];
            }
            [self postWuLiuInfo:NO];
            
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

- (void)creatTopView
{
    UIView * topView = [[UIView alloc] init];
    if (self.userInterfaceType == HaveConfirmUI)
    {
        topView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 90);
    }
    else
    {
        self.extraHeight = 33;
        topView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 90 + self.extraHeight);
        UIView * waitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 34)];
        waitView.backgroundColor = App_Main_Color;
        [topView addSubview:waitView];
        
        self.applicationReturnsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 20, 20)];
        [waitView addSubview:self.applicationReturnsImageView];
        self.applicationReturnsImageView.image = [UIImage imageNamed:@"iconfont-daifukuandingdan.png"];
        
        self.applicationReturnsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, UI_SCREEN_WIDTH - 40, 16)];
        self.applicationReturnsLabel.font = [UIFont systemFontOfSize:14];
        self.applicationReturnsLabel.textColor = [UIColor whiteColor];
        self.applicationReturnsLabel.textAlignment = NSTextAlignmentLeft;
        [waitView addSubview:self.applicationReturnsLabel];
        
    }
    [_backView addSubview:topView];
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_adr1.png"]];
    leftImageView.frame = CGRectMake(9, 17 + self.extraHeight, 20, 20);
    [topView addSubview:leftImageView];
    
    self.peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 17 + self.extraHeight, 120, 15)];
    self.peopleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:_peopleLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-120-38, 17 + self.extraHeight, 120, 15)];
    _phoneLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:_phoneLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 36 + self.extraHeight, UI_SCREEN_WIDTH-38*2, 50)];
    _addressLabel.font = [UIFont systemFontOfSize:12];
    _addressLabel.numberOfLines = 0;
    [topView addSubview:_addressLabel];
    self.addressView = topView;
    
}

- (void)creatMiddleView
{
    self.middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 98 + self.extraHeight, UI_SCREEN_WIDTH, 375)];
    [_backView addSubview:_middleView];
    
    CGFloat startOriginX = 70;
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 70)];
    timeView.backgroundColor = WHITE_COLOR;
    [_middleView addSubview:timeView];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake( 15, 5, 200.0, 20.0)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"送货时间";
    label3.font = LMJ_CT 14];
    label3.textColor = [UIColor colorFromHexCode:@"#505059"];
    [timeView addSubview:label3];
    
    
    _expressTimeField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label3.frame)+5, UI_SCREEN_WIDTH-30, 30.0f)];
    _expressTimeField.placeholder = @"请选择送货时间";
    //    _expressTimeField.inputAccessoryView=[self setToolBar:200];
    //    _expressTimeField.inputView = _datePicker;
    _expressTimeField.enabled = NO;
    [_expressTimeField setBorderStyle:UITextBorderStyleNone];
    _expressTimeField.layer.borderColor = [[UIColor colorFromHexCode:@"#ffffff"] CGColor];
    [timeView addSubview:_expressTimeField];
    
    UIView * goodView = [[UIView alloc] initWithFrame:CGRectMake(0, startOriginX+0, UI_SCREEN_WIDTH, 34)];
    goodView.backgroundColor = NAVI_COLOR;
    [_middleView addSubview:goodView];
    
    UIImageView * leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-qingdantianbao.png"]];
    leftView.frame = CGRectMake(14, 8, 19, 22);
    [goodView addSubview:leftView];
    
    UILabel * goodListView = [[UILabel alloc] initWithFrame:CGRectMake(36, 10, 80, 15)];
    goodListView.text = @"商品清单";
    
    goodListView.font = [UIFont systemFontOfSize:14];
    [goodView addSubview:goodListView];
    
    self.photoView = [[UIView alloc] initWithFrame:CGRectMake(0, startOriginX+34, UI_SCREEN_WIDTH, 95)];
    _photoView.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:_photoView];
    
    
    self.goodNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-15-5-85, 35, 80, 20)];
    _goodNumLabel.text = @"共1件";
    _goodNumLabel.font = LMJ_XT 14];
    _goodNumLabel.textAlignment = NSTextAlignmentRight;
    _goodNumLabel.textColor = BLACK_COLOR;
    [_photoView addSubview:_goodNumLabel];
    
    UIImageView * nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_jt_right.png"]];
    nextImageView.frame = CGRectMake(UI_SCREEN_WIDTH-10-5, 40, 5, 8);
    [_photoView addSubview:nextImageView];
    
    UIView * moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, startOriginX+128, UI_SCREEN_WIDTH, 105)];
    moneyView.backgroundColor = MONEY_COLOR;
    [_middleView addSubview:moneyView];
    
    NSArray * titleArray = @[@"商品价格", @"运费", @"应付款"];
    NSArray * moArray = @[@"¥0.00", @"¥0.00", @"¥0.00"];
    float disHeight=0;
    if(self.userInterfaceType==ApplicationReturnsUI){
        titleArray = @[@"商品价格", @"运费", @"应付款", @"应退款"];
        moArray = @[@"¥0.00", @"¥0.00", @"¥0.00", @"¥0.00"];
        disHeight=35;
        moneyView.frame=CGRectMake(0, 128, UI_SCREEN_WIDTH, 140);
    }
    if(self.tryOutDetailDic != nil) {
        titleArray = @[@"商品价格", @"应付款"];
        moArray = @[@"¥0.00", @"¥0.00"];
        moneyView.frame=CGRectMake(0, 128, UI_SCREEN_WIDTH, 70);
    }else  {
        UITapGestureRecognizer * goodListTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gogoodList)];
        
        [_photoView addGestureRecognizer:goodListTap];
    }
    for (int i = 0; i < titleArray.count; i++) {
        UILabel * tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 13 + 35 * i, 70, 19)];
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(230* adapterFactor, 13 + 35 * i, 80* adapterFactor, 19)];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont systemFontOfSize:13];
        
        _moneyLabel.text = [moArray objectAtIndex:i];
        tiLabel.text = [titleArray objectAtIndex:i];
        tiLabel.font = [UIFont systemFontOfSize:13];
        [moneyView addSubview:_moneyLabel];
        [moneyView addSubview:tiLabel];
        
        
        if (i == 0) {
            self.jiaGeLabel = _moneyLabel;
        }
        if (i == 1) {
            self.yunFeiLabel = _moneyLabel;
        }
        if (i == 2) {
            if (self.userInterfaceType==HaveConfirmUI) {
                _moneyLabel.textColor = App_Main_Color;
            }
            _yingpayLabel = _moneyLabel;
        }
        if(i==3){
            
            _moneyLabel.textColor = App_Main_Color;
            _yingBackMoney = _moneyLabel;
        }
    }
    
    self.orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, startOriginX+242+disHeight, 250, 15)];
    _orderNumLabel.text = @"订单编号:";
    _orderNumLabel.font = [UIFont systemFontOfSize:12];
    [_middleView addSubview:_orderNumLabel];
    
    self.TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.orderNumLabel.frame) + 8, 250, 15)];
    _TimeLabel.text = @"下单时间:";
    _TimeLabel.font = [UIFont systemFontOfSize:12];
    
    [_middleView addSubview:_TimeLabel];
    
    self.payType = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.TimeLabel.frame) + 8, 200, 15)];
    self.payType.text = @"支付方式:";
    [_middleView addSubview:_payType];
    _payType.font = [UIFont systemFontOfSize:12];
    
    
    if (self.tryOutDetailDic != nil) {
        _orderNumLabel.hidden = YES;
        _payType.hidden = YES;
        _TimeLabel.frame = CGRectMake(18, 242+disHeight-30, 250, 15);
    }
    
    
    
    self.applyApplicationReturnsLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.payType.frame) + 8, 200, 15)];
    self.applyApplicationReturnsLabel.text = @"申请退货时间:";
    [_middleView addSubview:self.applyApplicationReturnsLabel];
    self.applyApplicationReturnsLabel.font = [UIFont systemFontOfSize:12];
    self.applyApplicationReturnsLabel.hidden = YES;
    
    self.applicationReturnsSuccessLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.applyApplicationReturnsLabel.frame) + 8, 200, 15)];
    self.applicationReturnsSuccessLabel.text = @"成功退货时间:";
    [_middleView addSubview:self.applicationReturnsSuccessLabel];
    self.applicationReturnsSuccessLabel.font = [UIFont systemFontOfSize:12];
    self.applicationReturnsSuccessLabel.hidden = YES;
    
    CGFloat offY = 0;
    if (self.userInterfaceType == ApplicationReturnsUI)
    {
        offY = CGRectGetMaxY(self.applicationReturnsSuccessLabel.frame);
    }else {
        offY = CGRectGetMaxY(self.payType.frame);
    }
    self.heyueLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, offY + 8, 200, 15)];
    [_middleView addSubview:_heyueLabel];
    _heyueLabel.font = [UIFont systemFontOfSize:12];
    
    self.faPiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(_heyueLabel.frame) + 8, UI_SCREEN_WIDTH - 36, 15)];
    [_middleView addSubview:_faPiaoLabel];
    _faPiaoLabel.font = [UIFont systemFontOfSize:12];
    
    CGRect frame = _middleView.frame;
    frame.size.height = CGRectGetMaxY(_faPiaoLabel.frame);
    _middleView.frame = frame;
    
    
    if (self.userInterfaceType == ApplicationReturnsUI)
    {
        _backView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, _middleView.frame.size.height+_middleView.frame.origin.y+200);
        upTipLabel.frame=CGRectMake(upTipLabel.frame.origin.x, _backView.contentSize.height+10, upTipLabel.frame.size.width, upTipLabel.frame.size.height);
    }
    
    
}
- (void)addView:(NSArray *)array
{
    NSInteger num = array.count;
    if (array.count > 3) {
        num = 3;
        
        UILabel *andSoOn = [[UILabel alloc] initWithFrame:CGRectMake(10 + 60 * 3, 19.5+35/2, 55, 20)];
        andSoOn.text = @". . 等";
        andSoOn.textColor = [UIColor blackColor];
        andSoOn.textAlignment = NSTextAlignmentCenter;
        andSoOn.font = [UIFont systemFontOfSize:14];
        [_photoView addSubview:andSoOn];
        
    }
    for (int i = 0; i < num; i++) {
        
        NSDictionary * dic = [array objectAtIndex:i];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 60 * i, 19.5, 55, 55)];
        [self.photoImageView af_setImageWithURL:url];
        [_photoView addSubview:_photoImageView];
    }
}

- (void)gogoodList
{
    GoodsListViewController * goodVC = [[GoodsListViewController  alloc] init];
    [self.navigationController pushViewController:goodVC animated:YES];
    goodVC.goodsListArray = self.tempArray;
    goodVC.guigeArr = self.tempArray;
}

- (void)creatView
{
    [self.allScrollView addSubview:self.backView];
    [self creatTopView];
    [self creatMiddleView];
    
    //试用申请暂时隐藏确认收货
    
    //    if (self.tryOutDetailDic)
    //    {
    //        [self creatLogisticsView];
    //    }
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 90 + self.extraHeight, UI_SCREEN_WIDTH, 0.5)];
    topLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 98.5 + self.extraHeight, UI_SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 90.5 + self.extraHeight, UI_SCREEN_WIDTH, 8)];
    littleView.backgroundColor = MONEY_COLOR;
    [_backView addSubview:littleView];
    [_backView addSubview:topLine];
    [_backView addSubview:bottomLine];
    
}

//物流信息
- (void)creatLogisticsView
{
    self.logisticsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame), UI_SCREEN_WIDTH, 40)];
    self.logisticsView.backgroundColor = MONEY_COLOR;
    [_backView addSubview:_logisticsView];
    
    _backView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, CGRectGetMaxY(self.logisticsView.frame)+200);
    
    upTipLabel.frame=CGRectMake(0, _backView.contentSize.height+4, UI_SCREEN_WIDTH, 40);
    
    UIImageView * logImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-wuliu.png"]];
    logImageView.frame = CGRectMake(14, 10, 20, 20);
    [_logisticsView addSubview:logImageView];
    
    UILabel * logLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logImageView.frame) + 10, 10, 80, 20)];
    logLabel.text = @"物流信息";
    logLabel.font = [UIFont systemFontOfSize:14];
    [_logisticsView addSubview:logLabel];
    
    UIImageView *rightView = [[UIImageView alloc] init];
    rightView.frame = CGRectMake(UI_SCREEN_WIDTH-30, 16, 15.2, 8);
    rightView.transform = CGAffineTransformMakeRotation(90*M_PI/180);
    rightView.image = [[UIImage imageNamed:@"home_up.png"] imageWithColor:LINE_DEEP_COLOR];
    [_logisticsView addSubview:rightView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLogDetail)];
    [_logisticsView addGestureRecognizer:tap];
    
}
- (void)goLogDetail
{
    LogisticsDetailVC * logDVC = [[LogisticsDetailVC alloc] init];
    logDVC.orderStr=self.orderIDStr;
    logDVC.OID=self.order_str;
    if (self.tryOutDetailDic != nil) {
        logDVC.isTry = YES;
        logDVC.tryID = [NSString stringWithFormat:@"%@",[self.tryOutDetailDic valueForKey:@"id"]];
    }
    [self.navigationController pushViewController:logDVC animated:YES];
    
}

#pragma mark - 地图相关的方法
- (void)showNagivationView
{
    NSString *gps=[[PreferenceManager sharedManager] preferenceForKey:@"gps"];
    NSArray *tempGps=[gps componentsSeparatedByString:@","];
    if (tempGps.count==2)
    {
        CLLocationCoordinate2D from;
        from.longitude=[[tempGps objectAtIndex:0] doubleValue];
        from.latitude=[[tempGps objectAtIndex:1] doubleValue];
        
        [self navFrom:from toLocation:_shopLocation];
    }
}

-(void)navFrom:(CLLocationCoordinate2D )froml  toLocation:(CLLocationCoordinate2D)toLocation{
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

-(void)guide:(NSInteger)mapType{
    CLLocationCoordinate2D startCoor =self.startCoor ;
    CLLocationCoordinate2D endCoor = self.endCoor;
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
    if (mapType==2) {
        if(C_IOS7){
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
            toLocation.name = _locatedAddress;
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }
    }
    
    if (mapType==3) {
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=0",AppScheme,AppScheme,[NSString stringWithFormat:@"%f",endCoor.latitude],[NSString stringWithFormat:@"%f",endCoor.longitude]];
        NSLog(@"usrlString:%@",urlString);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

#pragma mark - 物流模块
- (void)creatAllLogisticsView
{
    allLOgisticView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    allLOgisticView.delegate=self;
    allLOgisticView.alwaysBounceVertical=YES;
    allLOgisticView.backgroundColor=[UIColor clearColor];
    [self.allScrollView addSubview:allLOgisticView];
    
    downTipLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, -40, UI_SCREEN_WIDTH, 40)];
    downTipLabel.textColor=BLACK_COLOR;
    downTipLabel.font=[UIFont systemFontOfSize:15];
    downTipLabel.text=@"继续拖动回到顶部";
    downTipLabel.textAlignment=NSTextAlignmentCenter;
    downTipLabel.backgroundColor=[UIColor clearColor];
    [allLOgisticView addSubview:downTipLabel];
    
    self.logisticsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 138, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 138 - 47 - 64)];
    self.logisticsTableView.delegate = self;
    self.logisticsTableView.dataSource = self;
    self.logisticsTableView.scrollEnabled=NO;
    self.logisticsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [allLOgisticView addSubview:self.topView];
    [allLOgisticView addSubview:self.logisticsTableView];
    [allLOgisticView addSubview:self.typeView];
    
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 90, UI_SCREEN_WIDTH, 0.5)];
    topLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 98.5, UI_SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 90.5, UI_SCREEN_WIDTH, 8)];
    littleView.backgroundColor = MONEY_COLOR;
    
    
    [allLOgisticView addSubview:littleView];
    [allLOgisticView addSubview:topLine];
    [allLOgisticView addSubview:bottomLine];
}


-(UIView *)typeView
{
    if (_typeView == nil) {
        self.typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 98, UI_SCREEN_WIDTH, 40)];
        UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 13, 100, 16)];
        typeLabel.text = @"物流状态";
        typeLabel.font = [UIFont systemFontOfSize:14];
        [_typeView addSubview:typeLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(typeLabel.frame) + 10, UI_SCREEN_WIDTH - 24, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [_typeView addSubview:line];
    }
    return _typeView;
}

- (UIView *)topView
{
    if (_topView == nil) {
        
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
        
        
        self.logisticsLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_layer11.png"] ];
        self.logisticsLogo.frame = CGRectMake(9, 17, 40, 40);
        [_topView addSubview:self.logisticsLogo];
        
        self.titleArr = @[@"", @"运单编号:"];
        for (int i = 0; i < _titleArr.count; i++) {
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(52, 17 + 20 * i, 180, 15)];
            label.text =  [_titleArr objectAtIndex:i];
            [_topView addSubview:label];
            
            if (i == 0) {
                label.font = [UIFont systemFontOfSize:14];
                self.wuliuCompanyLabel=label;
            }
            
            if (i == 1) {
                self.logisticaNum = [[UILabel alloc] initWithFrame:CGRectMake(120, 37, 200, 15)];
                _logisticaNum.text = self.wuliuStr;
                [_topView addSubview:_logisticaNum];
                label.font = [UIFont systemFontOfSize:14];
                
            }
        }
    }
    return _topView;
}



#pragma mark - 物流接口
-(void)postWuLiuInfo:(BOOL)isTryOut
{
    NSString*body=@"";
    if (isTryOut == YES) {
        body=[NSString stringWithFormat:@"&type=try&id=%@", [self.tryOutDetailDic valueForKey:@"id"]];
    }else {
        body=[NSString stringWithFormat:@"&order=%@", self.orderIDStr];
    }
    NSString *str=MOBILE_SERVER_URL(@"express.php");
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
            _logisticsInfoArray = [responseObject objectForKey:@"data"];
            UIFont *font = [UIFont systemFontOfSize:15.0];
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                        forKey:NSFontAttributeName];
            _textHeightArray=[[NSMutableArray alloc] initWithCapacity:0];
            float height=0;
            for (int i = 0; i < _logisticsInfoArray.count; i++) {
                
                NSAttributedString *platFormstr = [[NSAttributedString alloc] initWithString:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"context"] attributes:attrsDictionary];
                CGRect paragraphRect =
                [platFormstr boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, CGFLOAT_MAX)
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                          context:nil];
                
                NSAttributedString *platFormstr1 = [[NSAttributedString alloc] initWithString:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"ftime"] attributes:attrsDictionary];
                
                CGRect paragraphRect1 =
                [platFormstr1 boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           context:nil];
                
                [_textHeightArray addObject:[[NSNumber alloc] initWithDouble:paragraphRect1.size.height + paragraphRect.size.height]];
                
                height += paragraphRect1.size.height + paragraphRect.size.height;
            }
            
            self.logisticsTableView.frame= CGRectMake(0, 138, UI_SCREEN_WIDTH, height+30+138);
            allLOgisticView.contentSize=CGSizeMake(UI_SCREEN_WIDTH,CGRectGetMaxY(self.logisticsTableView.frame));
            /*  暂时后台未传
             if ([[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"ischeck"]] isEqualToString:@"1"])
             {
             self.statusLabel.text = @"签收成功";
             }
             else
             {
             self.statusLabel.text = @"待签收";
             }
             */
            
            [self.logisticsLogo af_setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"picurl"]]];
            self.logisticaNum.text=self.wuliuStr;
            self.wuliuCompanyLabel.text=[responseObject valueForKey:@"com"];
            
            [self.logisticsTableView reloadData];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                
            }else{
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}


#pragma mark - scorllview动画处理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_backView) {
        if (scrollView.contentOffset.y>_backView.contentSize.height-_backView.frame.size.height+30) {
            upTipLabel.text=@"松开查看物流";
        }else{
            upTipLabel.text=@"继续上拉查看物流";
        }
    }
    if (scrollView==allLOgisticView) {
        if (scrollView.contentOffset.y<-30) {
            downTipLabel.text=@"松开回到顶部";
        }else{
            downTipLabel.text=@"继续下拉回到顶部";
        }
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView==_backView)
    {
        if (scrollView.contentOffset.y>_backView.contentSize.height-_backView.frame.size.height+30) {
            [self.allScrollView setContentOffset:CGPointMake(0, self.allScrollView.frame.size.height) animated:YES];
        }
    }
    if (scrollView==allLOgisticView) {
        if (scrollView.contentOffset.y<-30) {
            [self.allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logisticsInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* logisticsInfoCellName = @"logisticsInfoCell";
    LogisticsDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:logisticsInfoCellName];
    if(cell == nil)
    {
        cell = [[LogisticsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logisticsInfoCellName];
        
    }
    
    cell.mainInfoLabel.text = [[_logisticsInfoArray objectAtIndex:indexPath.row] objectForKey:@"context"];
    cell.timeInfoLabel.text = [[_logisticsInfoArray objectAtIndex:indexPath.row] objectForKey:@"ftime"];
    cell.isLastStatus = (indexPath.row == 0);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[_textHeightArray objectAtIndex:indexPath.row] doubleValue] + 20;
}


@end
