//
//  ApplyRecordViewController.m
//  SmallCEO
//
//  Created by gaojun on 15-8-25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "ApplyRecordViewController.h"
#import "RecordTableViewCell.h"

@interface ApplyRecordViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UITableView         *recordTV;
@property (nonatomic, strong) UIView              *noDataView;
@property (nonatomic, strong) MJRefreshFooterView *MJFooterView;
@property (nonatomic, strong) MJRefreshHeaderView *MJHeaderView;

@property (nonatomic, assign) NSInteger           currentPage;
@property (nonatomic, copy)   NSString            *lastDate;

@property (nonatomic, strong)   NSMutableArray      *sectionViewStatusArray; //1 is shrink status, 0 is normal status

@end

@implementation ApplyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"授信申请记录";
    self.currentPage = 1;
    self.sectionViewStatusArray = [NSMutableArray arrayWithCapacity:0];
    
    [self createRecordTableView];
    [self createNoDataView];
    [self requestApplyRecordData];
}

- (void)createNoDataView
{
    self.noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
    self.noDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.noDataView];
    
    UILabel *noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.text = @"暂无数据";
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    [self.noDataView addSubview:noDataWarningLabel];
    self.noDataView.hidden = YES;
}

- (void)createRecordTableView
{
    _recordTV = [[UITableView alloc]init];
    _recordTV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    _recordTV.backgroundColor = [UIColor whiteColor];
    _recordTV.delegate = self;
    _recordTV.dataSource = self;
    _recordTV.tag = 1223334444;
    _recordTV.showsHorizontalScrollIndicator = NO;
    _recordTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_recordTV];
    
    self.MJHeaderView = [[MJRefreshHeaderView alloc] init];
    self.MJHeaderView.delegate = self;
    self.MJHeaderView.scrollView = _recordTV;
    
    self.MJFooterView = [[MJRefreshFooterView alloc] init];
    self.MJFooterView.delegate = self;
    self.MJFooterView.scrollView = _recordTV;
}

#pragma mark - 获取申请纪录信息
- (void)requestApplyRecordData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_credit_apply.php");
    NSString *bodyStr;
    if (self.currentPage == 1)
    {
        bodyStr = [NSString stringWithFormat:@"act=list&p=%ld", (long)self.currentPage];
    }
    else
    {
        bodyStr = [NSString stringWithFormat:@"act=list&p=%ld&last_date=%@", (long)self.currentPage, _lastDate];
    }
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               [self.MJHeaderView endRefreshing];
                               [self.MJFooterView endRefreshing];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"获取数据失败"];
                               }
                               
                               NSDictionary *dic = [[responseObject valueForKey:@"apply_list"] objectForKey:@"list"];
                               if ([dic isKindOfClass:[NSDictionary class]] &&
                                   self.currentPage == 1)
                               {
                                   _lastDate = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"apply_list"] objectForKey:@"list_date"]];
                                   listDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                                   listDicAllKeys = [listDic allKeys];
                                   if (self.sectionViewStatusArray.count != 0)
                                   {
                                       [self.sectionViewStatusArray removeAllObjects];
                                   }
                                   
                                   for (int i = 0; i < listDicAllKeys.count; i++) {
                                       [self.sectionViewStatusArray addObject:[NSNumber numberWithInteger:0]];
                                   }
                                   [_recordTV reloadData];
                                   self.noDataView.hidden = YES;
                                   [SVProgressHUD dismiss];
                               }
                               else if ([dic isKindOfClass:[NSDictionary class]] &&
                                        self.currentPage != 1)
                               {
                                   _lastDate = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"apply_list"] objectForKey:@"list_date"]];
                                   [self handleBillDataWithNewData:dic];
                                   listDicAllKeys = [listDic allKeys];
                                   if (self.sectionViewStatusArray.count != 0)
                                   {
                                       [self.sectionViewStatusArray removeAllObjects];
                                   }
                                   
                                   for (int i = 0; i < listDicAllKeys.count; i++) {
                                       [self.sectionViewStatusArray addObject:[NSNumber numberWithInteger:0]];
                                   }
                                   [_recordTV reloadData];
                                   self.noDataView.hidden = YES;
                                   [SVProgressHUD dismiss];
                               }
                               else if ([dic isKindOfClass:[NSArray class]] &&
                                        self.currentPage !=1)
                               {
                                   [SVProgressHUD dismissWithSuccess:@"没有更多数据"];
                               }
                               else if ([dic isKindOfClass:[NSArray class]] &&
                                        self.currentPage ==1)
                               {
                                   self.noDataView.hidden = NO;
                                   [SVProgressHUD dismiss];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [self.MJHeaderView endRefreshing];
                               [self.MJFooterView endRefreshing];
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark - 处理拼接数据
- (void)handleBillDataWithNewData:(NSDictionary *)dataDic
{
    NSArray *keysNameArray = [dataDic allKeys];
    for (int i = 0; i < keysNameArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@", [[dataDic objectForKey:[keysNameArray objectAtIndex:i]] objectForKey:@"is_have_ym"]];
        if ([str isEqualToString:@"1"])
        {
            [listDic setObject:[dataDic objectForKey:[keysNameArray objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%@", [keysNameArray objectAtIndex:i]]];
        }
        else
        {
            NSArray *oldBillData = [[listDic objectForKey:[keysNameArray objectAtIndex:i]] objectForKey:@"list"];
            NSArray *billData = [[dataDic objectForKey:[keysNameArray objectAtIndex:i]] objectForKey:@"list"];
            NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:[listDic objectForKey:[keysNameArray objectAtIndex:i]]];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:oldBillData];
            [array addObjectsFromArray:billData];
            [temp setObject:array forKey:@"list"];
            [listDic setObject:temp forKey:[NSString stringWithFormat:@"%@", [keysNameArray objectAtIndex:i]]];
        }
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *allKeys = [NSMutableArray arrayWithArray:listDicAllKeys];
    [allKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1 options:NSNumericSearch];
    }];
    
    if (self.sectionViewStatusArray.count != 0 &&
        [[self.sectionViewStatusArray objectAtIndex:section] integerValue] == 1)
    {
        return 0;
    }
    
    NSArray *temp = [[listDic valueForKey:[allKeys objectAtIndex:section]] valueForKey:@"list"];
    return temp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSMutableArray *allKeys = [NSMutableArray arrayWithArray:listDicAllKeys];
    [allKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1 options:NSNumericSearch];
    }];
    NSArray *temp = [[listDic valueForKey:[allKeys objectAtIndex:indexPath.section]] valueForKey:@"list"];
    
    NSDictionary *tempDic=[temp objectAtIndex:indexPath.row];
    [cell updateUIwithDic:tempDic];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listDicAllKeys.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 25.0)];
    headerView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    headerView.tag = section;
    [headerView addTarget:self action:@selector(shrinkSection:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *allKeys = [NSMutableArray arrayWithArray:listDicAllKeys];
    [allKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1 options:NSNumericSearch];
    }];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH - 20, 25.0)];
    textLabel.font = [UIFont systemFontOfSize:13.0];
    NSString *date = [NSString stringWithFormat:@"%@",[allKeys objectAtIndex:section]];
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    NSString *monthStr = [dateArray objectAtIndex:1];
    if ([[monthStr substringToIndex:1] isEqualToString:@"0"])
    {
        monthStr = [monthStr substringFromIndex:1];
    }
    textLabel.text = [NSString stringWithFormat:@"%@年%@月", [dateArray objectAtIndex:0], monthStr];
    [headerView addSubview:textLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24.0, UI_SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor = [UIColor colorFromHexCode:@"aaaaaa"];
    [headerView addSubview:lineLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49.0;
}

#pragma mark - 收缩UITableView单元
- (void)shrinkSection:(UIView *)sectionHeaderView
{
    if (sectionHeaderView.tag < self.sectionViewStatusArray.count)
    {
        NSInteger status = [[self.sectionViewStatusArray objectAtIndex:sectionHeaderView.tag] integerValue];
        NSInteger newStatus = status == 1 ? 0 : 1;
        [self.sectionViewStatusArray replaceObjectAtIndex:sectionHeaderView.tag withObject:[NSNumber numberWithInteger:newStatus]];
        [_recordTV reloadData];
    }
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        self.currentPage = 1;
        [self requestApplyRecordData];
    }
    else
    {
        self.currentPage++;
        [self requestApplyRecordData];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.MJHeaderView free];
    [self.MJFooterView free];
}

@end
