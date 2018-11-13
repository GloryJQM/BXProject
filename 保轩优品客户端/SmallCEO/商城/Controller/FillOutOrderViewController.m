//
//  FillOutOrderViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "FillOutOrderViewController.h"
#import "AddressView.h"
#import "SupplierView.h"
#import "PayOrderViewController.h"

#import "AdrListViewController.h"
#import "StoreBuyViewController.h"
#import "FreightStateView.h"
@interface FillOutOrderViewController ()
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UILabel *voucher;
@property (nonatomic, strong) UILabel *voucherPrice;
@property (nonatomic, strong) UISwitch *aSwitch;
@property (nonatomic, copy) NSString *countdown;

@property (nonatomic, strong) AddressView *addressView;

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *voucherhint;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, copy) NSString *contacts_id;

@property (nonatomic, assign) NSInteger receiving_method;

@property (nonatomic, strong) FreightStateView *freightStateView;
@end

@implementation FillOutOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    self.view.backgroundColor = backWhite;
    self.countdown = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"pay_info"][@"use_coupon"]];
    self.receiving_method = 0;
    [self creationScrollView];
}

- (void)creationScrollView {
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64 - 50)];
    _mainScrollView.backgroundColor = backWhite;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    __block typeof(self) weakSelf = self;
    self.addressView = [[AddressView alloc] initWithY:0 is_point_type:0 Block:^{
        AdrListViewController *vc = [[AdrListViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        vc.wp = 0;
        vc.hdBlock = ^(NSDictionary* dic,long index) {
            self.contacts_id = [NSString stringWithFormat:@"%@", dic[@"contacts_id"]];
            self.receiving_method = 2;
            [_addressView setDictionary:dic];
            _mainView.frame = CGRectMake(0, _addressView.maxY + 10, UI_SCREEN_WIDTH, _mainView.height);
            _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY + 30);
        };
    }];
    [_mainScrollView addSubview:_addressView];
    self.contacts_id = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"contacts_id"]];
    [_addressView setDictionary:self.goodsInfoDic[@"delivery_info"][@"express"]];
    
    if ([self.contacts_id isBlankString]) {
        self.receiving_method = 2;
    }
    

    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.addressView.maxY + 10, UI_SCREEN_WIDTH, 0)];
    [_mainScrollView addSubview:_mainView];
    
    CGFloat supplierY = 0;
    NSDictionary *goods_info = self.goodsInfoDic[@"goods_info"];
    NSArray *goods_list = goods_info[@"goods_list"];
    for (int i = 0; i < goods_list.count; i++) {
        SupplierView *supplierView = [[SupplierView alloc] initWithY:supplierY dataDic:goods_list[i] is_point_type:0];
        [_mainView addSubview:supplierView];
        
        supplierY = supplierView.maxY + 10;
    }
    
        UIView *voucherView = [[UIView alloc] initWithFrame:CGRectMake(0, supplierY, UI_SCREEN_WIDTH, 50)];
        voucherView.backgroundColor = [UIColor whiteColor];
        [_mainView addSubview:voucherView];
        
        UILabel *voucherLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
        voucherLabel.text = @"代金券抵扣";
        voucherLabel.textAlignment = NSTextAlignmentLeft;
        voucherLabel.font = [UIFont systemFontOfSize:14];
        voucherLabel.textColor = Color0E0E0E;
        [voucherView addSubview:voucherLabel];
        
        self.aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 70, 10, 100, 30)];
        [_aSwitch addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
        _aSwitch.onTintColor = App_Main_Color;
        [_aSwitch setOn:NO];
        [voucherView addSubview:_aSwitch];
        
        self.voucherhint = [[UILabel alloc] initWithFrame:CGRectMake(voucherLabel.maxX + 10, 17, UI_SCREEN_WIDTH - voucherLabel.maxX - 90, 20)];
        NSString *coupon = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"coupon"]];
        NSString *use_coupon = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"pay_info"][@"use_coupon"]];
        _voucherhint.text = [NSString stringWithFormat:@"剩余代金券%@, 可抵扣%@", [coupon money], [use_coupon money]];
        _voucherhint.textAlignment = NSTextAlignmentLeft;
        _voucherhint.font = [UIFont systemFontOfSize:12];
        _voucherhint.textColor = Color161616;
        _voucherhint.numberOfLines = 0;
        CGSize vouSize = [_voucherhint sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - voucherLabel.maxX - 90, 20)];

        _voucherhint.frame = CGRectMake(voucherLabel.maxX + 10, (50 - vouSize.height) / 2, UI_SCREEN_WIDTH - voucherLabel.maxX - 90, vouSize.height);
        [voucherView addSubview:_voucherhint];
        
        self.voucher = [[UILabel alloc] initWithFrame:CGRectMake(15, voucherView.maxY + 15, UI_SCREEN_WIDTH - 30, 20)];
        _voucher.text = @"使用代金券将无法使用金币支付";
        _voucher.textAlignment = NSTextAlignmentLeft;
        _voucher.font = [UIFont systemFontOfSize:12];
        _voucher.textColor = ColorB0B8BA;
        [_mainView addSubview:_voucher];
        
        supplierY = _voucher.maxY + 10;
    
    
    NSArray *titleArray = @[@"商品合计", @"代金券抵扣", @"运费"];
    NSArray *contentArray = @[@"goods_total_money", @"", @"shsm_freight"];
    NSDictionary *pay_info = self.goodsInfoDic[@"pay_info"];

    for (int i = 0; i < titleArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, supplierY, UI_SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        [_mainView addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
        titleLabel.text = titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = Color0E0E0E;
        CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(100, 20)];
        titleLabel.frame = CGRectMake(15, 15, titleSize.width, 20);
        [view addSubview:titleLabel];
        
        if ([titleArray[i] isEqualToString:@"运费"]) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.maxX + 6, titleLabel.minY + 2, 16, 16)];
            [button setImage:[UIImage imageNamed:@"疑问@2x"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
        
        NSString *goods_total_money = [NSString stringWithFormat:@"%@", pay_info[contentArray[i]]];
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.maxX + 10, 15, UI_SCREEN_WIDTH - titleLabel.maxX - 25, 20)];
        priceLabel.text = [goods_total_money money];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = Color0E0E0E;
        [view addSubview:priceLabel];
        
        [view addLineWithY:49.5];
        
        supplierY = view.maxY;
        
        if ([titleArray[i] isEqualToString:@"代金券抵扣"]) {
            self.voucherPrice = priceLabel;
        }
    }
    
    _mainView.frame = CGRectMake(0, _mainView.minY, UI_SCREEN_WIDTH, supplierY + 30);
    _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY);
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _mainScrollView.maxY, UI_SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    NSString *total_money = [NSString stringWithFormat:@"%@", pay_info[@"total_money"]];

    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, UI_SCREEN_WIDTH - 150, 20)];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = Color74828B;
    [bottomView addSubview:_priceLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = App_Main_Color;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(UI_SCREEN_WIDTH - 140, 0, 140, bottomView.height);
    [bottomView addSubview:button];
    
    NSString *priceString =[NSString stringWithFormat:@"应付金额 %@", [total_money money]];
    _priceLabel.attributedText = [priceString String:[total_money money] Color:ColorD0011B];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
}

- (void)handleSwitch:(UISwitch *)sender {
    NSDictionary *pay_info = self.goodsInfoDic[@"pay_info"];
    if (!sender.isOn) {
        NSString *coupon = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"coupon"]];
        NSString *use_coupon = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"pay_info"][@"use_coupon"]];
        _voucherhint.text = [NSString stringWithFormat:@"剩余代金券%@, 可抵扣%@", [coupon money], [use_coupon money]];
        CGSize vouSize = [_voucherhint sizeThatFits:CGSizeMake(_voucherhint.width, 20)];
        _voucherhint.frame = CGRectMake(_voucherhint.minX, (50 - vouSize.height) / 2, _voucherhint.width, vouSize.height);
        
        self.voucherPrice.text = @"¥0.00";
        NSString *total_money = [NSString stringWithFormat:@"%@", pay_info[@"total_money"]];
        NSString *priceString = [NSString stringWithFormat:@"应付金额 %@", [total_money money]];
        self.priceLabel.attributedText =  [priceString String:[total_money money] Color:ColorD0011B];
        
    }else {
        self.voucherPrice.text = [NSString stringWithFormat:@"-%@", [self.countdown money]];
        NSString *total_money_coupon = [NSString stringWithFormat:@"%@", pay_info[@"total_money_coupon"]];
        NSString *priceString = [NSString stringWithFormat:@"应付金额 %@", [total_money_coupon money]];
        self.priceLabel.attributedText =  [priceString String:[total_money_coupon money] Color:ColorD0011B];
        
        NSString *use_coupon = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"pay_info"][@"use_coupon"]];
        _voucherhint.text = [NSString stringWithFormat:@"已使用代金券, 抵扣%@", [use_coupon money]];
        CGSize vouSize = [_voucherhint sizeThatFits:CGSizeMake(_voucherhint.width, 20)];
        _voucherhint.frame = CGRectMake(_voucherhint.minX, (50 - vouSize.height) / 2, _voucherhint.width, vouSize.height);
    }
}

//提交订单按钮
- (void)submitOrder {
    if (self.receiving_method > 0 && [self.contacts_id isBlankString]) {
        PayOrderViewController *vc = [[PayOrderViewController alloc] init];
        vc.dataDic = self.goodsInfoDic[@"pay_info"];
        vc.contacts_id = self.contacts_id;
        if (self.aSwitch.isOn && [self.countdown floatValue] > 0) {
            vc.isVoucher = YES;
            vc.use_coupon = self.countdown;
        }else {
            vc.isVoucher = NO;
            vc.use_coupon = @"0";
        }
        vc.is_point_type = 0;
        vc.goods_attr_ids = self.goods_attr_ids;
        vc.goods_id = self.goods_id;
        vc.goods_num = self.goods_num;
        vc.receiving_method = self.receiving_method;
        vc.user_points = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"user_gold"]];
        vc.isShopCart = self.isShopCart;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请选择一个提货或收货地址"];
    }
}

//点击问好显示提示
- (void)handleButton:(UIButton *)sender {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1000)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(remoButton:) forControlEvents:UIControlEventTouchUpInside];
    button.alpha = 0.2;
    [window addSubview:button];
    
    CGFloat excursion = _mainScrollView.contentOffset.y;
    self.freightStateView = [[FreightStateView alloc] initWithY:_mainView.minY + sender.superview.minY + 64 - excursion dataDic:self.goodsInfoDic[@"freight_info"] is_point_type:0];
    [window addSubview:_freightStateView];
}

- (void)remoButton:(UIButton *)sender {
    [sender removeFromSuperview];
    [_freightStateView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
