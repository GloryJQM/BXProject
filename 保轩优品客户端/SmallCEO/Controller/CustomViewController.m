//
//  CustomViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/11/4.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "CustomViewController.h"
#import "IntegrationTableViewCell.h"
#import "ShaiXuanViewController.h"
#import "DateOut.h"
#import "OrderCell.h"
#import "ConfirmDetailVC.h"
#import "WaitViewController.h"


@interface CustomViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MJRefreshBaseViewDelegate>
{
    UILabel * titleLable;
    UIView * titleView;
    BOOL isClick;
    NSInteger seletedBtn;
    NSArray * yearArray;
    NSArray * monthArray;
    NSArray * dayArray;
    NSString * tempYear;
    NSString * tempMonth;
    NSString * tempDay;
    
    NSInteger checkClickIndexpath;
}
@property (nonatomic, strong)NSMutableArray * labelArray;
@property (nonatomic, strong)UIScrollView * customScrollView;
@property (nonatomic, strong)UITableView * allTableView;
@property (nonatomic, strong)UITableView * waitPayTableView;
@property (nonatomic, strong)UITableView * shouHuoTableView;
@property (nonatomic, strong)UITableView * waitGoodsTableView;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)NSMutableArray * buttonArray;
@property (nonatomic, strong)NSMutableArray * buttonImageViewArray;
@property (nonatomic, strong)UIView * topLine;

@property (nonatomic, strong)UIView * backShaiXuanView;
@property (nonatomic, strong)UIPickerView * shaiXuanPickerView;
@property (nonatomic, strong)UIView * areaShaiXuanView;

@property (nonatomic, strong)NSString * yearStr;
@property (nonatomic, strong)NSString * monthStr;
@property (nonatomic, strong)NSString * dayStr;


@property (nonatomic, strong)NSMutableArray * allDataArray;
@property (nonatomic, strong)NSMutableArray * payDataArray;
@property (nonatomic, strong)NSMutableArray * goodsDataArray;
@property (nonatomic, strong)NSMutableArray * shouHuoDataArray;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * areaView;

@end

@implementation CustomViewController
-(void)dealloc
{
    [self.headView free];
    [self.footView free];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.curPage=1;
    [self chose];
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:newDate];
    NSString * year = [dateString substringToIndex:4];
    DLog(@"year  %@", year);
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    NSString * month = [dateString substringWithRange:NSMakeRange(5, 2)];
    DLog(@"month %@", month);
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    
    [_shaiXuanPickerView selectRow:indexOfObject inComponent:0 animated:YES];
    [_shaiXuanPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
    [_shaiXuanPickerView selectRow:0 inComponent:2 animated:YES];
    
    tempYear = year;
    tempMonth = month;
    tempDay = @"全部";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    
    curContentPage=1;
    self.pageClick = -1;
    self.curPage = 1;
    self.buttonImageViewArray = [NSMutableArray arrayWithCapacity:0];
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.allDataArray = [NSMutableArray arrayWithCapacity:0];
    self.payDataArray = [NSMutableArray arrayWithCapacity:0];
    self.goodsDataArray = [NSMutableArray arrayWithCapacity:0];
    self.shouHuoDataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    
    yearArray = @[@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027" ];
    
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    //    dayArray = [NSArray array];
    dayArray = @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - 100 / 2, 30, 100, 20)];
    
    self.navigationItem.titleView = titleView;
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.text = @"顾客订单";
    [titleView addSubview:titleLable];
    
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake( 80, 6, 11, 6)];
    topView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:topView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderXiala)];
    [titleView addGestureRecognizer:tap];
    
    
    //基本页面布局
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 45)];
    self.topView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.topView];
    
    NSArray * topTitleArray = @[@"全部订单",@"待付款",@"待发货", @"已发货"];
    [self topButton:topTitleArray];

    
    self.customScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 31+15, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _customScrollView.contentSize   = CGSizeMake(UI_SCREEN_WIDTH*topTitleArray.count, UI_SCREEN_HEIGHT );
    _customScrollView.userInteractionEnabled =YES;
    _customScrollView.delegate = self;
    _customScrollView.pagingEnabled = YES;
    _customScrollView.tag = 10086;
    _customScrollView.alwaysBounceHorizontal = NO;
    _customScrollView.alwaysBounceVertical = NO;
    _customScrollView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.customScrollView];
    
    
    self.allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-46)];
    _allTableView.delegate = self;
    _allTableView.dataSource = self;
    _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.customScrollView addSubview:self.allTableView];
    
    self.waitPayTableView = [[UITableView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-46)];
    _waitPayTableView.delegate = self;
    _waitPayTableView.dataSource = self;
    _waitPayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.customScrollView addSubview:_waitPayTableView];
    
    self.waitGoodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*2, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-46)];
    _waitGoodsTableView.delegate = self;
    _waitGoodsTableView.dataSource = self;
    _waitGoodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.customScrollView addSubview:_waitGoodsTableView];
    
    
    self.shouHuoTableView = [[UITableView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*3, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64-46)];
    _shouHuoTableView.delegate = self;
    _shouHuoTableView.dataSource = self;
    _shouHuoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.customScrollView addSubview:_shouHuoTableView];

    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_allTableView;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_allTableView;
    self.footView.delegate=self;

    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    
    [leftNavBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [leftNavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftNavBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftNavBtn addTarget:self action:@selector(popShaiXuanPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.rightBarButtonItem= leftItem;
    
    
    [self creatPickView];
    [self postAll];
    [self orderView];
    
}
- (void)chose
{
    switch (curContentPage) {
        case 1:
            [self postAll];
            break;
            
        case 2:
            [self postWaitPay];
            break;
            
        case 3:
            [self postWaitGoods];
            break;
            
        case 4:
            [self postShouHuo];
            break;
        default:
            break;
    }
}

- (void)orderXiala
{
    self.isClick = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [titleView addGestureRecognizer:tap];
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self.view addSubview:_backView];
    
    self.areaView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 219/2);
    
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    
    self.isClick = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderXiala)];
    [titleView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -219/2, UI_SCREEN_WIDTH, 219/2);
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
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, -219/2, UI_SCREEN_WIDTH, 219/2)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    
    NSArray * array = @[@"我的订单", @"顾客订单"];
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  219/2 /  array.count * i, UI_SCREEN_WIDTH, 219 /2/ array.count)];
        //                line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line];
        
        UIImageView * clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 10 - 40.5, (219 /2/  array.count - 10) / 2, 14, 10)];
        clickImageView.image = [UIImage imageNamed:@"icon_buleright.png"];
        clickImageView.tag = 500 + i;
        clickImageView.userInteractionEnabled = YES;
        //        clickImageView.backgroundColor  = App_Main_Color;
        [clickImageView addTarget:self action:@selector(btnDoClick:) forControlEvents:UIControlEventTouchUpInside];
        [line addSubview:clickImageView];
        [self.buttonImageViewArray addObject:clickImageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        label.text = array[i];
        [line addSubview:label];
        line.tag = 600 + i;
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10,  219/2 / array.count *(i + 1), UI_SCREEN_WIDTH - 20, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
        
        [_labelArray addObject:label];
        [line addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 1) {
            label.textColor = App_Main_Color;
        }else{
            clickImageView.hidden = YES;
        }
    }
}

- (void)doClick:(UIView *)sender
{
    
    UIImageView  * tempImageView  = (UIImageView *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:0];
    tempImageView.hidden = NO;
    for (UIImageView * buttn1 in self.buttonImageViewArray) {
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
    if (vcTag == 600) {
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.popBlock) {
            self.popBlock(vcTag);
        }
    }
}


#pragma mark-页面的 scrollView 的所有动画以及刷新
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
        btn.frame = CGRectMake(UI_SCREEN_WIDTH / array.count * i, 0, UI_SCREEN_WIDTH / array.count, 45);
        btn.backgroundColor = WHITE_COLOR;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(movie:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 3000 + i;
        [self.topView addSubview:btn];
        
        [self.buttonArray addObject:btn];
        
        if (i == 0) {
            [btn setTitleColor:App_Main_Color forState:UIControlStateNormal];//初始化时默认选中的按钮的颜色
        }else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//其余按钮的颜色
        }
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  45, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:line];
    
    self.topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/ array.count, 1)];
    _topLine.backgroundColor = App_Main_Color;
    [line addSubview:_topLine];
    
    
}
- (void)movie:(UIButton *)sender
{
    self.curPage=1;
    [sender setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
//    sender.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];//被点击的按钮要改变的颜色
    for (UIButton * button in self.buttonArray) {
        if (![sender isEqual:button]) {
            [button setTitleColor:[UIColor colorFromHexCode:@"252525"] forState:UIControlStateNormal];//其余按钮要改变到的颜色
//            button.backgroundColor = WHITE_COLOR;
        }
    }
    
    //移动线动画
    [UIView animateWithDuration:0.1 animations:^{
        [self.topLine setTransform:CGAffineTransformMake(1, 0, 0, 1, UI_SCREEN_WIDTH / 4 * (sender.tag - 3000), 0)];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.customScrollView setContentOffset:CGPointMake(UI_SCREEN_WIDTH * (sender.tag - 3000), 0) animated:YES];
    }];
    
    if (sender.tag == 3000) {
        
        [self refresh:_allTableView];
        curContentPage = 1;
        [self postAll];
        
    }else if (sender.tag == 3001){
        
        curContentPage = 2;
        [self postWaitPay];
        
        [self refresh:_waitPayTableView];
    }else if (sender.tag == 3002){
        
        curContentPage = 3;
        
        [self postWaitGoods];
        [self refresh:_waitGoodsTableView];
        
    }else if (sender.tag == 3003){
        
        curContentPage = 4;
        
        [self postShouHuo];
        [self refresh:_shouHuoTableView];
        
    }

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
    CGPoint point =  self.customScrollView.contentOffset;
    self.pageClick = point.x/UI_SCREEN_WIDTH;
    self.curPage = 1;
    if (self.pageClick == 0) {
        
        [self postAll];
        
    }else if (self.pageClick == 1){
        
        [self postWaitPay];
        
    }else if (self.pageClick == 2){
        
        [self postWaitGoods];
        
    }else if (self.pageClick == 3){
        
        [self postShouHuo];
    }
}

-(void)reloadMoreData
{
    CGPoint point =  self.customScrollView.contentOffset;
    self.pageClick = point.x/UI_SCREEN_WIDTH;
    
    if (self.pageClick == 0) {
        
        [self postAll];
        
    }else if (self.pageClick == 1){
        
        [self postWaitPay];
        
        
    }else if (self.pageClick == 2){
        
        [self postWaitGoods];
        
    }else if (self.pageClick == 3){
        
        [self postShouHuo];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _allTableView) {
        return  self.allDataArray.count;
    }
    if (tableView == _waitPayTableView) {
        return  self.payDataArray.count;
    }
    if (tableView == _waitGoodsTableView) {
        return  self.goodsDataArray.count;
    }
    if (tableView == _shouHuoTableView) {
        return  self.shouHuoDataArray.count;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"order";
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _allTableView) {
        [cell updataWith:self.allDataArray[indexPath.row]];
        cell.checkButton.tag = indexPath.row;
        [cell.checkButton addTarget:self action:@selector(allCheckWuLiu:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (tableView == _waitPayTableView) {
        [cell updataWith:self.payDataArray[indexPath.row]];
    }
    if (tableView == _waitGoodsTableView) {
        [cell updataWith:self.goodsDataArray[indexPath.row]];
        cell.checkButton.tag = indexPath.row;
        [cell.checkButton addTarget:self action:@selector(waitCheckWuLiu:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (tableView == _shouHuoTableView) {
        [cell updataWith:self.shouHuoDataArray[indexPath.row]];
        cell.checkButton.tag = indexPath.row;
        [cell.checkButton addTarget:self action:@selector(checkWuLiu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 214;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _allTableView) {
        NSDictionary * goodsinfoDic = [self.allDataArray objectAtIndex:indexPath.row];
        //0代表代付款, 2代表代发货,3已发货,4已收货
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 0) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            waitVC.flagVC = 4;
            waitVC.flag = 1;
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
            waitVC.flagVC = 4;
            waitVC.flag = 3;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        }
        
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 4) {
           
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
    
    if (tableView == _waitPayTableView) {
        WaitViewController * waitVC = [[WaitViewController alloc] init];
        [self.navigationController pushViewController:waitVC animated:YES];
        waitVC.flagVC = 4;
        
        NSDictionary * goodsinfoDic = [self.payDataArray objectAtIndex:indexPath.row];
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        waitVC.titleArrays = @[@"取消订单", @"付款"];
        waitVC.flag = 1;
        
        [waitVC.view removeFromSuperview];
        [waitVC.payType removeFromSuperview];
        [waitVC.logisticsView removeFromSuperview];
        [waitVC.erWeiImageView removeFromSuperview];
    }
    else if(tableView == _waitGoodsTableView)
    {
        NSDictionary * goodsinfoDic = [self.goodsDataArray  objectAtIndex:indexPath.row];
        WaitViewController * waitVC = [[WaitViewController alloc] init];
        [self.navigationController pushViewController:waitVC animated:YES];
        
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
            
            waitVC.flag = 2;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            [waitVC.view removeFromSuperview];
            [waitVC.buttomView removeFromSuperview];
            [waitVC.logisticsView removeFromSuperview];
            [waitVC.bView removeFromSuperview];
            
        }
    }
    else if (tableView == _shouHuoTableView)
    {
        NSDictionary * goodsinfoDic = [self.shouHuoDataArray  objectAtIndex:indexPath.row];
       
        if ([[goodsinfoDic objectForKey:@"is_pay_status"]intValue]==4) {
            ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
            confirmVC.isCustomerOrder = YES;
            [self.navigationController pushViewController:confirmVC animated:YES];
            confirmVC.userInterfaceType = HaveConfirmUI;
            confirmVC.ID = [goodsinfoDic objectForKey:@"order_title"];
        }
        
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            waitVC.flagVC = 4;
            waitVC.flag = 3;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
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
}

- (void)waitCheckWuLiu:(UIButton*)sender
{
    NSDictionary * goodsinfoDic = [self.goodsDataArray  objectAtIndex:sender.tag];
    WaitViewController * waitVC = [[WaitViewController alloc] init];
    [self.navigationController pushViewController:waitVC animated:YES];
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
        
        waitVC.flag = 2;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        [waitVC.view removeFromSuperview];
        [waitVC.buttomView removeFromSuperview];
        [waitVC.logisticsView removeFromSuperview];
        [waitVC.bView removeFromSuperview];
        
    }

}

- (void)checkWuLiu:(UIButton *)sender
{
    checkClickIndexpath = sender.tag;
    DLog(@"已收货的查看物流");
    ConfirmDetailVC * vc = [[ConfirmDetailVC alloc] init];
    vc.isCustomerOrder = YES;
    NSDictionary * goodsinfoDic = [self.shouHuoDataArray objectAtIndex:checkClickIndexpath];
    vc.userInterfaceType = HaveConfirmUI;
    vc.ID =   [goodsinfoDic objectForKey:@"order_title"];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)allCheckWuLiu:(UIButton *)sender
{
//    checkClickIndexpath = sender.tag;
    DLog(@"全部订单的查看物流");
     NSDictionary * goodsinfoDic = [self.allDataArray objectAtIndex:sender.tag];
    
   
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
        WaitViewController * waitVC = [[WaitViewController alloc] init];
       
        waitVC.flag = 2;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        [waitVC.view removeFromSuperview];
        [waitVC.buttomView removeFromSuperview];
        [waitVC.logisticsView removeFromSuperview];
        [waitVC.bView removeFromSuperview];
         [self.navigationController pushViewController:waitVC animated:YES];
    }
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
        WaitViewController * waitVC = [[WaitViewController alloc] init];
        [self.navigationController pushViewController:waitVC animated:YES];
         waitVC.flagVC = 4;
        waitVC.flag = 3;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        waitVC.titleArrays = @[@"确认收货"];
    }
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 4) {
        
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        confirmVC.isCustomerOrder = YES;
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = HaveConfirmUI;
        confirmVC.ID = [goodsinfoDic objectForKey:@"order_title"];      }

  
}

#pragma mark-http
-(void)postAll
{
    [SVProgressHUD show];
    
    NSString*body = [NSString stringWithFormat:@"type=1&act=0&is_seller=0&p=%d", self.curPage];
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
//            self.order_str = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"order_title"]];
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.allDataArray removeAllObjects];
                }
                [self.allDataArray addObjectsFromArray:tempArray];
                
                if (self.allDataArray.count == 0) {
                    UILabel *noDataWarningLabel = [[UILabel alloc] init];
                    noDataWarningLabel.tag = 10086;
                    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                    noDataWarningLabel.text = @"暂无订单";
                    noDataWarningLabel.textColor=[UIColor grayColor];
                    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                    [_allTableView addSubview:noDataWarningLabel];
                }else {
                    UILabel *noDataWarningLabel = (UILabel *)[_allTableView viewWithTag:10086];
                    [noDataWarningLabel removeFromSuperview];
                }
                
                [self.allTableView reloadData];
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

-(void)postWaitPay
{
    [SVProgressHUD show];
    
    NSString*body = [NSString stringWithFormat:@"&type=1&p=%d&act=1&is_seller=0",self.curPage];
    
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is________%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary * dic =[responseObject objectForKey:@"content"];
            NSArray * tempArray = [NSArray array];
            tempArray = [dic objectForKey:@"list"];
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.payDataArray removeAllObjects];
                }
                [self.payDataArray addObjectsFromArray:tempArray];
                
                if (self.payDataArray.count == 0) {
                    UILabel *noDataWarningLabel = [[UILabel alloc] init];
                    noDataWarningLabel.tag = 10086;
                    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                    noDataWarningLabel.text = @"暂无订单";
                    noDataWarningLabel.textColor=[UIColor grayColor];
                    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                    [_waitPayTableView addSubview:noDataWarningLabel];
                }else {
                    UILabel *noDataWarningLabel = (UILabel *)[_waitPayTableView viewWithTag:10086];
                    [noDataWarningLabel removeFromSuperview];
                }
                [_waitPayTableView reloadData];
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
-(void)postWaitGoods
{
    [SVProgressHUD show];
    
    NSString*body = [NSString stringWithFormat:@"&type=1&p=%d&act=2&is_seller=0",self.curPage];
    
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is++++++++%@",body);
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
                    [self.goodsDataArray removeAllObjects];
                }
                [self.goodsDataArray addObjectsFromArray:tempArray];
                
                DLog(@"waitGoods data %@",self.goodsDataArray);
                if (self.goodsDataArray.count == 0) {
                    UILabel *noDataWarningLabel = [[UILabel alloc] init];
                    noDataWarningLabel.tag = 10086;
                    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                    noDataWarningLabel.text = @"暂无订单";
                    noDataWarningLabel.textColor=[UIColor grayColor];
                    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                    [_waitGoodsTableView addSubview:noDataWarningLabel];
                }else {
                    UILabel *noDataWarningLabel = (UILabel *)[_waitGoodsTableView viewWithTag:10086];
                    [noDataWarningLabel removeFromSuperview];
                }
                [self.waitGoodsTableView reloadData];
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
-(void)postShouHuo
{
    [SVProgressHUD show];
    
    NSString*body = [NSString stringWithFormat:@"&type=1&p=%d&act=3&is_seller=0",self.curPage];
    
    NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is++++++++%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary * contentDic = [responseObject objectForKey:@"content"];
            NSArray * tempArray = [NSArray array];
            tempArray = [contentDic objectForKey:@"list"];
            self.order_str = [NSString stringWithFormat:@"%@", [contentDic objectForKey:@"order_title"]];

            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.shouHuoDataArray removeAllObjects];
                }
                [self.shouHuoDataArray addObjectsFromArray:tempArray];
                
                DLog(@"waitGoods data %@",self.shouHuoDataArray);
                if (self.shouHuoDataArray.count == 0) {
                    UILabel *noDataWarningLabel = [[UILabel alloc] init];
                    noDataWarningLabel.tag = 10086;
                    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                    noDataWarningLabel.text = @"暂无订单";
                    noDataWarningLabel.textColor=[UIColor grayColor];
                    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                    [_shouHuoTableView addSubview:noDataWarningLabel];
                }else {
                    UILabel *noDataWarningLabel = (UILabel *)[_shouHuoTableView viewWithTag:10086];
                    [noDataWarningLabel removeFromSuperview];
                }
                [self.shouHuoTableView reloadData];
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

#pragma mark - 弹出和消失PickerView
- (void)popShaiXuanPickerView
{
    DLog(@"筛选");
    self.backShaiXuanView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaShaiXuanView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 260, UI_SCREEN_WIDTH, 260);
    [UIView commitAnimations];
    
    
    [self.shaiXuanPickerView reloadAllComponents];
    
}

- (void)hideShaiXuanPickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaShaiXuanView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 260);
    [UIView commitAnimations];
    
    [self performSelector:@selector(backShaiXuan) withObject:nil afterDelay:0.3];
    
}
- (void)backShaiXuan
{
    self.backShaiXuanView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
}

#pragma mark - UIPickerView的创建
- (void)creatPickView
{
    self.backShaiXuanView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _backShaiXuanView.backgroundColor = MONEY_COLOR;
    [_backShaiXuanView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backShaiXuanView];
    
    //底部视图
    self.areaShaiXuanView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 260)];
    [_backShaiXuanView addSubview:_areaShaiXuanView];
    
    //添加关闭和完成的视图
    UIView * fiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    fiView.backgroundColor = MONEY_COLOR;
    [_areaShaiXuanView addSubview:fiView];
    
    //关闭
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(0, 5, 80, 33);
    [closeButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(hideShaiXuanPickerView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [fiView addSubview:closeButton];
    
    //完成
    UIButton * finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
    finishButton.frame = CGRectMake(UI_SCREEN_WIDTH - 110, 5, 102, 33);
    [finishButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    finishButton.backgroundColor = App_Main_Color;
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishChose) forControlEvents:UIControlEventTouchUpInside];
    [fiView addSubview:finishButton];
    
    
    self.shaiXuanPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, UI_SCREEN_WIDTH, 168)];
    _shaiXuanPickerView.dataSource = self;
    _shaiXuanPickerView.delegate = self;
    _shaiXuanPickerView.tag = 2000;
    _shaiXuanPickerView.backgroundColor = WHITE_COLOR;
    [_areaShaiXuanView addSubview:_shaiXuanPickerView];
    
}

-(void)finishChose
{
    
    [self hideShaiXuanPickerView];
    [self getShaixuanData];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return yearArray.count;
        
    }else if (component == 1){
        
        return monthArray.count;
        
    }else if (component == 2){
        
        return 32;
    }
    return 3;
}
- (void)getShaixuanData
{
    [SVProgressHUD show];
    if ([tempDay isEqualToString:@"全部"]) {
        tempDay = @"";
    }
    NSString * string = [NSString stringWithFormat:@"%@%@%@", tempYear, tempMonth, tempDay];
    
    NSString*body = [NSString stringWithFormat:@"type=1&act=0&time=%@&is_seller=0", string];;
    
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
            
            if (tempArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"筛选结果为空"];
            } else{
                
                ShaiXuanViewController * vc = [[ShaiXuanViewController alloc]init];
                vc.flag = 4;
                
                vc.dataArray = tempArray;
                [self.navigationController pushViewController:vc animated:YES];
                
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

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSString * year = [NSString stringWithFormat:@"%@年", yearArray[row]];
        return year;
        
    }else if(component==1){
        
        NSString * month = [NSString stringWithFormat:@"%@月", monthArray[row]];
        return month;
        
    }else if(component==2){
        
        
        if (row == 0) {
            return [NSString stringWithFormat:@"%@", dayArray[row]];
        }else{
            return [NSString stringWithFormat:@"%@日", dayArray[row]];
        }
    }
    return nil;
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:newDate];
    NSString * year = [dateString substringToIndex:4];
    DLog(@"year  %@", year);
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    NSString * month = [dateString substringWithRange:NSMakeRange(5, 2)];
    DLog(@"month %@", month);
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    NSString * day = [dateString substringFromIndex:8];
    DLog(@"day %@", day);
    int myDate = [[NSString stringWithFormat:@"%@%@%@",year,month,day] intValue];
    DateOut * dateOut = [[DateOut alloc] init];
    NSArray * tempArray = [dateOut dayAllDayInYear:[yearArray[indexOfObject] intValue] withMonth:[monthArray[indexOfObjectOfMonth]intValue]];
    NSInteger indexOfObjectOfDay = [tempArray indexOfObject:day];
    
#pragma mark - 得到当前的选中的时间下标
    NSInteger yearSelectedIndex = [pickerView selectedRowInComponent:0];
    NSInteger monthSelectedIndex = [pickerView selectedRowInComponent:1];
    NSInteger daySelectedIndex = [pickerView selectedRowInComponent:2];
    NSString *seletedYear = [yearArray objectAtIndex:yearSelectedIndex];
    NSString *seletedMonth = [monthArray objectAtIndex:monthSelectedIndex];
    NSString *seletedDay =nil;
    if (daySelectedIndex == 0) {
        seletedDay = @"00";
    }else {
        seletedDay = [dayArray objectAtIndex:daySelectedIndex];
    }
    int seletedDate = [[NSString stringWithFormat:@"%@%@%@",seletedYear,seletedMonth,seletedDay] intValue];
    if (seletedDate > myDate) {
        [_shaiXuanPickerView selectRow:indexOfObject inComponent:0 animated:YES];
        [_shaiXuanPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
        [_shaiXuanPickerView selectRow:indexOfObjectOfDay inComponent:2 animated:YES];
        tempYear = year;
        tempMonth = month;
        tempDay = day;
        
        self.yearStr = year;
        self.monthStr = month;
        self.dayStr = day;
    }else {
        
        if(component==0)
        {
            self.yearStr = yearArray[row];
            
            self.monthStr = tempMonth;
            self.dayStr = tempDay;
            tempYear = self.yearStr;
            //            DLog(@"nian%@", self.yearStr);
        }else if(component==1)
        {
            self.monthStr = monthArray[row];
            self.dayStr = tempDay;
            self.yearStr = tempYear;
            tempMonth = self.monthStr;
            //            DLog(@"month %@", self.monthStr);
        }else if(component==2)
        {
            self.dayStr = dayArray[row];
            self.yearStr = tempYear;
            self.monthStr = tempMonth;
            tempDay = self.dayStr;
            //            DLog(@"day %@", self.dayStr);
        }
        
        int yearIndex = [tempYear intValue];
        int monthIndex = [tempMonth intValue];
        int dayIndex = [dateOut allDayInYear:yearIndex andMonth:monthIndex];
        //        DLog(@"个数:%d--%ld",dayIndex,daySelectedIndex);
        if (dayIndex < daySelectedIndex) {
            [_shaiXuanPickerView selectRow:dayIndex inComponent:2 animated:YES];
        }
    }
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
