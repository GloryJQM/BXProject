//
//  HistoryViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/9/7.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "HistoryViewController.h"
#import "AddViewController.h"


#import "TimeDetailViewController.h"
#import "RecordCell.h"
#import "ShaiXuanViewController.h"
#import "CumulativeGainViewController.h"

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIView *titleView;
    NSArray * yearArray;
    NSArray * monthArray;
    NSArray * dayArray;
    NSString * tempYear;
    NSString * tempMonth;
    NSString * tempDay;
    UILabel *noDataWarningLabel;
}
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * areaView;
@property (nonatomic, strong)NSMutableArray * buttonArray;
@property (nonatomic, strong)NSMutableArray * labelArray;
@property (nonatomic, assign)BOOL isClick;
@property (nonatomic, strong)UITableView * tab;
@property (nonatomic, strong)UIView * backShaiXuanView;
@property (nonatomic, strong)UIView * areaShaiXuanView;
@property (nonatomic, strong)UIPickerView * shaiXuanPickerView;
@property (nonatomic, strong)NSString * yearStr;
@property (nonatomic, strong)NSString * monthStr;
@property (nonatomic, strong)NSString * dayStr;
@end

@implementation HistoryViewController

-(void)dealloc{
    [_headView free];
    [_footView free];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:newDate];
    NSString * year = [dateString substringToIndex:4];
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    NSString * month = [dateString substringWithRange:NSMakeRange(5, 2)];
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    NSString * day = [dateString substringWithRange:NSMakeRange(8, 2)];
    NSInteger indexOfObjectOfdDay = [dayArray indexOfObject:day];
    
    [_shaiXuanPickerView selectRow:indexOfObject inComponent:0 animated:NO];
    [_shaiXuanPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:NO];
    [_shaiXuanPickerView selectRow:indexOfObjectOfdDay inComponent:2 animated:NO];
    
    tempYear = year;
    tempMonth = month;
    tempDay = day;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    
    yearArray = @[@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027" ];
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    dayArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];

    titleView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - 80 / 2, 30, 100, 20)];
    
    self.navigationItem.titleView = titleView;
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleLable.text = @"历史访问";
    titleLable.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLable];
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake( 80, 6, 11, 6)];
    topView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:topView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
    [self historyView];

    [self.view addSubview:self.tab];
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_tab;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_tab;
    self.footView.delegate=self;
    self.curPage = 1;
    [self postRecode];
    [self creatPickView];

    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    [leftNavBtn setTitle:@"筛选" forState:UIControlStateNormal];
    leftNavBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftNavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [leftNavBtn addTarget:self action:@selector(goToShaiXuanPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.rightBarButtonItem= leftItem;
    
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.hidden = YES;
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无记录";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    [_tab addSubview:noDataWarningLabel];

}
#pragma mark - 弹出和消失PickerView
- (void)goToShaiXuanPickerView {
    self.backShaiXuanView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.areaShaiXuanView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 260, UI_SCREEN_WIDTH, 260);
    [UIView commitAnimations];
    [self.shaiXuanPickerView reloadAllComponents];
}

- (void)hideShaiXuanPickerView {
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
    //    closeButton.backgroundColor = [UIColor yellowColor];
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

-(void)finishChose {
    
    [self hideShaiXuanPickerView];
    [self getShaixuanData];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return yearArray.count;
    }else if (component == 1){
        return monthArray.count;
    }else if (component == 2){
        return dayArray.count;
    }
    return 0;
}
- (void)getShaixuanData
{
    [SVProgressHUD show];
    DLog(@"筛选时间%@-%@-%@", tempYear, tempMonth, tempDay);
    NSString * string = [NSString stringWithFormat:@"%@-%@-%@", tempYear, tempMonth, tempDay];
    
    NSString*body=[NSString stringWithFormat:@"nowdate=%@&p=1", string];
    NSString *str=MOBILE_SERVER_URL(@"history_fangwen.php");
    [SVProgressHUD show];
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
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"content"];
            
            if (tempArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"筛选结果为空" duration:1.5];
            } else{
                
                ShaiXuanViewController * vc = [[ShaiXuanViewController alloc]init];
                vc.flag = 5;
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

        NSString * day;
//        if (row == 0) {
//            day = [NSString stringWithFormat:@"%@", dayArray[row]];
//        }else{
            day = [NSString stringWithFormat:@"%@日", dayArray[row]];
//        }
        return day;
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
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    NSString * month = [dateString substringWithRange:NSMakeRange(5, 2)];
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    NSString * day = [dateString substringFromIndex:8];
    int nowDate = [[NSString stringWithFormat:@"%@%@%@",year,month,day] intValue];
    
    DateOut * dateOut = [[DateOut alloc] init];
    NSArray * tempArray = [dateOut dayAllDayInYear:[yearArray[indexOfObject] intValue] withMonth:[monthArray[indexOfObjectOfMonth]intValue]];
    NSInteger indexOfObjectOfDay = [tempArray indexOfObject:day];

#pragma mark - 得到当前的选中的时间下标
    NSInteger yearSelectedIndex = [pickerView selectedRowInComponent:0];
    NSInteger monthSelectedIndex = [pickerView selectedRowInComponent:1];
    NSInteger daySelectedIndex = [pickerView selectedRowInComponent:2];
    NSString *seletedYear = [yearArray objectAtIndex:yearSelectedIndex];
    NSString *seletedMonth = [monthArray objectAtIndex:monthSelectedIndex];
    NSString *seletedDay = [dayArray objectAtIndex:daySelectedIndex];
    int seletedDate = [[NSString stringWithFormat:@"%@%@%@",seletedYear,seletedMonth,seletedDay] intValue];
    if (seletedDate > nowDate) {
        [_shaiXuanPickerView selectRow:indexOfObject inComponent:0 animated:YES];
        [_shaiXuanPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
        [_shaiXuanPickerView selectRow:indexOfObjectOfDay-1 inComponent:2 animated:YES];
        
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
        }else if(component==1)
        {
            self.monthStr = monthArray[row];
            self.dayStr = tempDay;
            self.yearStr = tempYear;
            tempMonth = self.monthStr;
        }else if(component==2)
        {
            self.dayStr = dayArray[row];
            self.yearStr = tempYear;
            self.monthStr = tempMonth;
            tempDay = self.dayStr;
        }
        DLog(@"nian %@", self.yearStr);
        DLog(@"month %@", self.monthStr);
        DLog(@"day %@", self.dayStr);
        int yearIndex = [tempYear intValue];
        int monthIndex = [tempMonth intValue];
        int dayIndex = [dateOut allDayInYear:yearIndex andMonth:monthIndex];
        DLog(@"当月数:%d--被选日:%ld",dayIndex,daySelectedIndex+1);
        if (dayIndex < daySelectedIndex+1) {
            [_shaiXuanPickerView selectRow:dayIndex-1 inComponent:2 animated:YES];
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
    NSString*body=[NSString stringWithFormat:@"&p=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"history_fangwen.php");
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
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"content"];
            
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:tempArray];
                
                if (self.dataArray.count == 0) {
                   
                    noDataWarningLabel.hidden = NO;
                    
                }else {
                    noDataWarningLabel.hidden = YES;
                }
                [self.tab reloadData];
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
    RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateDic:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

#pragma mark - 弹出和消失
- (void)xiala
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
    DLog(@"_______");
    self.isClick = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -219, UI_SCREEN_WIDTH, 219);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
    
}


- (void)historyView
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
    
    
    
    NSArray * array = @[ @"累计收益", @"今日收益", @"今日访问", @"今日订单", @"收入概览", @"历史访问"];
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0,  219 / 6 * i, UI_SCREEN_WIDTH, 219 / 6)];
        //                line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:tempView];
        
        UIImageView * clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 10 - 40.5, (219 / 6 - 10) / 2, 14, 10)];
        clickImageView.image = [UIImage imageNamed:@"icon_buleright.png"];
        clickImageView.tag = 400 + i;
        clickImageView.userInteractionEnabled = YES;
        //        clickImageView.backgroundColor  = App_Main_Color;
        [clickImageView addTarget:self action:@selector(btnDoClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempView addSubview:clickImageView];
        [self.buttonArray addObject:clickImageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        label.text = array[i];
        
        [tempView addSubview:label];
        
        tempView.tag = 500 + i;
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10,  36 *(i + 1), UI_SCREEN_WIDTH - 20, 1)];
        
        DLog(@"+++++  %.f, %.f", line1.frame.size.height, line1.frame.origin.y);
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
        
        [_labelArray addObject:label];
        [tempView addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 5) {
            label.textColor = App_Main_Color;
            
        }
        
        if (i == 5) {
            line1.hidden  = YES;
        }
        
        if (i == 5) {
            
        }else{
            clickImageView.hidden = YES;
        }
        
    }
    
    
}
- (void)btnDoClick:(UIImageView *)sender
{
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag+100) afterDelay:0.5];
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
    NSLog(@"1 = %@", label1);
    NSLog(@"count = coutn = %ld", self.labelArray.count);
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
- (void)popToMyGoodsVCWithTag:(NSNumber *)obj {
    int vcTag = [obj intValue];
    if (vcTag == 505) {
        
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




- (void)clickAddView
{
    AddViewController  * vc = [[AddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
