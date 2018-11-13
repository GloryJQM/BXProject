//
//  ClassifyViewController.m
//  SmallCEO
//
//  Created by nixingfu on 16/3/14.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ScreenView.h"
#import "ListCollectionViewCell.h"
#import "CommodityDetailViewController.h"
#import "SearchViewController.h"
#import "ScreenTableView.h"
@interface ClassifyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MJRefreshBaseViewDelegate>
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSString *sort_type;//选择的条件
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *childrenArray;

@property (strong,nonatomic)   MJRefreshHeaderView *header;
@property (strong,nonatomic)   MJRefreshFooterView *footer;

@property (nonatomic, strong) ScreenTableView *screenTableView;
@end

@implementation ClassifyViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.curPage = 1;
    self.cid = 1;
    self.sort_type = @"";
    self.dataArray = [NSMutableArray array];
    self.childrenArray = [NSMutableArray array];
    [self createNagivationBarView];
    [self creationTitleView];
    [self creationCollectionView];
    [self getDataForClassify];
    [self getDataForClassifySec];
    
}

- (void)creationCollectionView {
    NSInteger countPerRow = 2;
    CGFloat itemWidth = (UI_SCREEN_WIDTH - 1 - 45) / (countPerRow * 1.0);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + 100);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 44 - 64 - 49) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:@"ListCollectionViewCell"];
    
    _header = [[MJRefreshHeaderView alloc]init];
    _header.delegate = self;
    _header.scrollView = _collectionView;
    
    
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.delegate = self;
    _footer.scrollView = _collectionView;
    
}
//请求列表数据
- (void)getDataForClassify {
    NSString *bodyStr = [NSString stringWithFormat:@"act=2&p=%ld&cid=%ld&sort_type=%@",(long)self.curPage,(long)self.cid, self.sort_type];
    [RCLAFNetworking postWithUrl:@"goodsCategoryApiNew2.php" BodyString:bodyStr isPOST:YES success:^(id responseObject) {
        DLog(@"金币商城: == %@", responseObject);
        [_footer endRefreshing];
        [_header endRefreshing];
        NSArray *listArray = responseObject[@"list"];
        if (self.curPage == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in listArray) {
            [self.dataArray addObject:dic];
        }
        [_collectionView reloadData];
    } fail:^(NSError *error) {
        [_footer endRefreshing];
        [_header endRefreshing];
        [self.view configBlankPage:EaseBlankPageTypeRefresh hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self getDataForClassify];
        }];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionViewCell" forIndexPath:indexPath];
    [cell setDictionary:self.dataArray[indexPath.row] isLeft:YES];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *body = [NSString stringWithFormat:@"aid=%@",self.dataArray[indexPath.row][@"goods_id"]];
    [RCLAFNetworking postWithUrl:@"getSupplierProductNew2.php" BodyString:body isPOST:YES success:^(id responseObject) {
        NSDictionary *contDic=[responseObject valueForKey:@"cont"];
        if ([contDic isKindOfClass:[NSDictionary class]]) {
            CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
            vc.comDetailDic = contDic;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:nil];
}

#pragma CreationTitleiew 创建头部视图
- (void)creationTitleView {
    ScreenView *screenView = [[ScreenView alloc] initWithY:0 titleArray:@[@"销量优先", @"价格排序"] block:^(NSString *string) {
        if ([string containsString:@"销量优先"]) {
            self.sort_type = @"2";
        }else if ([string containsString:@"价格最高"]) {
            self.sort_type = @"4";
        }else if ([string containsString:@"价格最低"]) {
            self.sort_type = @"3";
        }
        self.curPage = 1;
        [self getDataForClassify];
    }];
    [self.view addSubview:screenView];
}

- (void)createNagivationBarView {
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 17.5, 13)];
    [leftButton addTarget:self action:@selector(handleLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"Menu Burger@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    [rightButton addTarget:self action:@selector(handleRightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon-sousuo@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)handleLeftItem {
        [_screenTableView removeFromSuperview];
        UIWindow *delegate = [[UIApplication sharedApplication] keyWindow];
        self.screenTableView = [[ScreenTableView alloc] initWithY:64 NSarray:self.childrenArray block:^(NSInteger cid) {
            self.cid = cid;
            self.curPage = 1;
            [self getDataForClassify];
        } isdefault:[NSString stringWithFormat:@"%ld", (long)self.cid]];
        [delegate addSubview:_screenTableView];
}

- (void)handleRightItem {
    SearchViewController *search = [[SearchViewController alloc]init];
    BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:search];
    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    search.shouldRequest = YES;
    search.cid = self.cid;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if(refreshView ==_header){
        self.curPage = 1;
        [self getDataForClassify];
    }else{
        self.curPage++;
        [self getDataForClassify];
    }
}

- (void)getDataForClassifySec {
    [RCLAFNetworking postWithUrl:@"goodsCategoryApiNew2.php" BodyString:@"act=1&p_cid=1&is_all=1" isPOST:YES success:^(id responseObject) {
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
                [self.childrenArray addObject:dic];
        }
        DLog(@"%@", responseObject);
    } fail:^(NSError *error) {
        [self.view configBlankPage:EaseBlankPageTypeRefresh hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self getDataForClassifySec];
        }];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat f = scrollView.contentOffset.y;
    NSInteger countPerRow = 2;
    CGFloat itemWidth = (UI_SCREEN_WIDTH - 1 - 45) / (countPerRow * 1.0) + 100;
    if (f > (itemWidth * 5 * self.curPage - 50)) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
