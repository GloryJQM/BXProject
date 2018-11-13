//
//  CommissionViewController.m
//  Jiang
//
//  Created by peterwang on 17/2/28.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "CommissionViewController.h"
#import "XHDatePickerView.h"
#import "NoDataWarningView.h"
#import "CommissionTableViewCell.h"
#import "MJRefresh.h"
@interface CommissionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NoDataWarningView *noDataWarningView;
    
}

@property (nonatomic, copy)   NSString       *lastDate;
@property (nonatomic, assign) NSInteger      currentPage;
@property (nonatomic, copy)   NSString       *selectDate;

@property (nonatomic, strong) UITableView    *billTableView;

@property (nonatomic, strong) NSMutableDictionary *contentDic;
@property (nonatomic, strong) NSMutableDictionary *contentInfoDic;
@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *foot;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation CommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavi];
    self.navigationItem.title = @"我的奖金";
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentDic = [NSMutableDictionary dictionary];
    self.contentInfoDic = [NSMutableDictionary dictionary];
    self.lastDate = @"0";
    self.currentPage = 1;
    self.selectDate = @"";
    [self createMainView];
    [self requestBillInfos];
    [self creatBackView];
}
- (void)creatBackView
{
    _imageArray = [NSMutableArray array];
    for (int i = 0; i < 1;i++ ) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-75, UI_SCREEN_HEIGHT/4-50, 150, 150)];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:@"icon-tishi2@2x"];
        
        [self.billTableView addSubview:imageView];
        [_imageArray addObject:imageView];
    }
}

- (void)createNavi {
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(Datepicker)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
}
- (void)dealloc {
    [_header free];
    [_foot free];
}
- (void)createMainView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor whiteColor];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    noDataWarningView = [[NoDataWarningView alloc] initWithFrame:tableView.bounds title:@"暂无数据"];
    //[tableView addSubview:noDataWarningView];
    noDataWarningView.hidden = NO;
    _header = [[MJRefreshHeaderView alloc]init];
    _header.scrollView = tableView;
    __weak CommissionViewController *vc = self;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        vc.currentPage = 1;
        vc.lastDate = @"0";
        [vc requestBillInfos];
    };
    _foot = [[MJRefreshFooterView alloc]init];
    _foot.scrollView = tableView;
    _foot.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        vc.currentPage++;
        [vc requestBillInfos];
    };

    [self.view addSubview:tableView];
    self.billTableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
    if (billDicAllKeys.count == 0) return 0;
    NSMutableDictionary *dic = [self.contentInfoDic objectForKey:billDicAllKeys[section]];
    
    if ([[dic objectForKey:@"shrinkSection"] isEqualToString:@"1"]) {
        return 0;
    }
    
    NSArray *currentMonthBillArray = [self.contentDic objectForKey:billDicAllKeys[section]];
    if (currentMonthBillArray.count == 0) return 0;
    
    return currentMonthBillArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommissionTableViewCell *cell = [CommissionTableViewCell cellWithTableView:tableView];
    NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
    NSArray *currentMonthBillArray = [self.contentDic objectForKey:billDicAllKeys[indexPath.section]];
    NSMutableDictionary *dic = currentMonthBillArray[indexPath.row];
    NSString *imgString = [dic objectForKey:@"finance_type"];
    NSString *nameString = [dic objectForKey:@"number_txt"];
    NSString *detailString = [dic objectForKey:@"remark"];
    NSString *timeString = [dic objectForKey:@"log_time_h_i"];
    NSString *dateString = [dic objectForKey:@"log_time_y_m_d"];
    
    if ([imgString isEqualToString:@"1"]) {
        cell.headImage.image = [UIImage imageNamed:@"icon-jinfen@2x"];
    }else {
        cell.headImage.image = [UIImage imageNamed:@"icon-daijinquan@2x"];
    }
    cell.moneyLabel.text = nameString;
    cell.detail.text = detailString;
    cell.time.text = timeString;
    cell.dateLabel.text = dateString;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contentDic.allKeys.count;
    //    return 2;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40.0)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.tag = section;
    [headerView addTarget:self action:@selector(shrinkSection:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
    NSDictionary *dic = [self.contentInfoDic objectForKey:billDicAllKeys[section]];
    NSString *nameString = [dic objectForKey:@"date_txt"];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , 0, UI_SCREEN_WIDTH / 2.0 - 15, 40.0)];
    nameLabel.font = [UIFont systemFontOfSize:15.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = BLACK_COLOR;
    nameLabel.text = nameString;
    [headerView addSubview:nameLabel];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0.5)];
    topLineView.backgroundColor = [UIColor colorFromHexCode:@"dddddd"];
    [headerView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, UI_SCREEN_WIDTH, 0.5)];
    bottomLineView.backgroundColor = [UIColor colorFromHexCode:@"dddddd"];
    [headerView addSubview:bottomLineView];
    
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CompanyServeDetailController* vc = [[CompanyServeDetailController alloc] init];
//    
//    NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
//    NSArray *currentMonthBillArray = [self.contentDic objectForKey:billDicAllKeys[indexPath.section]];
//    NSMutableDictionary *dic = currentMonthBillArray[indexPath.row];
//    vc.contentDic = [dic copy];
//    
//    NSDictionary *infoDic = [self.contentInfoDic objectForKey:billDicAllKeys[indexPath.section]];
//    
//    vc.navTitle = [infoDic objectForKey:@"name"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 收缩UITableView单元
- (void)shrinkSection:(UIView *)sectionHeaderView
{
    if (sectionHeaderView.tag < self.contentDic.allKeys.count)
    {
        
        NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
        NSMutableDictionary  *currentDic = [self.contentInfoDic objectForKey:billDicAllKeys[sectionHeaderView.tag]];
        if ([[currentDic objectForKey:@"shrinkSection"] isEqualToString:@"1"]) {
            [currentDic setValue:@"0" forKey:@"shrinkSection"];
        }else{
            [currentDic setValue:@"1" forKey:@"shrinkSection"];
        }
        [self.contentInfoDic setValue:currentDic forKey:billDicAllKeys[sectionHeaderView.tag]];
        [self.billTableView reloadData];
    }
}


#pragma mark - 处理拼接数据

- (void)handleDataWithNewData:(NSArray *)array
{
    DLog(@"%@",array);
    if (![array isKindOfClass:[NSArray class]]) return;
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dic = array[i];
        
        NSString *is_have_draw = [NSString stringWithFormat:@"%@", dic[@"info"][@"is_have_draw"]];
        NSString *infoId = [NSString stringWithFormat:@"%d",i];
        NSArray *listArray = [dic objectForKey:@"list"];
        
        NSMutableDictionary *infoDic = [[dic objectForKey:@"info"] mutableCopy];
        [infoDic setObject:@"0" forKey:@"shrinkSection"];
        
        if([is_have_draw isEqualToString:@"1"]){
            
            [self.contentDic setObject:listArray forKey:infoId];
            [self.contentInfoDic setObject:infoDic forKey:infoId];
            
        }else{
            
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[self.contentDic objectForKey:infoId]];
            [array addObjectsFromArray:listArray];
            [self.contentDic setObject:listArray forKey:infoId];
            [self.contentInfoDic setObject:infoDic forKey:infoId];
        }
        
    }
    
}

#pragma mark - Http request methods
- (void)requestBillInfos
{
    [SVProgressHUD show];
    NSString *str =  MOBILE_SERVER_URL(@"incomeApi.php");
    
    NSString *bodyStr = [NSString stringWithFormat:@"o_search=%@&date=%@&p=%ld",self.lastDate,self.selectDate,(long)self.currentPage];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               [self.foot endRefreshing];
                               [self.header endRefreshing];
                               
                               NSString *state = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if ([state isEqualToString:@"1"]) {
                                   //
                                   if (self.currentPage == 1) {
                                       self.contentDic = [NSMutableDictionary dictionary];
                                       self.contentInfoDic = [NSMutableDictionary dictionary];
                                   }
                                   //
                                   NSArray *listArray = (NSArray*)[responseObject objectForKey:@"list"];
                                   //
                                   self.lastDate = [responseObject objectForKey:@"o_search"];
                                   if (listArray.count > 0) {
                                       
                                       [self handleDataWithNewData:listArray];
                                       
                                       
                                       [self.billTableView reloadData];
                                       NSMutableArray *billDicAllKeys = [NSMutableArray arrayWithArray:self.contentDic.allKeys];
                                       noDataWarningView.hidden = billDicAllKeys.count == 0 ? NO : YES;
                                       [SVProgressHUD dismiss];
                                       
                                       
                                   }else{
                                       
                                       [self.billTableView reloadData];
                                       
                                       [SVProgressHUD dismiss] ;
                                   }
                                   
                                   
                               }else{
                                   [SVProgressHUD dismiss];
                               }

                               UIImageView *image = self.imageArray[0];
                               if (self.contentDic.allKeys.count == 0) {
                                   image.hidden = NO;
                               }else {
                                   image.hidden = YES;
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               [self.header endRefreshing];
                               [self.foot endRefreshing];
                               UIImageView *image = self.imageArray[0];
                               image.hidden = NO;
                           }];
    
}
#pragma  mark - 按钮点击方法
- (void)Datepicker {
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
        self.currentPage = 1;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        self.selectDate = [formatter stringFromDate:startDate];
        [self requestBillInfos];
        
    } andType:0];
    [datepicker show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
