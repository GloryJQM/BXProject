//
//  ClassifyViewController.m
//  SmallCEO
//
//  Created by nixingfu on 16/3/14.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "SearchViewController.h"
#import "SelctTab.h"
#import "SearchListViewController.h"
#import "SuspendedView.h"
#import "ClassifyViewTableViewCell.h"
#import "CustomSearchTextField.h"
#import "UpOrDownButton.h"
#import "TabSelectView.h"
#import "CommodityDetailViewController.h"
#import "LoginViewController.h"
#import "SearchSelectCell.h"
#import "TipsSelectorView.h"
#import "ListCollectionViewCell.h"

static NSString *const ClassifyViewCollectionCellStr = @"ClassifyViewCollectionCellStr";
@interface SearchViewController ()<UIWebViewDelegate,MJRefreshBaseViewDelegate,SuspendedViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,TabSelectViewDelegate,GGViewDelegate,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,TipsSelectorViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray      *_tableArr;
    NSMutableArray      *_curSelIndexArr;
    NSMutableArray      *_datasArr;
    NSMutableArray      *_tabNameArr;
    UIScrollView        *_scrollView;
    NSInteger           _leftIndex;
    NSInteger           _rightIndex;
    NSInteger           _scrollIndex;
    SelctTab            *_tapView;
    UIView              *choseView;
    UIView              *shadowView;
    UIView              *allGoodsChoseView;
    UIView              *profitChoseView;
    UIView              *priceChoseView;
    
    TabSelectView       *tabBlackView;
    TabSelectView       *profitBlackView;
    TabSelectView       *priceBlackView;
    TabSelectView       *tabView;
    long                seletedIndex;
    BOOL                isOut;
    
    UIInputView         *goodsImage;
    UILabel             *goodsLabel;
    UILabel             *priceLabel;
    UIButton            *addShopCart;
    
}


@property (strong ,nonatomic)   MJRefreshHeaderView     *header;
@property (strong ,nonatomic)   NSMutableArray      *arrBrowseHistory;
@property (strong)              UIWebView           *webView;
@property (nonatomic,strong)    UISearchBar          *searchBar;
@property (strong,nonatomic)    UISearchDisplayController *searchDisplay;
@property NSString *preSearchText;
@property (nonatomic, strong) NSString *keyword;

@property (strong , nonatomic) UITableView  *leftTableView;
@property (strong , nonatomic) UITableView  *rightTableView;
@property (strong , nonatomic) UICollectionView  *leftCollectionView;
@property (strong , nonatomic) UICollectionView  *rightCollectionView;

@property (strong , nonatomic) NSMutableArray   *leftDataSource;
@property (strong , nonatomic) NSMutableArray   *rightDataSource;

@property (strong , nonatomic) NSMutableArray   *leftTableArray;
@property (strong , nonatomic) NSMutableArray   *rightTableArray;

@property (strong , nonatomic) NSMutableArray   *allDataArray;

@property (nonatomic, strong) CustomSearchTextField *searchTextField;

@property (nonatomic, strong) SuspendedView *suspendedView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *goodID;
//@property (nonatomic, assign) NSInteger leftTableCellIndex;
//@property (nonatomic, assign) NSInteger rightTableCellIndex;
@property (nonatomic, assign) NSInteger leftPage;
@property (nonatomic, assign) NSInteger rightPage;
@property (nonatomic, assign) BOOL isSection;
//后台返回的规格
@property (nonatomic,strong)NSArray* ggArr;
//以选择的规格arr
@property (nonatomic,strong)NSMutableArray* subGG;

@property (nonatomic,strong)UIWindow* myGGView;

@property (nonatomic,strong)UIButton* sureBtn;

@property (nonatomic,strong)UIView* bodyView;
@property (nonatomic,strong)UIView* buyView;

/*规格前三个属性title*/
@property (nonatomic,strong)NSString* firstStr;
@property (nonatomic,strong)NSString* secondStr;
@property (nonatomic,strong)NSString* thirdStr;

@property (nonatomic,strong)ShopCartCell* shopCell;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property(nonatomic,strong) NSDictionary  *comDetailDic;

@property(nonatomic,assign) NSInteger  selectedGoodsCount;
@property (nonatomic,assign)float allPay;
@property (nonatomic,assign)float onePay;
@property (nonatomic,assign)float attrPay;
@property (nonatomic, strong) NSString *sort_type;//选择的条件
//检索视图
@property (nonatomic, strong) UITableView *selectTable;
@property (nonatomic, strong) NSMutableArray *searchData;
//默认视图
@property (nonatomic, strong) UITableView *defaultTable;
@property (nonatomic, strong) NSMutableArray *defaultData;

@property (nonatomic, strong) NSMutableArray *headerViews;
@property (nonatomic, strong) NSMutableArray *footerViews;

@property (nonatomic, strong) TipsSelectorView *historySearchedTipsView;
@property (nonatomic, strong) TipsSelectorView *historySearchedUsersView;

@property (nonatomic, strong) NSMutableArray *mySearchArr;
@property (nonatomic, strong) NSMutableArray *hotSearchArr;

@end

@implementation SearchViewController

-(void)dealloc{
    [_arrBrowseHistory removeAllObjects];
    [_leftTableArray removeAllObjects];
    [_rightTableArray removeAllObjects];
    for (int i = 0; i<_headerViews.count; i++) {
        MJRefreshHeaderView *header = _headerViews[i];
        MJRefreshFooterView *footer = _footerViews[i];
        [header free];
        [footer free];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"分类";
        
        self.leftTableArray = [NSMutableArray arrayWithCapacity:0];
        self.rightTableArray = [NSMutableArray arrayWithCapacity:0];
        
        self.mySearchArr = [NSMutableArray arrayWithCapacity:0];
        self.hotSearchArr = [NSMutableArray arrayWithCapacity:0];
        
        _leftDataSource = [[NSMutableArray alloc] init];
        _rightDataSource = [[NSMutableArray alloc] init];
        
        _allDataArray = [[NSMutableArray alloc]init];
        
        self.leftPage = 1;
        self.rightPage = 1;
        self.isSection = NO;
        
    }
    return self;
}
- (void)goodsCountChanged:(NSInteger)count
{
    self.selectedGoodsCount = count;
    [self changeAllPriceWith:(int)self.selectedGoodsCount andGGPrice:self.attrPay];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sort_type = @"";
    self.keyword = @"";
    if (!_cid) {
        self.cid = 0;
    }
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _headerViews = [NSMutableArray new];
    _footerViews = [NSMutableArray new];
    
    _tableArr = [[NSMutableArray alloc] initWithCapacity:0];
    _curSelIndexArr = [[NSMutableArray alloc] initWithCapacity:0];
    _datasArr = [[NSMutableArray alloc] initWithCapacity:0];
    _tabNameArr = [[NSMutableArray alloc] initWithCapacity:0];
    _arrBrowseHistory = [[NSMutableArray alloc] init];
    
    [self createMainView];
    
}

- (void)createMainView
{
    [self createNavigationView];
    
}
- (void)createNavigationView
{
    if (!_searchTextField) {
        self.searchTextField = [[CustomSearchTextField alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH - 20 - 40, 30)];
        self.navigationItem.titleView = self.searchTextField;
        self.searchTextField.delegate = self;
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        self.searchTextField.inputAccessoryView = btnT;
        [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        UIImage *image = [UIImage imageNamed:@"icon-sousuo@2x"];
        [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = bar;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTextField becomeFirstResponder];
    });
}
#pragma mark - 视图即将显示获取分选条
- (void)viewWillAppear:(BOOL)animated {
    if (_suspendedView == nil) {
        [self getDataForSearchRecord];
        [self getDataForClassifySec];
    }
}

#pragma mark - 搜索之后的tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _searchData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellStr = @"cellslect";
    SearchSelectCell *cell = (SearchSelectCell  *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[SearchSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleLable.text = [NSString stringWithFormat:@"%@", self.searchData[self.searchData.count-1-indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%@",self.searchData[self.searchData.count-1-indexPath.row]);
    //self.searchBar.text = self.searchData[self.searchData.count-1-indexPath.row];
    self.searchTextField.text = self.searchData[self.searchData.count-1-indexPath.row];
    [self doRequest:self.searchData[self.searchData.count-1-indexPath.row]];
    [self.searchTextField resignFirstResponder];
}
-(void)doRequest:(NSString *)seaText
{
    self.keyword = seaText;
    [self getDataForClassify];
}
- (void)missKeyBoard {
    [self.searchTextField resignFirstResponder];
    if (self.searchData.count == 0) {
        self.selectTable.hidden = YES;
    }
}
- (void)creatBackView
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
        for (int i = 0; i < self.suspendedView.items.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-53, UI_SCREEN_HEIGHT/4-50, 106, 106)];
            imageView.hidden = NO;
            imageView.image = [UIImage imageNamed:@"pho-zanwushuju@2x"];
            
            UICollectionView *currentCollectView;
            if (i == 0) {
                currentCollectView = _leftCollectionView;
            }else {
                currentCollectView = _rightCollectionView;
            }
            [currentCollectView addSubview:imageView];
            [_imageArray addObject:imageView];
        }
    }
}

- (void)createSelectView
{
    [self.view addSubview:self.suspendedView];
    //[self createMainScrollView];
}

- (void)createMainScrollView
{
    [self.view addSubview:self.scrollView];
    [self createChoseView];
    [self createClassView];
    
    [_leftCollectionView removeFromSuperview];
    [_rightCollectionView removeFromSuperview];
    
    [_scrollView addSubview:self.leftCollectionView];
    [_scrollView addSubview:self.rightCollectionView];
    
    if (self.headerViews.count == 0) {
        for (int i = 0; i < 2; i ++) {
            MJRefreshHeaderView *header = [[MJRefreshHeaderView alloc]init];
            if (i == 0) {
                header.scrollView = self.leftCollectionView;
            }else {
                header.scrollView = self.rightCollectionView;
            }
            header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
                if (i == 0) {
                    self.leftPage = 1;
                }else {
                    self.rightPage = 1;
                }
                [self loadMyDatas];
            };
            [_headerViews addObject:header];
            
            MJRefreshFooterView *footer = [[MJRefreshFooterView alloc]init];
            if (i == 0) {
                footer.scrollView = self.leftCollectionView;
            }else {
                footer.scrollView = self.rightCollectionView;
            }
            footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
                if (i == 0) {
                    self.leftPage++;
                }else {
                    self.rightPage++;
                }
                [self loadMyDatas];
            };
            [_footerViews addObject:footer];
        }
    }
    
}
- (void)loadMyDatas
{
    self.isSection = NO;
    [self getDataForClassify];
}
- (void)createChoseView {
    if (!choseView) {
        /*选项卡*/
        choseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.suspendedView.maxY, UI_SCREEN_WIDTH, 0)];
        //choseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.suspendedView.maxY, UI_SCREEN_WIDTH, 44)];
        choseView.backgroundColor= WHITE_COLOR_3;
        [self.view addSubview:choseView];
        
        NSArray *btnNames = @[@"全部商品",@"销量排序",@"价格排序"];
        
        CGFloat btnW = UI_SCREEN_WIDTH/3.0-2;
        for (int i = 0; i < 2; i ++) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 41.5*i, UI_SCREEN_WIDTH, 0)];
            line.backgroundColor = LINE_COLOR;
            [choseView addSubview:line];
            
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(btnW+(btnW+1)*i, 0, 1, 0)];
            line2.backgroundColor = LINE_COLOR;
            [choseView addSubview:line2];
        }
        
        for (int i = 0; i < 3; i ++) {
            UpOrDownButton  *choseBtn = [[UpOrDownButton alloc]  init];
            choseBtn.rightView.image = [UIImage imageNamed:@"zai_xiaLa@2x"];
            choseBtn.frame = CGRectMake(i*(btnW+1), 0.5, btnW, 0);
            choseBtn.titleLab.text = btnNames[i];
            choseBtn.backgroundColor = WHITE_COLOR_3;
            choseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            choseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //[choseView addSubview:choseBtn];
            choseBtn.tag = 10086+i;
            [choseBtn addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        //检索视图
        _searchData = [NSMutableArray array];
        _selectTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _selectTable.delegate = self;
        _selectTable.dataSource = self;
        _selectTable.hidden = YES;
        _selectTable.tableFooterView = [UIView new];
        [self.view addSubview:_selectTable];
        //默认搜索记录视图
        _defaultTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _defaultTable.backgroundColor = [UIColor whiteColor];
        _defaultTable.tableFooterView = [UIView new];
        
        if (![self.searchTextField.text isEqualToString:@""]) {
            _defaultTable.hidden = YES;
        }
        //_defaultTable.hidden = YES;
        [self.view addSubview:_defaultTable];
        
        NSArray *arr = [[PreferenceManager sharedManager]preferenceForKey:@"search"];
        if (arr != NULL && ![arr isKindOfClass:[NSNull class]]) {
            self.historySearchedTipsView.tips = arr;
            self.mySearchArr = [NSMutableArray arrayWithArray:arr];
        }else {
            self.historySearchedTipsView.tips = @[];
        }
        self.historySearchedUsersView.tips = self.hotSearchArr;
        [_defaultTable addSubview:self.historySearchedTipsView];
        [_defaultTable addSubview:self.historySearchedUsersView];
        [_defaultTable reloadData];
        _defaultTable.contentSize = CGSizeMake(UI_SCREEN_WIDTH, self.historySearchedUsersView.maxY);
        
    }else {
        if (seletedIndex) {
            UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
            oldBtn.rightView.image = [UIImage imageNamed:@"zai_xiaLa@2x"];
            isOut = NO;
        }
    }
    //视图移到最前方
    [self.view bringSubviewToFront:_selectTable];
    [self.view bringSubviewToFront:_defaultTable];
}
- (void)searchAction {
    if (![_searchTextField.text isEqualToString:@""]) {
        _defaultTable.hidden = YES;
        self.keyword = _searchTextField.text;
        [self getDataForClassify];
    }
    
}
#pragma mark -searchTextField
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.returnKeyType == UIReturnKeySearch) {
        if (![_searchTextField.text isEqualToString:@""]) {
            _defaultTable.hidden = YES;
            self.keyword = textField.text;
            [self getDataForClassify];
        }
    }
    
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        NSArray *arr = [[PreferenceManager sharedManager]preferenceForKey:@"search"];
        if (arr != NULL && ![arr isKindOfClass:[NSNull class]]) {
            self.historySearchedTipsView.tips = arr;
            self.mySearchArr = [NSMutableArray arrayWithArray:arr];
        }else {
            self.historySearchedTipsView.tips = @[];
        }
        _historySearchedUsersView.y = _historySearchedTipsView.maxY;
        [_defaultTable reloadData];
        _defaultTable.contentSize = CGSizeMake(UI_SCREEN_WIDTH, self.historySearchedUsersView.maxY);
        _defaultTable.hidden = NO;
        [_historySearchedTipsView unselectAll];
        [_historySearchedUsersView unselectAll];
        return;
    }
    NSString*body=[NSString stringWithFormat:@"keyword=%@&from_type=2&cid=%ld", [textField.text URLEncodedString], (long)_cid];
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
        [self.searchData removeAllObjects];
        for (NSDictionary *dic in array) {
            [self.searchData addObject:[dic objectForKey:@"subject"]];
        }
        
        if (self.searchData.count > 0) {
            self.selectTable.hidden = NO;
        }
        [self.selectTable reloadData];
        _defaultTable.hidden = YES;
        if ([self.searchTextField.text isEqualToString:@""]) {
            _defaultTable.hidden = NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];
}
- (void)createClassView {
    for (UIView *view in shadowView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in allGoodsChoseView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in tabView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in profitBlackView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in priceBlackView.subviews) {
        [view removeFromSuperview];
    }
    [shadowView removeFromSuperview];
    [allGoodsChoseView removeFromSuperview];
    [profitChoseView removeFromSuperview];
    [priceChoseView removeFromSuperview];
    [tabBlackView removeFromSuperview];
    [tabView removeFromSuperview];
    [profitBlackView removeFromSuperview];
    [priceBlackView removeFromSuperview];
    //自适应高度
    CGFloat allH = UI_SCREEN_HEIGHT-48-choseView.maxY;
    NSDictionary *dic = _allDataArray[self.suspendedView.currentItemIndex];
    NSArray *children = dic[@"children"];
    CGFloat counH = children.count *42.0;
    if (counH<=allH) {
        allH = counH;
    }
    /*展开的选项卡的背景*/
    shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, -(UI_SCREEN_HEIGHT-42)-200, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-42)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.7;
    [self.view addSubview:shadowView];
    [shadowView addTarget:self action:@selector(hideChoseView) forControlEvents:UIControlEventTouchUpInside];
    
    allGoodsChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -allH-SuspendedViewHeight, UI_SCREEN_WIDTH, allH)];
    allGoodsChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:allGoodsChoseView];
    
    profitChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    profitChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:profitChoseView];
    
    priceChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    priceChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceChoseView];
    
    /*二级分类*/
    tabBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0f, 0+SuspendedViewHeight, UI_SCREEN_WIDTH/2.0f, 165) isBlack:YES kinds:0];
    tabBlackView.delegate=self;
    [allGoodsChoseView addSubview:tabBlackView];
    tabBlackView.hidden=YES;
    
    /*一级分类*/
    tabView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, allH) isBlack:YES kinds:0];
    tabView.delegate=self;
    tabView.tag = 10000;//全部商品
    [allGoodsChoseView addSubview:tabView];
    
    /*利润二级分类*/
    profitBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    profitBlackView.delegate=self;
    profitBlackView.tag = 2000;//销量选择
    [profitChoseView addSubview:profitBlackView];
    
    /*会员价二级分类*/
    priceBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    priceBlackView.delegate=self;
    priceBlackView.tag = 3000;//价格选择
    [priceChoseView addSubview:priceBlackView];
    //设置第一分类
    //NSDictionary *dic = _allDataArray[self.suspendedView.currentItemIndex];
    [tabView updateWithArr:dic[@"children"]];
    BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
    if (isVip) {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"会员价最高"},@{@"cat_name":@"会员价最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"参考利润最高"},@{@"cat_name":@"参考利润最低"}]];
    }else {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"销量最高"},@{@"cat_name":@"销量最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"价格最高"},@{@"cat_name":@"价格最低"}]];
    }
    
}
#pragma mark --选项卡代理--
-(void)tabView:(TabSelectView *)view clickAtIndex:(NSInteger)index {
    NSDictionary *dic = _allDataArray[self.suspendedView.currentItemIndex];
    NSArray *children = dic[@"children"];
    if (view.tag == 10000) {
        
        //全部商品分区
        _cid = [children[index][@"cid"] intValue];
    }else if (view.tag == 3000){
        if (index == 0) {
            self.sort_type = @"2";
        }else if(index == 1){
            self.sort_type = @"1";
        }
    }else if (view.tag == 2000){
        if (index == 0) {
            self.sort_type = @"4";
        }else if(index == 1){
            self.sort_type = @"3";
        }
    }
    //点击分类更改一下参数
    self.isSection = YES;
    if (self.suspendedView.currentItemIndex == 0) {
        self.leftPage = 1;
    }else {
        self.rightPage = 1;
    }
    [self getDataForClassify];
}
- (void)choseBtnClick:(UpOrDownButton *)sender {
    
    //CGFloat allH = 165.0f;
    CGFloat allH = UI_SCREEN_HEIGHT-48-choseView.maxY;
    NSDictionary *dic = _allDataArray[self.suspendedView.currentItemIndex];
    NSArray *children = dic[@"children"];
    CGFloat counH = children.count *42.0;
    if (counH<=allH) {
        allH = counH;
    }
    CGFloat othH = 83.0f;
    CGFloat choseViewHight = 42;
    
    if (seletedIndex != 0) {
        UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
        oldBtn.rightView.image = [UIImage imageNamed:@"zai_xiaLa@2x"];
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
            shadowView.frame = CGRectMake(0, choseViewHight + 40, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
            if (sender.tag == 10086) {
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                allGoodsChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, allH);
            }else if (sender.tag == 10088) {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                profitChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, othH);
            }else {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, othH);
            }
            sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        }
    }
    else if (isOut == NO)
    {
        if (sender.tag == 10086) {
            allGoodsChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, allH);
        }else if (sender.tag == 10088) {
            profitChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, othH);
        }else {
            priceChoseView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, othH);
        }
        sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        shadowView.frame = CGRectMake(0, choseViewHight+40, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
        isOut = YES;
    }
    
    seletedIndex = sender.tag;
    
}

- (void)hideChoseView {
    UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
    [self choseBtnClick:oldBtn];
}
- (void)dealAction:(id)sender{
    
    
    UIButton *btn = (UIButton *)sender;
    NSArray *array = [NSArray array];
    if (self.suspendedView.currentItemIndex == 0) {
        array = [_leftTableArray[btn.tag] objectForKey:@"goods_attr"];
        self.onePay = [[_leftTableArray[btn.tag] objectForKey:@"goods_price"] floatValue];
        self.goodID = [_leftTableArray[btn.tag] objectForKey:@"goods_id"];
        self.comDetailDic = _leftTableArray[btn.tag];
    }else {
        array = [_rightTableArray[btn.tag] objectForKey:@"goods_attr"];
        self.onePay = [[_rightTableArray[btn.tag] objectForKey:@"goods_price"] floatValue];
        self.goodID = [_rightTableArray[btn.tag] objectForKey:@"goods_id"];
        self.comDetailDic = _rightTableArray[btn.tag];
    }
    
    self.ggArr = [NSArray array];
    self.subGG = [NSMutableArray arrayWithCapacity:0];
    self.ggArr = array;
    
    for(int i=0;i<self.ggArr.count;i++)
    {
        [self.subGG addObject:@"-1"];
    }
    
    if(self.ggArr.count == 0)
    {
        self.firstStr = @"";
        self.secondStr = @"";
        self.thirdStr = @"";
    }else if(self.ggArr.count == 1)
    {
        self.firstStr = [[[self.ggArr[0] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
        self.secondStr = @"";
        self.thirdStr = @"";
    }else if(self.ggArr.count == 2)
    {
        self.firstStr = [[[self.ggArr[0] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
        self.secondStr = [[[self.ggArr[1] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
        self.thirdStr = @"";
    }else
    {
        self.firstStr = [[[self.ggArr[0] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
        self.secondStr = [[[self.ggArr[1] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
        self.thirdStr = [[[self.ggArr[2] objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
    }
    
    //用数据画图
    [self popGGview];
    
    if (self.suspendedView.currentItemIndex == 0) {
        [self.shopCell updataWhenClassify:_leftTableArray[btn.tag]];
    }else {
        [self.shopCell updataWhenClassify:_rightTableArray[btn.tag]];
    }
    
    
    Animation_Appear .3];
    self.myGGView.hidden = NO;
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.bodyView.frame.size.height)];
    [UIView commitAnimations];
    self.sureBtn.hidden = NO;
}

#pragma -mark SuspendedView delegate
- (void)didClickView:(SuspendedView *)view atItemIndex:(NSInteger)index {
    Animation_Appear 0.4];
    _scrollView.contentOffset = CGPointMake(index * UI_SCREEN_WIDTH, 0);
    [UIView commitAnimations];
    DLog(@"%ld",(long)index);
    if (index == 0) {
        _cid = [_allDataArray[index][@"cid"] intValue];
        self.leftPage = 1;
        [self getDataForClassify];
    }else {
        _cid = [_allDataArray[index][@"cid"] intValue];
        self.rightPage = 1;
        [self getDataForClassify];
    }
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.leftCollectionView) {
        return _leftTableArray.count;
    }
    return _rightTableArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassifyViewCollectionCellStr forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.gwButton.tag = indexPath.item;
    [cell.gwButton addTarget:self action:@selector(dealAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.suspendedView.currentItemIndex == 0) {
        [cell setDictionary:_leftTableArray[indexPath.item] isLeft:YES];
    }else {
        [cell setDictionary:_rightTableArray[indexPath.item] isLeft:NO];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str;
    
    if (self.suspendedView.currentItemIndex == 0) {
        str = _leftTableArray[indexPath.item][@"goods_id"];
    }else{
        str = _rightTableArray[indexPath.item][@"goods_id"];
    }
    
    NSString *body = [NSString stringWithFormat:@"aid=%@",str];
    NSString *url = MOBILE_SERVER_URL(@"getSupplierProductNew2.php");
    [SVProgressHUD show];
    
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"---------%@",body);
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
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
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}
#pragma mark - tipselectDelegate
- (void)didClickClearButton:(UIButton*)button {
    NSMutableArray *arr = [[PreferenceManager sharedManager]preferenceForKey:@"search"];
    if (arr == NULL || [arr isKindOfClass:[NSNull class]]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"没有历史搜索记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else {
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"是否删除历史搜索记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //        [alert show];
        [_historySearchedTipsView.totalTipButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_historySearchedTipsView.totalTipButtons removeAllObjects];
        _historySearchedTipsView.height = _historySearchedTipsView.topTitleLabel.maxY;
        _historySearchedTipsView.mainScrollView.height = _historySearchedTipsView.height;
        _historySearchedUsersView.y = _historySearchedTipsView.maxY;
        _defaultTable.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64);
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"search"];
    }
}
- (void)selectTipsAtIndex:(NSInteger)index AndTag:(NSInteger)tag
{
    NSString*title = @"";
    if (tag == 111) {
        title = _mySearchArr[index];
        self.searchTextField.text = title;
        TipsSelectorView *view1 = (TipsSelectorView *)[self.view viewWithTag:111];
        TipsSelectorView *view2 = (TipsSelectorView *)[self.view viewWithTag:222];
        [view1 unselectAll];
        [view2 unselectAll];
        self.keyword = title;
        _defaultTable.hidden = YES;
        [self getDataForClassify];
    }else if (tag == 222){
        title = _hotSearchArr[index];
        self.searchTextField.text = title;
        TipsSelectorView *view1 = (TipsSelectorView *)[self.view viewWithTag:111];
        TipsSelectorView *view2 = (TipsSelectorView *)[self.view viewWithTag:222];
        [view1 unselectAll];
        [view2 unselectAll];
        self.keyword = title;
        _defaultTable.hidden = YES;
        [self getDataForClassify];
    }
}
#pragma mark - alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [_historySearchedTipsView.totalTipButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_historySearchedTipsView.totalTipButtons removeAllObjects];
        _historySearchedTipsView.height = _historySearchedTipsView.topTitleLabel.maxY;
        _historySearchedTipsView.mainScrollView.height = _historySearchedTipsView.height;
        _historySearchedUsersView.y = _historySearchedTipsView.maxY;
        _defaultTable.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64);
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"search"];
    }
}
#pragma mark - Getter

- (SuspendedView *)suspendedView
{
    if (!_suspendedView)
    {
        _suspendedView = [[SuspendedView alloc] initWithSuspendedViewStyle:SuspendedViewStyleVaule3];
        _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 0);
        _suspendedView.delegate = self;
        NSMutableArray *indexarr = [NSMutableArray new];
        for (int i = 0; i<_allDataArray.count; i++) {
            [indexarr addObject:_allDataArray[i][@"cat_name"]];
        }
        _suspendedView.items = indexarr;
        _suspendedView.backgroundColor = [UIColor whiteColor];
        _suspendedView.currentItemIndex = 0;
        
    }
    
    return _suspendedView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.suspendedView.maxY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.suspendedView.maxY )];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        _scrollView.alwaysBounceHorizontal=YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;
        
        _scrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.suspendedView.maxY );
    }
    return _scrollView;
}
- (UICollectionView *)leftCollectionView
{
    if (!_leftCollectionView) {
        
        NSInteger countPerRow = 2;
        CGFloat interval = 15;
        CGFloat itemWidth = (UI_SCREEN_WIDTH - 1 - 45) / (countPerRow * 1.0);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + 100);
        //flowLayout.minimumLineSpacing = interval / 4.0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _leftCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH , UI_SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
        _leftCollectionView.delegate = self;
        _leftCollectionView.dataSource = self;
        _leftCollectionView.backgroundColor = [UIColor whiteColor];
        [_leftCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:ClassifyViewCollectionCellStr];
        _leftCollectionView.alwaysBounceVertical = YES;
    }
    return _leftCollectionView;
}


- (UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        NSInteger countPerRow = 2;
        CGFloat interval = 15;
        CGFloat itemWidth = (UI_SCREEN_WIDTH - 1 - 45) / (countPerRow * 1.0);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + 100);
        //flowLayout.minimumLineSpacing = interval / 4.0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SuspendedViewHeight-64-40) collectionViewLayout:flowLayout];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        [_rightCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:ClassifyViewCollectionCellStr];
        _rightCollectionView.alwaysBounceVertical = YES;
    }
    return _rightCollectionView;
}


#pragma  mark - http
- (void)getDataForSearchRecord {
    [SVProgressHUD show];
    NSString *bodyStr;
    bodyStr = [NSString stringWithFormat:@"act=3"];
    NSString *str = MOBILE_SERVER_URL(@"goodsCategoryApiNew2.php");
    
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   [SVProgressHUD dismiss];
                                   self.hotSearchArr = responseObject[@"hot_search_list"];
                                   self.mySearchArr = responseObject[@"my_search_list"];
                                   if (_defaultTable) {
                                       [_defaultTable reloadData];
                                   }
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}


- (void)getDataForClassifySec {
    [SVProgressHUD show];
    NSString *bodyStr;
    bodyStr = [NSString stringWithFormat:@"act=1"];
    bodyStr = [NSString stringWithFormat:@"act=1&p_cid=%@",@"2"];
    NSString *str = MOBILE_SERVER_URL(@"goodsCategoryApiNew2.php");
    
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   [SVProgressHUD dismiss];
                                   self.allDataArray = responseObject[@"list"];
                                   [self createSelectView];
                                   [self getDataForClassify];
                                   
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
//获取发现数据
- (void)getDataForClassify {
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"goodsCategoryApiNew2.php");
    NSString *bodyStr;
    if (self.suspendedView.currentItemIndex == 0) {
        bodyStr = [NSString stringWithFormat:@"act=2&p=%ld&&sort_type=%@&keyword=%@&cid=%ld",(long)self.leftPage, _sort_type,self.keyword, (long)_cid];
    }else {
        bodyStr= [NSString stringWithFormat:@"act=2&p=%ld&sort_type=%@&keyword=%@&cid=%ld",(long)self.rightPage, _sort_type,self.keyword, (long)_cid];
    }
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               //终止
                               if (self.headerViews.count>0) {
                                   MJRefreshHeaderView *header = self.headerViews[self.suspendedView.currentItemIndex];
                                   MJRefreshFooterView *foot = self.footerViews[self.suspendedView.currentItemIndex];
                                   [header endRefreshing];
                                   [foot endRefreshing];
                               }
                               
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   
                                   if (self.selectTable) {
                                       self.selectTable.hidden = YES;
                                   }
                                   
                                   [SVProgressHUD dismiss];
                                   if (![responseObject isKindOfClass:[NSDictionary class]]) {
                                       return;
                                   }
                                   if (![[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                                       return;
                                   }
                                   [self createMainScrollView];
                                   [self creatBackView];
                                   if (self.suspendedView.currentItemIndex == 0) {
                                       //选择分组重新请求
                                       if (self.isSection) {
                                           [self.leftTableArray removeAllObjects];
                                           [self.leftTableArray addObjectsFromArray:[responseObject objectForKey:@"list"]];
                                       }else {
                                           if (self.leftPage == 1) {
                                               [self.leftTableArray removeAllObjects];
                                               [self.leftTableArray addObjectsFromArray:[responseObject objectForKey:@"list"]];
                                           }else {
                                               NSArray *arr = [responseObject objectForKey:@"list"];
                                               [self.leftTableArray addObjectsFromArray:arr];
                                           }
                                       }
                                       [self.leftCollectionView reloadData];
                                       UIImageView *image = self.imageArray[self.suspendedView.currentItemIndex];
                                       if (self.leftTableArray.count == 0) {
                                           image.hidden = NO;
                                       }else {
                                           image.hidden = YES;
                                       }
                                       
                                   }else {
                                       //选择分组重新请求
                                       if (self.isSection) {
                                           [self.rightTableArray removeAllObjects];
                                           [self.rightTableArray addObjectsFromArray:[responseObject objectForKey:@"list"]];
                                       }else {
                                           if (self.rightPage == 1) {
                                               [self.rightTableArray removeAllObjects];
                                               [self.rightTableArray addObjectsFromArray:[responseObject objectForKey:@"list"]];
                                           }else {
                                               NSArray *arr = [responseObject objectForKey:@"list"];
                                               [self.rightTableArray addObjectsFromArray:arr];
                                           }
                                       }
                                       [self.rightCollectionView reloadData];
                                       UIImageView *image = self.imageArray[self.suspendedView.currentItemIndex];
                                       if (self.rightTableArray.count == 0) {
                                           image.hidden = NO;
                                       }else {
                                           image.hidden = YES;
                                       }
                                   }
                                   
                                   //搜索记录保存
                                   if (self.keyword !=NULL && ![self.keyword isEqualToString:@""]) {
                                       
                                       NSMutableArray *arr = [[PreferenceManager sharedManager]preferenceForKey:@"search"];
                                       if ([arr containsObject:self.keyword]) {
                                           return;
                                       }
                                       if (arr != NULL && ![arr isKindOfClass:[NSNull class]]) {
                                           arr = (NSMutableArray *)[[arr reverseObjectEnumerator]allObjects];
                                           if (arr.count >=20) {
                                               [arr removeObjectAtIndex:0];
                                           }
                                           [arr addObject:self.keyword];
                                       }else {
                                           arr = [[NSMutableArray alloc]initWithObjects:self.keyword, nil];
                                       }
                                       NSMutableArray *changeArr = (NSMutableArray *)[[arr reverseObjectEnumerator]allObjects];
                                       
                                       [[PreferenceManager sharedManager]setPreference:changeArr forKey:@"search"];
                                   }
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               if (self.headerViews.count>0) {
                                   MJRefreshHeaderView *header = self.headerViews[self.suspendedView.currentItemIndex];
                                   MJRefreshFooterView *foot = self.footerViews[self.suspendedView.currentItemIndex];
                                   [header endRefreshing];
                                   [foot endRefreshing];
                               }
                           }];
    
}

- (TipsSelectorView *)historySearchedTipsView
{
    if (!_historySearchedTipsView)
    {
        _historySearchedTipsView = [[TipsSelectorView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0)];
        _historySearchedTipsView.topTitleLabel.text = @"历史搜索";
        _historySearchedTipsView.topTitleLabel.textColor = [UIColor blackColor];
        //        _historySearchedTipsView.tips = [NSArray arrayWithArray:self.historySearchArray];
        _historySearchedTipsView.backgroundColor = [UIColor whiteColor];
        _historySearchedTipsView.enableMultipleChoice = NO;
        _historySearchedTipsView.delegate = self;
        _historySearchedTipsView.tag = 111;
        _historySearchedTipsView.clearButton.tag = 6666;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _historySearchedTipsView.height - 0.5, _historySearchedTipsView.width, 0.5)];
        lineView.backgroundColor = LINE_SHALLOW_COLOR;
        [_historySearchedTipsView addSubview:lineView];
    }
    
    return _historySearchedTipsView;
}
- (TipsSelectorView *)historySearchedUsersView
{
    if (!_historySearchedUsersView)
    {
        _historySearchedUsersView = [[TipsSelectorView alloc] initWithFrame:CGRectMake(0, _historySearchedTipsView.maxY, UI_SCREEN_WIDTH, 0)];
        _historySearchedUsersView.topTitleLabel.text = @"热门搜索";
        _historySearchedUsersView.topTitleLabel.textColor = [UIColor blackColor];
        //        _historySearchedUsersView.tips = [NSArray arrayWithArray:self.historySearchArray];
        _historySearchedUsersView.backgroundColor = [UIColor whiteColor];
        _historySearchedUsersView.enableMultipleChoice = NO;
        _historySearchedUsersView.clearButton.hidden = YES;
        _historySearchedUsersView.delegate = self;
        _historySearchedUsersView.tag = 222;
        _historySearchedUsersView.clearButton.tag = 8888;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _historySearchedUsersView.height - 0.5, _historySearchedUsersView.width, 0.5)];
        lineView.backgroundColor = LINE_SHALLOW_COLOR;
        [_historySearchedUsersView addSubview:lineView];
    }
    
    return _historySearchedUsersView;
}

#pragma  mark - 加入购物车
-(void)sureAction:(UIButton * )sender{
    self.sureBtn.tag = 88;
    for (int i = 0; i < self.subGG.count; i++)
    {
        if ([[self.subGG objectAtIndex:i] isEqualToString:@"-1"])
        {
            if (!self.myGGView.hidden)
            {
                UIAlertView* alv = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请选择规格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alv show];
            }
            
            //            Animation_Appear .3];
            //            self.myGGView.hidden = NO;
            //            [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.bodyView.frame.size.height)];
            //            [UIView commitAnimations];
            //            self.sureBtn.hidden = NO;
            return;
        }
    }
    //    if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
    //        [self closeGGView];
    //    }
    if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        [self closeGGView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LoginViewController performIfLogin:self withShowTab:YES loginAlreadyBlock:^{
                [self addToShopCart];
            }loginSuccessBlock:nil];
        });
    }else {
        [self closeGGView];
        [self addToShopCart];
    }
}
- (void)addToShopCart {
    [SVProgressHUD show];
    NSMutableArray *selectedSpecificationArray = [self getGoodsSelectedSpecification];
    NSString *specificationStr = [selectedSpecificationArray componentsJoinedByString:@","];
    NSString *body = [NSString stringWithFormat:@"act=1&goods_num=%ld&goods_id=%@&goods_attr_ids=%@",(long)self.selectedGoodsCount,self.goodID,specificationStr];
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
            [BaseNavigationViewController getNumOfShopCart];
            [self closeGGView];
            [SVProgressHUD showSuccessWithStatus:@"添加成功"] ;
        } else {
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            } else {
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
- (NSMutableArray *)getGoodsSelectedSpecification
{
    
    DLog(@"ggarr:%@   subarr:%@",self.ggArr,self.subGG );
    NSMutableArray *selectedSpecificationArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < self.ggArr.count; i++)
    {
        NSArray *goodsSingleSpecification = [[self.ggArr objectAtIndex:i] objectForKey:@"data"];
        NSInteger index=[[self.subGG objectAtIndex:i] integerValue];
        DLog(@"subGG:%@   index=%ld",self.subGG,index);
        if(  (index<goodsSingleSpecification.count)   &&   (index>=0)   ){
            NSString *selectedSpecificationId = [NSString stringWithFormat:@"%@",[[goodsSingleSpecification objectAtIndex:index] objectForKey:@"id"]];
            [selectedSpecificationArray addObject:selectedSpecificationId];
        }
    }
    
    return selectedSpecificationArray;
}
#pragma mark - ggview代理
-(void)closeGGView
{
    Animation_Appear .3];
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    [UIView commitAnimations];
    [self performSelector:@selector(closeGGSuper) withObject:nil afterDelay:0.32];
}


-(void)closeGGSuper
{
    self.myGGView.hidden = YES;
}

//在viewDidLoad中创建规格的界面
-(void)popGGview
{
    
    self.firstStr=@"";
    self.secondStr=@"";
    self.thirdStr=@"";
    
    if(self.myGGView == nil)
    {
        self.myGGView = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        self.myGGView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        self.myGGView.tag = 1888;
        self.myGGView.windowLevel = 999;
        //[self.view addSubview:self.myGGView];
        [self.myGGView makeKeyAndVisible];
        
    }else
    {
        
    }
    self.myGGView.hidden = YES;
    
    for (UIView *view in self.myGGView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    
    UIImageView* imgVi = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-9, 28, 18, 10)];
    //imgVi.image = [UIImage imageNamed:@"csl_guige_up.png"];
    [maskView addSubview:imgVi];
    
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
    self.shopCell.picImg.center = CGPointMake(self.shopCell.picImg.center.x, self.shopCell.picImg.center.y);
    self.shopCell.nameLab.hidden = YES;
    self.shopCell.thLab.center = CGPointMake(self.shopCell.thLab.center.x,self.shopCell.thLab.center.y);
    [self.shopCell setFrame:CGRectMake(self.shopCell.frame.origin.x, self.shopCell.frame.origin.y, UI_SCREEN_WIDTH,106)];
    [self.shopCell.exitBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bodyView.frame.size.height - 44, UI_SCREEN_WIDTH, 44)];
    
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 44)];
    btnT.backgroundColor = App_Main_Color;
    [btnT addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnT setTitle:@"确定" forState:UIControlStateNormal];
    [btnT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnT.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:btnT];
    
    
    GGView* ggView = [[GGView alloc]initWith:self.ggArr andUpView:self.shopCell andBottomView:bottomView andHeight:400 andFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.bodyView.frame.size.height) withGGViewType:GGViewTypeNormal];
    ggView.delegate = self;
    //ggView.canBuyNum = num;
    [self.bodyView addSubview:ggView];
    
    [ggView.closeBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
    maskView.frame=CGRectMake(maskView.frame.origin.x, maskView.frame.origin.y+ggView.guigeOffsetY, maskView.frame.size.width, maskView.frame.size.height);
    self.selectedGoodsCount = 1;
}

-(void)hiddenView
{
    self.buyView.hidden = YES;
}

-(void)checkAttr
{
    self.sureBtn.tag = 77;
    self.sureBtn.hidden = NO;
    
    Animation_Appear .3];
    self.myGGView.hidden = NO;
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.bodyView.frame.size.height)];
    [UIView commitAnimations];
}

- (void)clickCancelBtn {
    Animation_Appear 0.3];
    [self.buyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    [UIView commitAnimations];
    [self performSelector:@selector(hiddenView) withObject:nil afterDelay:.3];
    
}



- (void)outWhichOne:(long)index {
    //x 为多类规格里父类规格所在的位置
    //y 为一类规格里子类规格所在的位置
    long x = index/10000;
    long y = index%10000;
    
    //此数组记录了用户选取规格的情况 数组下标代表规格种类 下面里的值代表子类规格
    [self.subGG replaceObjectAtIndex:x withObject:[NSString stringWithFormat:@"%ld",y]];
    
    NSArray *selectArr=[self getGoodsSelectedSpecification];
    [self changeWithAttr:[selectArr componentsJoinedByString:@","]];
    
    //这边设置规格的3个预览 如不足3个就按相应个数 如果超过则只取前3个 x+1为单个商品的规格父类数量
    if(x == 0)
    {
        self.firstStr = [[[self.ggArr[0] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }else if(x == 1)
    {
        self.secondStr = [[[self.ggArr[1] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }else if(x == 2)
    {
        self.thirdStr = [[[self.ggArr[2] objectForKey:@"data"] objectAtIndex:[self.subGG[x] intValue]] objectForKey:@"name"];
    }
    
    [self.shopCell setGGWith:self.firstStr andTwo:self.secondStr andThree:self.thirdStr];
    
    self.attrPay = 0.0;
    
    //遍历数组 判断数组里是否有元素为-1 即没有被选过的规格
    for(int i = 0;i<self.subGG.count;i++)
    {
        if([self.subGG[i] isEqualToString:@"-1"])
        {
            
        }else
        {
            self.attrPay = self.attrPay + [[[[self.ggArr[i] objectForKey:@"data"] objectAtIndex:[self.subGG[i] intValue]] objectForKey:@"attr_price"] floatValue];
        }
    }
    
    [self changeAllPriceWith:(int)self.selectedGoodsCount andGGPrice:self.attrPay];
}
#pragma mark - 改变图片
-(void)changeWithAttr:(NSString *)attr {
    
    NSString *aid=[NSString stringWithFormat:@"%@",[self.comDetailDic valueForKey:@"goods_id"]];
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
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

#pragma mark - 改变价格
- (void)changeAllPriceWith:(int)num andGGPrice:(float)attPrice {
    self.allPay = self.onePay * num + attPrice;
    NSString* thStr =[NSString stringWithFormat:@"合计：%.2f",self.allPay];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(3,thStr.length-3)];
    self.shopCell.priceLab.attributedText = str;
    if (num == 1) {
        self.shopCell.priceLab.text = [NSString stringWithFormat:@"单价:%.2f", self.onePay + attPrice];;
    }
}
@end
