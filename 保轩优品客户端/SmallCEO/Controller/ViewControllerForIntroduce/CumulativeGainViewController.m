//
//  CumulativeGainViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/12.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

static const CGFloat PNLineChartXLabelWidth = 45.0;

#import "CumulativeGainViewController.h"
#import "TimeDetailViewController.h"
#import "CustomTableViewCell.h"
#import "PNChart.h"
#import "DayShaiXuanViewController.h"
#import "TimeDetailTableViewCell.h"

@interface CumulativeGainViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate,RiliViewDelegate>
{
    UIView * titleView, *bottomView, *headerView;
    UILabel * allLabel;
    UILabel * allMoneyLabel;
    UIButton * kuangBtn;
    UIImageView * kuangImageView;
    UIImageView * tipView;
    
    UIScrollView *middleView;
    UITableView * zhuTableView;
    UITableView * incomeTableView;

    double dataMax, dataMin;
    
    NSString * dateString;
    
    NSArray * yearArray;
    NSArray * monthArray;
    NSArray * pickerDayArr;
    
    NSString * tempYear;
    NSString * tempMonth;
    NSString * tempDay;
    
    UIPickerView *datePickerView;
    UILabel *noDataWarningLabel;
}
@property (nonatomic, assign) int curPage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *areaView;
@property (nonatomic, strong) UIScrollView *GainScrollView;
@property (nonatomic, strong) NSMutableArray *dateBttonArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *dateDataArray;
@property (nonatomic, strong) UIView *doubleMiddleView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIDatePicker *tempDatePickerView;
@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) UILabel *titleLable1;
@property (nonatomic, strong) NSArray* month;
@property (nonatomic, assign) NSInteger oldLabelIndex;
@property (nonatomic, strong) PNLineChart *lineChartView;
@property (nonatomic, assign) CGFloat xWidth;

@end

@implementation CumulativeGainViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.curPage = 1;
    
    yearArray = @[@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027" ];
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    pickerDayArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    self.month = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    self.dateBttonArray = [NSMutableArray arrayWithCapacity:0];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH-120) / 2, 30, 120, 20)];
    _titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120-11, 20)];
    _titleLable1.text = @"积分";
    _titleLable1.textColor = [UIColor blackColor];
    _titleLable1.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:_titleLable1];

    
    tipView = [[UIImageView alloc] initWithFrame:CGRectMake( 120-11, 7, 11, 6)];
    tipView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:tipView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];

    titleView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    self.navigationItem.titleView = titleView;
    
    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftNavBtn setTitle:@"筛选" forState:UIControlStateNormal];
    leftNavBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(billFilter) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.rightBarButtonItem= leftItem;
    
    [self creatPopView];
    
    [self.view addSubview:self.GainScrollView];
    [self creatMainView];
    
    
    
    [self postDayAllShouYi:500];
//    [self createFilterView];
    
    
    incomeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -64)];
    incomeTableView.delegate = self;
    incomeTableView.dataSource = self;
    incomeTableView.backgroundColor = WHITE_COLOR;
    incomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:incomeTableView];
    incomeTableView.hidden = YES;
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无数据";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    noDataWarningLabel.hidden = YES;
    [self.view addSubview:noDataWarningLabel];
}

- (UIScrollView *)GainScrollView
{
    if (_GainScrollView == nil) {
        self.GainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
//        _GainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT + 64);
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
    
    allLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-200/2, 14, 200, 20)];
    allLabel.text = @"总累计收益(元)";
    allLabel.textColor = [UIColor colorFromHexCode:@"686868"];
    allLabel.font = [UIFont systemFontOfSize:14];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allLabel];
    
    allMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50,UI_SCREEN_WIDTH, 40)];
    allMoneyLabel.text = @"00.00";
    allMoneyLabel.textColor = [UIColor colorFromHexCode:@"ea6153"];
    allMoneyLabel.font = [UIFont systemFontOfSize:30];
    allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allMoneyLabel];
    
    kuangBtn = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80 - 6, 12,80, 20)];
    [kuangBtn setTitleColor:[UIColor colorFromHexCode:@"ea6153"] forState:UIControlStateNormal];
    [kuangBtn setTitle:@"折起折线图" forState:UIControlStateNormal];

    kuangBtn.backgroundColor = WHITE_COLOR;
    kuangBtn.layer.cornerRadius = 10;
    kuangBtn.layer.borderColor = [UIColor colorFromHexCode:@"ea6153"].CGColor;
    kuangBtn.layer.borderWidth = 1;
    [kuangBtn addTarget:self action:@selector(kuang) forControlEvents:UIControlEventTouchUpInside];
    kuangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    kuangBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:kuangBtn];
    
    middleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, UI_SCREEN_WIDTH, 200)];
    middleView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 200);
    middleView.showsHorizontalScrollIndicator = NO;
    middleView.bounces = NO;
    [headerView addSubview:middleView];
    
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -64)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = WHITE_COLOR;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    zhuTableView = tab;
    zhuTableView.tableHeaderView = headerView;
    [self.GainScrollView addSubview:tab];
    
  
}


- (UIView *)doubleMiddleView
{
    if (_doubleMiddleView == nil) {
        self.doubleMiddleView = [[UIView alloc] initWithFrame:CGRectMake(0, 100+200, UI_SCREEN_WIDTH, 36 + 17*2)];
        _doubleMiddleView.backgroundColor = [UIColor colorFromHexCode:@"edeef0"];
        [self.GainScrollView addSubview:_doubleMiddleView];
        
        NSArray * dateArray = @[@"日", @"月", @"年"];
        for (int i = 0; i < dateArray.count; i++) {
            UIButton * dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            dateBtn.frame = CGRectMake((UI_SCREEN_WIDTH - 128)/2 + 36*i + 15*i, 17, 36, 36);
            dateBtn.layer.cornerRadius = 36/2;
            dateBtn.backgroundColor = WHITE_COLOR;
            dateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [dateBtn setTitle:[NSString stringWithFormat:@"%@", dateArray[i]] forState:UIControlStateNormal];
            [_doubleMiddleView addSubview:dateBtn];
            [dateBtn setTitleColor:[UIColor colorFromHexCode:@"9f9f9f"] forState:UIControlStateNormal];
            [dateBtn addTarget:self action:@selector(clickDateButton:) forControlEvents:UIControlEventTouchUpInside];
            dateBtn.tag = 600 + i;
            [self.dateBttonArray addObject:dateBtn];
            if (i == 0) {
                [dateBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
                [dateBtn setBackgroundColor:[UIColor colorFromHexCode:@"ea6153"]];
                
            }
            
            if (i == 1) {
                dateString = @"月";
            }
        }
       

    }
     return _doubleMiddleView;
}
- (void)clickDateButton:(UIButton *)sender
{
    
    UIButton * button = (UIButton *)[_doubleMiddleView viewWithTag:sender.tag] ;
    button.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];//被点击的按钮要改变的颜色
    [button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    
    for (UIButton * tempBtn in self.dateBttonArray) {
       
        if (![button isEqual:tempBtn]) {
            [tempBtn setTitleColor:[UIColor colorFromHexCode:@"9f9f9f"] forState:UIControlStateNormal];

            tempBtn.backgroundColor = WHITE_COLOR;//其余按钮要改变到的颜色
        }
    }
    
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString* dateStr = [fmt stringFromDate:newDate];
    NSString * year = [dateStr substringToIndex:4];
    NSString * month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSString * day = [dateStr substringFromIndex:8];
    if (sender.tag == 602) {
        tempMonth = @"全部";
        tempDay = @"全部";
    }else if (sender.tag == 601) {
        tempDay = @"全部";
        tempMonth = month;
    }else {
        tempDay = day;
        tempMonth = month;
    }
    tempYear = year;
    [self postDayAllShouYi:sender.tag];
}
- (void)kuang
{
    if (self.isFirst == NO) {
        middleView.hidden = YES;
        headerView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 100);
        zhuTableView.tableHeaderView = headerView;
        [kuangBtn setTitle:@"展开折线图" forState:UIControlStateNormal];
        self.isFirst = YES;

    }else {

        [kuangBtn setTitle:@"折起折线图" forState:UIControlStateNormal];
        middleView.hidden = NO;
        headerView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 300);
        zhuTableView.tableHeaderView = headerView;
        self.isFirst = NO;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        if (self.dayArray.count == 0) {
            return 0;
        }else {
            return 90;
        }
    }else {
        return 70;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        if (self.dayArray.count != 0) {
            NSDictionary *tempDic=[self.dayArray objectAtIndex:section];
            
            UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
            
            UIView* upVi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 32)];
            upVi.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];
            
            UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 32)];
            lab.text = [NSString stringWithFormat:@"%@年%@月",[tempDic valueForKey:@"year" ],[tempDic valueForKey:@"month" ]];
            
            lab.textColor = TIILE_COLOR;
            lab.font = GFB_FONT_XT 18];
            [upVi addSubview:lab];
            
            
            UIView* midVi = [[UIView alloc]initWithFrame:CGRectMake(0, 32, UI_SCREEN_WIDTH, 20)];
            midVi.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
            
            UILabel* lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 20)];
            lab1.textColor = WHITE_COLOR;
            lab1.font = GFB_FONT_XT 12];
            
            UILabel* lab2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 65, 20)];
            lab2.textColor = WHITE_COLOR;
            lab2.font = GFB_FONT_CT 15];
            
            [midVi addSubview:lab1];
            [midVi addSubview:lab2];
            
            UIView* downVi = [[UIView alloc]initWithFrame:CGRectMake(0, 52, UI_SCREEN_WIDTH, 38)];
            downVi.backgroundColor = WHITE_COLOR;
            
            NSArray* arr = [NSArray array];
            arr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
            for(int i = 0;i<arr.count;i++)
            {
                UILabel* lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15+i*(UI_SCREEN_WIDTH-30)/7, 0, (UI_SCREEN_WIDTH-30)/7, 38)];
                lab3.text = arr[i];
                lab3.textColor = LINE_COLOR;
                lab3.textAlignment = NSTextAlignmentCenter;
                lab3.font = GFB_FONT_CT 15];
                
                [downVi addSubview:lab3];
            }
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 37, UI_SCREEN_WIDTH, 1)];
            line.backgroundColor = LINE_COLOR;
            [downVi addSubview:line];
            
            [head addSubview:upVi];
            [head addSubview:midVi];
            [head addSubview:downVi];
            
            return head;

        }else {
            return nil;
        }
        
    }else {
        return self.doubleMiddleView;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        return self.dayArray.count;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        return 1;
    }else {
        return self.dayArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        static NSString* str2 = @"TimeDetailCell";
        TimeDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if(cell == nil)
        {
            cell = [[TimeDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *month=[NSString stringWithFormat:@"%@",[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"month"]];
        NSString *year=[NSString stringWithFormat:@"%@",[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"year"]];
        [cell upDataWith:[year intValue] andMonth:[month intValue] delegate:self :self.dayArray[indexPath.section] withStep:NO];
        
        return cell;
    }else {
        static NSString * cellIndentifier = @"cell";
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];    
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updata:[self.dayArray objectAtIndex:indexPath.row] max:dataMax min:dataMin];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_titleLable1.text isEqualToString:@"按日历查看"]) {
        DateOut* date = [[DateOut alloc]init];
        int year = [[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"year"] intValue];
        int mo = [[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"month"]intValue];
        int allDay = [date allDayInYear:year andMonth:mo];
        int firstDay = [date theFirstDayIsInYear:year andMonth:mo];
        
        DLog(@"~~%d",firstDay);
        int row = 0;
        if(allDay==28 && firstDay ==1)
        {
            row = 4;
        }else if(firstDay == 7 &&  allDay>29)
        {
            row = 6;
        }else if(firstDay == 6 &&  allDay>30)
        {
            row = 6;
        }else
        {
            row = 5;
        }
        
        return 44*row;
    }else {
        return 80;
    }
}
//按日历查看点击详情
-(void)giveUp:(long)date work:(float)workTime
{
    NSString *dateStr = [NSString stringWithFormat:@"%ld",date];
    NSString * year = [dateStr substringToIndex:4];
    NSString * month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString * day = [dateStr substringFromIndex:6];
    
    tempYear = year;
    tempMonth = month;
    tempDay = day;
    DLog("%@/%@/%@",tempYear,tempMonth,tempDay)
    [self getSpecificDateBillInfo];
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
    
    self.areaView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 173);
    
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    self.isClick = NO;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -173, UI_SCREEN_WIDTH, 173);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
    
}

- (void)creatPopView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT )];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, -173, UI_SCREEN_WIDTH, 173)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    
    NSArray * array = @[@"积分", @"金币", @"代金券"];
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0,  173 / array.count * i, UI_SCREEN_WIDTH, 173 / array.count)];
        tempView.backgroundColor = WHITE_COLOR;
        [_areaView addSubview:tempView];
        tempView.tag = 500 + i;

        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.text = array[i];
        label.backgroundColor = WHITE_COLOR;
        [tempView addSubview:label];
        [_labelArray addObject:label];

        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10,  42.5, UI_SCREEN_WIDTH - 20, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [tempView addSubview:line1];
        [self.buttonArray addObject:line1];

        [tempView addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0) {
            label.textColor = [UIColor colorFromHexCode:@"ea6153"];
            line1.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
        }
    }
}
- (void)doClick:(UIView *)sender
{
    UIView * line1 = (UIView *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:1];
    line1.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];//被点击的按钮要改变的颜色

    for (UIView * tempLine in self.buttonArray) {
      
        if (![line1 isEqual:tempLine]) {
            tempLine.backgroundColor = LINE_SHALLOW_COLOR;//其余按钮要改变到的颜色
        }
    }

    UILabel * label1 = (UILabel *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:0];
    label1.backgroundColor = WHITE_COLOR;
    label1.textColor = [UIColor colorFromHexCode:@"ea6153"];//被点击的按钮要改变的颜色
    for (UILabel * tilabel in self.labelArray) {
        if (![label1 isEqual:tilabel]) {
            tilabel.textColor = [UIColor blackColor];//其余按钮要改变到的颜色
        }
    }
    
    [self hidePickerView];
#pragma mark - 顶部按钮
    if (sender.tag == 500) {
        _titleLable1.text = @"积分";
        [self postDayAllShouYi:500];
        self.GainScrollView.hidden = NO;
        noDataWarningLabel.hidden = YES;
        incomeTableView.hidden = YES;

    }else if (sender.tag == 501) {
        _titleLable1.text = @"金币";
        self.GainScrollView.hidden = YES;
        incomeTableView.hidden = NO;
        [self postDayAllShouYi:501];
        
    }else if (sender.tag == 502) {
        _titleLable1.text = @"代金券";
        //allLabel.text = @"最近一周收益(元)";
        self.GainScrollView.hidden = NO;
        noDataWarningLabel.hidden = YES;
        incomeTableView.hidden = YES;
        [self postDayAllShouYi:502];
        
    }else {
        _titleLable1.text = @"最近一月";
        allLabel.text = @"最近一月收益(元)";
        self.GainScrollView.hidden = NO;
        noDataWarningLabel.hidden = YES;
        incomeTableView.hidden = YES;
        [self postDayAllShouYi:0];
        
    }
   
}



#pragma mark - http

//日月年
-(void)postDayAllShouYi:(NSInteger)judgeTag
{
    [SVProgressHUD show];

    NSString*body=@"";
    if (judgeTag == 500) {
        body=[NSString stringWithFormat:@"income_type=1&see_type=3&time=2017"];
    }else if (judgeTag == 501){
        
        body=[NSString stringWithFormat:@"income_type=2&see_type=3&time=2017"];
    }else if (judgeTag == 502){
        
        body=[NSString stringWithFormat:@"income_type=3&see_type=3&time=2017"];
    }

    
    NSString *str=MOBILE_SERVER_URL(@"financeChartApi.php");
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
            
            allMoneyLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"total"]];
            dataMax = [[dic objectForKey:@"max"] doubleValue];
            dataMin = [[dic objectForKey:@"min"] doubleValue];
            
            //倒叙排序
            NSArray* reversedArray=[[array reverseObjectEnumerator] allObjects];
            self.dayArray = [NSMutableArray arrayWithArray:reversedArray];
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

- (void)postTimeDetail {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"p=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"shuju.php");
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
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSArray* temp=[responseObject valueForKey:@"content"];

            if (self.curPage == 1) {
                [self.dayArray removeAllObjects];
            }
            
            [self.dayArray addObjectsFromArray:temp];
            
            noDataWarningLabel.hidden = self.dayArray.count == 0 ? NO:YES;

            [incomeTableView reloadData];
            
            
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
#pragma mark - 时间选择器
- (void)createFilterView
{
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    
    datePickerView = [[UIPickerView alloc] init];
    datePickerView.frame =  CGRectMake(0, UI_SCREEN_HEIGHT - 216, UI_SCREEN_WIDTH, 216);
    datePickerView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    datePickerView.dataSource = self;
    datePickerView.delegate = self;
    [self.overlayWindow addSubview:datePickerView];
    
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString* dateStr = [fmt stringFromDate:newDate];
    NSString * year = [dateStr substringToIndex:4];
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    NSString * month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    NSString * day = [dateStr substringFromIndex:8];
    DateOut * dateOut = [[DateOut alloc] init];
    NSArray * tempArray = [dateOut dayAllDayInYear:[yearArray[indexOfObject] intValue] withMonth:[monthArray[indexOfObjectOfMonth]intValue]];
    NSInteger indexOfObjectOfDay = [tempArray indexOfObject:day];
    
    [datePickerView selectRow:indexOfObject inComponent:0 animated:YES];

    if ([tempDay isEqualToString:@"全部"] || [tempMonth isEqualToString:@"全部"]) {
        NSInteger indexOfObjectOfMon = [monthArray indexOfObject:tempMonth];
        NSInteger indexOfObjectOfDa = [pickerDayArr indexOfObject:tempDay];
        
        [datePickerView selectRow:indexOfObjectOfMon inComponent:1 animated:YES];
        [datePickerView selectRow:indexOfObjectOfDa inComponent:2 animated:YES];
        
        tempYear = year;
    }else {
        [datePickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
        [datePickerView selectRow:indexOfObjectOfDay inComponent:2 animated:YES];
        
        tempYear = year;
        tempMonth = month;
        tempDay = day;
    }
    
    UIToolbar *pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(datePickerView.frame) - 40, UI_SCREEN_WIDTH, 40)];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelFilter)];
    
    UIBarButtonItem *blankSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixedBlankSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedBlankSpaceButton.width = 15.0;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(finishFilter)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:fixedBlankSpaceButton,leftBarButton, blankSpaceButton, rightBarButton, fixedBlankSpaceButton, nil];
    pickerToolBar.items = itemsArray;
    [self.overlayWindow addSubview:pickerToolBar];
    
    UIView *topViewInWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - CGRectGetHeight(datePickerView.frame) - CGRectGetHeight(pickerToolBar.frame))];
    [topViewInWindow addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [self.overlayWindow addSubview:topViewInWindow];
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

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%@年", yearArray[row]];
        
    }else if(component==1){
        if (row == 0) {
            return [NSString stringWithFormat:@"%@", monthArray[row]];
        }else{
            return [NSString stringWithFormat:@"%@月", monthArray[row]];
        }
    }else if(component==2){
        if (row == 0) {
            return [NSString stringWithFormat:@"%@", pickerDayArr[row]];
        }else{
            return [NSString stringWithFormat:@"%@日", pickerDayArr[row]];
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
    
    NSString* dateStr = [fmt stringFromDate:newDate];
    NSString * year = [dateStr substringToIndex:4];
    NSInteger indexOfObject = [yearArray indexOfObject:year];
    
    NSString * month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSInteger indexOfObjectOfMonth = [monthArray indexOfObject:month];
    NSString * day = [dateStr substringFromIndex:8];
    
    int myDate = [[NSString stringWithFormat:@"%@%@%@",year,month,day] intValue];
    DateOut * dateOut = [[DateOut alloc] init];
    NSArray * tempArray = [dateOut dayAllDayInYear:[yearArray[indexOfObject] intValue] withMonth:[monthArray[indexOfObjectOfMonth]intValue]];
    NSInteger indexOfObjectOfDay = [tempArray indexOfObject:day];
    
    // 得到当前的选中的时间下标
    NSInteger yearSelectedIndex = [pickerView selectedRowInComponent:0];
    NSInteger monthSelectedIndex = [pickerView selectedRowInComponent:1];
    NSInteger daySelectedIndex = [pickerView selectedRowInComponent:2];
    NSString *seletedYear = [yearArray objectAtIndex:yearSelectedIndex];
    NSString *seletedMonth = [monthArray objectAtIndex:monthSelectedIndex];
    NSString *seletedDay = nil;
    if (daySelectedIndex == 0) {
        seletedDay = @"00";
    }else {
        seletedDay = [pickerDayArr objectAtIndex:daySelectedIndex];
    }
    int seletedDate = [[NSString stringWithFormat:@"%@%@%@",seletedYear,seletedMonth,seletedDay] intValue];
    if (seletedDate > myDate) {
        [datePickerView selectRow:indexOfObject inComponent:0 animated:YES];
        [datePickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
        [datePickerView selectRow:indexOfObjectOfDay inComponent:2 animated:YES];
        tempYear = year;
        tempMonth = month;
        tempDay = day;

    }else if ([seletedYear intValue] > [year intValue] && [seletedMonth isEqualToString:@"全部"]) {
        [datePickerView selectRow:indexOfObject inComponent:0 animated:YES];
        [datePickerView selectRow:0 inComponent:1 animated:YES];
        [datePickerView selectRow:0 inComponent:2 animated:YES];
        
        tempYear = year;
        tempMonth = @"全部";
        tempDay = @"全部";
    }else if ([seletedYear intValue] <= [year intValue] && [seletedMonth isEqualToString:@"全部"]) {
        tempYear = seletedYear;
        tempMonth = monthArray[row];
        tempDay = @"全部";
        
        [datePickerView selectRow:0 inComponent:1 animated:YES];
        [datePickerView selectRow:0 inComponent:2 animated:YES];
    }else {
        if(component==0)
        {
            tempYear = yearArray[row];
        }else if(component==1)
        {
            tempMonth = monthArray[row];
        }else if(component==2)
        {
            tempDay = pickerDayArr[row];
        }
        int yearIndex = [tempYear intValue];
        int monthIndex = [tempMonth intValue];
        int dayIndex = [dateOut allDayInYear:yearIndex andMonth:monthIndex];
        if (dayIndex < daySelectedIndex) {
            [datePickerView selectRow:dayIndex inComponent:2 animated:YES];
        }
    }
}

- (void)billFilter
{
    [self createFilterView];
    [self showSelectView];
}



-(void)viewWillDisappear:(BOOL)animated{
    [self hideSelectView];
}

- (void)cancelFilter
{
    [self hideSelectView];
}

- (void)finishFilter
{
    [self hideSelectView];
   
    [self getSpecificDateBillInfo];
}
- (void)getSpecificDateBillInfo
{
    [SVProgressHUD show];

    int seeType = 0;
    NSString *time = @"";
    if ([tempDay isEqualToString:@"全部"] && ![tempMonth isEqualToString:@"全部"]) {
        seeType = 3;
        time = [NSString stringWithFormat:@"%@-%@",tempYear,tempMonth];
    }else if ([tempMonth isEqualToString:@"全部"]) {
        seeType = 1;
        time = [NSString stringWithFormat:@"%@",tempYear];
    }else {
        seeType = 4;
        time = [NSString stringWithFormat:@"%@-%@-%@",tempYear,tempMonth,tempDay];
    }
    
    NSString *body = [NSString stringWithFormat:@"income_type=0&see_type=%d&time_type=5&time=%@",seeType, time];
    
    NSString *str=MOBILE_SERVER_URL(@"financeChartApi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is %@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSDictionary * dic = [responseObject objectForKey:@"income"];
            
            
            DayShaiXuanViewController *vc = [[DayShaiXuanViewController alloc] init];
            vc.dataDic = dic;
            if (seeType == 4) {
                vc.timeType = 2;
            }else {
                vc.timeType = 1;
            }
            vc.titleStr = _titleLable1.text;
            [self.navigationController pushViewController:vc animated:YES];
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


#pragma mark -
- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        _overlayWindow.userInteractionEnabled = YES;
    }
    return _overlayWindow;
}

- (void)showSelectView
{
    self.maskView.alpha = 0.7;
    self.maskView.backgroundColor = [UIColor grayColor];
    if(!self.maskView.superview)
        [self.overlayWindow insertSubview:self.maskView atIndex:0];
    
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideSelectView
{
    [self.maskView removeFromSuperview];
    self.maskView = nil;

    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:self.overlayWindow];
    [self.overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}


#pragma mark - 更新折线图数据
- (void)updateLineChartData:(NSArray *)data
{
    if (self.lineChartView)
    {
        [self.lineChartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.lineChartView removeFromSuperview];
        self.lineChartView = nil;
    }
    
    NSMutableArray *dateArray = [NSMutableArray new];
    NSMutableArray *incomeData = [NSMutableArray new];
    for (int i = 0; i < data.count; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%@", [[data objectAtIndex:i] objectForKey:@"date"]];
        [dateArray addObject:dateStr];
        [incomeData addObject:[NSString stringWithFormat:@"%@", [[data objectAtIndex:i] objectForKey:@"income"]]];
    }
    
    CGFloat width = PNLineChartXLabelWidth * data.count;
    width = width < UI_SCREEN_WIDTH ? UI_SCREEN_WIDTH : width;
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, width, 200.0)];
    lineChart.layer.borderWidth = 1;
    lineChart.drawDataAnimateTime = 0.01;
    lineChart.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
    [middleView addSubview:lineChart];
    middleView.contentSize = CGSizeMake(width, middleView.frame.size.height);
    self.lineChartView = lineChart;
    
    [lineChart setXLabels:dateArray];
    PNLineChartData *lineChartData = [PNLineChartData new];
    lineChartData.color = [UIColor whiteColor];
    lineChartData.itemCount = lineChart.xLabels.count;
    lineChartData.getData = ^(NSUInteger index) {
        CGFloat yValue = [incomeData[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[lineChartData];
    [lineChart strokeChart];
    
    if (width > UI_SCREEN_WIDTH)
    {
        self.xWidth = (CGRectGetWidth(lineChart.frame) - lineChart.chartMarginLeft - lineChart.chartMarginRight) / data.count;
        middleView.delegate = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineChart.drawDataAnimateTime * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSInteger number = UI_SCREEN_WIDTH / self.xWidth;
            middleView.contentOffset = CGPointMake((data.count - number) * ceil(self.xWidth), 0);
        });
    }
}

- (NSDate *)convertDateFromString:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateStr];
    return date;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == middleView)
    {
        NSInteger index = scrollView.contentOffset.x / self.xWidth;
        [self.lineChartView showHighlightLabelAtIndex:index + 3 resetLabelAtIndex:self.oldLabelIndex];
    }
}

@end
