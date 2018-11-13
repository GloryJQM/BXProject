//
//  IntegrationViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "IntegrationViewController.h"
#import "IntegrationTableViewCell.h"
@interface IntegrationViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, UIScrollViewDelegate>
{
    UILabel *noDataWarningLabel;
    NSInteger seletedIndex;
}
@property (nonatomic, strong)UITableView * intergationView;
@property (nonatomic, strong)UILabel * integrationLab;
@property (nonatomic, strong)UIView * topView;

@property (nonatomic, strong)UIScrollView * mainView;

@property (nonatomic, strong)UITableView * incomeView;

@property (nonatomic, strong)UITableView * expenditureView;
@property (nonatomic, strong)NSMutableArray * buttonArray;


@property (nonatomic, strong)NSMutableArray * allDataArray;
@property (nonatomic, strong)NSMutableArray * incomeDataArray;

@property (nonatomic, strong)NSMutableArray * expenditureDataArray;

@end

@implementation IntegrationViewController

- (void)dealloc
{
    [_headView free];
    [_footView free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"积分明细";
    
    curContentPage=1;
    self.pageClick = -1;
    self.curPage = 1;
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.allDataArray = [NSMutableArray arrayWithCapacity:0];
    self.incomeDataArray = [NSMutableArray arrayWithCapacity:0];
    self.expenditureDataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 78)];
    self.topView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.topView];
    
    UILabel * integrationLabel = [[UILabel   alloc] initWithFrame:CGRectMake(12, 0, UI_SCREEN_WIDTH-12, 33)];
    integrationLabel.backgroundColor = WHITE_COLOR;
    integrationLabel.font = [UIFont systemFontOfSize:13];
    [self.topView addSubview:integrationLabel];
    self.integrationLab = integrationLabel;
    
   
    
    UIView * intervalView = [[UIView alloc] initWithFrame:CGRectMake(0, 33, UI_SCREEN_WIDTH, 5)];
    intervalView.backgroundColor = [UIColor colorFromHexCode:@"eeeeee"];
    intervalView.layer.borderColor = [UIColor colorFromHexCode:@"cdcece"].CGColor;
    intervalView.layer.borderWidth = 0.5;
    [self.topView addSubview:intervalView];

    NSArray * topTitleArray = @[@"全部",@"收入",@"支出"];
    [self topButton:topTitleArray];
    
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 78, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _mainView.contentSize   = CGSizeMake(UI_SCREEN_WIDTH*topTitleArray.count, UI_SCREEN_HEIGHT );
    _mainView.userInteractionEnabled =YES;
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.tag = 10086;
    _mainView.alwaysBounceHorizontal = NO;
    _mainView.alwaysBounceVertical = NO;
    _mainView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.mainView];
    
    
    self.intergationView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-78)];
    _intergationView.delegate = self;
    _intergationView.dataSource = self;
    _intergationView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:self.intergationView];
    
    self.incomeView = [[UITableView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-78)];
    _incomeView.delegate = self;
    _incomeView.dataSource = self;
        _incomeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:_incomeView];
    
    self.expenditureView = [[UITableView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*2, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-78)];
    _expenditureView.delegate = self;
    _expenditureView.dataSource = self;
        _expenditureView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:_expenditureView];

    
    
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_intergationView;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_intergationView;
    self.footView.delegate=self;
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.tag = 100;
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无记录";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:noDataWarningLabel];
    
    [self postIntegretionAll];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 10086) {
        
        if (scrollView.contentOffset.x == self.view.bounds.size.width*(curContentPage-1)) {
            
        }else {
            CGFloat index = scrollView.contentOffset.x/self.view.bounds.size.width;
            curContentPage = index;
            UIButton *btn = (UIButton *)[self.topView viewWithTag:curContentPage+3000];
            [self movie:btn];
        }
    }
}

#pragma mark - 顶部选项卡
- (void)topButton:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(UI_SCREEN_WIDTH / array.count * i, 38, UI_SCREEN_WIDTH / array.count, 39);
        btn.backgroundColor = WHITE_COLOR;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(movie:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 3000 + i;
        [self.topView addSubview:btn];
        
        [self.buttonArray addObject:btn];
        
        if (i == 0) {
            [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];//初始化时默认选中的按钮的颜色
            btn.backgroundColor = App_Main_Color;
            seletedIndex = btn.tag;
        }else {
            [btn setTitleColor:[UIColor colorFromHexCode:@"252525"] forState:UIControlStateNormal];//其余按钮的颜色
        }
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  39+38, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorFromHexCode:@"e1e1e1"];
    [self.topView addSubview:line];
    
    
    
}

- (void)movie:(UIButton *)sender
{
    if (seletedIndex == sender.tag) {
        return;
    }
    self.curPage=1;
    [sender setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    sender.backgroundColor = App_Main_Color;//被点击的按钮要改变的颜色
    for (UIButton * button in self.buttonArray) {
        if (![sender isEqual:button]) {
             [button setTitleColor:[UIColor colorFromHexCode:@"252525"] forState:UIControlStateNormal];//其余按钮要改变到的颜色
            button.backgroundColor = WHITE_COLOR;
        }
    }
    
    
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.mainView setContentOffset:CGPointMake(UI_SCREEN_WIDTH * (sender.tag - 3000), 0) animated:YES];
    }];
    
    if (sender.tag == 3000) {
        
        [self refresh:_intergationView];
        curContentPage = 1;
        [self postIntegretionAll];
        
    }else if (sender.tag == 3001){
        
        curContentPage = 2;
        [self postIntegretionIncome];
        
        [self refresh:_incomeView];
    }else if (sender.tag == 3002){
        
        curContentPage = 3;
        
        [self postIntegretionExpenditure];
        [self refresh:_expenditureView];
    }
    seletedIndex = sender.tag;
}
#pragma mark - MJRefresh
- (void)refresh:(UITableView *)tempView
{
    self.headView.scrollView=tempView;
    self.footView.scrollView=tempView;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        self.curPage=1;
        [self reloadData];
        
    }else
    {
        self.curPage++;
        [self reloadMoreData];
        
    }
}

-(void)reloadData
{
    CGPoint point =  self.mainView.contentOffset;
    self.pageClick = point.x/UI_SCREEN_WIDTH;
    self.curPage = 1;
    if (self.pageClick == 0) {
        
        [self postIntegretionAll];
        
    }else if (self.pageClick == 1){
        
        [self postIntegretionIncome];
        
    }else if (self.pageClick == 2){
        
        [self postIntegretionExpenditure];
        
    }
}

-(void)reloadMoreData
{
    CGPoint point =  self.mainView.contentOffset;
    self.pageClick = point.x/UI_SCREEN_WIDTH;
    
    if (self.pageClick == 0) {
        
        [self postIntegretionAll];
        
    }else if (self.pageClick == 1){
        
        [self postIntegretionIncome];
        
        
    }else if (self.pageClick == 2){
        
        [self postIntegretionExpenditure];
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _intergationView) {
       return  self.allDataArray.count;
    }
    if (tableView == _incomeView) {
        return  self.incomeDataArray.count;
    }
    if (tableView == _expenditureView) {
        return  self.expenditureDataArray.count;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"Integration";
    IntegrationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[IntegrationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _intergationView) {
        [cell updateCellDate:self.allDataArray[indexPath.row]];
    }
    if (tableView == _incomeView) {
        [cell updateCellDate:self.incomeDataArray[indexPath.row]];
    }
    if (tableView == _expenditureView) {
        [cell updateCellDate:self.expenditureDataArray[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
    
}
#pragma mark - HTTP
-(void)postIntegretionAll
{
    [SVProgressHUD show];
    
    NSString*body =[NSString stringWithFormat:@"act=list&type=0&page=%d", self.curPage] ;
    
    NSString *str=MOBILE_SERVER_URL(@"my_point_list.php");
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
            
//            NSDictionary * contentDic = [responseObject objectForKey:@"content"];
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"list"];
            
            NSString* thStr =[NSString stringWithFormat:@"我的积分: %@", [responseObject objectForKey:@"point"]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
            
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"fc2a33"] range:NSMakeRange(5,thStr.length-5)];
            self.integrationLab.attributedText = str;

            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.allDataArray removeAllObjects];
                }
                [self.allDataArray addObjectsFromArray:tempArray];
                
                if (self.allDataArray.count == 0) {
                    noDataWarningLabel.hidden = NO;
                }else {
                    noDataWarningLabel.hidden = YES;

                }
                [self.intergationView reloadData];
            }
        }else{
            
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}
-(void)postIntegretionIncome
{
    [SVProgressHUD show];
    
    NSString*body =[NSString stringWithFormat:@"act=list&type=1&page=%d", self.curPage] ;
    
    NSString *str=MOBILE_SERVER_URL(@"my_point_list.php");
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
            
            //            NSDictionary * contentDic = [responseObject objectForKey:@"content"];
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"list"];
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.incomeDataArray removeAllObjects];
                }
                [self.incomeDataArray addObjectsFromArray:tempArray];
                
                if (self.incomeDataArray.count == 0) {
                    noDataWarningLabel.hidden = NO;
                }else {
                    noDataWarningLabel.hidden = YES;
                    
                }
                
                [self.incomeView reloadData];
            }
        }else{
            
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                //                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}
-(void)postIntegretionExpenditure
{
    [SVProgressHUD show];
    
    NSString*body =[NSString stringWithFormat:@"act=list&type=2&page=%d", self.curPage] ;
    
    NSString *str=MOBILE_SERVER_URL(@"my_point_list.php");
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
            
            //            NSDictionary * contentDic = [responseObject objectForKey:@"content"];
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"list"];
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.expenditureDataArray removeAllObjects];
                }
                [self.expenditureDataArray addObjectsFromArray:tempArray];
                
                if (self.expenditureDataArray.count == 0) {
                    noDataWarningLabel.hidden = NO;
                }else {
                    noDataWarningLabel.hidden = YES;
                    
                }
                [self.expenditureView reloadData];
            }
        }else{
            
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                //                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
