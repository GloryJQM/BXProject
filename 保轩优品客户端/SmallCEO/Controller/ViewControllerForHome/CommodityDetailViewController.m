//
//  CommodityDetailViewController.m
//  Lemuji
//
//  Created by quanmai on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//



#import "CommodityDetailViewController.h"
#import "SlideScrollView.h" //整体的滚动试图
#import "BannerScrollView.h" //自定义自动轮播图
#import "JJPhotoManeger.h"
#import "CommodityDetailsView.h"
#import "BottomView.h"
#import "StandardView.h"

#import "LoginViewController.h"
#import "ShopCartViewController.h"
#import "FillOutOrderViewController.h"
#import "PointFillOutOrderViewController.h"
@interface CommodityDetailViewController ()<BannerScrollNetDelegate, JJPhotoDelegate, StandardViewDelegate, UIWebViewDelegate> {
    CGFloat _webMinX;
}
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *bannerImageArray;
@property (nonatomic, strong) BottomView *bottomView;
@property (nonatomic, strong) StandardView *standardView;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) UIWebView *wView;

@property (nonatomic, strong) SlideScrollView *slideScrollView;

@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.amount = 1;
    self.imageArray = [NSMutableArray array];
    self.bannerImageArray = [NSMutableArray array];
    [self creationScrollView];
    [self creationButton];
    [self getShopCartGoodsCount];
}

- (void)creationScrollView {
    self.slideScrollView = [[SlideScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    [self.view addSubview:_slideScrollView];
    
    NSString *h5String=[NSString stringWithFormat:@"%@",[self.comDetailDic valueForKey:@"canshu"]];
    _slideScrollView.loadImagesScrollView.imageUrlArr=[NSString getImageArrWtihH5string:h5String];
    
    NSArray *pro_ablumAry = [self.comDetailDic objectForKey:@"pro_ablum"];
    for (NSDictionary *dic in pro_ablumAry) {
        [self.imageArray addObject:dic[@"filename"]];
    }
    
    BannerScrollView *localScrollView = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH) WithNetImages:self.imageArray];
    localScrollView.AutoScrollDelay = 2;
    localScrollView.netDelagate = self;
    [_slideScrollView.firstScrollView addSubview:localScrollView];
    
    CommodityDetailsView *commodityDetailsView = [[CommodityDetailsView alloc] initWithY:UI_SCREEN_WIDTH DataDic:self.comDetailDic];
    [_slideScrollView.firstScrollView addSubview:commodityDetailsView];
    
    CGFloat heightMay = commodityDetailsView.maxY + 10;
    
    NSString *jsString=[NSString stringWithFormat:@"%@",[self.comDetailDic valueForKey:@"description"]];
    if ([jsString isBlankString]) {
        _webMinX = commodityDetailsView.maxY;
        self.wView=[[UIWebView alloc] initWithFrame:CGRectMake(0, commodityDetailsView.maxY, UI_SCREEN_WIDTH, 100)];
        [_wView loadHTMLString:jsString baseURL:nil];
        _wView.delegate = self;
        _wView.scrollView.userInteractionEnabled = YES;
        _wView.scrollView.scrollEnabled = NO;
        _wView.userInteractionEnabled = YES;
        [_slideScrollView.firstScrollView addSubview:_wView];
        
        heightMay = _wView.maxY + 10;
    }
    
    _slideScrollView.firstScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, heightMay);
    
    NSString *is_point_type =  [NSString stringWithFormat:@"%@", self.comDetailDic[@"is_point_type"]];
    if (![is_point_type isBlankString]) {
        is_point_type = @"0";
    }
    
    __block typeof(self) weakSelf = self;
    self.bottomView = [[BottomView alloc] initWithBlock:^(NSString *titleString) {
        if ([titleString isEqualToString:@"购物车"]) {
            [weakSelf goShopCart];
        }
        if ([titleString isEqualToString:@"加入购物车"]) {
            [self addStandardView:titleString];
        }
        if ([titleString isEqualToString:@"立即购买"] || [titleString isEqualToString:@"立即兑换"]) {
            [self addStandardView:titleString];
        }
        if ([titleString isEqualToString:@"收藏"] || [titleString isEqualToString:@"取消收藏"]) {
            [weakSelf collectGoods:titleString];
        }
    } is_point_type:[is_point_type integerValue]];
    
    if ([[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        self.bottomView.isCollect = [[self.comDetailDic objectForKey:@"is_already_collection"] integerValue];
    }
    [self.view addSubview:_bottomView];
}

- (void)addStandardView:(NSString *)string {
    self.standardView = [[StandardView alloc] initWithDic:self.comDetailDic title:string goods_id:self.goods_id];
    _standardView.delegate = self;
    [self.view addSubview:_standardView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = _wView.scrollView.contentSize.height;
    
    if (webViewHeight > 100) {
        _wView.frame = CGRectMake(0, _webMinX, UI_SCREEN_WIDTH, webViewHeight);
        _slideScrollView.firstScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _wView.maxY + 10);
    }
}

#pragma mark 
- (void)standardTitleStr:(NSString *)titleStr goods_id:(NSString *)goods_id goods_num:(NSInteger)goods_num attr_id:(NSString *)attr_id{
    DLog(@"%@----%@", titleStr, goods_id);
    if ([titleStr isEqualToString:@"立即购买"] || [titleStr isEqualToString:@"立即兑换"]) {
        if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LoginViewController performIfLogin:self withShowTab:NO loginAlreadyBlock:^{
                    [self goods_id:goods_id goods_num:goods_num attr_id:attr_id];
                }loginSuccessBlock:nil];
            });
        }else {
            [self goods_id:goods_id goods_num:goods_num attr_id:attr_id];
        }
    }else {
        if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LoginViewController performIfLogin:self withShowTab:NO loginAlreadyBlock:^{
                    [self addtoShopCart:goods_id amount:goods_num];
                }loginSuccessBlock:nil];
            });
        }else {
            [self addtoShopCart:goods_id amount:goods_num];
        }
    }
}

//加入购物车
- (void)addtoShopCart:(NSString *)string amount:(NSInteger)amount{
    NSString *bodyStr = [NSString stringWithFormat:@"act=1&goods_num=%ld&goods_id=%@", (long)amount, string];
    [RCLAFNetworking noSVPPostWithUrl:@"mallCartApiNew.php" BodyString:bodyStr success:^(id responseObject) {
        [SVProgressHUD showCorrectWithStatus:@"添加成功"];
        [self getShopCartGoodsCount];
    } fail:nil];
}

//立即购买
- (void)goods_id:(NSString *)goods_id goods_num:(NSInteger)goods_num attr_id:(NSString *)attr_id{
    NSString *body = [NSString stringWithFormat:@"act=1&goods_id=%@&goods_num=%ld&goods_attr_ids=%@", goods_id, (long)goods_num, attr_id];
    [RCLAFNetworking postWithUrl:@"orderApiNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
        if ([self.comDetailDic[@"is_point_type"] integerValue] == 1) {
            PointFillOutOrderViewController *vc = [[PointFillOutOrderViewController alloc] init];
            vc.goodsInfoDic = responseObject;
            vc.goods_num = goods_num;
            vc.goods_attr_ids = attr_id;
            vc.goods_id = goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            FillOutOrderViewController *vc = [[FillOutOrderViewController alloc] init];
            vc.goodsInfoDic = responseObject;
            vc.goods_num = goods_num;
            vc.goods_attr_ids = attr_id;
            vc.goods_id = goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:nil];
}

#pragma mark - 获取购物车的个数
- (void)getShopCartGoodsCount {
    if(![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        return;
    }
    [RCLAFNetworking postWithUrl:@"addcart.php" BodyString:@"type=6" isPOST:YES success:^(id responseObject) {
        NSString *countStr = [NSString stringWithFormat:@"%@", [[responseObject objectForKey:@"content"] objectForKey:@"count"]];
        self.bottomView.countStr = countStr;
    } fail:nil];
}

#pragma mark - 前往购物车
- (void)goShopCart {
    NSString *is_point_type =  [NSString stringWithFormat:@"%@", self.comDetailDic[@"is_point_type"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoginViewController performIfLogin:self withShowTab:NO loginAlreadyBlock:^{
            ShopCartViewController* vc = [[ShopCartViewController alloc]init];
            vc.isNotHome = YES;
            vc.isPoint = [is_point_type integerValue];
            [self.navigationController pushViewController:vc animated:YES];
        }loginSuccessBlock:nil];
    });
}

#pragma mark - 收藏
- (void)collectGoods:(NSString *)titleString {
    if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LoginViewController performIfLogin:self withShowTab:NO loginAlreadyBlock:^{
                [self joinGoods:titleString];
            } loginSuccessBlock:nil];
        });
    }else {
        [self joinGoods:titleString];
    }
}

- (void)joinGoods:(NSString *)string {
    NSString *bodyStr;
    NSString *aid=[NSString stringWithFormat:@"%@",[self.comDetailDic valueForKey:@"aid"]];
    if ([string isEqualToString:@"收藏"]) {
        bodyStr = [NSString stringWithFormat:@"&type=collection&come_way=1&goods_id=%@", aid];
    }else if ([string isEqualToString:@"取消收藏"]) {
        bodyStr = [NSString stringWithFormat:@"&type=cancel&come_way=1&goods_id=%@",aid];
    }

    [RCLAFNetworking noSVPPostWithUrl:@"goods_collection.php" BodyString:bodyStr success:^(id responseObject) {
        [SVProgressHUD showCorrectWithStatus:[responseObject objectForKey:@"info"]];
        self.bottomView.collectButton.selected = !self.bottomView.collectButton.selected;
    } fail:nil];
}

/** 点中自动轮播图后触发*/
-(void)didSelectedNetImageAtIndex:(NSInteger)index{
    [self checkImageView:index array:nil];
}

- (void)checkImageView:(NSInteger)index array:(NSArray *)ary{
    [self.bannerImageArray removeAllObjects];
    NSArray *array;
    if (ary.count > 0) {
        array = ary;
    }else {
        array = self.imageArray;
    }
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:nil];
        [_bannerImageArray addObject:imageview];
    }
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    mg.viewController = self.navigationController;
    [mg showLocalPhotoViewer:_bannerImageArray selecView:_bannerImageArray[index]];
}

- (void)creationButton {
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 44, 44)];
    [returnBtn addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
    [returnBtn setImage:[UIImage imageNamed:@"commodityreturn@2x"] forState:UIControlStateNormal];
    [self.view addSubview:returnBtn];
}

- (void)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
