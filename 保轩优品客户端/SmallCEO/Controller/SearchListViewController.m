//
//  SearchListViewController.m
//  Lemuji
//
//  Created by quanmai on 15/7/17.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "SearchListViewController.h"
#import "NavSearchBar.h"
#import "HomeCategoryCell.h"
#import "SearchSelectCell.h"
#import "CommodityDetailViewController.h"
#import "UpOrDownButton.h"
#import "TabSelectView.h"
#import "GoodsCollectionViewCell.h"
#import "SuspendedView.h"

#define ITEM_INDENTIFIER @"item"

@interface SearchListViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,HomeCategoryCellDelegate,TabSelectViewDelegate,HomeCategoryCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GoodsCollectionViewCellDelegate,SuspendedViewDelegate>{
    TabSelectView *tabBlackView;
    TabSelectView *profitBlackView;
    TabSelectView *priceBlackView;
    TabSelectView *tabView;
    
    UIView *allGoodsChoseView;
    UIView *profitChoseView;
    UIView *priceChoseView;
    UIView *shadowView;
    UIView *choseView;
    long seletedIndex;
    BOOL isOut;
    NSString *act;
    NSString *order;
    NSArray *cateTypeArr;
    NSInteger curMainCateIndex;
    BOOL isGetCateTypeArr;
    
}


@property(nonatomic,strong) NavSearchBar *searchBar;
@property(nonatomic,strong) UITableView *selectTableV;
@property(nonatomic,strong) UICollectionView *goodsCollectionView;;
@property (nonatomic, strong) SuspendedView *suspendedView;

@end


@implementation SearchListViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchCid=@"";
        self.juheCid=@"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 0;
    seletedIndex = 0;
    curMainCateIndex=0;
    isOut = NO;
    
    self.view.backgroundColor=[UIColor whiteColor];
    selectDataSource=[[NSMutableArray alloc] initWithCapacity:0];
    [self postHot];
    [self popGGview];
    
    resultDataSource=[[NSMutableArray alloc] initWithCapacity:0];
    self.searchBar=[[NavSearchBar alloc] initWithFrame:CGRectMake(-20, 7, UI_SCREEN_WIDTH-2*50+20, 30)];
    self.searchBar.delegate=self;
    
    UIView *temp=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    temp.backgroundColor=[UIColor clearColor];
    [temp addSubview:self.searchBar];
    
    self.navigationItem.titleView=temp;
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
//    [rightButton setImage:[[UIImage imageNamed:@"home_search_black.png"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"icon-sousuo@2x"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    self.selectTableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    self.selectTableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.selectTableV.delegate=self;
    self.selectTableV.dataSource=self;
    self.selectTableV.backgroundColor=[UIColor whiteColor];
    self.selectTableV.showsVerticalScrollIndicator = NO;
    self.selectTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.selectTableV.tableFooterView=({
        UIView *tView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 240)];
        tView;
    });
    [self.view addSubview:self.selectTableV];
    
    [self createSelectView];
    [self createChoseView];
    //商品
    UICollectionViewFlowLayout*flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = 0;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake(UI_SCREEN_WIDTH/ 2, (UI_SCREEN_WIDTH -  3*10) / 2+100);//item的大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.goodsCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 42, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-42) collectionViewLayout:flowLayout];
    self.goodsCollectionView.delegate=self;
    self.goodsCollectionView.dataSource=self;
    self.goodsCollectionView.backgroundColor=MONEY_COLOR;
    self.goodsCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.goodsCollectionView];
    self.goodsCollectionView.alwaysBounceVertical = YES;

    [self.goodsCollectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:ITEM_INDENTIFIER];
    

    
    self.selectTableV.hidden=YES;
    self.goodsCollectionView.hidden=YES;
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=self.goodsCollectionView;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=self.goodsCollectionView;
    self.footView.delegate=self;
    
    [self createClassView];
    
    if (self.shouldDoRequest)
    {
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self apppageLinkWithCid];
        });
    }else if (self.isJuHeGoods) {
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self apppageLinkWithJid];
        });
    }else{
        [self.searchBar becomeFirstResponder];
    }
}
- (void)createChoseView {
    /*选项卡*/
    choseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.suspendedView.maxY, UI_SCREEN_WIDTH, 42)];
    choseView.backgroundColor= WHITE_COLOR_3;
    [self.view addSubview:choseView];
    
    NSArray *btnNames = @[@"全部商品",@"会员价",@"参考利润"];
    BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
    if (!isVip) {
        btnNames = @[@"全部商品",@"销量排序",@"价格排序"];
    }
    CGFloat btnW = UI_SCREEN_WIDTH/3.0-2;
    for (int i = 0; i < 2; i ++) {
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 41.5*i, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LINE_COLOR;
        [choseView addSubview:line];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(btnW+(btnW+1)*i, 0, 1, 41)];
        line2.backgroundColor = LINE_COLOR;
        [choseView addSubview:line2];
    }
    
    for (int i = 0; i < 3; i ++) {
        UpOrDownButton  *choseBtn = [[UpOrDownButton alloc]  init];
        choseBtn.frame = CGRectMake(i*(btnW+1), 0.5, btnW, 41);
        choseBtn.titleLab.text = btnNames[i];
        choseBtn.backgroundColor = WHITE_COLOR_3;
        choseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        choseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [choseView addSubview:choseBtn];
        choseBtn.tag = 10086+i;
        [choseBtn addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)createSelectView
{
    [self.view addSubview:self.suspendedView];
}
#pragma mark - Get suspendview

//- (SuspendedView *)suspendedView
//{
//    if (!_suspendedView)
//    {
//        _suspendedView = [[SuspendedView alloc] initWithSuspendedViewStyle:SuspendedViewStyleVaule3];
//        _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, SuspendedViewHeight);
//        _suspendedView.delegate = self;
//        NSMutableArray *indexarr = [NSMutableArray new];
//        indexarr = @[@"保轩精品",@"车主生活"];
////        for (int i = 0; i<_allDataArray.count; i++) {
////            [indexarr addObject:_allDataArray[i][@"cat_name"]];
////        }
//        _suspendedView.items = indexarr;
//        _suspendedView.backgroundColor = [UIColor whiteColor];
//        _suspendedView.currentItemIndex = 0;
//        
//    }
//    
//    return _suspendedView;
//}
- (void)createClassView {
    /*展开的选项卡的背景*/
    shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, -(UI_SCREEN_HEIGHT-42)-200, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-42)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.7;
    [self.view addSubview:shadowView];
    [shadowView addTarget:self action:@selector(hideChoseView) forControlEvents:UIControlEventTouchUpInside];
    
    allGoodsChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -165, UI_SCREEN_WIDTH, 165)];
    allGoodsChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:allGoodsChoseView];
    
    profitChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    profitChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:profitChoseView];
    
    priceChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    priceChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceChoseView];
    
    /*二级分类*/
    tabBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0f, 0, UI_SCREEN_WIDTH/2.0f, 165) isBlack:YES kinds:0];
    tabBlackView.delegate=self;
    [allGoodsChoseView addSubview:tabBlackView];
    tabBlackView.hidden=YES;
    
    /*一级分类*/
    tabView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/2.0f, 165) isBlack:NO kinds:0];
    tabView.delegate=self;
    [allGoodsChoseView addSubview:tabView];
    
    /*利润二级分类*/
    profitBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    profitBlackView.delegate=self;
    [profitChoseView addSubview:profitBlackView];
    
    /*会员价二级分类*/
    priceBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    priceBlackView.delegate=self;
    [priceChoseView addSubview:priceBlackView];
    
    BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
    if (isVip) {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"会员价最高"},@{@"cat_name":@"会员价最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"参考利润最高"},@{@"cat_name":@"参考利润最低"}]];
    }else {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"销量最高"},@{@"cat_name":@"销量最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"价格最高"},@{@"cat_name":@"价格最低"}]];
    }

}

- (void)choseBtnClick:(UpOrDownButton *)sender {

    CGFloat allH = 165.0f;
    CGFloat othH = 83.0f;
    CGFloat choseViewHight = 42;
    
    if (seletedIndex != 0) {
        UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
        oldBtn.rightView.image = [UIImage imageNamed:@"dzai_xiaLa@2x"];
    }
    if (isOut == YES)
    {
        if ( seletedIndex == sender.tag) {
            if (sender.tag == 10086) {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);

            }else if (sender.tag == 10088) {
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                
            }else {
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
            }
            sender.rightView.image = [UIImage imageNamed:@"zai_xiaLa@2x"];
            
            shadowView.frame = CGRectMake(0, -(UI_SCREEN_HEIGHT-choseViewHight), UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
            
            isOut = NO;
        }else {
            if (sender.tag == 10086) {
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                allGoodsChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, allH);
            }else if (sender.tag == 10088) {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                profitChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
            }else {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
            }
            sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        }
    }
    else if (isOut == NO)
    {
        if (sender.tag == 10086) {
            allGoodsChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, allH);
        }else if (sender.tag == 10088) {
            profitChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
        }else {
            priceChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
        }
        sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        shadowView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
        isOut = YES;
    }
    seletedIndex = sender.tag;
}

//底部tab选择点击
-(void)tabView:(TabSelectView *)view clickAtIndex:(NSInteger)index{
    self.searchBar.text = @"";
    if (view==tabBlackView) {
        //二级分类
        NSArray *tempSubCateArr=[[cateTypeArr objectAtIndex:curMainCateIndex]  valueForKey:@"child"];
        if ([tempSubCateArr isKindOfClass:[NSArray class]] && tempSubCateArr.count != 0) {
            self.curPage=0;
            self.searchCid=[NSString stringWithFormat:@"%@",[[tempSubCateArr objectAtIndex:index]  valueForKey:@"cid"]];
            [self doRequest:self.searchBar.text];
            if (seletedIndex != 0) {
                isOut = YES;
                [self hideChoseView];
            }
        }
    }else if (view == profitBlackView) {
        //利润分类
        self.curPage=0;
        BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
        if (isVip) {
            act = @"profit";
        }else {
            act = @"fprice";
        }
        if (index == 0) {
            order = @"desc";
        }else {
            order = @"asc";
        }
        [self doRequest:self.searchBar.text];
        if (seletedIndex != 0) {
            isOut = YES;
            [self hideChoseView];
        }
    }else if (view == priceBlackView) {
        //供货价分类
        self.curPage=0;
        if (index == 0) {
            act = @"sellnum";
            order = @"desc";
        }else {
            act = @"sellnum";
            order = @"asc";
        }
        [self doRequest:self.searchBar.text];
        if (seletedIndex != 0) {
            isOut = YES;
            [self hideChoseView];
        }
    }else{
        //一级分
        //相同return
        if(curMainCateIndex == index && index != 0){
            return;
        }
        curMainCateIndex=index;
        
        NSArray *tempSubCate=[[cateTypeArr objectAtIndex:index] valueForKey:@"child"];
        if ([tempSubCate isKindOfClass:[NSArray class]]) {
            /*有二级分类*/
            if (tempSubCate.count>0) {
                tabBlackView.hidden=NO;
                [tabBlackView updateWithArr:tempSubCate];
                
                
                NSArray *tempSubCateArr=[[cateTypeArr objectAtIndex:curMainCateIndex]  valueForKey:@"child"];
                if ([tempSubCateArr isKindOfClass:[NSArray class]]) {
                    self.curPage=0;
                    self.searchCid=[NSString stringWithFormat:@"%@",[[tempSubCateArr objectAtIndex:0]  valueForKey:@"cid"]];
//                    [self doRequest:self.searchBar.text];
                }
            }
            /*无二级分类*/
            else{
                self.curPage=0;
                self.searchCid=[NSString stringWithFormat:@"%@",[[cateTypeArr objectAtIndex:index] valueForKey:@"cid"]];
//                [self doRequest:self.searchBar.text];
                tabBlackView.hidden=YES;
                [self hideChoseView];
            }
        }
        /*无二级分类*/
        else{
            self.curPage=0;
            self.searchCid=[NSString stringWithFormat:@"%@",[[cateTypeArr objectAtIndex:index] valueForKey:@"cid"]];
            [self doRequest:self.searchBar.text];
            tabBlackView.hidden=YES;
            [self hideChoseView];
        }
    }
}

- (void)hideChoseView {
    UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
    [self choseBtnClick:oldBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar endEditing:YES];
}
-(void)dealloc
{
    [self.headView free];
    [self.footView free];
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        self.curPage=0;
        if ([self.searchCid isValid] || [self.juheCid isValid]) {
            [self doRequest:@""];
        }else{
            [self doRequest:self.searchBar.text];
        }
    }else
    {
        self.curPage++;
        if ([self.searchCid isValid] || [self.juheCid isValid]) {
           [self doRequest:@""];
        }else{
             [self doRequest:self.searchBar.text];
        }
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return resultDataSource.count;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:ITEM_INDENTIFIER forIndexPath:indexPath];
    item.itemIndexPath = indexPath;
    [item updateSearchDic:[resultDataSource objectAtIndex:indexPath.row]];
    item.delegate = self;
    item.tag=indexPath.row;
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isOut == NO) {
        NSString *aid=[NSString stringWithFormat:@"%@",[[resultDataSource objectAtIndex:indexPath.row] valueForKey:@"aid"]];
        [self productshopdetailWithAid:aid];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView==self.selectTableV){
        return selectDataSource.count;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==self.selectTableV){
        return 44;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.selectTableV){
        NSString *cellStr = @"cellslect";
        SearchSelectCell *cell = (SearchSelectCell  *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[SearchSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLable.text = [NSString stringWithFormat:@"%@", selectDataSource[selectDataSource.count-1-indexPath.row]];
        return cell;
    }
    else{
        return nil;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.selectTableV) {
        [self.searchBar resignFirstResponder];
        self.searchBar.text = selectDataSource[selectDataSource.count-1-indexPath.row];
        [self doRequest:selectDataSource[selectDataSource.count-1-indexPath.row]];
    }
}
#pragma mark - http
/*商品详情接口*/
-(void)productshopdetailWithAid:(NSString *)aid
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    NSString *str=MOBILE_SERVER_URL(@"productshopdetail_lemuji.php");
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
            
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
            [SVProgressHUD dismiss];
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


#pragma -mark searchbardelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.selectTableV.hidden=NO;
    self.goodsCollectionView.hidden=YES;
    choseView.hidden = YES;
    if (isOut == YES) {
        [self hideChoseView];
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
 
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
    //    NSLog(@"text:%@",text);
    //    NSLog(@"search.Text:%@",searchBar.text);
    //    NSLog(@"searchBar.textInputContextIdentifier:%@",searchBar.textInputContextIdentifier);
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([self.searchBar.text isEqualToString:@""]) {
        return;
    }
    [self loadSearBarList:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.curPage = 0;
    [self doRequest:searchBar.text];
    [self.searchBar resignFirstResponder];
}

-(void)missKeyBoard{
    [self.searchBar resignFirstResponder];
    
    if (selectDataSource.count>0) {
        self.selectTableV.hidden=NO;
        self.goodsCollectionView.hidden=YES;
        choseView.hidden = YES;
    }else{
        self.selectTableV.hidden=YES;
        self.goodsCollectionView.hidden=NO;
        choseView.hidden = NO;
    }
}


//搜索处理 预加载

-(void)loadSearBarList:(NSString *)string
{
    NSString*body=[NSString stringWithFormat:@"keyword=%@&from_type=2", [string URLEncodedString]];
    NSString *str=MOBILE_SERVER_URL(@"searchlist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"list"];
        if (array.count != 0)
        {
            [selectDataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in array)
        {
            [selectDataSource addObject:[dic objectForKey:@"subject"]];
        }
        [self.selectTableV reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];
}

-(void)doRequest:(NSString *)seaText
{
    seaText = [seaText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&min=%d&max=10",self.curPage*10];
    
    if ([seaText isValid]) {
        body = [NSString stringWithFormat:@"%@&keyword=%@",body,seaText];
        isGetCateTypeArr = NO;
    }else {
        if([self.searchCid isValid]){
            //分类商品
            body=[NSString stringWithFormat:@"%@&cid=%@",body,self.searchCid];
        }else if ([self.juheCid isValid]){
            //聚合商品
            body=[NSString stringWithFormat:@"%@&jid=%@",body,self.juheCid];
        }
    }
    
    if ([order isValid] && [act isValid]) {
        body=[NSString stringWithFormat:@"%@&orderby=%@&sort=%@",body,act,order];
    }
    NSString *str=MOBILE_SERVER_URL(@"searchlist_lemuji.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"body is %@",body);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        self.selectTableV.hidden=YES;
        self.goodsCollectionView.hidden=NO;
        choseView.hidden = NO;
         if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            //分类
            if ([[[responseObject valueForKey:@"cont" ] valueForKey:@"category"] isKindOfClass:[NSArray class]] && !isGetCateTypeArr)
            {
                isGetCateTypeArr=YES;
                cateTypeArr=[[responseObject valueForKey:@"cont" ] valueForKey:@"category"];
                
                [tabView updateWithArr:cateTypeArr];
                
                if (cateTypeArr.count>0)
                {
                    if ([[[cateTypeArr objectAtIndex:0] valueForKey:@"child"] isKindOfClass:[NSArray class]])
                    {
                        NSArray *tempCate=[[cateTypeArr objectAtIndex:0] valueForKey:@"child"];
                        if (tempCate.count>0)
                        {
                            [tabBlackView updateWithArr:tempCate];
                            tabBlackView.hidden=NO;
                            
                        }
                    }
                }
            }

            NSArray* temp = [[responseObject objectForKey:@"cont"] objectForKey:@"list"];
            if(self.curPage == 0)
            {
                [resultDataSource removeAllObjects];
                self.goodsCollectionView.contentOffset = CGPointMake(self.goodsCollectionView.contentOffset.x, 0);
            }
            [resultDataSource addObjectsFromArray:temp];
            [self.goodsCollectionView reloadData];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)postHot
{
    
    NSString*body=[NSString stringWithFormat:@"keyword=%@&from_type=2",@""];
    NSString *str=MOBILE_SERVER_URL(@"searchlist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"list"];
        if (array.count != 0)
        {
            [selectDataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in array)
        {
            [selectDataSource addObject:[dic objectForKey:@"subject"]];
        }
        [self.selectTableV reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];
}


-(void)rightBtnClick
{
    self.curPage = 0;
    [self doRequest:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}


-(void)apppageLinkWithCid{
    self.curPage = 0;
    if ([self.searchCid isValid]) {
        [self doRequest:@""];
    }
}
-(void)apppageLinkWithJid{
    self.curPage = 0;
    if ([self.juheCid isValid]) {
        [self doRequest:@""];
    }
}

#pragma mark - cell delegate
-(void)buyAtRow:(NSInteger)row{
    NSArray *array=[[resultDataSource objectAtIndex:row] valueForKey:@"guige" ];
    if ([array isKindOfClass:[NSArray class]]) {
        self.ggArr=[[NSMutableArray alloc] initWithArray:array];
    }else{
        self.ggArr=[[NSMutableArray alloc] initWithCapacity:0];
    }
    self.comDetailDic=[resultDataSource objectAtIndex:row];
    [self popGGview];
    
    Animation_Appear .3];
    self.myGGView.hidden = NO;
    //[self.view bringSubviewToFront:self.myGGView];
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.bodyView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)saleAtRow:(NSInteger)row{
    self.comDetailDic=[resultDataSource objectAtIndex:row];
    //[self addToShopMyLib];
}

//在viewDidLoad中创建规格的界面
-(void)popGGview
{
    self.firstStr = @"";
    self.secondStr = @"";
    self.thirdStr = @"";
    self.onePay = [[NSString stringWithFormat:@"%@", [self.comDetailDic objectForKey:@"gonghuo_price"]] floatValue];
    
    
    self.subGG=[[NSMutableArray alloc] initWithCapacity:0];
    for(int i = 0; i < self.ggArr.count; i++)
    {
        [self.subGG addObject:@"-1"];
    }
    
    if(self.myGGView == nil)
    {
        self.myGGView = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        self.myGGView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        self.myGGView.tag = 1888;
        self.myGGView.windowLevel = 999;
        //[self.view addSubview:self.myGGView];
        [self.myGGView makeKeyAndVisible];
    }
    self.myGGView.hidden = YES;
    
    for (UIView *view in self.myGGView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    [self.myGGView addSubview:maskView];
    
    
    self.bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -maskView.frame.size.height - 14)];
    self.bodyView.backgroundColor = [UIColor clearColor];
    [self.myGGView addSubview:self.bodyView];
    
    self.shopCell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.shopCell.backgroundColor = WHITE_COLOR;
    self.shopCell.numSelect.hidden = YES;
    self.shopCell.finishBtn.hidden = YES;
    self.shopCell.imageArrowView.hidden=YES;
    self.shopCell.numChangeV.hidden = YES;
    self.shopCell.choseComBtn.hidden = YES;
    self.shopCell.nameLab.hidden = YES;
    self.shopCell.thLab.center = CGPointMake(self.shopCell.thLab.center.x,self.shopCell.thLab.center.y);
    [self.shopCell setFrame:CGRectMake(self.shopCell.frame.origin.x, self.shopCell.frame.origin.y, UI_SCREEN_WIDTH,106)];
    [self.shopCell updataWhenHome:self.comDetailDic];
    [self.shopCell.exitBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView* bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bodyView.frame.size.height - 80, UI_SCREEN_WIDTH, 80)];
    UILabel* priceLab = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-200-15, 5, 200, 20)];
//    priceLab.textAlignment = NSTextAlignmentRight;
//    
//    NSString* thStr = [NSString stringWithFormat:@"合计：%@",[self.comDetailDic valueForKey:@"gonghuo_price"]];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"6a6a6a"] range:NSMakeRange(0,3)];
//    [str addAttribute:NSForegroundColorAttributeName value:App_Main_Color range:NSMakeRange(3,thStr.length-3)];
//    priceLab.attributedText = str;
//    
//    [bottomView addSubview:priceLab];
    
    
    //添加到购物车
    UIButton *btnI1=[[UIButton alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height - 44, UI_SCREEN_WIDTH, 44)];
    btnI1 .backgroundColor=App_Main_Color;
    btnI1.layer.cornerRadius=0;
    btnI1.titleLabel.font=[UIFont systemFontOfSize:15];
    [btnI1 setTitle:@"添加到购物车" forState:UIControlStateNormal];
    btnI1.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnI1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnI1 addTarget:self action:@selector(buyRightNow) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnI1];
    
    self.allPriceLab = priceLab;
    
    GGView* ggView = [[GGView alloc]initWith:self.ggArr andUpView:self.shopCell andBottomView:bottomView andHeight:400 andFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.bodyView.frame.size.height) withGGViewType:GGViewTypeNormal];
    ggView.delegate = self;
    [self.bodyView addSubview:ggView];
    
    [ggView.closeBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
    maskView.frame=CGRectMake(maskView.frame.origin.x, maskView.frame.origin.y+ggView.guigeOffsetY, maskView.frame.size.width, maskView.frame.size.height);
    self.selectedGoodsCount = 1;
}


-(void)buyRightNow{
    for (int i = 0; i < self.subGG.count; i++)
    {
        if ([[self.subGG objectAtIndex:i] isEqualToString:@"-1"])
        {
            if (!self.myGGView.hidden)
            {
                UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请选择规格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alv show];
                return;
            }
            
        }
    }
    
    [SVProgressHUD show];
    NSMutableArray *selectedSpecificationArray = [self getGoodsSelectedSpecification];
    NSString *specificationStr = [selectedSpecificationArray componentsJoinedByString:@","];
    NSString *body = [NSString stringWithFormat:@"act=1&goods_id=%@&goods_num=%ld&goods_attr_id=%@,", [self.comDetailDic objectForKey:@"aid"], (long)self.selectedGoodsCount, specificationStr];
    NSString *str = MOBILE_SERVER_URL(@"mallCartApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"info"]] ;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self closeGGView];
            });
        } else {
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            } else {
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

- (void)closeGGView {
    Animation_Appear .3];
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    [UIView commitAnimations];
    [self performSelector:@selector(closeGGSuper) withObject:nil afterDelay:0.32];
}

#pragma mark - GGViewDelegate method
- (void)goodsCountChanged:(NSInteger)count {
    self.selectedGoodsCount = count;
    [self changeAllPriceWith:(int)self.selectedGoodsCount andGGPrice:self.attrPay];
}

- (void)changeAllPriceWith:(int)num andGGPrice:(float)attPrice {
    self.allPay = self.onePay * num + attPrice;
    NSString* thStr =[NSString stringWithFormat:@"合计：%.2f",self.allPay];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"6a6a6a"] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:App_Main_Color range:NSMakeRange(3,thStr.length-3)];
    self.shopCell.priceLab.attributedText = str;
    if (num == 1) {
        self.shopCell.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f", self.onePay + attPrice];
    }
}

- (void)outWhichOne:(long)index {
    long x = index/10000;
    long y = index%10000;
    //此数组记录了用户选取规格的情况 数组下标代表规格种类 下面里的值代表子类规格
    [self.subGG replaceObjectAtIndex:x withObject:[NSString stringWithFormat:@"%ld",y]];
    
    NSArray *selectArr=[self getGoodsSelectedSpecification];
    [self changeWithAttr:[selectArr componentsJoinedByString:@","]];
    
    //这边设置规格的3个预览 如不足3个就按相应个数 如果超过则只取前3个 x+1为单个商品的规格父类数量
    if(x == 0) {
        self.firstStr = [[[self.ggArr[0] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }else if(x == 1) {
        self.secondStr = [[[self.ggArr[1] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }else if(x == 2) {
        self.thirdStr = [[[self.ggArr[2] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }
    
    [self.shopCell setGGWith:self.firstStr andTwo:self.secondStr andThree:self.thirdStr];
    
    self.attrPay = 0.0;
    
    //遍历数组 判断数组里是否有元素为-1 即没有被选过的规格
    for(int i = 0;i<self.subGG.count;i++) {
        if([self.subGG[i] isEqualToString:@"-1"]) {
        }else {
            self.attrPay = self.attrPay + [[[[self.ggArr[i] objectForKey:@"data"] objectAtIndex:[self.subGG[i] intValue]] objectForKey:@"attr_price"] floatValue];
        }
    }
    [self changeAllPriceWith:(int)self.selectedGoodsCount andGGPrice:self.attrPay];
}

- (NSMutableArray *)getGoodsSelectedSpecification {
    NSMutableArray *selectedSpecificationArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < self.ggArr.count; i++)
    {
        NSArray *goodsSingleSpecification = [[self.ggArr objectAtIndex:i] objectForKey:@"data"];
        NSInteger index=[[self.subGG objectAtIndex:i] integerValue];
             if(  (index<goodsSingleSpecification.count)   &&   (index>=0)   ){
            NSString *selectedSpecificationId = [NSString stringWithFormat:@"%@",[[goodsSingleSpecification objectAtIndex:index] objectForKey:@"id"]];
            [selectedSpecificationArray addObject:selectedSpecificationId];
        }
    }
    return selectedSpecificationArray;
}

#pragma mark - 改变图片
- (void)changeWithAttr:(NSString *)attr {
    NSString *aid=[NSString stringWithFormat:@"%@",[self.comDetailDic valueForKey:@"aid"]];
    NSString*body=[NSString stringWithFormat:@"aid=%@&goods_attr_id=%@",aid,attr];
    NSString *str=MOBILE_SERVER_URL(@"goods_pic.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            NSString *picImgStr = [NSString stringWithFormat:@"%@", [responseObject valueForKey:@"picurl"]];
            if ([picImgStr isEqualToString:@""] ||
                [picImgStr isEqualToString:@"<null>"]) {
                return;
            }
            [self.shopCell.picImg af_setImageWithURL:[NSURL URLWithString:picImgStr]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];
}

#pragma mark -
- (void)closeGGSuper {
    self.myGGView.hidden = YES;
}
@end
