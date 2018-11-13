//
//  TodayOrderViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "TodayOrderViewController.h"
#import "TodayOrderCell.h"
#import "WaitViewController.h"
#import "ConfirmDetailVC.h"
#import "RecordViewController.h"
#import "AddViewController.h"
#import "TodayIncomeViewController.h"
#import "TimeDetailViewController.h"
#import "HistoryViewController.h"
#import "CumulativeGainViewController.h"

@interface TodayOrderViewController ()<UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate>
{
    UIView *titleView;
}
@property (nonatomic, strong)UITableView * tab;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * areaView;

@property (nonatomic, strong)NSMutableArray * buttonArray;

@property (nonatomic, strong)NSMutableArray * labelArray;
@property (nonatomic, assign)BOOL isClick;

@end

@implementation TodayOrderViewController
-(void)dealloc
{
    [self.headView free];
    [self.footView free];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.curPage=1;
    [self postRecode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage=1;
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    titleView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - 80 / 2, 30, 130, 20)];
    
    self.navigationItem.titleView = titleView;
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 20)];
    titleLable.text = @"今日客户订单";
    titleLable.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLable];
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake( 110, 6, 11, 6)];
    topView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:topView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderXiala)];
    [titleView addGestureRecognizer:tap];

    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.tab];
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_tab;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_tab;
    self.footView.delegate=self;
        [self orderView];
    // Do any additional setup after loading the view.
}
#pragma mark - 弹出和消失
- (void)orderXiala
{
    self.isClick = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [titleView addGestureRecognizer:tap];
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self.view addSubview:_backView];
    
    self.areaView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 219);
    
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    
    self.isClick = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderXiala)];
    [titleView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -219, UI_SCREEN_WIDTH, 219);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
    
}

- (void)orderView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT )];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, -438 / 2, UI_SCREEN_WIDTH, 438 / 2)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    
    NSArray * array = @[@"累计收益", @"今日收益", @"今日访问", @"今日订单", @"收入概览", @"历史访问"];
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  219 /  array.count * i, UI_SCREEN_WIDTH, 219 / array.count)];
        //                line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line];
        
        UIImageView * clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 10 - 40.5, (219 / 6 - 10) / 2, 14, 10)];
        clickImageView.image = [UIImage imageNamed:@"icon_buleright.png"];
        clickImageView.tag = 400 + i;
        clickImageView.userInteractionEnabled = YES;
        //        clickImageView.backgroundColor  = App_Main_Color;
        [clickImageView addTarget:self action:@selector(btnDoClick:) forControlEvents:UIControlEventTouchUpInside];
        [line addSubview:clickImageView];
        [self.buttonArray addObject:clickImageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        label.text = array[i];
        [line addSubview:label];
        line.tag = 500 + i;
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10,  219 / array.count *(i + 1), UI_SCREEN_WIDTH - 20, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
        
        [_labelArray addObject:label];
        [line addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 3) {
            label.textColor = App_Main_Color;
            
        }
        
        if (i == 5) {
            line1.hidden = YES;
        }
        
        if (i == 3) {
            
        }else{
            clickImageView.hidden = YES;
        }
        
    }
}

- (void)doClick:(UIView *)sender
{
    
    UIImageView  * tempImageView  = (UIImageView *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:0];
    tempImageView.hidden = NO;
    for (UIImageView * buttn1 in self.buttonArray) {
        if (![tempImageView isEqual:buttn1]) {
            buttn1.hidden = YES;
        }
    }
    
    
    UILabel * label1 = (UILabel *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:1];
    label1.textColor = App_Main_Color;//被点击的按钮要改变的颜色
    for (UILabel * tilabel in self.labelArray) {
        NSLog(@"2 = %@", tilabel);
        if (![label1 isEqual:tilabel]) {
            tilabel.textColor = [UIColor blackColor];//其余按钮要改变到的颜色
        }
    }
    
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag) afterDelay:0.5];
    
}
- (void)btnDoClick:(UIImageView *)sender
{
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag+100) afterDelay:0.5];
}
- (void)popToMyGoodsVCWithTag:(NSNumber *)obj {
    int vcTag = [obj intValue];
    if (vcTag == 503) {
        
    }else if (vcTag == 500) {
        CumulativeGainViewController * vc = [[CumulativeGainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.popBlock) {
            self.popBlock(vcTag);
        }
    }
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        
        self.curPage=1;
        [self postRecode];
        
    }else
    {
        self.curPage++;
        [self postRecode];
        
    }
    
}
-(void)postRecode
{
   
        [SVProgressHUD show];
        
          NSString*body=[NSString stringWithFormat:@"type=1&act=0&is_seller=0&p=%d&time=1", self.curPage];
        NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
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
                [SVProgressHUD dismiss];

                NSDictionary * contentDic = [responseObject objectForKey:@"content"];
                
                NSArray * tempArray = [NSArray array];
                tempArray = [contentDic objectForKey:@"list"];
                
                
                if([tempArray isKindOfClass:[NSArray class]])
                {
                    if(self.curPage == 1)
                    {
                        [self.dataArray removeAllObjects];
                    }
                    [self.dataArray addObjectsFromArray:tempArray];
                    if (self.dataArray.count == 0) {
                        UILabel *noDataWarningLabel = [[UILabel alloc] init];
                        noDataWarningLabel.tag = 10086;
                        noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                        noDataWarningLabel.text = @"暂无数据";
                        noDataWarningLabel.textColor=[UIColor grayColor];
                        noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                        noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                        [_tab addSubview:noDataWarningLabel];
                    }else {
                        UILabel *noDataWarningLabel = (UILabel *)[_tab viewWithTag:10086];
                        [noDataWarningLabel removeFromSuperview];
                    }
                    [self.tab reloadData];
                }
            }else{
                if ([responseObject valueForKey:@"info"]!=nil) {
                    [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
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

#pragma mark - 懒加载
-(UITableView *)tab
{
    if (!_tab) {
        self.tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT  - 64)];
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
       
    }
    return _tab;
}

#pragma mark - UITableViewDataSource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"cell";
    TodayOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[TodayOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    [cell updateDic:[self.dataArray objectAtIndex:indexPath.row]];
       return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:indexPath.row];
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 0) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            waitVC.flagVC = 4;
            
            waitVC.flag = 1;

            waitVC.titleArrays = @[@"取消订单"];
            
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            [waitVC.payType removeFromSuperview];
            [waitVC.logisticsView removeFromSuperview];
            
            [waitVC.erWeiImageView removeFromSuperview];
        }
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            
            waitVC.flag = 2;

            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            [waitVC.view removeFromSuperview];
            [waitVC.buttomView removeFromSuperview];
            [waitVC.logisticsView removeFromSuperview];
            [waitVC.bView removeFromSuperview];
            
        }
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            
            waitVC.flag = 3;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            waitVC.titleArrays = @[@"确认收货"];
          
            waitVC.erweiImage = [UIImage imageNamed:@"gj_saomiao_twocode.png"];
        }
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"]intValue]==4) {
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        confirmVC.isCustomerOrder = YES;
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = HaveConfirmUI;
        confirmVC.ID = [goodsinfoDic objectForKey:@"order_title"];
    }
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 7) {
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = ApplicationReturnsUI;
        confirmVC.status = BottomViewStatusNone;
        confirmVC.isCustomerOrder = YES;
        confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
    }
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 8 ||
        [[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 9)
    {
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = ApplicationReturnsUI;
        confirmVC.status = BottomViewStatusDelete;
        confirmVC.isCustomerOrder = YES;
        confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
    }
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 10) {
        
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = HaveConfirmUI;
        confirmVC.status = BottomViewStatusDelete;
        confirmVC.isCustomerOrder = YES;
        confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
    }
    //  11可售后，12已评价，13待评价
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 11 ||
        [[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 12 ||
        [[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 13)
    {
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        confirmVC.status = BottomViewStatusDeleteAndService;
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = HaveConfirmUI;
        confirmVC.isCustomerOrder = YES;
        confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
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
