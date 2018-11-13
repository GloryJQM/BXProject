//
//  DayShaiXuanViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/16.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "DayShaiXuanViewController.h"
#import "CustomTableViewCell.h"
#import "PNChart.h"
@interface DayShaiXuanViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView * titleView,  *bottomView,  *doubleMiddleView;
    UILabel * allMoneyLabel;
    UILabel * noDataWarningLabel;
    
    UIButton * kuangBtn;
    UIImageView * kuangImageView;
    
    UIScrollView* middleView;
    UITableView * zhuTableView;
    
    UIView * headerView;
    double dataMax, dataMin;
}
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * areaView;

@property (nonatomic, strong)UIScrollView * GainScrollView;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)NSMutableArray * riLiDataArray;

@property (nonatomic, strong)NSMutableArray * riLiShaiXuanDataArray;

@end

@implementation DayShaiXuanViewController

- (void)viewWillAppear:(BOOL)animated
{
    DLog(@"筛选结果  %@  %@  %@", self.dataDic, self.titleStr, self.date);
    DLog(@"收益类型  -----  %d  %d", self.whichShouYiTap, self.whichVC);
   
    if (self.whichVC == 1 ) {
        [self getTodayInfor];
    }else if (self.whichVC == 4){
        [self getShaiXuanTodayInfor];    
    }else{
        NSArray * array = [self.dataDic objectForKey:@"list"];
        NSArray * reserArray = [[array reverseObjectEnumerator]allObjects];
        self.dataArray = [NSMutableArray arrayWithArray:reserArray];
        
        noDataWarningLabel.hidden = self.dataArray.count == 0 ? NO:YES;
        
        dataMax=[[self.dataDic valueForKey:@"max"] doubleValue];
        dataMin=[[self.dataDic valueForKey:@"min"] doubleValue];
        
        [self updateLineChartData:self.dataArray];
        if (self.whichVC == 30) {
            allMoneyLabel.text = [NSString stringWithFormat:@"%d", [[self.dataDic objectForKey:@"total"] intValue]];
        }else {
            allMoneyLabel.text = [NSString stringWithFormat:@"%.2lf", [[self.dataDic objectForKey:@"total"]floatValue]];
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - 80 / 2, 30, 100, 20)];
    self.navigationItem.titleView = titleView;
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    //1代表从日历近  4代表从筛选结果近 20表示昨日收益 30表示售出量
    if (self.whichVC == 1 || self.whichVC == 4) {
        titleLable.text = @"当日收益";
    } else if(self.whichVC == 20){
        titleLable.text = @"昨日收益";
    }else{
        titleLable.text = @"筛选结果";
    }
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentRight;
    [titleView addSubview:titleLable];

    [self.view addSubview:self.GainScrollView];
    [self creatMainView];
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 300-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无数据";
    noDataWarningLabel.textColor = DETAILS_COLOR;
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:noDataWarningLabel];
}

- (UIScrollView *)GainScrollView
{
    if (_GainScrollView == nil) {
        self.GainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
        _GainScrollView.scrollEnabled = NO;
        
    }
    return _GainScrollView;
}

- (void)creatMainView
{
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 300)];
    headerView.backgroundColor = WHITE_COLOR;
    [self.GainScrollView addSubview:headerView];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 100)];
    topView.backgroundColor = WHITE_COLOR;
    [headerView addSubview:topView];
    
    UILabel * allLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-200/2, 14, 200, 20)];
    if (self.whichVC == 20) {
        allLabel.text = @"昨日收益(元)";
    }else if(self.whichVC == 30){
        allLabel.text = @"当日售出(件)";
    }else {
        allLabel.text = @"当前收益(元)";
    }
    
    allLabel.textColor = [UIColor colorFromHexCode:@"686868"];
    allLabel.font = [UIFont systemFontOfSize:14];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allLabel];
    
    allMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50,UI_SCREEN_WIDTH, 40)];
    allMoneyLabel.text = [NSString stringWithFormat:@"%.2lf", [[self.dataDic objectForKey:@"total"]floatValue]];
    allMoneyLabel.textColor = [UIColor colorFromHexCode:@"#ea6153"];
    allMoneyLabel.font = [UIFont systemFontOfSize:30];
    allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    
    [topView addSubview:allMoneyLabel];
    
    
    
    kuangBtn = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80 - 6, 12,80, 27)];
    [kuangBtn setTitleColor:[UIColor colorFromHexCode:@"#ea6153"] forState:UIControlStateNormal];
    [kuangBtn setTitle:@"折起折线图" forState:UIControlStateNormal];
    
    kuangBtn.backgroundColor = WHITE_COLOR;
    kuangBtn.layer.cornerRadius = 27/2;
    kuangBtn.layer.borderColor = [UIColor colorFromHexCode:@"#ea6153"].CGColor;
    kuangBtn.layer.borderWidth = 1;
    [kuangBtn addTarget:self action:@selector(kuang) forControlEvents:UIControlEventTouchUpInside];
    kuangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    kuangBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:kuangBtn];
    
    
    middleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, UI_SCREEN_WIDTH, 200)];
    middleView.contentSize = CGSizeMake(SCREEN_WIDTH, 200);
    middleView.showsHorizontalScrollIndicator = NO;
    middleView.bounces = NO;
    [headerView addSubview:middleView];
    
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -64)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle =UITableViewCellSeparatorStyleNone;
    zhuTableView= tab;
    zhuTableView.tableHeaderView = headerView;
    [self.GainScrollView addSubview:tab];
    
}

- (void)kuang
{
    if (self.isFirst == NO) {
        
        headerView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 100);
        zhuTableView.tableHeaderView = headerView;
        middleView.hidden = YES;
        [kuangBtn setTitle:@"展开折线图" forState:UIControlStateNormal];
        self.isFirst = YES;
    }else {
        
        [kuangBtn setTitle:@"折起折线图" forState:UIControlStateNormal];
        headerView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 300);
        zhuTableView.tableHeaderView = headerView;
        middleView.hidden = NO;
        self.isFirst = NO;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.whichVC == 1) {
        
        DLog(@"rili  %ld", self.riLiDataArray.count);
        return self.riLiDataArray.count;
    }else if (self.whichVC == 4){
        return self.riLiShaiXuanDataArray.count;
    }
    else{
        return self.dataArray.count;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIndentifier = @"cell";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.whichVC == 30) {
        cell.isInt = YES;
    }
    if (self.timeType == 2) {
        if (self.whichVC == 1) {
            [cell updataTime:self.riLiDataArray[indexPath.row] max:dataMax min:dataMin];
        }else if (self.whichVC == 4) {
            [cell updataTime:self.riLiShaiXuanDataArray[indexPath.row] max:dataMax min:dataMin];
        } else{
            [cell updataTime:self.dataArray[indexPath.row] max:dataMax min:dataMin];
        }
    }else {
        if (self.whichVC == 1) {
            [cell updata:self.riLiDataArray[indexPath.row] max:dataMax min:dataMin];
        }else if (self.whichVC == 4) {
            [cell updata:self.riLiShaiXuanDataArray[indexPath.row] max:dataMax min:dataMin];
        } else{
            [cell updata:self.dataArray[indexPath.row] max:dataMax min:dataMin];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)getTodayInfor
{
    [SVProgressHUD show];
    
    NSString* stryear = [self.date substringToIndex:4];
    NSString* strmonth = [self.date substringWithRange:NSMakeRange(4, 2)];
    NSString* strday = [self.date substringWithRange:NSMakeRange(6, 2)];
    
    DLog(@"日历中的那种类型 %d", self.whichShouYiTap);
    
    NSString *body=  @"";
    if (self.whichShouYiTap == 1001) {
        
        DLog(@"为什么不进去");
        body = [NSString stringWithFormat:@" income_type=0&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }else if(self.whichShouYiTap == 1002){
        body = [NSString stringWithFormat:@" income_type=1&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }else if (self.whichShouYiTap == 1003){
        body = [NSString stringWithFormat:@" income_type=2&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }
    
    
    NSString *str=MOBILE_SERVER_URL(@"my_income_list.php");
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
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary * dic = [responseObject objectForKey:@"income"];
            NSArray * array = [dic objectForKey:@"list"];
            NSArray * reserArray = [[array reverseObjectEnumerator]allObjects];
            self.riLiDataArray = [NSMutableArray arrayWithArray:reserArray];
            
            allMoneyLabel.text = [NSString stringWithFormat:@"%.2lf", [[self.dataDic objectForKey:@"total"]floatValue]];
            noDataWarningLabel.hidden = self.riLiDataArray.count == 0 ? NO:YES;
            dataMax = [dic[@"max"] doubleValue];
            dataMin = [dic[@"min"] doubleValue];
            [zhuTableView reloadData];
            [self updateLineChartData:array];
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
- (void)getShaiXuanTodayInfor
{
    [SVProgressHUD show];
    
    NSString* stryear = [self.date substringToIndex:4];
    NSString* strmonth = [self.date substringWithRange:NSMakeRange(4, 2)];
    NSString* strday = [self.date substringWithRange:NSMakeRange(6, 2)];
    
    
    DLog(@"月份筛选进来是那种类型  %d", self.whichShouYiTap);
    NSString *body=  @"";
    if (self.whichShouYiTap == 1001) {
        
        DLog(@"为什么不进去");
        body = [NSString stringWithFormat:@" income_type=0&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }else if(self.whichShouYiTap == 1002){
        body = [NSString stringWithFormat:@" income_type=1&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }else if (self.whichShouYiTap == 1003){
        body = [NSString stringWithFormat:@" income_type=2&see_type=4&time_type=5&time=%@-%@-%@", stryear, strmonth, strday];
    }
    
    
    NSString *str=MOBILE_SERVER_URL(@"my_income_list.php");
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
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary * dic = [responseObject objectForKey:@"income"];
            
            NSArray * array = [dic objectForKey:@"list"];
            NSArray * reserArray = [[array reverseObjectEnumerator]allObjects];
            self.riLiShaiXuanDataArray = [NSMutableArray arrayWithArray:reserArray];
        
            allMoneyLabel.text = [NSString stringWithFormat:@"%.2lf", [[self.dataDic objectForKey:@"total"]floatValue]];
            noDataWarningLabel.hidden = self.riLiShaiXuanDataArray.count == 0 ? NO:YES;
            dataMax=[[self.dataDic valueForKey:@"max"] doubleValue];
            dataMin=[[self.dataDic valueForKey:@"min"] doubleValue];
            [zhuTableView reloadData];
            [self updateLineChartData:array];
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

#pragma mark - 更新折线图数据
- (void)updateLineChartData:(NSArray *)data
{
    NSMutableArray *mutableData = [[NSMutableArray alloc] initWithArray:data];
    [mutableData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDictionary *dic1 = (NSDictionary *)obj1;
        NSDictionary *dic2 = (NSDictionary *)obj2;
        NSComparisonResult result = [[NSString stringWithFormat:@"%@", [dic1 objectForKey:@"hour"]] doubleValue] > [[NSString stringWithFormat:@"%@", [dic2 objectForKey:@"hour"]] doubleValue] ? NSOrderedDescending : NSOrderedAscending;
        return result;
    }];
    
    NSMutableArray *dateArray = [NSMutableArray new];
    NSMutableArray *incomeData = [NSMutableArray new];
    for (int i = 0; i < mutableData.count; i++) {
        if (self.timeType == 2) {
            [dateArray addObject:[NSString stringWithFormat:@"%@:00", [[mutableData objectAtIndex:i] objectForKey:@"hour"]]];
        }else {
            NSString *date =[NSString stringWithFormat:@"%@", [[mutableData objectAtIndex:i] objectForKey:@"date"]];
            if (date.length > 5) {
                NSString *monthAndDay = [date substringFromIndex:5];
                [dateArray addObject:monthAndDay];
            }else {
                [dateArray addObject:date];

            }
        }
        if (self.isFormSell) {
            [incomeData addObject:[NSString stringWithFormat:@"%@", [[mutableData objectAtIndex:i] objectForKey:@"record"]]];
        }else {
            [incomeData addObject:[NSString stringWithFormat:@"%@", [[mutableData objectAtIndex:i] objectForKey:@"income"]]];
        }
        
    }
    NSArray *dateArr = [NSArray arrayWithArray:dateArray];
    NSArray *incomeDataArr = [NSArray arrayWithArray:incomeData];
    
    NSArray *newDate = @[];
    NSArray *newIncomeData = @[];
    
    if (self.timeType == 2) {
        newDate = dateArr;
        newIncomeData = incomeDataArr;
    }else {
        newDate = [[dateArr reverseObjectEnumerator]  allObjects];
        newIncomeData = [[incomeDataArr reverseObjectEnumerator]  allObjects];
    }

    
    
    CGFloat width = 45.0 * data.count;
    width = width < UI_SCREEN_WIDTH ? UI_SCREEN_WIDTH : width;
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, width, 200.0)];
    if (self.whichVC == 30) {
        lineChart.isInt = YES;
    }
    lineChart.layer.borderWidth = 1;
    lineChart.backgroundColor = [UIColor colorFromHexCode:@"#ea6153"];
    [middleView addSubview:lineChart];
    middleView.contentSize = CGSizeMake(width, middleView.frame.size.height);
    
    [lineChart setXLabels:newDate];
    PNLineChartData *lineChartData = [PNLineChartData new];
    lineChartData.color = [UIColor whiteColor];
    lineChartData.itemCount = lineChart.xLabels.count;
    lineChartData.getData = ^(NSUInteger index) {
        CGFloat yValue = [newIncomeData[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    lineChart.chartData = @[lineChartData];
    [lineChart strokeChart];
}

@end
