//
//  WaitViewController.m
//  Lemuji
//
//  Created by gaojun on 15-7-14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

typedef NS_ENUM(NSUInteger, PayMehod)
{
    PayMehodNone = 0,
    PayMehodAliPay,
    PayMehodAliPayAndBalancePay,
    PayMehodBalancePay,
    PayMehodWxPayAndBalancePay,
    PayMehodWxPay
};

#import "WaitViewController.h"
#import "LogisticsDetailVC.h"
#import "LogisticsDetailVC.h"
#import "GoodsListViewController.h"
#import "AuthenticationPwdView.h"
#import "AlixPayResult.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PayViewController.h"
#import "SetSecretViewController.h"
#import "PayFinishViewController.h"
#import <MapKit/MapKit.h>
#import "PayPasswordInputView.h"
#import "EditPwdWithOldPwdViewController.h"
#import "WXApi.h"
#import "SurePayMethodsView.h"
#import "XMLDictionary.h"
#import "payRequsestHandler.h"
#import "WXUtil.h"
@interface WaitViewController () <UIActionSheetDelegate, UITextFieldDelegate, PayPasswordInputViewDelegate, UIAlertViewDelegate,AuthenticationPwdInputViewDelegate>

@property (nonatomic, strong)NSDictionary * waitPayDic;

@property (nonatomic, strong)UILabel * jiaGeLabel;

@property (nonatomic, strong)UILabel * yunFeiLabel;

@property (nonatomic, strong)UILabel * yingpayLabel;

@property (nonatomic, strong) UILabel *shifukuanLabel;

@property (nonatomic, strong)UIView * photoView;

@property (nonatomic, strong)NSArray * tempArray;

@property (nonatomic, strong)NSString * order_str;

@property (nonatomic,assign)int payWay;
@property (nonatomic, strong) UIButton *selecteInvoiceButton;
@property (nonatomic, strong) UITextField *invoiceTextField;

@property (nonatomic, strong) UIView *shopInfoView;
@property(nonatomic,assign) CLLocationCoordinate2D startCoor;
@property(nonatomic,assign)  CLLocationCoordinate2D endCoor;
@property (nonatomic, copy) NSString *locatedAddress;

@property (nonatomic, assign) PayMehod payMethod;
@property (nonatomic, assign) BOOL isHasEnoughBalance;

@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIButton    *selectePhoneNumberButton;

@property (nonatomic, copy)   NSString *payPassword;

@property (nonatomic, strong) NSMutableArray *moneyRelativeLabelArray;

@property (nonatomic, assign) BOOL isChangeVip;
@property (nonatomic ,strong)  UIDatePicker *datePicker;//日期选取器
@property (nonatomic ,strong)  UITextField  *expressTimeField;
@property (nonatomic ,strong)  NSString *timeSp;

@property (nonatomic ,strong)  NSArray *payMethodArr;
@property (nonatomic, strong) NSDictionary *payDic;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) NSInteger method;
@property (nonatomic, assign) CLLocationCoordinate2D shopLocation;
@property (nonatomic, strong) UIView *moneyView;
@property (nonatomic, copy) NSString *is_point_type;
@end

@implementation WaitViewController
@synthesize allLOgisticView,upTipLabel,downTipLabel;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payFailNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payCancelNotification" object:nil];
}

- (void)paySuccess {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PayViewController *vc = [[PayViewController alloc] init];
        vc.payStatusType = PayStatusTypeSuccess;
        vc.shareOrderId = self.shareId;
        vc.isChangeVip = self.isChangeVip;
        [self.navigationController pushViewController:vc animated:YES];
    });
}
- (void)payFail {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PayViewController *vc = [[PayViewController alloc] init];
        vc.payStatusType = PayStatusTypeFail;
        vc.shareOrderId = self.shareId;
        vc.isChangeVip = NO;
        [self.navigationController pushViewController:vc animated:YES];
    });
}
- (void)payCancel {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PayViewController *vc = [[PayViewController alloc] init];
        vc.payStatusType = PayStatusTypeCancel;
        vc.shareOrderId = self.shareId;
        vc.isChangeVip = NO;
        [self.navigationController pushViewController:vc animated:YES];
    });
}
- (void)viewWillAppear:(BOOL)animated {
    [self getPayMethod];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"订单详情";
    self.payPassword = @"";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"paySuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payCancel) name:@"payCancelNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"payFailNotification" object:nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    self.btns = [NSMutableArray arrayWithCapacity:0];
    self.moneyRelativeLabelArray = [[NSMutableArray alloc] init];
    self.waitPayDic = [NSDictionary dictionary];

    self.payMethod = PayMehodWxPay;

    self.allScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-50)];
    self.allScrollView.scrollEnabled=NO;
    _allScrollView.backgroundColor = WHITE_COLOR2;
    self.allScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, self.allScrollView.frame.size.height*2);
    [self.view addSubview:self.allScrollView];
    
    self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-50)];
    _backView.showsVerticalScrollIndicator=NO;
    _backView.backgroundColor = WHITE_COLOR2;
    _backView.alwaysBounceVertical=YES;
    
    
    if (self.flag == 3||self.flag == 4) {
        _backView.delegate=self;
    }else{
        _backView.delegate=nil;
    }
    [self creatView];
    [self creatAllLogisticsView];
    [self RequestForWaitPayOrder];
}

#pragma mark - http
//确认收货
-(void)postConfirmGoodsData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=2&order_id=%@",self.order_id];
    NSString *str=MOBILE_SERVER_URL(@"orderForUser.php");
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
            [SVProgressHUD showSuccessWithStatus:@"已确认"] ;
            [self.navigationController popViewControllerAnimated:YES];
//            PayFinishViewController* vc = [[PayFinishViewController alloc]init];
//            vc.orderTitle=self.orderTitle;
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

//加载图片
- (void)uploadImageView:(NSArray *)array {
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 + i * 100, 80, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"goods_img"]]];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.middleView addSubview:imageView];

        UILabel *goodsCount = [[UILabel alloc] init];
        goodsCount.frame = CGRectMake(imageView.maxY + 10, 40 + i * 100, UI_SCREEN_WIDTH - imageView.maxY - 20, 20);
        goodsCount.textColor = BLACK_COLOR;
        goodsCount.textAlignment = NSTextAlignmentRight;
        goodsCount.font = [UIFont systemFontOfSize:14];
        goodsCount.text  = [NSString stringWithFormat:@"x%@",[dic objectForKey:@"goods_num"]];
        [self.middleView addSubview:goodsCount];
        
        //商品名称
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.maxX+10, imageView.y - 5, UI_SCREEN_WIDTH-imageView.maxX-20, 40)];
        nameLabel.numberOfLines = 0;
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.text = dic[@"goods_name"];
        [self.middleView addSubview:nameLabel];
        
        //规格
        UILabel *formatLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.maxX+10, nameLabel.maxY, UI_SCREEN_WIDTH-imageView.maxX-20, 20)];
        formatLabel.textColor = [UIColor lightGrayColor];
        formatLabel.font = [UIFont systemFontOfSize:14];
        formatLabel.text = [NSString stringWithFormat:@"规格:%@",dic[@"goods_attr"]];
        [self.middleView addSubview:formatLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.maxX+10, formatLabel.maxY+10, UI_SCREEN_WIDTH-imageView.maxX-22, 20)];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:14];
        if ([_is_point_type isEqualToString:@"1"]) {
            priceLabel.text = [NSString stringWithFormat:@"%@", dic[@"goods_price"]];
        }else {
            priceLabel.text = [NSString stringWithFormat:@"¥%@", dic[@"goods_price"]];
        }
        
        [self.middleView addSubview:priceLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 99 * i, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = WHITE_COLOR2;
        [self.middleView addSubview:line];
    }
    
    self.middleView.frame = CGRectMake(0, UI_SCREEN_WIDTH * 100 / 375.0 + 100, UI_SCREEN_WIDTH, 100 * array.count);
    self.moneyView.frame = CGRectMake(0, self.middleView.maxY + 10, UI_SCREEN_WIDTH, 150);
    self.backView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _moneyView.maxY + 20);
}

//获取订单详情
-(void)RequestForWaitPayOrder {
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"act=4&order_id=%@",self.order_id];
    NSString *str=MOBILE_SERVER_URL(@"orderForUser.php");
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
            
            self.waitPayDic = [responseObject objectForKey:@"order"];
            self.order_str = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"order_title"]];
            if([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"order"] objectForKey:@"receiving_method"]] intValue] == 1)
            {
                self.shopInfoView.userInteractionEnabled = YES;
                _peopleLabel.text = [NSString stringWithFormat:@"店长:%@", [self.waitPayDic objectForKey:@"shop_name"]];
                _addressLabel.text = [NSString stringWithFormat:@"店铺地址：%@", [self.waitPayDic objectForKey:@"address"]];
            }else
            {
                self.shopInfoView.userInteractionEnabled = NO;
                _peopleLabel.text = [NSString stringWithFormat:@"收货人:%@", [self.waitPayDic objectForKey:@"contact_name"]];
                _addressLabel.text = [NSString stringWithFormat:@"收货地址：%@", [self.waitPayDic objectForKey:@"address"]];
            }
            if (![[self.waitPayDic objectForKey:@"latitude"] isKindOfClass:[NSNull class]]) {
                _shopLocation.longitude = [[self.waitPayDic  valueForKey:@"longitude"] doubleValue];
                _shopLocation.latitude = [[self.waitPayDic  valueForKey:@"latitude"] doubleValue];
                _locatedAddress = [self.waitPayDic objectForKey:@"address"];
            }
            
            _phoneLabel.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"contact_tel"]];
            
            self.orderStr = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"order_id"]];

            
            
            self.is_point_type = [self.waitPayDic objectForKey:@"is_point_type"];
            if ([_is_point_type isEqualToString:@"1"]) {
                self.jiaGeLabel.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"goods_pay_money"]];
                self.yingpayLabel.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"order_sum"]];
                self.shifukuanLabel.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"goods_sum_money"]];
            }else {
                self.jiaGeLabel.text = [NSString stringWithFormat:@"¥%@", [self.waitPayDic objectForKey:@"goods_pay_money"]];
                self.yingpayLabel.text = [NSString stringWithFormat:@"¥%@", [self.waitPayDic objectForKey:@"order_sum"]];
                self.shifukuanLabel.text = [NSString stringWithFormat:@"¥%@", [self.waitPayDic objectForKey:@"goods_sum_money"]];
            }
            
            if ([[NSString stringWithFormat:@"%@",[self.waitPayDic objectForKey:@"order_freight"]] isEqualToString:@""]) {
                if ([_is_point_type isEqualToString:@"1"]) {
                    self.yunFeiLabel.text = @"0";
                }else {
                    self.yunFeiLabel.text = @"¥0";
                }
            }else {
                if ([_is_point_type isEqualToString:@"1"]) {
                    self.yunFeiLabel.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"order_freight"]];
                }else {
                    self.yunFeiLabel.text = [NSString stringWithFormat:@"¥%@", [self.waitPayDic objectForKey:@"order_freight"]];
                }
            }
            
            self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号: %@", [_orderDic objectForKey:@"order_title"]];
            self.order_str1 = [self.waitPayDic objectForKey:@"order_title"];
            self.str = [self.waitPayDic objectForKey:@"wuliu_num"];
            self.TimeLabel.text = [NSString stringWithFormat:@"下单时间: %@", [_orderDic objectForKey:@"log_time"]];
            self.tempArray =  [self.waitPayDic objectForKey:@"goods_list"];
            self.payType.text = [NSString stringWithFormat:@"支付方式:%@", [self.waitPayDic objectForKey:@"pay_method"]];
            [self uploadImageView:self.tempArray];
            /*海淘商品,实名认证*/
            NSString *personverifyName = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"personverify_name"]];
            NSString *personverifyIDCard = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"personverify_IDCard"]];
            if ([personverifyName isValid] && [personverifyIDCard isValid]) {
                self.heyueLabel.text = [NSString stringWithFormat:@"真实姓名:%@",personverifyName];
                self.faPiaoLabel.text = [NSString stringWithFormat:@"身份证号:%@",personverifyIDCard];
            }
            /*****--分割--****/
            
            if ([[NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"is_kaipiao"]] isEqualToString:@"1"])
            {
                self.selecteInvoiceButton.selected = YES;
            }
            else
            {
                [self.invoiceTextField superview].hidden = YES;
                self.selecteInvoiceButton.selected = NO;
            }
            self.invoiceTextField.text = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"kaipiaoinfo"]];
            NSString *balanceString = [NSString stringWithFormat:@"%@",[self.waitPayDic valueForKey:@"my_account"]];
            NSString *needChuanNum = [NSString stringWithFormat:@"%@", [self.waitPayDic valueForKey:@"need_chuan"]];
            self.selectePhoneNumberButton.selected = [needChuanNum isEqualToString:@"1"];
            
            self.phoneNumberTextField.placeholder = [NSString stringWithFormat:@"%@", [self.waitPayDic valueForKey:@"partner_num"]];
            CGFloat allPrice = [[self.waitPayDic valueForKey:@"actual_pay_money"] floatValue];
            if (allPrice>balanceString.floatValue) {
                /*余额不足*/
                self.isHasEnoughBalance=NO;
            }else{
                self.isHasEnoughBalance=YES;
            }
            
            //待收货有物流信息  已确认是另一个类
            if (self.flag ==3) {
                [self postWuLiuInfo];
            }
            
            _timeSp=[NSString stringWithFormat:@"%@",[self.waitPayDic objectForKey:@"post_time"]];
            if (![_timeSp isEqualToString:@"0"] && [_timeSp isValid]) {
                _expressTimeField.text = _timeSp;
            }else{
                _expressTimeField.text = @"未指定送货时间";
                _expressTimeField.textColor = [UIColor colorFromHexCode:@"8e8e93"];
            }
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

- (void)getPayMethod {
    NSString*body=[NSString stringWithFormat:@"act=3&order_id=%@",self.order_id];
    NSString *str=MOBILE_SERVER_URL(@"orderApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        self.payDic = responseObject;
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            self.payMethodArr = [[responseObject objectForKey:@"pay_info"] objectForKey:@"payment_mode"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        DLog(@"%@",error);
    }];
    [op start];
}

- (void)creatTopView {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH * 100 / 375.0)];
    image.image = [UIImage imageNamed:@"pho-diandanbianhao@2x_02"];
    [_backView addSubview:image];
    
        self.orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (UI_SCREEN_WIDTH * 100 / 375.0  - 50) / 2, UI_SCREEN_WIDTH - 40, 20)];
        _orderNumLabel.text = @"订单编号:";
        _orderNumLabel.font = [UIFont systemFontOfSize:14];
    _orderNumLabel.textColor = [UIColor whiteColor];
    _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        [image addSubview:_orderNumLabel];
    
        self.TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.orderNumLabel.frame) + 10, UI_SCREEN_WIDTH - 40, 20)];
        _TimeLabel.text = @"下单时间:";
        _TimeLabel.font = [UIFont systemFontOfSize:14];
    _TimeLabel.textAlignment = NSTextAlignmentLeft;
    _TimeLabel.textColor = [UIColor whiteColor];
        [image addSubview:_TimeLabel];
    
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, image.maxY, UI_SCREEN_WIDTH, 89)];
    topView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:topView];
    
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_adr1.png"]];
    leftImageView.frame = CGRectMake(7, 35, 20, 20);
    [topView addSubview:leftImageView];
    
    self.peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(39, 17, 125, 15)];
    _peopleLabel.text = @"";
    _peopleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:_peopleLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-100-30, 17, 100, 15)];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    
    _phoneLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:_phoneLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 31, 260, 50)];
    _addressLabel.text = @"";
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.numberOfLines = 0;
    [topView addSubview:_addressLabel];
    
    
    self.shopInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 89)];
    [topView addSubview:self.shopInfoView];
    self.shopInfoView.backgroundColor = [UIColor clearColor];
        [self.shopInfoView addTarget:self action:@selector(showNagivationView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)creatMiddleView {
    self.middleView = [[UIView alloc] init];
    _middleView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_middleView];
    
        CGFloat startOriginX = 70;
        if (self.flag == 2 || self.flag == 3 || self.flagVC == 4|| self.flag == 4) {
            self.middleView.frame = CGRectMake(0, UI_SCREEN_WIDTH * 100 / 375.0 + 100, UI_SCREEN_WIDTH, 100);
        }else  {
            self.middleView.frame = CGRectMake(0, UI_SCREEN_WIDTH * 100 / 375.0 + 100, UI_SCREEN_WIDTH, 100);
    
        }

    //第二组
    self.photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 95)];
    _photoView.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:_photoView];
    
//    UITapGestureRecognizer * goodListTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotogoodList)];
//    [_photoView addGestureRecognizer:goodListTap];
    
    
    UILabel *goodsCount = [[UILabel alloc] init];
    goodsCount.frame = CGRectMake(UI_SCREEN_WIDTH-15-5-85, 35, 80, 20);
    goodsCount.textColor = BLACK_COLOR;
    goodsCount.textAlignment = NSTextAlignmentRight;
    goodsCount.font = [UIFont systemFontOfSize:14];
    [_photoView addSubview:goodsCount];
    self.goodNumLabel = goodsCount;
    
//    UIView * littleView = [[UIView alloc] initWithFrame:CGRectMake(0, _middleView.maxY, UI_SCREEN_WIDTH, 8)];
//    littleView.backgroundColor = MONEY_COLOR;
//    [_backView addSubview:littleView];
    
    //第三组
    self.moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, _middleView.maxY + 10, UI_SCREEN_WIDTH, 150)];
    _moneyView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_moneyView];
    
    NSArray * titleArray = @[@"商品价格", @"运费 (快递)", @"订单总价", @"实付款"];
    NSArray * moArray = @[@"¥0.00",@"¥0.00", @"¥0.00", @"¥0.00"];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel * tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 13 + 35 * i, 100, 19)];
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 12 - 80 * adapterFactor, 13 + 35 * i, 80 * adapterFactor, 19)];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.text = [moArray objectAtIndex:i];
        tiLabel.text = [titleArray objectAtIndex:i];
        tiLabel.font = [UIFont systemFontOfSize:14];
        
        [_moneyView addSubview:moneyLabel];
        [_moneyView addSubview:tiLabel];
        
        if (i == 0) {
            self.jiaGeLabel = moneyLabel;
        }
        if (i == 1) {
            self.yunFeiLabel = moneyLabel;
        }
        if (i == 2) {
           moneyLabel.textColor = [UIColor colorFromHexCode:@"#ea6153"];
            _yingpayLabel = moneyLabel;
        }
        if (i == 3) {
            self.shifukuanLabel = moneyLabel;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 109, UI_SCREEN_WIDTH - 20, 1)];
            label.backgroundColor = WHITE_COLOR2;
            [_moneyView addSubview:label];
            
        }
    }
    
    
//    self.orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, startOriginX+242, 350, 15)];
//    _orderNumLabel.text = @"订单编号:";
//    _orderNumLabel.font = [UIFont systemFontOfSize:12];
//    [_middleView addSubview:_orderNumLabel];
//    
//    self.TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.orderNumLabel.frame) + 8, 250, 15)];
//    _TimeLabel.text = @"下单时间:";
//    _TimeLabel.font = [UIFont systemFontOfSize:12];
//    
//    [_middleView addSubview:_TimeLabel];
//    
//    self.payType = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.TimeLabel.frame) + 8, 200, 15)];
//    _payType.font = [UIFont systemFontOfSize:12];
//    self.payType.text = @"支付方式:";
//    if (self.flag == 1) {
//        _payType.hidden = YES;
//        _payType.frame =CGRectMake(18, CGRectGetMaxY(self.TimeLabel.frame), 200, 0);
//    }
//    [_middleView addSubview:_payType];
//    
//    self.heyueLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(self.payType.frame) + 8, 200, 15)];
//    [_middleView addSubview:_heyueLabel];
//    _heyueLabel.font = [UIFont systemFontOfSize:12];
//    
//    self.faPiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(_heyueLabel.frame) + 8, UI_SCREEN_WIDTH - 36, 15)];
//    [_middleView addSubview:_faPiaoLabel];
//    _faPiaoLabel.font = [UIFont systemFontOfSize:12];
//    
//    CGRect frame = _middleView.frame;
//    frame.size.height = CGRectGetMaxY(_faPiaoLabel.frame);
//    _middleView.frame = frame;
//    
//    NSArray* payNames = [NSArray array];
//    payNames = @[@"使用余额支付",@"微信支付",@"支付宝支付"];
    
    
//#pragma mark - 顾客订单应隐藏支付方式
//    for(int i=0;i<payNames.count;i++)
//    {
//        self.bView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+10+50*i, UI_SCREEN_WIDTH, 50)];
//        [_backView addSubview:_bView];
//        if(self.flag == 2 || self.flag == 3 || self.flagVC == 4|| self.flag == 4)
//        {
//            self.bView.hidden = YES;
//            self.bView.frame = CGRectMake(0, CGRectGetMaxY(_middleView.frame)+10+50*i, UI_SCREEN_WIDTH, 0);
//            self.bView.clipsToBounds = YES;
//            _backView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, CGRectGetMaxY(self.middleView.frame) + 44+30);
//        }else {
//            _backView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, CGRectGetMaxY(self.middleView.frame)+150+10+44+30);
//        }
//        
//        _bView.tag = i;
//        
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chosePay:)];
//        [_bView addGestureRecognizer:tap];
//        
//        UISwitch * swit = [[UISwitch alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 52 - 15, 5, 52, 31)];
//        swit.userInteractionEnabled = NO;
//        swit.tag = i;
//        [self.btns addObject:swit];
//        [_bView addSubview:swit];
//        
//        
//        UIImageView* payImgVi = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 25, 25)];
//        if(i==1)
//        {
//            swit.on = YES;
//            payImgVi.image = [UIImage imageNamed:@"gj_wechat0.png"];
//            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(42, 42, UI_SCREEN_WIDTH-42, 1)];
//            line.backgroundColor = LINE_SHALLOW_COLOR;
//            [_bView addSubview:line];
//        }else if (i == 2)
//        {
//            payImgVi.image = [UIImage imageNamed:@"gj_zhifubao.png"];
//        }
//        [_bView addSubview:payImgVi];
//        
//        UILabel* nameLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 7, 120, 20)];
//        nameLab.font = [UIFont systemFontOfSize:15];
//        nameLab.text = payNames[i];
//        nameLab.font = LMJ_XT 14];
//        nameLab.textColor = DETAILS_COLOR;
//        [_bView addSubview:nameLab];
//        
//        if (i == 0) {
//            nameLab.frame = CGRectMake(15, 7, 120, 20);
//        }
//        
//        UILabel *moneyRelativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + 90, 10, UI_SCREEN_WIDTH /2-20, 20)];
//        moneyRelativeLabel.textAlignment = NSTextAlignmentRight;
//        moneyRelativeLabel.font = [UIFont systemFontOfSize:13.0];
//        NSString *allMoneyStr = [NSString stringWithFormat:@"%@", [self.waitPayDic objectForKey:@"my_account"]];
//        moneyRelativeLabel.text = i == 0 ? [NSString stringWithFormat:@"可用余额%.2f元", [allMoneyStr doubleValue]] : @"";
//        moneyRelativeLabel.textColor = i == 0 ? [UIColor colorFromHexCode:@"8e8e93"] : App_Main_Color;
//        [_bView addSubview:moneyRelativeLabel];
//        [self.moneyRelativeLabelArray addObject:moneyRelativeLabel];
//        
//        CGRect rect = CGRectMake(160, 7, UI_SCREEN_WIDTH-20-160, 20);
//        UILabel* detailsLab = [[UILabel alloc]initWithFrame:rect];
//        NSString *supposedStr = @"";
//        
//        detailsLab.font = LMJ_XT 13];
//        detailsLab.textAlignment = NSTextAlignmentCenter;
//        detailsLab.text = supposedStr;
//        detailsLab.layer.cornerRadius = 5;
//        detailsLab.textColor = App_Main_Color;
//        detailsLab.layer.backgroundColor = [[UIColor colorFromHexCode:@"ededed"] CGColor];
//        CGSize size = [detailsLab sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
//        CGFloat offsetX = (160 - size.width - 29) / 2;
//        detailsLab.frame = CGRectMake(160 + offsetX, detailsLab.frame.origin.y, size.width + 29, 20);
//        [_bView addSubview:detailsLab];
//        detailsLab.hidden=YES;
//        if(i == 0)
//        {
//            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(42, 42, UI_SCREEN_WIDTH-42, 1)];
//            line.backgroundColor = LINE_SHALLOW_COLOR;
//            [_bView addSubview:line];
//            self.weixinShowLabel=detailsLab;
//        }
//        if (i==1) {
//            self.taobaoShowLabel=detailsLab;
//        }
//    }
    
}
//- (void)createTimeView {
//    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 70)];
//    timeView.backgroundColor = WHITE_COLOR;
//    [_middleView addSubview:timeView];
//    
//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake( 15, 5, 200.0, 20.0)];
//    label3.backgroundColor = [UIColor clearColor];
//    label3.text = @"送货时间";
//    label3.font = LMJ_CT 14];
//    label3.textColor = [UIColor colorFromHexCode:@"#505059"];
//    [timeView addSubview:label3];
//    
//    _expressTimeField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label3.frame)+5, UI_SCREEN_WIDTH-30, 30.0f)];
//    _expressTimeField.placeholder = @"未指定送货时间";
//    _expressTimeField.enabled = NO;
//    [_expressTimeField setBorderStyle:UITextBorderStyleNone];
//    _expressTimeField.layer.borderColor = [[UIColor colorFromHexCode:@"#ffffff"] CGColor];
//    [timeView addSubview:_expressTimeField];
//    
//}
//前往商品清单
- (void)gotogoodList
{
    GoodsListViewController * goodVC = [[GoodsListViewController  alloc] init];
    goodVC.is_point_type = [NSString stringWithFormat:@"%ld", self.is_point_type];
    [self.navigationController pushViewController:goodVC animated:YES];
    goodVC.goodsListArray = self.tempArray;
    goodVC.isJifen = [[self.waitPayDic objectForKey:@"is_jifen_order"] integerValue];
    NSArray *temp= [self.waitPayDic valueForKey:@"goodsinfo"];
    if([temp isKindOfClass:[NSArray class]]){
        goodVC.guigeArr=[NSArray arrayWithArray:temp];
    }
    goodVC.flag = 0;
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
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_img"]]];
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 60 * i, 19.5, 55, 55)];
        
        [self.photoImageView af_setImageWithURL:url];
        [_photoView addSubview:_photoImageView];
    }
}

-(void)chosePay:(id)sender
{
    UIView* vi = (UIView*)[sender view];
    for(UISwitch* btn in self.btns)
    {
        if(btn.tag == vi.tag)
        {
            [btn setOn:YES animated:YES];
        }
        else
        {
            [btn setOn:NO animated:YES];
        }
    }
    /*如果选择了余额支付  支付方式为3*/
    UISwitch *balanceBtn=[self.btns objectAtIndex:0];
    UISwitch *wxPayBtn=[self.btns objectAtIndex:1];
    UISwitch *aliPayBtn=[self.btns objectAtIndex:2];
    
    if ((wxPayBtn.on || aliPayBtn.on) &&
        [NSString stringWithFormat:@"%@", [self.waitPayDic valueForKey:@"my_account"]].doubleValue == 0 &&
        balanceBtn.on)
    {
        balanceBtn.on = NO;
    }
    
    if (balanceBtn.on && wxPayBtn.on)
    {
        self.payMethod = PayMehodWxPayAndBalancePay;
    }
    
    if (balanceBtn.on && aliPayBtn.on)
    {
        self.payMethod = PayMehodAliPayAndBalancePay;
    }
    
    if (balanceBtn.on && !wxPayBtn.on && !aliPayBtn.on)
    {
        self.payMethod = PayMehodBalancePay;
    }
    
    if (!balanceBtn.on && wxPayBtn.on)
    {
        self.payMethod = PayMehodWxPay;
    }
    
    if (!balanceBtn.on && aliPayBtn.on)
    {
        self.payMethod = PayMehodAliPay;
    }
    
    //判断是否选择支付方式
    BOOL isChoosePayMethod = NO;
    for(UISwitch* btn in self.btns)
    {
        if (btn.on==YES) {
            isChoosePayMethod=YES;
        }
    }
    
    if (!isChoosePayMethod) {
        self.payMethod = PayMehodNone;
    }
    
    UILabel *balanceMoneyLabel = [self.moneyRelativeLabelArray objectAtIndex:0];
    balanceMoneyLabel.textColor = balanceBtn.on ? App_Main_Color : [UIColor colorFromHexCode:@"8e8e93"];
    
    if (!self.isHasEnoughBalance)
    {
        NSString *balanceString = [NSString stringWithFormat:@"%@", [self.waitPayDic valueForKey:@"my_account"]];
        NSString *allPrice = [NSString stringWithFormat:@"%@", [self.waitPayDic valueForKey:@"total_price"]];
        double remainMoney = allPrice.doubleValue - balanceString.doubleValue;
        UILabel *remainMoneyForWeiXinLabel = [self.moneyRelativeLabelArray objectAtIndex:1];
        remainMoneyForWeiXinLabel.text = (wxPayBtn.on && balanceBtn.on) ? [NSString stringWithFormat:@"剩余%.2f元", remainMoney] : @"";
        
        UILabel *remainMoneyForAlipayLabel = [self.moneyRelativeLabelArray objectAtIndex:2];
        remainMoneyForAlipayLabel.text = (aliPayBtn.on && balanceBtn.on)? [NSString stringWithFormat:@"剩余%.2f元", remainMoney] : @"";
    }
}


- (void)creatView
{
    [self.allScrollView addSubview:self.backView];
    [self creatTopView];
    [self creatMiddleView];
    
    if (self.flagVC == 3)
    {
        [self creatBottomView];
    }
    
    [self creatLogisticsView];
    
//    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 89, UI_SCREEN_WIDTH, 0.5)];
//    topLine.backgroundColor = LINE_DEEP_COLOR;
//    
//    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 97.5, UI_SCREEN_WIDTH, 0.5)];
//    bottomLine.backgroundColor = LINE_DEEP_COLOR;
    
//    UIView * littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, UI_SCREEN_WIDTH, 8)];
//    littleView.backgroundColor = MONEY_COLOR;
//    [_backView addSubview:littleView];
//    [_backView addSubview:topLine];
//    [_backView addSubview:bottomLine];
    
}

//物流信息
- (void)creatLogisticsView
{
    self.logisticsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame), UI_SCREEN_WIDTH, 33)];
    if (_flag == 3) {
        _logisticsView.hidden = YES;
    }
    [_backView addSubview:_logisticsView];
    
    
    upTipLabel.frame=CGRectMake(0, _backView.contentSize.height, UI_SCREEN_WIDTH, 40);
    
    if (self.flag == 1) {
        self.logisticsView.hidden = YES;
    }
    UIImageView * logImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-wuliu.png"]];
    logImageView.frame = CGRectMake(14, 7, 18, 18);
    [_logisticsView addSubview:logImageView];
    
    UILabel * logLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logImageView.frame) + 10, 7, 80, 18)];
    logLabel.text = @"物流信息";
    logLabel.font = [UIFont systemFontOfSize:12];
    [_logisticsView addSubview:logLabel];
    
}

- (void)goLogDetail
{
    LogisticsDetailVC * logDVC = [[LogisticsDetailVC alloc] init];
    [self.navigationController pushViewController:logDVC animated:YES];
    logDVC.OID=self.orderTitle;
    logDVC.orderStr = self.orderStr;
    logDVC.str = self.order_str1;
}

- (void)creatBottomView
{
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 44-64, UI_SCREEN_WIDTH, 44)];
    [self.view addSubview:_buttomView];
    
    for (int i = 0; i < _titleArrays.count; i++) {
        
        
        self.twoLabel = [[UILabel alloc] init];
        
        if (_titleArrays.count == 1) {
            _twoLabel.frame = CGRectMake(UI_SCREEN_WIDTH  - 90, 5, 80 , 30);
        }else {
            _twoLabel.frame = CGRectMake(UI_SCREEN_WIDTH  - 180 + i * 90, 5, 80 , 30);
        }
        self.twoLabel.text = [_titleArrays objectAtIndex:i];
        _twoLabel.tag = 101 + i;
        _twoLabel.layer.cornerRadius = 3;
        _twoLabel.layer.masksToBounds = YES;
        [_buttomView addSubview:self.twoLabel];
        _twoLabel.font = [UIFont systemFontOfSize:14];
        _twoLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
        [_twoLabel addGestureRecognizer:tap];
        self.twoLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            self.twoLabel.textColor = [UIColor blackColor];
            if ([self.twoLabel.text isEqualToString:@"确认收货"]) {
                self.twoLabel.textColor = [UIColor whiteColor];
                self.twoLabel.backgroundColor = App_Main_Color;
            }
            if ([self.twoLabel.text isEqualToString:@"取消订单"]) {
                self.twoLabel.backgroundColor = WHITE_COLOR;
                _twoLabel.layer.borderColor = [UIColor blackColor].CGColor;
                _twoLabel.layer.borderWidth = 0.5;
            }
            
            if ([self.twoLabel.text isEqualToString:@"退款处理中"] ||
                [self.twoLabel.text isEqualToString:@"退款完成"]) {
                [self.twoLabel removeGestureRecognizer:tap];
            }
        }
        
        if (i == 1) {
            if ([self.twoLabel.text isEqualToString:@"付款"] || [self.twoLabel.text isEqualToString:@"确认收货"]) {
                self.twoLabel.textColor = [UIColor whiteColor];
                self.twoLabel.backgroundColor = App_Main_Color;
            }
            if ([self.twoLabel.text isEqualToString:@"扫描二维码收货"]) {
                self.twoLabel.textColor = [UIColor blackColor];
                self.erWeiImageView = [[UIImageView alloc] initWithImage:self.erweiImage];
                _erWeiImageView.frame = CGRectMake(300 * adapterFactor, 15, 15 * adapterFactor, 15);
                
                [_buttomView  addSubview:_erWeiImageView];
            }
        }
    }
}

- (void)creatCancleBottomView
{
    if (self.flag == 3||self.flag == 4)
    {
        [self creatBottomView];
        return;
    }
    
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 44-64, UI_SCREEN_WIDTH, 44)];
    [self.view addSubview:_buttomView];
    self.twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH , 44)];
    self.twoLabel.backgroundColor = [UIColor whiteColor];
    self.twoLabel.text = @"取消订单";
    self.twoLabel.tag = 101;
    [_buttomView addSubview:self.twoLabel];
    _twoLabel.font = [UIFont systemFontOfSize:14];
    _twoLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
    [_twoLabel addGestureRecognizer:tap];
    self.twoLabel.textAlignment = NSTextAlignmentCenter;
    
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


#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000 && buttonIndex == 0)
    {
        [self postRemoveData];
    }
    if (actionSheet.tag == 999 && buttonIndex == 0)
    {
        [self postConfirmGoodsData];
    }
    if (actionSheet.tag==1001&&buttonIndex==0) {
        [self postApplyBackCom];
    }
}

#pragma mark -
- (void)showAlertViewWithSpecificMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
#pragma mark - 点击取消订单或者付款
- (void)doClick:(id)sender
{
    UILabel * label = (UILabel *)[sender view];
    if (label.tag == 101) {
        if ([label.text isEqualToString:@"退款"]) {
            UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认退款?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            act.tag = 1001;
            [act showInView:self.view];
        }
        
        if ([label.text isEqualToString:@"取消订单"]) {
            UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认取消订单？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            act.tag = 1000;
            [act showInView:self.view];
        }
        
        if ([label.text isEqualToString:@"确认收货"]) {
            UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认收货" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            act.tag = 999;
            [act showInView:self.view];
        }
    }
    if (label.tag == 102) {
        if ([label.text isEqualToString:@"付款"]) {
            if (self.payMethodArr.count > 0) {
                //判断是否为积分订单再做处理
                NSString *str;
                if ([[self.waitPayDic objectForKey:@"is_point_type"] integerValue] == 1) {
                    str = [NSString stringWithFormat:@"%@",[self.payDic valueForKey:@"pay_info"][@"total_money"]];
                }else {
                    str = [NSString stringWithFormat:@"¥%@",[self.payDic valueForKey:@"pay_info"][@"total_money"]];
                }
                [SurePayMethodsView showWithPriceStr:str withMethod:self.payMethodArr];
                [SurePayMethodsView sharedView].clickSureButtonBlock = ^ (NSInteger method) {
                    self.method = method;
                    //修改支付密码
//                    NSDictionary *dic = self.payMethodArr[0];
//                    if ([dic[@"is_verify_password"] integerValue] == 1) {
//                        //需要输入密码
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [AuthenticationPwdView show];
//                            [AuthenticationPwdView sharedView].promptSubtextLabel.text = [NSString stringWithFormat:@"%@:%@", dic[@"name"], self.yingpayLabel.text];
//                            [AuthenticationPwdView sharedView].forgetPwdButton.hidden = YES;
//                            [AuthenticationPwdView sharedView].inputView.delegate = self;
//                        });
//                    }else {
//                        self.password = @"";
//                        [self payReady:method];
//                    }
                    
                    self.password = @"";
                    [self payReady:method];
//                    //判断是否已经设置支付密码
//                    if ([self.payDic[@"is_already_set_pay_password"] integerValue] == 1) {
//                        
//                    }else {
//                        //前往设置支付密码
//                        SetSecretViewController *set = [[SetSecretViewController alloc]init];
//                        set.finishBlock = ^(void){
//                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.payDic];
//                            dic[@"is_already_set_pay_password"] = @"1";
//                            self.payDic = dic;
//                        };
//                        set.SecretType = SetTradeSecretType;
//                        [self.navigationController pushViewController:set animated:YES];
//                    }
                    
                };
            }else {
                [SVProgressHUD showErrorWithStatus:@"没有获取到支付方式"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }
        if ([label.text isEqualToString:@"确认收货"]) {
            UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认收货" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            act.tag = 999;
            [act showInView:self.view];
        }
    }
}
//结束支付
- (void)inputCompletePassword:(NSMutableString *)password {
    self.payPassword = password;
    [self payReady:self.method];
    
}
#pragma mark - PayPasswordInputViewDelegate
- (void)inputView:(PayPasswordInputView *)inputView doClickButtonWithType:(ButtonType)type withPassword:(NSString *)password
{
    if (type == ButtonTypePay)
    {
        _payPassword = password;
        [self payReady:self.payMethod];
    }
    else if (type == ButtonTypeForgetPassword)
    {
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPassword;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark - 获取支付密码设置状态
- (void)requestPayPwdSettingsStatus
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_pay_password.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"act=status"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               [SVProgressHUD dismiss];
                               
                               if ([returnState isEqualToString:@"1"])
                               {
                                   PayPasswordInputView *inputView = [[PayPasswordInputView alloc] init];
                                   inputView.delegate = self;
                                   [inputView showInView:self.view];
                               }
                               else
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"你还未设置支付密码,请先前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                   [alertView show];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPasswordWithoutVerifyCode;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark -
-(void)postApplyBackCom
{
    NSString *reasonString=[NSString stringWithFormat:@"不想买了"];
    NSString *otherReasonString=[NSString stringWithFormat:@"我的原因"];
    
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=7&order_title=%@&reason=%@&other=%@",self.orderTitle,reasonString,otherReasonString];
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
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
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
    NSString*body=[NSString stringWithFormat:@"act=3&order_id=%@",self.order_id];
    
    NSString *str=MOBILE_SERVER_URL(@"orderForUser.php");
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
            [SVProgressHUD showSuccessWithStatus:@"取消订单成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}
#pragma mark - 支付准备
-(void)payReady:(NSInteger)pay_method
{
    [SVProgressHUD show];
    NSString *body;
    body = [NSString stringWithFormat:@"act=3&order_id=%@&pay_method=%@&pay_password=%@", self.order_id,[self.payMethodArr[pay_method] objectForKey:@"type"],[NSString md5:self.password]];
    
    NSString *str=MOBILE_SERVER_URL(@"payOrderApi.php");
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
        
        if ([[responseObject objectForKey:@"status"] intValue] == 1 || [[responseObject objectForKey:@"is_success"] intValue] == 1) {
            if ([responseObject[@"payment_mode"]integerValue] == 1)
            {
                [self paySuccess];
                [SVProgressHUD dismissWithSuccess:@"余额支付成功"];
            }else if ([responseObject[@"payment_mode"]integerValue] == 2){
                [SVProgressHUD showSuccessWithStatus:@"正在前往支付宝支付"];
                [self paymentWithOrderSign:[responseObject objectForKey:@"sign_code"]];
            }else if ([responseObject[@"payment_mode"]integerValue] == 3)
            {
                //先判断微信是否安装或者支持
                if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
                    [SVProgressHUD showSuccessWithStatus:@"正在前往微信支付"];
                    [self sendWxPayWithDic:responseObject];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"请先安装微信"];
                }
            }else {
                [SVProgressHUD dismiss];
            }
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
            [self payFail];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self payFail];
    }];
    [op start];
}

#pragma mark - 微信支付

- (void)onResp:(BaseResp *)resp {
    //接收到微信的回调
    DLog(@"%@", resp);
    if (resp.errCode == WXSuccess) {
        //支付成功
        [self paySuccess];
    }else {
        [self payFail];
        //支付失败
        DLog(@"%@", resp.errStr);
    }
}
- (void)sendWxPayWithDic:(NSDictionary *)dic;
{
    NSDictionary *dic1 = [NSDictionary dictionaryWithXMLString:dic[@"pay_xml"]];
    PayReq *req             = [[PayReq alloc] init];
    req.openID              = [dic1 objectForKey:@"appid"];
    req.partnerId           = [dic1 objectForKey:@"partnerid"];
    req.prepayId            = [dic1 objectForKey:@"prepayid"];
    req.nonceStr            = [dic1 objectForKey:@"noncestr"];
    req.timeStamp           = [[dic1 objectForKey:@"timestamp"] integerValue];
    req.package             = [dic1 objectForKey:@"package"];
    req.sign                = [dic1 objectForKey:@"sign"];
    [WXApi sendReq:req];
}
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

-(void)paymentWithOrderSign:(NSString *)sign {//调用支付宝支付接口
    
    NSString *appScheme = @"baoxuan";//在info中urltypes中添加一条并设置Scheme 这样支付宝才能返回到当前应用中
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"result = %@",resultDic);
        
        NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        NSString *str = @"";
        if (resultDic)
        {
            if ([statusStr isEqualToString:@"9000"])
            {
                NSLog(@"success!");
                str = @"交易成功";
                [self paySuccess];
                return ;
            }else if([statusStr isEqualToString:@"6001"])
            {
                str = @"交易取消";
                [self payCancel];
                return ;
            }else
            {
                str = @"交易失败";
                DLog(@"AlixPayResult_error0!");
                [self payFail];
                return ;
            }
        }
        else
        {
            str = @"支付宝连接失败";
            NSLog(@"AlixPayResult_error1!");
            //失败
        }
        
        UIAlertView *alerTivew = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alerTivew show];
    }];
    
}


-(NSString*)doRsa:(NSString*)orderInfo
{
    /*  id<DataSigner> signer;
     signer = CreateRSADataSigner(PartnerPrivKey);
     NSString *signedString = [signer signString:orderInfo];
     return signedString;*/
    return nil;
}



#pragma mark - 物流模块
- (void)creatAllLogisticsView
{
    allLOgisticView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    allLOgisticView.delegate=self;
    allLOgisticView.showsVerticalScrollIndicator=NO;
    allLOgisticView.alwaysBounceVertical=YES;
    allLOgisticView.backgroundColor=[UIColor clearColor];
    [self.allScrollView addSubview:allLOgisticView];
    
    
    downTipLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, -40, UI_SCREEN_WIDTH, 40)];
    downTipLabel.textColor=BLACK_COLOR;
    downTipLabel.font=[UIFont systemFontOfSize:15];
    downTipLabel.text=@"";
    downTipLabel.textAlignment=NSTextAlignmentCenter;
    downTipLabel.backgroundColor=[UIColor clearColor];
    [allLOgisticView addSubview:downTipLabel];
    
    self.logisticsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 138, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 138 -44 - 64)];
    self.logisticsTableView.delegate = self;
    self.logisticsTableView.dataSource = self;
    self.logisticsTableView.scrollEnabled=NO;
    self.logisticsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [allLOgisticView addSubview:self.topView];
    [allLOgisticView addSubview:self.logisticsTableView];
    //    [allLOgisticView addSubview:self.bottomView];
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
        
        
        self.logisticsLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cslNoImage.png"]];
        self.logisticsLogo.frame = CGRectMake(9, 17, 40, 40);
        //        logisticsLogo.backgroundColor = [UIColor blueColor];
        [_topView addSubview:self.logisticsLogo];
        
        self.titleArr = @[@"物流公司", @"运单编号:"];
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
                _logisticaNum.text = self.str;
                [_topView addSubview:_logisticaNum];
                label.font = [UIFont systemFontOfSize:14];
                
            }
            /* 暂时隐藏@"待签收"
             if (i == 2) {
             label.textColor = App_Main_Color;
             label.font = [UIFont systemFontOfSize:14];
             self.statusLabel = label;
             }
             */
        }
        
    }
    return _topView;
}
- (UIView *)bottomView
{
    if (_bottomView == nil) {
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 64 - 44, UI_SCREEN_WIDTH, 44)];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
        label.text = @"确认收货";
        [_bottomView addSubview:label];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:20];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
        [label addGestureRecognizer:tap];
        label.backgroundColor = App_Main_Color;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomView;
}


#pragma mark - 物流接口
-(void)postWuLiuInfo
{
    //    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&order=%@", self.orderStr];
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
            
            height+=paragraphRect1.size.height + paragraphRect.size.height;
        }
        
        self.logisticsTableView.frame= CGRectMake(0, 138, UI_SCREEN_WIDTH, height+30+138);
        allLOgisticView.contentSize=CGSizeMake(UI_SCREEN_WIDTH,CGRectGetMaxY(self.logisticsTableView.frame));
        self.allScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, self.allScrollView.frame.size.height*2);
        
        /*暂时隐藏  @"待签收"
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
        self.logisticaNum.text=self.str;
        self.wuliuCompanyLabel.text=[responseObject valueForKey:@"com"];
        
        
        [self.logisticsTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];
}


#pragma mark - scorllview动画处理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_backView) {
//        if (scrollView.contentOffset.y>_backView.contentSize.height-_backView.frame.size.height+30+44) {
//            upTipLabel.text=@"松开查看物流";
//        }else if (scrollView.contentOffset.y>_backView.contentSize.height-_backView.frame.size.height+30){
//            upTipLabel.text=@"继续上拉查看物流";
//        }
    }
    if (scrollView==allLOgisticView) {
//        if (scrollView.contentOffset.y<-30) {
//            downTipLabel.text=@"松开回到顶部";
//        }else{
//            downTipLabel.text=@"继续下拉回到顶部";
//        }
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView==_backView) {
//        if (scrollView.contentOffset.y>_backView.contentSize.height-_backView.frame.size.height+30+44) {
//            [self.allScrollView setContentOffset:CGPointMake(0, self.allScrollView.frame.size.height) animated:YES];
//            self.twoLabel.hidden = YES;
//        }
    }
    if (scrollView==allLOgisticView) {
//        if (scrollView.contentOffset.y<-30) {
//            [self.allScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//            self.twoLabel.hidden = NO;
//        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _logisticsInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* logisticsInfoCellName = @"logisticsInfoCell";
    LogisticsDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:logisticsInfoCellName];
    if(cell == nil) {
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

