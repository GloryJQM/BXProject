
//
//  ShopCartViewController.m
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ShopCartViewController.h"
#import "SuspendedView.h"
#import "ShoppingCartCell.h"
#import "SectionHeadView.h"
#import "ShoppingCartView.h"

#import "FillOutOrderViewController.h"
#import "PointFillOutOrderViewController.h"
#import "CommodityDetailViewController.h"
#import "StandardView.h" //cell对象
#import "HeaderModel.h" //头部试图对象
@interface ShopCartViewController ()<SuspendedViewDelegate, UITableViewDelegate, UITableViewDataSource, StandardViewDelegate,MJRefreshBaseViewDelegate>{
    UIImageView *imageView;
    CGFloat _sumPricePoint;
}
@property (strong,nonatomic)   MJRefreshHeaderView *header;

@property (nonatomic, strong) SuspendedView *suspendedView;
@property (nonatomic, copy) NSString *is_point_type;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ShoppingCartView *shopCartView;


@property (nonatomic, strong) StandardView *standardView;
@property (nonatomic, strong) NSString *cart_id;
@property (nonatomic, strong) NSString *goods_idStr;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NSString *user_points;
@end

@implementation ShopCartViewController

- (void)refreshTabbar {
    [BaseNavigationViewController getNumOfShopCart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestDataList];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = WHITE_COLOR2;
    self.dataArray = [NSMutableArray array];
    if (self.isPoint) {
        self.is_point_type = @"1";
    }else {
        self.is_point_type = @"0";
    }
    
    [self creationSuspendedView];
    [self creationTableView];
    [self requestDataList];
}

//懒加载头部选择按钮
- (void)creationSuspendedView {
    self.suspendedView = [[SuspendedView alloc] initWithSuspendedViewStyle:SuspendedViewStyleVaule3];
    _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 50);
    _suspendedView.delegate = self;
    _suspendedView.items = @[@"金币商城", @"积分商城"];
    _suspendedView.currentItemIndex = [self.is_point_type integerValue];
    
    _suspendedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.suspendedView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor = ColorE4E4E4;
    [_suspendedView addSubview:line];
}

- (void)creationTableView {
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 18)];
    [_rightButton addTarget:self action:@selector(handleRightItem:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    CGFloat height = 0;
    if (!self.isNotHome) {
        height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 87 - 49;
    }else {
        height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 87;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _suspendedView.maxY, UI_SCREEN_WIDTH, height)];
    _tableView.backgroundColor = WHITE_COLOR2;
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _header = [[MJRefreshHeaderView alloc]init];
    _header.delegate = self;
    _header.scrollView = _tableView;
    
    [_tableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:@"ShoppingCartCell"];
    
    __block typeof(self) weakSelf = self;
    self.shopCartView = [[ShoppingCartView alloc] initWithY:_tableView.maxY block:^(NSString *name) {
        if ([name containsString:@"全选"]) {
            [weakSelf checkAll:name];
        }else if ([name isEqualToString:@"提交订单"]) {
            [weakSelf submitOrder];
        }else if ([name isEqualToString:@"删除"]) {
            NSArray *array = [NSArray arrayWithArray:[weakSelf getGoods_idArray]];
            if (array.count == 0) {
                [SVProgressHUD showErrorWithStatus:@"您还没有选择商品"];
                return;
            }
            [weakSelf removeOrder:[array componentsJoinedByString:@","]];
        }
    }];
    [self.view addSubview:_shopCartView];
    
    [self.view sendSubviewToBack:_shopCartView];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 160) / 2, 100, 160, 130)];
    imageView.hidden = YES;
    imageView.image = [UIImage imageNamed:@"shop_cart_empty@2x"];
    [_tableView addSubview:imageView];
}

//点击headerView上的全选按钮
- (void)sectionHeadViewButton:(UIButton *)sender {
    NSInteger section = sender.tag;
    HeaderModel *headerModel = self.dataArray[section];
    headerModel.selectState = !headerModel.selectState;
    
    NSArray *goodsList = headerModel.goodsArray;
    for (ShopCartModel *shopCartModel in goodsList) {
        shopCartModel.selectState = headerModel.selectState;
    }
    [_tableView reloadData];
    [self getSumPrice];
}

//选择某个商品
- (void)selectButton:(UIButton *)sender {
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    
    HeaderModel *headerModel = self.dataArray[section];
    NSArray *goodsList = headerModel.goodsArray;
    
    ShopCartModel *shopCartModel = goodsList[row];
    shopCartModel.selectState = !shopCartModel.selectState;
    
    NSInteger index = 0;
    for (ShopCartModel *model in goodsList) {
        if (model.selectState) {
            index++;
        }
    }
    
    if (index == goodsList.count) {
        headerModel.selectState = YES;
    }else {
        headerModel.selectState = NO;
    }
    [_tableView reloadData];
    [self getSumPrice];
}

//全选
- (void)checkAll:(NSString *)string {
    BOOL isSlect = YES;
    if ([string isEqualToString:@"全选"]) {
        isSlect = YES;
    }else if ([string isEqualToString:@"取消全选"]) {
        isSlect = NO;
    }
    
    for (HeaderModel *headerModel in self.dataArray) {
        headerModel.selectState = isSlect;
        NSArray *goodsList = headerModel.goodsArray;
        for (ShopCartModel *shopCartModel in goodsList) {
            shopCartModel.selectState = isSlect;
        }
    }
    [_tableView reloadData];
    [self getSumPrice];
}


//计算总价
- (void)getSumPrice {
    CGFloat sumPrice = 0;
    NSInteger sumIndex = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        HeaderModel *headerModel = self.dataArray[i];
        NSArray *goodsList = headerModel.goodsArray;
        for (ShopCartModel *shopCartModel in goodsList) {
            if (shopCartModel.selectState) {
                CGFloat goodsPrice = [shopCartModel.goodsPrice floatValue];
                NSInteger goodsNum = [shopCartModel.goodsNum integerValue];
                sumPrice += goodsPrice * goodsNum;
                sumIndex++;
            }
        }
    }
    
    NSString *sum = [NSString stringWithFormat:@"%f", sumPrice];
    _sumPricePoint = sumPrice;
    self.shopCartView.priceLable.text = [sum moneyPoint:[self.is_point_type integerValue]];
    self.shopCartView.sumMoneyLable.text = [NSString stringWithFormat:@"已选 (%ld)", (long)sumIndex];
    
    if (sumIndex > 0) {
        self.shopCartView.selectButton.selected = YES;
    }else {
        self.shopCartView.selectButton.selected = NO;
    }
}

//提交订单
- (void)submitOrder {
    NSArray *array = [NSArray arrayWithArray:[self getGoods_idArray]];
    
    if (array.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"您还没有选择商品"];
        return;
    }
    
    if ([self.is_point_type isEqualToString:@"1"] && _sumPricePoint > [self.user_points floatValue]) {
        [SVProgressHUD showErrorWithStatus:@"您的积分不足"];
            return;
    }
    
    NSString *body = [NSString stringWithFormat:@"act=2&is_point_type=%@&ids=%@",self.is_point_type,[array componentsJoinedByString:@","]];
    [RCLAFNetworking postWithUrl:@"orderApiNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
        if ([self.is_point_type integerValue] == 1) {
            PointFillOutOrderViewController *vc = [[PointFillOutOrderViewController alloc] init];
            vc.goodsInfoDic = responseObject;
            vc.goods_attr_ids = [array componentsJoinedByString:@","];
            vc.isShopCart = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            FillOutOrderViewController *vc = [[FillOutOrderViewController alloc] init];
            vc.goodsInfoDic = responseObject;
            vc.goods_attr_ids = [array componentsJoinedByString:@","];
            vc.isShopCart = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } fail:nil];
}

//获取已选择商品的goods_id集合
- (NSMutableArray *)getGoods_idArray {
    NSMutableArray *goods_idAry = [NSMutableArray array];
    for (HeaderModel *headerModel in self.dataArray) {
        NSArray *goodsList = headerModel.goodsArray;
        for (ShopCartModel *shopCartModel in goodsList) {
            if (shopCartModel.selectState) {
                [goods_idAry addObject:shopCartModel.idStr];
            }
        }
    }
    return goods_idAry;
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectButton.tag = indexPath.section * 100 + indexPath.row;
    [cell.selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    HeaderModel *headerModel = self.dataArray[indexPath.section];
    NSArray *goodsList = headerModel.goodsArray;
    [cell addTheValue:goodsList[indexPath.row] is_point_type:[self.is_point_type integerValue] isShow:self.rightButton.selected];
    cell.button.tag = indexPath.section * 100 + indexPath.row;
    [cell.button addTarget:self action:@selector(handeleButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeaderModel *headerModel = self.dataArray[section];
    NSArray *goodsList = headerModel.goodsArray;
    return goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 122;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rightButton.selected) {
        return;
    }
    HeaderModel *headerModel = self.dataArray[indexPath.section];
    NSArray *goodsList = headerModel.goodsArray;
    
    ShopCartModel *shopCartModel = goodsList[indexPath.row];
    
    if ([shopCartModel.status isEqualToString:@"3"]) {
        [SVProgressHUD showErrorWithStatus:shopCartModel.status_info];
        return;
    }
    
    
    NSString *body = [NSString stringWithFormat:@"aid=%@", shopCartModel.relate_id];
    [RCLAFNetworking postWithUrl:@"getSupplierProductNew2.php" BodyString:body isPOST:YES success:^(id responseObject) {
        NSDictionary *contDic=[responseObject valueForKey:@"cont"];
        if ([contDic isKindOfClass:[NSDictionary class]]) {
            CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
            vc.comDetailDic = contDic;
            vc.goods_id = shopCartModel.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeadView"];
    if (!sectionHeadView) {
        sectionHeadView =  [[SectionHeadView alloc] initWithReuseIdentifier:@"sectionHeadView"];
    }
    
    sectionHeadView.checkButton.tag = section;
    [sectionHeadView.checkButton addTarget:self action:@selector(sectionHeadViewButton:) forControlEvents:UIControlEventTouchUpInside];
    HeaderModel *headerModel = self.dataArray[section];
    [sectionHeadView setHeaderModel:headerModel];
    return sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HeaderModel * headerModel = self.dataArray[indexPath.section];
    NSArray *goodsList = headerModel.goodsArray;
    if ([goodsList isKindOfClass:[NSArray class]] && goodsList != nil) {
        ShopCartModel *shopCartModel = goodsList[indexPath.row];
        [self removeOrder:shopCartModel.idStr];
    }
}
//删除购物车商品
- (void)removeOrder:(NSString *)ids {
    RCLAlertView *rclAlerView = [[RCLAlertView alloc]initWithTitle:App_Alert_Notice_Title contentText:@"是否删除" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    rclAlerView.rightBlock = ^(){
        NSString *body = [NSString stringWithFormat:@"act=2&ids=%@",ids];
        [RCLAFNetworking postWithUrl:@"mallCartApiNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
            [self refreshTabbar];
            [self requestDataList];    } fail:nil];
    };
    [rclAlerView show];
}

//取消headerView粘性效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat sectionHeaderHeight = 64; //sectionHeaderHeight
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0){
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma mark SuspendedViewDelegate 点击头部选择按钮回调
- (void)didClickView:(SuspendedView *)view atItemIndex:(NSInteger)index {
    if (index == 0) {
        self.is_point_type = @"0";
    }else {
        self.is_point_type = @"1";
    }
    [self requestDataList];
}

//请求购物车列表
- (void)requestDataList{
    NSString *body = [NSString stringWithFormat:@"is_point_type=%@&act=3",self.is_point_type];
    [RCLAFNetworking postWithUrl:@"mallCartApiNew.php" BodyString:body isPOST:YES success:^(id responseObject) {
        DLog(@"购物车列表 responseObject == %@", responseObject);
        [_header endRefreshing];
        [self.dataArray removeAllObjects];
        NSArray *list = responseObject[@"list"];
        for (NSDictionary *supplierDic in list) {
            HeaderModel *headerModel = [[HeaderModel alloc] initWithDict:supplierDic];
            [self.dataArray addObject:headerModel];
        }
        self.shopCartView.headerLabel.text = [NSString stringWithFormat:@"您当前剩余%@积分", responseObject[@"user_points"]];
        self.user_points = [NSString stringWithFormat:@"%@", responseObject[@"user_points"]];
        
        [_tableView reloadData];
        [self getSumPrice];
        [self isShowImageView];
        [self isShowHeaderView];
        [self refreshTabbar];
    } fail:^(NSError *error) {
        [_header endRefreshing];
    }];
}


- (void)isShowImageView {
    if (self.dataArray.count > 0) {
        imageView.hidden = YES;
    }else {
        imageView.hidden = NO;
    }
}

- (void)handleRightItem:(UIButton *)sender {
    [self requestDataList];
    if (!sender.selected) {
        [self.shopCartView.button setTitle:@"删除" forState:UIControlStateNormal];
        self.shopCartView.button.backgroundColor = ColorD0011B;
        self.shopCartView.priceLable.hidden = YES;
    }else {
        [self.shopCartView.button setTitle:@"提交订单" forState:UIControlStateNormal];
        self.shopCartView.button.backgroundColor = App_Main_Color;
        self.shopCartView.priceLable.hidden = NO;
    }
    sender.selected = !sender.selected;
}

- (void)handeleButton:(UIButton *)sender {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    
    HeaderModel *headerModel = self.dataArray[section];
    NSArray *goodsList = headerModel.goodsArray;
    
    ShopCartModel *shopCartModel = goodsList[row];
    
    self.cart_id = shopCartModel.idStr;
    self.goods_idStr = shopCartModel.goods_id;
    NSString *body = [NSString stringWithFormat:@"aid=%@", shopCartModel.relate_id];
    [RCLAFNetworking postWithUrl:@"getSupplierProductNew2.php" BodyString:body isPOST:YES success:^(id responseObject) {
        NSDictionary *contDic=[responseObject valueForKey:@"cont"];
        if ([contDic isKindOfClass:[NSDictionary class]]) {
            self.standardView = [[StandardView alloc] initWithDic:contDic title:@"加入购物车" goods_id:self.goods_idStr];
            _standardView.delegate = self;
            _standardView.number = [shopCartModel.goodsNum integerValue];
            [window addSubview:_standardView];
        }
    } fail:nil];
}

#pragma mark StandardViewDelegate 重新选择购物车
- (void)standardTitleStr:(NSString *)titleStr goods_id:(NSString *)goods_id goods_num:(NSInteger)goods_num attr_id:(NSString *)attr_id {
    NSString *bodyStr = [NSString stringWithFormat:@"act=4&ids=%@&goods_id=%@&goods_number=%ld", self.cart_id,goods_id,(long)goods_num];
    [RCLAFNetworking postWithUrl:@"mallCartApiNew.php" BodyString:bodyStr isPOST:YES success:^(id responseObject) {
        [self refreshTabbar];
        [self requestDataList];
    } fail:nil];
    
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    [self requestDataList];
}

- (void)isShowHeaderView {
    if (self.dataArray.count == 0) {
        _shopCartView.hidden = YES;
        _rightButton.userInteractionEnabled = NO;
    }else {
        _shopCartView.hidden = NO;
        _rightButton.userInteractionEnabled = YES;
    }
    CGFloat height = 0;
    if ([self.is_point_type isEqualToString:@"1"]) {
        if (!self.isNotHome) {
            height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 87 - 49;
        }else {
            height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 87;
        }
        self.shopCartView.headerView.hidden = NO;
        _tableView.frame = CGRectMake(0, _suspendedView.maxY, UI_SCREEN_WIDTH, height);
    }else {
        if (!self.isNotHome) {
            height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 55 - 49;
        }else {
            height = UI_SCREEN_HEIGHT - _suspendedView.maxY - 64 - 55;
        }
        self.shopCartView.headerView.hidden = YES;
        _tableView.frame = CGRectMake(0, _suspendedView.maxY, UI_SCREEN_WIDTH, height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
