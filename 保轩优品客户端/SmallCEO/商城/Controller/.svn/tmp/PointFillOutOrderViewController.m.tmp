//
//  PointFillOutOrderViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/26.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PointFillOutOrderViewController.h"
#import "AddressView.h"
#import "SupplierView.h"
#import "AdrListViewController.h"
#import "StoreBuyViewController.h"

#import "PayOrderViewController.h"

#import "FreightStateView.h"
@interface PointFillOutOrderViewController (){
    UILabel *_freightLabel;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UILabel *voucherPrice;

@property (nonatomic, strong) AddressView *addressView;
@property (nonatomic, strong) AddressView *pointaddressView;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, copy) NSString *contacts_id;
@property (nonatomic, copy) NSString *contacts_id1;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSInteger receiving_method;

@property (nonatomic, strong) FreightStateView *freightStateView;
@end

@implementation PointFillOutOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    self.view.backgroundColor = backWhite;
    self.receiving_method = 0;
    [self creationScrollView];
}

- (void)creationScrollView {
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64 - 65)];
    _mainScrollView.backgroundColor = backWhite;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    __block typeof(self) weakSelf = self;
    self.addressView = [[AddressView alloc] initWithY:0 is_point_type:1 Block:^{
        AdrListViewController *vc = [[AdrListViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        vc.wp = 0;
        vc.hdBlock = ^(NSDictionary* dic,long index) {
            weakSelf.contacts_id = [NSString stringWithFormat:@"%@", dic[@"contacts_id"]];
            DLog(@"送货上们-----%@", weakSelf.contacts_id);
            weakSelf.receiving_method = 2;
            [_addressView setDictionary:dic];
            
            weakSelf.button.selected = NO;
            weakSelf.button = _addressView.seleButton;
            _addressView.seleButton.selected = YES;
            
            _pointaddressView.frame = CGRectMake(0, _addressView.maxY + 10, UI_SCREEN_WIDTH, _pointaddressView.height);
            _mainView.frame = CGRectMake(0, _pointaddressView.maxY + 10, UI_SCREEN_WIDTH, _mainView.height);
            _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY + 30);
            
            [weakSelf isFreeShipping];
        };
    }];
    [_addressView.seleButton addTarget:self action:@selector(handleAddress) forControlEvents:UIControlEventTouchUpInside];
    _addressView.seleButton.tag = 2;
    [_mainScrollView addSubview:_addressView];
    self.contacts_id = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"contacts_id"]];
    [_addressView setDictionary:self.goodsInfoDic[@"delivery_info"][@"express"]];
    if ([self.contacts_id isBlankString]) {
        self.receiving_method = 2;
    }
    
    if (_addressView.seleButton.selected) {
        self.button = _addressView.seleButton;
    }
    
    self.pointaddressView = [[AddressView alloc] initWithY:self.addressView.maxY + 10 is_point_type:1 Block:^{
        StoreBuyViewController* vc = [[StoreBuyViewController alloc]init];
        vc.returnBlock=^(NSDictionary *dic, long index){
            weakSelf.contacts_id1 = [NSString stringWithFormat:@"%@", dic[@"contacts_id"]];
            weakSelf.receiving_method = 1;
            DLog(@"到店取货-----%@", weakSelf.contacts_id1);
            [_pointaddressView setPointDictionary:dic];
            
            weakSelf.button.selected = NO;
            weakSelf.button = _pointaddressView.seleButton;
            _pointaddressView.seleButton.selected = YES;
            
            _pointaddressView.frame = CGRectMake(0, _addressView.maxY + 10, UI_SCREEN_WIDTH, _pointaddressView.height);
            _mainView.frame = CGRectMake(0, _pointaddressView.maxY + 10, UI_SCREEN_WIDTH, _mainView.height);
            _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY + 30);
            [weakSelf isFreeShipping];
            
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [_mainScrollView addSubview:_pointaddressView];
    [_pointaddressView.seleButton addTarget:self action:@selector(handlePointAddress) forControlEvents:UIControlEventTouchUpInside];
    _pointaddressView.seleButton.tag = 1;
    [_pointaddressView setPointDictionary:nil];
    _pointaddressView.tihuo_info = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"tihuo_info"]];

    
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pointaddressView.maxY + 10, UI_SCREEN_WIDTH, 0)];
    [_mainScrollView addSubview:_mainView];
    
    CGFloat supplierY = 0;
    NSDictionary *goods_info = self.goodsInfoDic[@"goods_info"];
    NSArray *goods_list = goods_info[@"goods_list"];
    for (int i = 0; i < goods_list.count; i++) {
        SupplierView *supplierView = [[SupplierView alloc] initWithY:supplierY dataDic:goods_list[i] is_point_type:1];
        [_mainView addSubview:supplierView];
        
        supplierY = supplierView.maxY + 10;
    }
    
    NSArray *titleArray = @[@"商品合计", @"运费"];
    NSArray *contentArray = @[@"goods_total_money", @"shsm_freight"];
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
        if (i == titleArray.count - 1) {
            priceLabel.text = [goods_total_money money];
            _freightLabel = priceLabel;
        }else {
            priceLabel.text = [goods_total_money moneyPoint:1];
        }
        
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = Color0E0E0E;
        [view addSubview:priceLabel];
        
        [view addLineWithY:49.5];
        
        supplierY = view.maxY;
    }
    
    _mainView.frame = CGRectMake(0, _mainView.minY, UI_SCREEN_WIDTH, supplierY + 30);
    _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _mainScrollView.maxY, UI_SCREEN_WIDTH, 65)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    NSString *total_money = [NSString stringWithFormat:@"%@", pay_info[@"total_money"]];
    NSString *freight = [NSString stringWithFormat:@"%@", pay_info[@"shsm_freight"]];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, UI_SCREEN_WIDTH - 150, 20)];
    price.textAlignment = NSTextAlignmentLeft;
    price.text = @"总额";
    price.font = [UIFont systemFontOfSize:14];
    price.textColor = Color74828B;
    [bottomView addSubview:price];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, price.maxY, UI_SCREEN_WIDTH - 150, 20)];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = ColorD0011B;
    _priceLabel.text = [NSString stringWithFormat:@"%@(运费%@)", [total_money moneyPoint:1], [freight money]];
    [bottomView addSubview:_priceLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = App_Main_Color;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(UI_SCREEN_WIDTH - 140, 0, 140, bottomView.height);
    [bottomView addSubview:button];
    [button setTitle:@"立即兑换" forState:UIControlStateNormal];
}

- (void)handleAddress {
    if ([self.contacts_id isBlankString]) {
        self.button.selected = NO;
        self.button = _addressView.seleButton;
        _addressView.seleButton.selected = YES;
        self.receiving_method = 2;
        [self isFreeShipping];
    }else {
        AdrListViewController *vc = [[AdrListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.wp = 0;
        vc.hdBlock = ^(NSDictionary* dic,long index) {
            self.contacts_id = [NSString stringWithFormat:@"%@", dic[@"contacts_id"]];
            DLog(@"送货上们-----%@", self.contacts_id);
            self.receiving_method = 2;
            [_addressView setDictionary:dic];
            
            self.button.selected = NO;
            self.button = _addressView.seleButton;
            _addressView.seleButton.selected = YES;
            
            _pointaddressView.frame = CGRectMake(0, _addressView.maxY + 10, UI_SCREEN_WIDTH, _pointaddressView.height);
            _mainView.frame = CGRectMake(0, _pointaddressView.maxY + 10, UI_SCREEN_WIDTH, _mainView.height);
            _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY + 30);
            
            [self isFreeShipping];
            
        };
    }
    
}

- (void)handlePointAddress {
    if ([self.contacts_id1 isBlankString]) {
        self.button.selected = NO;
        self.button = _pointaddressView.seleButton;
        _pointaddressView.seleButton.selected = YES;
        self.receiving_method = 1;
        [self isFreeShipping];
    }else {
        StoreBuyViewController* vc = [[StoreBuyViewController alloc]init];
        vc.returnBlock=^(NSDictionary *dic, long index){
            self.contacts_id1 = [NSString stringWithFormat:@"%@", dic[@"contacts_id"]];
            self.receiving_method = 1;
            DLog(@"到店取货-----%@", self.contacts_id1);
            [_pointaddressView setPointDictionary:dic];
            
            self.button.selected = NO;
            self.button = _pointaddressView.seleButton;
            _pointaddressView.seleButton.selected = YES;
            
            _pointaddressView.frame = CGRectMake(0, _addressView.maxY + 10, UI_SCREEN_WIDTH, _pointaddressView.height);
            _mainView.frame = CGRectMake(0, _pointaddressView.maxY + 10, UI_SCREEN_WIDTH, _mainView.height);
            _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _mainView.maxY + 30);
            
            [self isFreeShipping];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//提交订单按钮
- (void)submitOrder {
    NSDictionary *pay_info = self.goodsInfoDic[@"pay_info"];
    CGFloat use_coupon_points_price = [pay_info[@"use_coupon_points_price"] floatValue];
    CGFloat total_money = [pay_info[@"total_money"] floatValue];
    if (total_money < use_coupon_points_price) {
        NSString *message = [NSString stringWithFormat:@"您所选商品积分总额不足%.f，无法兑换！", use_coupon_points_price];
        [SVProgressHUD showErrorWithStatus:message];
        return;
    }
    
    NSString *contacts;
    if (self.button.tag == 1) {
        contacts = self.contacts_id1;
    }else {
        contacts = self.contacts_id;
    }
    
    if (self.receiving_method > 0 && [contacts isBlankString]) {
        if (self.receiving_method == 1) {
            DLog(@"到店取货-----%@", contacts);
        }else if (self.receiving_method == 2) {
            DLog(@"送货上们-----%@", contacts);
        }
        PayOrderViewController *vc = [[PayOrderViewController alloc] init];
        vc.dataDic = self.goodsInfoDic[@"pay_info"];
        vc.contacts_id = contacts;
        vc.isVoucher = NO;
        vc.use_coupon = @"0";
        vc.is_point_type = 1;
        vc.goods_attr_ids = self.goods_attr_ids;
        vc.goods_id = self.goods_id;
        vc.goods_num = self.goods_num;
        vc.receiving_method = self.receiving_method;
        vc.user_points = [NSString stringWithFormat:@"%@", self.goodsInfoDic[@"delivery_info"][@"express"][@"user_points"]];
        vc.isShopCart = self.isShopCart;
        vc.freight = [self freight];
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
    self.freightStateView = [[FreightStateView alloc] initWithY:_mainView.minY + sender.superview.minY + 64 - excursion dataDic:self.goodsInfoDic[@"freight_info"] is_point_type:1];
    [window addSubview:_freightStateView];
}

- (void)remoButton:(UIButton *)sender {
    [sender removeFromSuperview];
    [_freightStateView removeFromSuperview];
}

- (void)isFreeShipping {
    NSDictionary *pay_info = self.goodsInfoDic[@"pay_info"];
    CGFloat total_money = [pay_info[@"total_money"] floatValue];
    
    if (self.receiving_method == 1) {
        NSString *ddqh_freight = [NSString stringWithFormat:@"%@", pay_info[@"ddqh_freight"]];
        _freightLabel.text = [ddqh_freight money];
        if ([ddqh_freight floatValue] > 0) {
           _priceLabel.text = [NSString stringWithFormat:@"%@(运费%@)", [[NSString stringWithFormat:@"%f", total_money] moneyPoint:1], [ddqh_freight money]];
        }else {
            _priceLabel.text = [NSString stringWithFormat:@"%@", [[NSString stringWithFormat:@"%f", total_money] moneyPoint:1]];
        }
        
    }else {
        NSString *shsm_freight = [NSString stringWithFormat:@"%@", pay_info[@"shsm_freight"]];
        _freightLabel.text = [shsm_freight money];
        _priceLabel.text = [NSString stringWithFormat:@"%@(运费%@)", [[NSString stringWithFormat:@"%f", total_money] moneyPoint:1], [shsm_freight money]];
    }
}

- (CGFloat)freight {
    NSDictionary *pay_info = self.goodsInfoDic[@"pay_info"];
    
    NSString *freight;
    if (self.receiving_method == 1) {
        freight = [NSString stringWithFormat:@"%@", pay_info[@"ddqh_freight"]];
    }else {
        freight = [NSString stringWithFormat:@"%@", pay_info[@"shsm_freight"]];
    }
    return [freight floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
