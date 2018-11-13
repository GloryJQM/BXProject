//
//  MyGoodStatisticsViewController.m
//  SmallCEO
//
//  Created by nixingfu on 15/11/10.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//
static const NSInteger PNLineChartXLabelWidth = 45;

#import "MyGoodStatisticsViewController.h"
#import "TimeDetailViewController.h"
#import "CustomTableViewCell.h"
#import "PNChart.h"
#import "DayShaiXuanViewController.h"
#import "TimeDetailTableViewCell.h"
#import "RecordCell.h"
#import "ShaiXuanViewController.h"

@interface MyGoodStatisticsViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate,RiliViewDelegate,MJRefreshBaseViewDelegate>
{
    UIView * titleView, *bottomView, *headerView;
    UILabel * allLabel;
    UILabel * allMoneyLabel;
    UIButton * kuangBtn;
    UIImageView * kuangImageView;
    UIImageView * tipView;

    UIScrollView *middleView;
    UITableView * zhuTableView;
    UITableView * statisticsTableView;

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
    UIButton *leftNavBtn;
    
    BOOL isGoodsVisterClick;
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
@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) UILabel *titleLable1;
@property (nonatomic, strong) NSArray* month;
@property (nonatomic, assign) NSInteger oldLabelIndex;
@property (nonatomic, strong) PNLineChart *lineChartView;

@property (nonatomic, strong)UIView *visterHeadView;
@property (nonatomic, strong)UIScrollView * IncomeMainView;
@property (nonatomic, strong)UILabel * totalMoney;
@property (nonatomic, strong)UILabel * modayLabel;
@property (nonatomic, strong)UILabel * dayLabel;
@property (nonatomic, strong)UILabel * peopleNumLabel;
@property (nonatomic, strong)UILabel * firstLabel;
@property (nonatomic, strong)UILabel * secondLabel;
@property (nonatomic, strong)UILabel * threeLabel;
@property (nonatomic, strong)UILabel * fiveLabel;
@property (nonatomic, strong)UILabel * sixLabel;
@property (nonatomic, strong)MJRefreshHeaderView *headView;
@property (nonatomic, assign) CGFloat xWidth;

@end

@implementation MyGoodStatisticsViewController

- (void)viewWillAppear:(BOOL)animated {
    isGoodsVisterClick = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.curPage = 1;
    
    yearArray = @[@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027" ];
    monthArray = @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    pickerDayArr = @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    self.month = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    self.dateBttonArray = [NSMutableArray arrayWithCapacity:0];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH-140) / 2, 30, 140, 20)];
    _titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140-11, 20)];
    _titleLable1.text = @"浏览统计(人次)";
    _titleLable1.textColor = [UIColor whiteColor];
    _titleLable1.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:_titleLable1];
    
    
    tipView = [[UIImageView alloc] initWithFrame:CGRectMake( 140-11, 7, 11, 6)];
    tipView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:tipView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
    
    titleView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    self.navigationItem.titleView = titleView;
    
    leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    [leftNavBtn setTitle:@"筛选" forState:UIControlStateNormal];
    leftNavBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftNavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(billFilter) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.rightBarButtonItem= leftItem;
    
    /*选项卡*/
    [self creatPopView];
    

    
    /*浏览统计*/
    [self createStatisticsTableView];
    [self postTimeDetail];
    
    /*今日访问记录*/
    
    
    /*商品累计收益*/
    [self createIncomeMainView];
    [self creatIncomeSubView];
    self.IncomeMainView.hidden = YES;

    /*售出量*/
    [self.view addSubview:self.GainScrollView];
    [self creatMainView];
    
    self.headView = [[MJRefreshHeaderView alloc] init];
    self.headView.scrollView = statisticsTableView;
    self.headView.delegate = self;

    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无数据";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    noDataWarningLabel.hidden = YES;
    [self.view addSubview:noDataWarningLabel];
}
- (void)createStatisticsTableView {
    statisticsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -64)];
    statisticsTableView.delegate = self;
    statisticsTableView.dataSource = self;
    statisticsTableView.backgroundColor = WHITE_COLOR;
    statisticsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:statisticsTableView];
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
    
    allLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-200/2, 14, 200, 20)];
    allLabel.text = @"当前商品售出量(件)";
    allLabel.textColor = [UIColor colorFromHexCode:@"686868"];
    allLabel.font = [UIFont systemFontOfSize:14];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allLabel];
    
    allMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50,UI_SCREEN_WIDTH, 40)];
    allMoneyLabel.text = @"00.00";
    allMoneyLabel.textColor = App_Main_Color;
    allMoneyLabel.font = [UIFont systemFontOfSize:30];
    allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allMoneyLabel];
    
    kuangBtn = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80 - 6, 12,80, 20)];
    [kuangBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    [kuangBtn setTitle:@"折起折线图" forState:UIControlStateNormal];
    
    kuangBtn.backgroundColor = WHITE_COLOR;
    kuangBtn.layer.cornerRadius = 10;
    kuangBtn.layer.borderColor = App_Main_Color.CGColor;
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
    self.GainScrollView.hidden = YES;
    
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
                [dateBtn setBackgroundColor:App_Main_Color];
            }
            if (i == 1) {
                dateString = @"月";
            }
        }
    }
    return _doubleMiddleView;
}
- (void)createIncomeMainView
{
    if (!_IncomeMainView) {
        self.IncomeMainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _IncomeMainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT + 10);
        _IncomeMainView.backgroundColor = WHITE_COLOR;
    }
    [self.view addSubview:_IncomeMainView];
}

- (void)creatIncomeSubView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 104)];
    backView.backgroundColor = App_Main_Color;
    [self.IncomeMainView addSubview:backView];
    
    self.totalMoney = [[UILabel alloc] initWithFrame:CGRectMake(23 , 21, 150, 20)];
    _totalMoney.text = @"总收入(元)";
    _totalMoney.font = [UIFont systemFontOfSize:20];
    _totalMoney.textColor = [UIColor colorFromHexCode:@"f0d200"];
    [backView addSubview:_totalMoney];
    
    self.modayLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 50, 200, 40)];
    _modayLabel.text = @"5689.00";
    _modayLabel.font = [UIFont systemFontOfSize:30];
    _modayLabel.textColor = WHITE_COLOR;
    [backView addSubview:_modayLabel];
    
    self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 104 + 12, 200, 20)];
    _peopleNumLabel.text = @"访客数(人)";
    _peopleNumLabel.font = [UIFont systemFontOfSize:20];
    _peopleNumLabel.textColor = SUB_TITLE;
    [self.IncomeMainView addSubview:_peopleNumLabel];
    
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 104 + 40, 200, 40)];
    _firstLabel.text = @"5689.00";
    _firstLabel.font = [UIFont systemFontOfSize:30];
    _firstLabel.textColor = App_Main_Color;
    
    [self.IncomeMainView addSubview:_firstLabel];
    
    
    UIView * IncomeBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 186, UI_SCREEN_WIDTH, 152)];
    IncomeBottomView.backgroundColor = MONEY_COLOR;
    [self.IncomeMainView addSubview:IncomeBottomView];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    line1.backgroundColor = LINE_SHALLOW_COLOR;
    [IncomeBottomView addSubview:line1];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 152 / 2, UI_SCREEN_WIDTH, 1)];
    line2.backgroundColor = LINE_SHALLOW_COLOR;
    [IncomeBottomView addSubview:line2];
    
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2, 0, 1, 152)];
    line3.backgroundColor = LINE_SHALLOW_COLOR;
    [IncomeBottomView addSubview:line3];
    
    
    UIView * line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 152, UI_SCREEN_WIDTH, 1)];
    line4.backgroundColor = LINE_SHALLOW_COLOR;
    [IncomeBottomView addSubview:line4];
    
    UILabel * payLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    payLabel.text = @"支付转化率";
    payLabel.textColor = SUB_TITLE;
    payLabel.font = [UIFont systemFontOfSize:20];
    [IncomeBottomView addSubview:payLabel];
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 39, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _secondLabel.text = @"23%";
    _secondLabel.font = [UIFont systemFontOfSize:18];
    [IncomeBottomView addSubview:_secondLabel];
    
    
    
    UILabel * payNumLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    payNumLabel.text = @"支付订单数";
    payNumLabel.textColor = SUB_TITLE;
    payNumLabel.font = [UIFont systemFontOfSize:20];
    [IncomeBottomView addSubview:payNumLabel];
    
    self.threeLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 39, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _threeLabel.text = @"589";
    _threeLabel.font = [UIFont systemFontOfSize:18];
    [IncomeBottomView addSubview:_threeLabel];
    
    
    UILabel * zongLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 152 / 2 + 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    zongLabel.text = @"总下单(单)";
    zongLabel.textColor = SUB_TITLE;
    zongLabel.font = [UIFont systemFontOfSize:20];
    [IncomeBottomView addSubview:zongLabel];
    
    
    self.fiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 39 + 152 / 2, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _fiveLabel.text = @"6000";
    _fiveLabel.font = [UIFont systemFontOfSize:18];
    [IncomeBottomView addSubview:_fiveLabel];
    
    
    UILabel *  saleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake( 23 + (UI_SCREEN_WIDTH / 2), 152 / 2 + 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    saleNumLabel.text = @"售出商品件数";
    saleNumLabel.textColor = SUB_TITLE;
    saleNumLabel.font = [UIFont systemFontOfSize:20];
    [IncomeBottomView addSubview:saleNumLabel];
    
    self.sixLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 39 + 152 / 2, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _sixLabel.text = @"3587";
    _sixLabel.font = [UIFont systemFontOfSize:18];
    [IncomeBottomView addSubview:_sixLabel];
    
    
}
- (void)clickDateButton:(UIButton *)sender
{
    
    UIButton * button = (UIButton *)[_doubleMiddleView viewWithTag:sender.tag] ;
    button.backgroundColor = App_Main_Color;//被点击的按钮要改变的颜色
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

- (UIView *)visterHeadView {
    if (_visterHeadView == nil) {
        _visterHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 65)];
        _visterHeadView.backgroundColor = WHITE_COLOR;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [_visterHeadView addSubview:line];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 20)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"今日访问";
        title.font =LMJ_XT 15];
        title.textColor = SUB_TITLE;
        [_visterHeadView addSubview:title];
    
    
        UILabel *visterCountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, UI_SCREEN_WIDTH, 30)];
        visterCountLab.textAlignment = NSTextAlignmentCenter;
        visterCountLab.text = @"0人次";
        visterCountLab.font =LMJ_CT 17];
        visterCountLab.tag = 200;
        visterCountLab.textColor = App_Main_Color;
        [_visterHeadView addSubview:visterCountLab];
    }
    return _visterHeadView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
        return self.dayArray.count;
    }else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
        if (self.dayArray.count == 0) {
            return 0;
        }else {
            return 90;
        }
    }else if ([_titleLable1.text isEqualToString:@"售出量"]) {
        return 70;
    }else if ([_titleLable1.text isEqualToString:@"今日访问记录"]){
        return 65;
    }else {
        return 0;

    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
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
            midVi.backgroundColor = App_Main_Color;
            
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
        
    }else if ([_titleLable1.text isEqualToString:@"售出量"]){
        return self.doubleMiddleView;
    }else if ([_titleLable1.text isEqualToString:@"今日访问记录"]){
        return self.visterHeadView;
    }else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {

        return 1;
    }else {
        return self.dayArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
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
        
    }else if ([_titleLable1.text isEqualToString:@"售出量"]){
        static NSString * cellIndentifier = @"sellCell";
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
        }
        cell.isInt = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updata:[self.dayArray objectAtIndex:indexPath.row] max:dataMax min:dataMin];
        
        return cell;
        
    }else if ([_titleLable1.text isEqualToString:@"今日访问记录"]) {
        static NSString * cellIndentifier = @"todayVisterCell";
        RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateDic:[self.dayArray objectAtIndex:indexPath.row]];
        return cell;
        
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
        DateOut* date = [[DateOut alloc]init];
        int year = [[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"year"] intValue];
        int mo = [[[self.dayArray objectAtIndex:indexPath.section] valueForKey:@"month"]intValue];
        int allDay = [date allDayInYear:year andMonth:mo];
        int firstDay = [date theFirstDayIsInYear:year andMonth:mo];
        int row = 0;
        DLog(@"year %d  %d  %d",year,firstDay,allDay)
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
        
    }else if ([_titleLable1.text isEqualToString:@"今日访问记录"]) {
        return 41;
        
    }else {
        return 80;
        
    }
}


-(void)giveUp:(long)date work:(float)workTime
{
    NSString *dateStr = [NSString stringWithFormat:@"%ld",date];
    tempYear = [dateStr substringToIndex:4];
    tempMonth = [dateStr substringWithRange:NSMakeRange(4, 2)];
    tempDay = [dateStr substringWithRange:NSMakeRange(6, 2)];
    
    isGoodsVisterClick = YES;
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

    NSArray * array = @[@"浏览统计(人次)",@"商品累计收益",@"今日访问记录", @"售出量"];
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
            label.textColor =App_Main_Color;
            line1.backgroundColor = App_Main_Color;
        }
    }
}
- (void)doClick:(UIView *)sender
{
    UIView * line1 = (UIView *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:1];
    line1.backgroundColor = App_Main_Color;//被点击的按钮要改变的颜色
    
    for (UIView * tempLine in self.buttonArray) {
        
        if (![line1 isEqual:tempLine]) {
            tempLine.backgroundColor = LINE_SHALLOW_COLOR;//其余按钮要改变到的颜色
        }
    }
    
    UILabel * label1 = (UILabel *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:0];
    label1.backgroundColor = WHITE_COLOR;
    label1.textColor = App_Main_Color;//被点击的按钮要改变的颜色
    for (UILabel * tilabel in self.labelArray) {
        if (![label1 isEqual:tilabel]) {
            tilabel.textColor = [UIColor blackColor];//其余按钮要改变到的颜色
        }
    }
    
    [self hidePickerView];
#pragma mark - 顶部按钮
    
    self.curPage = 1;
    [self.dayArray removeAllObjects];
    if (sender.tag == 500) {
        _titleLable1.text = @"浏览统计(人次)";
        self.GainScrollView.hidden = YES;
        self.IncomeMainView.hidden = YES;
        statisticsTableView.hidden = NO;
        leftNavBtn.hidden = NO;
        [self refresh:statisticsTableView];
        [self postTimeDetail];

    }else if (sender.tag == 501) {
        _titleLable1.text = @"商品累计收益";
        leftNavBtn.hidden = YES;
        self.GainScrollView.hidden = YES;
        self.IncomeMainView.hidden = NO;
        statisticsTableView.hidden = YES;
        noDataWarningLabel.hidden = YES;
        [self refresh:self.IncomeMainView];
        [self postIncome];
        
    }else if (sender.tag == 502) {
        _titleLable1.text = @"今日访问记录";
        leftNavBtn.hidden = YES;
        statisticsTableView.hidden = NO;
        self.GainScrollView.hidden = YES;
        self.IncomeMainView.hidden = YES;
        [self refresh:statisticsTableView];
        [self postRecode];
        
    }else {
        _titleLable1.text = @"售出量";
        self.GainScrollView.hidden = NO;
        statisticsTableView.hidden = YES;
        noDataWarningLabel.hidden = YES;
        self.IncomeMainView.hidden = YES;
        leftNavBtn.hidden = NO;
        [self refresh:zhuTableView];
        [self postDayAllShouYi:600];
    }
    
}

#pragma mark - MJRefresh
- (void)refresh:(UIScrollView *)tempView
{
    self.headView.scrollView=tempView;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        self.curPage=1;
        if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {

            [self postTimeDetail];
            
        }else if ([_titleLable1.text isEqualToString:@"商品累计收益"]) {
            
            [self postIncome];
            
        }else if ([_titleLable1.text isEqualToString:@"今日访问记录"]) {
            
            [self postRecode];
            
        }else {

            [self postDayAllShouYi:600];
        }

    }
}


#pragma mark - http

/*收益*/
-(void)postIncome
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",self.goodsID];
    NSString *str=MOBILE_SERVER_URL(@"my_product_statistics.php");
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
            
            NSDictionary * dic = [responseObject objectForKey:@"userinfo"];
            
            self.modayLabel.text = [NSString stringWithFormat:@"%.2f", [[dic objectForKey:@"total_income"] floatValue]];
            self.firstLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"view_num"]];
            self.secondLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"buy_percent"]];
            self.threeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"buy_order"]];
            self.fiveLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"all_order"]];
            self.sixLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_sell_num"]];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.headView endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.headView endRefreshing];

    }];
    [op start];
}

/*今日访问记录*/
-(void)postRecode
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateStr = [fmt stringFromDate:newDate];
    
    [SVProgressHUD show];

    NSString*body=[NSString stringWithFormat:@"nowdate=%@&aid=%@", dateStr,self.goodsID];
    NSString *str=MOBILE_SERVER_URL(@"today_fangwen.php");
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
            
            NSArray * tempArray = [[responseObject objectForKey:@"content"] valueForKey:@"data"];
            
            UILabel * count =(UILabel *)[self.visterHeadView viewWithTag:200];
            count.text = [NSString stringWithFormat:@"%@人次",[[responseObject objectForKey:@"content"] valueForKey:@"totalnum"]];
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.dayArray removeAllObjects];
                }
                [self.dayArray addObjectsFromArray:tempArray];
                
                noDataWarningLabel.hidden = tempArray.count == 0 ? NO:YES;

                [statisticsTableView reloadData];
            }
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.headView endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.headView endRefreshing];

    }];
    [op start];
}

/*售出量(年月日)*/
-(void)postDayAllShouYi:(NSInteger)judgeTag
{
    [SVProgressHUD show];
    NSString*body;
    if (judgeTag == 600) {
        body=[NSString stringWithFormat:@"record_type=2&see_type=3&time_type=4&aid=%@",self.goodsID];
    }else if (judgeTag == 601){
        
        body=[NSString stringWithFormat:@"record_type=2&see_type=2&time_type=4&aid=%@",self.goodsID];
    }else if (judgeTag == 602){
        
        body=[NSString stringWithFormat:@"record_type=2&see_type=1&time_type=4&aid=%@",self.goodsID];
    }
    DLog(@"body %@",body);
    NSString *str=MOBILE_SERVER_URL(@"my_product_record.php");
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
            
            allMoneyLabel.text = [NSString stringWithFormat:@"%d", [[dic objectForKey:@"total"] intValue]];
            dataMax = [[dic objectForKey:@"max"] doubleValue];
            
            dataMin = [[dic objectForKey:@"min"] doubleValue];
            
            DLog(@"最大值 %lf, 最小值 %lf", dataMax, dataMin);
            
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
        [self.headView endRefreshing];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.headView endRefreshing];

    }];
    [op start];
}

/*浏览统计(人次)*/
- (void)postTimeDetail {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"record_type=0&see_type=3&time_type=4&aid=%@",self.goodsID];
    NSString *str=MOBILE_SERVER_URL(@"my_product_record.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSArray* temp=[[responseObject valueForKey:@"record"] valueForKey:@"data"] ;
            DLog(@"temp %@",temp);
            noDataWarningLabel.hidden = temp.count == 0 ? NO:YES;
            
            self.dayArray = [[NSMutableArray alloc] initWithArray:temp];
            
            [statisticsTableView reloadData];
            
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.headView endRefreshing];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.headView endRefreshing];

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
    if ([_titleLable1.text isEqualToString:@"浏览统计(人次)"]) {
        isGoodsVisterClick = YES;
    }
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
    NSString *body = @"";
    if ([_titleLable1.text isEqualToString:@"售出量"]) {
        body = [NSString stringWithFormat:@"record_type=2&see_type=%d&time_type=5&time=%@&aid=%@",seeType, time,self.goodsID];
    }else {
        body = [NSString stringWithFormat:@"record_type=0&see_type=3&time_type=5&time=%@&aid=%@",time,self.goodsID];
    }
    DLog(@"body %@",body);
    
    NSString *str=MOBILE_SERVER_URL(@"my_product_record.php");
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
            if ([_titleLable1.text isEqualToString:@"售出量"]) {
                NSDictionary * dic = [responseObject objectForKey:@"income"];
                
                DayShaiXuanViewController *vc = [[DayShaiXuanViewController alloc] init];
                vc.dataDic = dic;
                if (seeType == 4) {
                    vc.timeType = 2;
                }else {
                    vc.timeType = 1;
                }
                vc.isFormSell = YES;
                vc.whichVC = 30;
                vc.titleStr = _titleLable1.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                ShaiXuanViewController*vc = [[ShaiXuanViewController alloc] init];
                if ([tempDay isEqualToString:@"全部"]) {
                    vc.flag = 6;
                    vc.dataArray =[[responseObject objectForKey:@"record"] valueForKey:@"data"];
                }else {
                    vc.flag = 5;
                    vc.dataArray =[responseObject objectForKey:@"list"];
                    vc.isGoodsVisterClick = isGoodsVisterClick;
                }
                vc.goodsID = self.goodsID;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.headView endRefreshing];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.headView endRefreshing];

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
        [incomeData addObject:[NSString stringWithFormat:@"%@", [[data objectAtIndex:i] objectForKey:@"record"]]];
    }
    
    CGFloat width = PNLineChartXLabelWidth * data.count;
    width = width < UI_SCREEN_WIDTH ? UI_SCREEN_WIDTH : width;
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, width, 200.0)];
    lineChart.isInt = YES;
    //    lineChart.layer.borderWidth = 1;
    lineChart.drawDataAnimateTime = 0.01;
    lineChart.backgroundColor = App_Main_Color;
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
            if (IS_IPHONE6 || IS_IPHONE6PLUS)
            {
                middleView.contentOffset = CGPointMake((data.count - number) * ceil(self.xWidth) - 15, 0);
            }
            else if (IS_IPHONE5)
            {
                middleView.contentOffset = CGPointMake((data.count - number) * ceil(self.xWidth) - 5, 0);
            }
            else
            {
                middleView.contentOffset = CGPointMake((data.count - number) * ceil(self.xWidth), 0);
            }
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
-(void)dealloc
{
    [self.headView free];
}
@end
