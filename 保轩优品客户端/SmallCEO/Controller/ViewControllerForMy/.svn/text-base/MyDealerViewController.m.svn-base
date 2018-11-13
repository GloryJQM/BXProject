//
//  MyDealerViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

static const NSInteger HeightForTopView = 39.5;

#import "MyDealerTableViewCell.h"
#import "MyDealerViewController.h"

@interface MyDealerViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    UIView * escView;
    UIView * esc;
    BOOL isPopOrHide;
    NSMutableArray *selectImageViewArr;
    NSMutableArray *selectLabelArr;
    UILabel *noDataWarningLabel;
}
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) MJRefreshFooterView *footerView;
@property (nonatomic, copy)   NSArray *myDealerInfoArray;
@property (nonatomic, strong) NSString *ascOrdesc;
//@property (nonatomic, strong) NSMutableArray *levelArray;
//@property (nonatomic, strong) NSMutableArray *puIDArray;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) int levelMax;

@end

@implementation MyDealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNagivationBarView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.ascOrdesc = @"asc";
    self.currentPage = 1;
    if (self.level == 0) {
        self.title = @"我的分销商";
    }else {
        self.title = [NSString stringWithFormat:@"%@的分销商",self.subTitle];
    }
    [self createTopView];
    [self createMainView];
    [self getMyDealerInfo];
    
    [self ecsBackView];

    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 150-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"没有分销商数据";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:14.0];
    noDataWarningLabel.hidden = YES;
    [self.mainTableView addSubview:noDataWarningLabel];
}

- (void)createNagivationBarView
{
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(sortDataBtnClick)
                                       ];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:14.0], NSFontAttributeName,
                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                       nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = billButtonItem;
}

-(void)sortDataBtnClick{
    
//    if ([self.ascOrdesc isEqualToString:@"asc"]) {
//        self.ascOrdesc=@"desc";
//    }else{
//        self.ascOrdesc=@"asc";
//    }
//    self.currentPage=1;
//    [self getMyDealerInfo];
    
    if (isPopOrHide == NO) {
        [self popEcsView];
        isPopOrHide = YES;
    }else{
        [self hideEscView];
        isPopOrHide = NO;
    }
    
}

-(void)sortData:(UIButton *)btn{
    int index=btn.tag;
    for (int i=0; i<selectImageViewArr.count; i++) {
        UIImageView *view=[selectImageViewArr objectAtIndex:i];
        if (i==index) {
            view.hidden=NO;
        }else{
            view.hidden=YES;
        }
    }
   
    switch (index) {
        case 0:
        {
            mySortType=4;
            self.ascOrdesc=@"asc";
        }
            break;
            
        case 1:
        {
            mySortType=3;
            self.ascOrdesc=@"desc";
        }
            break;
        case 2:
        {
            mySortType=2;
            self.ascOrdesc=@"asc";
        }
            break;
        case 3:
        {
            mySortType=1;
            self.ascOrdesc=@"desc";
        }
            break;
            
        default:
            break;
    }
    
    [self hideEscView];
    
    self.currentPage=1;
    [self getMyDealerInfo];

}

#pragma mark - 排序
- (void)ecsBackView
{
    
    escView = [[UIView alloc] initWithFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [self.view addSubview:escView];
    esc = [[UIView alloc] initWithFrame:CGRectMake(0, -120, UI_SCREEN_WIDTH, 120)];
    esc.backgroundColor = WHITE_COLOR;
    [escView addSubview:esc];
    
    NSArray * titleArray = @[@"加入日期升序", @"加入日期减序", @"获得返利升序", @"获得返利减序"];
    selectImageViewArr=[[NSMutableArray alloc] initWithCapacity:0];
    selectLabelArr=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i <  titleArray.count; i++) {
        UIView * escCell = [[UIView alloc] initWithFrame:CGRectMake(0, 30*i, UI_SCREEN_WIDTH, 30)];
        escCell.tag=i;
        [esc addSubview:escCell];
        
        UILabel * escLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 25)];
        escLabel.text = titleArray[i];
        [escCell addSubview:escLabel];
        [selectLabelArr addObject:escLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 30*(i + 1), UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [esc addSubview:line];
        
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-24, 10, 14, 10)];
        imageV.backgroundColor=[UIColor clearColor];
        imageV.layer.cornerRadius=0;
        imageV.image=[UIImage imageNamed:@"icon_buleright.png"];
        [escCell addSubview:imageV];
        imageV.hidden=YES;
        [selectImageViewArr addObject:imageV];
        
        [escCell addTarget:self action:@selector(sortData:) forControlEvents:UIControlEventTouchUpInside];
    
        
    }
    
}

- (void)popEcsView
{
    escView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    escView.backgroundColor = [UIColor colorFromHexCode:@"cdcdcd"];
    esc.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 120);
}
- (void)hideEscView
{
    isPopOrHide=NO;
    escView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    esc.frame = CGRectMake(0, -120, UI_SCREEN_WIDTH, 120);
}
- (void)createTopView
{
    UILabel *dealerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH / 4  +20, HeightForTopView)];
    dealerNameLabel.text = @"分销商名";
    dealerNameLabel.font = [UIFont systemFontOfSize:13.0];
    dealerNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dealerNameLabel];
    
    UILabel *dealerJoinTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dealerNameLabel.frame), 0, UI_SCREEN_WIDTH / 4, 40)];
    dealerJoinTimeLabel.text = @"加入日期";
    dealerJoinTimeLabel.font = [UIFont systemFontOfSize:13.0];
    dealerJoinTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dealerJoinTimeLabel];
    
    UILabel *myRebatesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dealerJoinTimeLabel.frame), 0, UI_SCREEN_WIDTH / 4-5, 40)];
    myRebatesLabel.text = @"获得返利";
    myRebatesLabel.font = [UIFont systemFontOfSize:13.0];
    myRebatesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:myRebatesLabel];
    
    UILabel *cheakSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myRebatesLabel.frame), 0, UI_SCREEN_WIDTH / 4 - 15, 40)];
    cheakSubLabel.text = @"查看下级";
    cheakSubLabel.font = [UIFont systemFontOfSize:13.0];
    cheakSubLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cheakSubLabel];
    
    CGFloat offsetXArray[3] = {CGRectGetMaxX(dealerNameLabel.frame), CGRectGetMaxX(dealerJoinTimeLabel.frame),CGRectGetMaxX(myRebatesLabel.frame)};
    for (int i = 0; i < 3; i++) {
        UILabel *verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetXArray[i], 8.75, 1, 22)];
        verticalLabel.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
        [self.view addSubview:verticalLabel];
    }
}

- (void)createMainView
{
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeightForTopView, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HeightForTopView)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = MONEY_COLOR;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:mainTableView];
    self.mainTableView = mainTableView;
    
    self.headerView = [[MJRefreshHeaderView alloc] init];
    self.headerView.scrollView = self.mainTableView;
    self.headerView.delegate = self;
    
    self.footerView = [[MJRefreshFooterView alloc] init];
    self.footerView.scrollView = self.mainTableView;
    self.footerView.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myDealerInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellForMyDealer";
    MyDealerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil)
    {
        cell = [[MyDealerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.dealerNameLabel.text = [NSString stringWithFormat:@"%@", [[_myDealerInfoArray objectAtIndex:indexPath.row] objectForKey:@"distributor_name"]];
    cell.dealerJoinTimeLabel.text = [NSString stringWithFormat:@"%@", [[_myDealerInfoArray objectAtIndex:indexPath.row] objectForKey:@"add_time"]];
    cell.myRebatesLabel.text = [NSString stringWithFormat:@"%@元", [[_myDealerInfoArray objectAtIndex:indexPath.row] objectForKey:@"income"]];
    NSNumber *child = [[_myDealerInfoArray objectAtIndex:indexPath.row] objectForKey:@"child"];
    if (child.intValue == 0) {

        cell.cheakSubLabel.hidden = YES;
    }else {
        cell.cheakSubLabel.hidden=NO;
        cell.cheakSubLabel.tag = indexPath.row;
        [cell.cheakSubLabel addTarget:self action:@selector(cheakSub:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell.phoneButton addTarget:self action:@selector(makeCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.phoneButton.tag = indexPath.row + 100;
    return cell;
}

- (void)cheakSub:(UIButton *)sender {

    MyDealerViewController *vc = [[MyDealerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.level = (int)(self.level + 1);
    vc.puID = [[_myDealerInfoArray objectAtIndex:sender.tag] objectForKey:@"puid"];
    vc.subTitle = [NSString stringWithFormat:@"%@", [[_myDealerInfoArray objectAtIndex:sender.tag] objectForKey:@"distributor_name"]];
}
- (void)makeCell:(UIButton *)sender {
    NSNumber *phoneNumber = [[_myDealerInfoArray objectAtIndex:sender.tag - 100] objectForKey:@"phone"];
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}
#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        //下拉刷新
        self.currentPage = 1;
        [self getMyDealerInfo];
    }else {
        //上拉加载
        self.currentPage ++;
        [self getMyDealerInfo];
    }
}

#pragma mark - 发送请求方法
- (void)getMyDealerInfo
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_distributor.php");
    
    
    NSString *body = nil;
    if (self.level == 0) {
        //第一个界面传人
        body =[NSString stringWithFormat:@"p=%d&order=%@",self.currentPage,self.ascOrdesc];
    }else {
        body = [NSString stringWithFormat:@"p=%d&level=%d&puid=%@&order=%@",self.currentPage,self.level,self.puID,self.ascOrdesc];
    }
    if (mySortType>2) {
        body=[NSString stringWithFormat:@"%@&type=time",body];
    }
    
    
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               [self.headerView endRefreshing];
                               [self.footerView endRefreshing];
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               if (self.currentPage == 1) {
                                   _myDealerInfoArray = [responseObject objectForKey:@"distributor_list"];
                               }else {
                                   NSMutableArray *addArray = [[NSMutableArray alloc] initWithArray:_myDealerInfoArray];
                                   [addArray addObjectsFromArray:[responseObject objectForKey:@"distributor_list"]];
                                   self.myDealerInfoArray = addArray;
                                   
                               }
                               DLog(@"shuliang--%ld",self.myDealerInfoArray.count);
                               if (self.level == 0 && self.myDealerInfoArray.count == 0) {
                                   noDataWarningLabel.hidden = NO;
                               }else {
                                   noDataWarningLabel.hidden = YES;
                               }

                               self.levelMax = (int)[responseObject objectForKey:@"levelMax"];
                               
                               [self.mainTableView reloadData];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [self.headerView endRefreshing];
                               [self.footerView endRefreshing];
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark -
- (void)dealloc
{
    [self.headerView free];
    [self.footerView free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
