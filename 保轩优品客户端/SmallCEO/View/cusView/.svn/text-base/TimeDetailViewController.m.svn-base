//
//  TimeDetailViewController.m
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "TimeDetailViewController.h"
#import "TimeDetailTableViewCell.h"
#import "RiLiView.h"
#import "EditSomeOneTimeViewController.h"
#import "TodayIncomeViewController.h"
#import "TodayOrderViewController.h"
#import "RecordViewController.h"
#import "AddViewController.h"
#import "HistoryViewController.h"
#import "ShaiXuanViewController.h"

@interface TimeDetailViewController ()
@property (nonatomic,strong)UITableView* tabV;
@property (nonatomic,strong)NSArray* month;
@property (nonatomic,strong)NSMutableArray* years;
@property (nonatomic,strong)NSMutableArray* months;

@property (nonatomic,strong)UIPickerView* pick;
@property (nonatomic,assign)int flag;

@property (nonatomic,strong)NSMutableArray* numOfYear;
@property (nonatomic,strong)NSMutableArray* numOfMonth;

@property (nonatomic,strong)UIView* backV;
@property (nonatomic,strong)UIView* bigV;

@property (nonatomic,strong)NSString* yearStr;
@property (nonatomic,strong)NSString* monthStr;

@property (nonatomic,assign)int status;
@property (nonatomic,strong)NSMutableDictionary* muDic;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * areaView;

@property (nonatomic, strong)NSMutableArray * buttonArray;

@property (nonatomic, strong)NSMutableArray * labelArray;

@property (nonatomic, strong)UIView * backShaiXuanView;

@property (nonatomic, strong)UIView * areaShaiXuanView;

@property (nonatomic, strong)NSArray * testArray;


@end

@implementation TimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (C_IOS7) {
        self.automaticallyAdjustsScrollViewInsets=NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.status=1;
    self.flag=1;
    self.years = [NSMutableArray arrayWithCapacity:0];
    self.numOfMonth = [NSMutableArray arrayWithCapacity:0];
    self.numOfYear = [NSMutableArray arrayWithCapacity:0];
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    self.labelArray = [NSMutableArray arrayWithCapacity:0];
    self.month = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];

    self.title = @"签到";

    [self createView];
    [self key];
}
#pragma mark - 弹出和消失
- (void)xiala {
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view addSubview:_backView];
    self.areaView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 219);
    [UIView commitAnimations];
}

- (void)hidePickerView {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -219, UI_SCREEN_WIDTH, 219);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
}
- (void)key
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT )];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, - 438 / 2, UI_SCREEN_WIDTH, 438 / 2)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    NSArray * array = @[@"累计收益", @"今日收益", @"今日访问", @"今日订单", @"收入概览", @"历史访问"];
    
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  219 /  array.count * i, UI_SCREEN_WIDTH, 219 / array.count)];
        [_areaView addSubview:line];
        
        UIImageView * clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 10 - 40.5, (219 / 6 - 10)/2, 14, 10)];
        clickImageView.image = [UIImage imageNamed:@"icon_buleright.png"];
        clickImageView.tag = 400 + i;
        clickImageView.userInteractionEnabled = YES;
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
        
        if (i == 0) {
            label.textColor = App_Main_Color;
        }
        
        if (i == 5) {
            line1.hidden = YES;
        }
        if (i == 0) {
            
        }else{
            clickImageView.hidden = YES;
        }
    }
}
- (void)btnDoClick:(UIImageView *)sender {
    
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag+100) afterDelay:0.5];
}
- (void)popToMyGoodsVCWithTag:(NSNumber *)obj {
    int vcTag = [obj intValue];
    if (vcTag == 500) {
        
    }else {
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.popBlock) {
            self.popBlock(vcTag);
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



#pragma mark - 弹出和消失PickerView
- (void)popShaiXuanPickerView {
    if (self.years.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"暂无数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        self.backShaiXuanView.frame = self.view.bounds;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.areaShaiXuanView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 260, UI_SCREEN_WIDTH, 260);
        [UIView commitAnimations];
        
        [self.areaPickerView reloadAllComponents];
    }
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
    
    
    self.areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, UI_SCREEN_WIDTH, 168)];
    _areaPickerView.dataSource = self;
    _areaPickerView.delegate = self;
    _areaPickerView.tag = 2000;
    _areaPickerView.backgroundColor = WHITE_COLOR;
    [_areaShaiXuanView addSubview:_areaPickerView];
}
#pragma mark - 筛选
- (void)finishChose {
    [SVProgressHUD show];
    if (self.yearStr.length > 3) {
        NSString *curYear  = self.yearStr;
        NSString *curMonth = self.monthStr;
        
        for (int i = 0; i < dataSourceArr.count; i++) {
            NSString *tYear  = [[dataSourceArr objectAtIndex:i] valueForKey:@"year"];
            NSString *tMonth = [[dataSourceArr objectAtIndex:i] valueForKey:@"month"];

            if ( ( [curMonth  intValue]==[tMonth intValue])  && ( [tYear  intValue]==[curYear intValue])) {
                NSMutableArray *shaiXuanResults = [[NSMutableArray alloc] initWithCapacity:0];
                NSDictionary *tempDic = [dataSourceArr objectAtIndex:i];
                [shaiXuanResults addObject:tempDic];
                ShaiXuanViewController *vc = [[ShaiXuanViewController alloc] init];
                vc.flag = 6;
                vc.dataArray = shaiXuanResults;
                DLog(@"筛选的数据:%@",shaiXuanResults);
                [self.navigationController pushViewController:vc animated:YES];
                [SVProgressHUD dismiss];
                break;
            }else {
                [SVProgressHUD dismissWithSuccess:@"筛选结果为空"];
            }
        }
    }
    [self hideShaiXuanPickerView];
}
-(void)createView
{
    self.tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tabV.backgroundColor = WHITE_COLOR;
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tabV];
    
    tiplable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tabV.frame.size.width, self.tabV.frame.size.height)];
    tiplable.textColor=[UIColor lightGrayColor];
    tiplable.font=GFB_FONT_CT 17];
    tiplable.textAlignment=NSTextAlignmentCenter;
    tiplable.backgroundColor=[UIColor clearColor];
    [self.tabV addSubview:tiplable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(dataSourceArr.count==0){
        tiplable.hidden=NO;
    }else{
        tiplable.hidden=YES;
    }
    return dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* str2 = @"TimeDetailCell";
    TimeDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str2];
    if(cell == nil)
    {
        cell = [[TimeDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSString *month=[NSString stringWithFormat:@"%@",[[dataSourceArr objectAtIndex:indexPath.section] valueForKey:@"month"]];
    NSString *year=[NSString stringWithFormat:@"%@",[[dataSourceArr objectAtIndex:indexPath.section] valueForKey:@"year"]];
    [cell upDataWith:[year intValue] andMonth:[month intValue] delegate:self :dataSourceArr[indexPath.section] withStep:YES];

    return cell;
}

-(void)giveUp:(long)date work:(float)workTime
{
    DLog(@"进图下一级页面");
//        TodayIncomeViewController* vc = [[TodayIncomeViewController alloc]init];
//
//        vc.date = [NSString stringWithFormat:@"%ld",date];
//        vc.whereVC = 4;
//     DLog(@"_____toiuoeiy   %@", vc.date);
//        [self.navigationController pushViewController:vc animated:YES];

}

-(void)clickIt
{
    if(self.where==2)
    {
        EditSomeOneTimeViewController* vc = [[EditSomeOneTimeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DateOut* date = [[DateOut alloc]init];
    int year = [[[dataSourceArr objectAtIndex:indexPath.section] valueForKey:@"year"] intValue];
    int mo = [[[dataSourceArr objectAtIndex:indexPath.section] valueForKey:@"month"]intValue];
    int allDay = [date allDayInYear:year andMonth:mo];
    int firstDay = [date theFirstDayIsInYear:year andMonth:mo];
    
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *tempDic=[dataSourceArr objectAtIndex:section];

    UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
    UIView* upVi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 32)];
    upVi.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];

    
    UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 32)];
    lab.text = [NSString stringWithFormat:@"%@年",[tempDic valueForKey:@"year"]];
    lab.textColor = TIILE_COLOR;
    lab.font = GFB_FONT_XT 18];
    [upVi addSubview:lab];
 
    
    UIView* midVi = [[UIView alloc]initWithFrame:CGRectMake(0, 32, UI_SCREEN_WIDTH, 20)];
    midVi.backgroundColor = BLUE_COLOR;
    
    UILabel* lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH-30, 20)];
    lab1.textColor = WHITE_COLOR;
    lab1.font = GFB_FONT_XT 12];
    lab1.text = [NSString stringWithFormat:@"%00d月签到合计%@天",[[tempDic valueForKey:@"month"] intValue],[tempDic valueForKey:@"sign_in_total"]];
    [midVi addSubview:lab1];
    
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
}

- (void)postTimeDetail {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=list&p=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"sign_in.php");
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

            NSArray* temp=[responseObject valueForKey:@"content"];
            dataSourceArr = [[NSMutableArray alloc] initWithArray:temp];
            
            if (temp.count == 0) {
                UILabel *noDataWarningLabel = [[UILabel alloc] init];
                noDataWarningLabel.tag = 10086;
                noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                noDataWarningLabel.text = @"暂无数据";
                noDataWarningLabel.textColor=[UIColor grayColor];
                noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
                [_tabV addSubview:noDataWarningLabel];
            }else {
                UILabel *noDataWarningLabel = (UILabel *)[_tabV viewWithTag:10086];
                [noDataWarningLabel removeFromSuperview];
            }

            self.years=[[NSMutableArray alloc] initWithCapacity:0];
        
            for (int i=0; i<dataSourceArr.count; i++) {
                NSString *yearString=[NSString stringWithFormat:@"%@",[dataSourceArr[i] valueForKey:@"year"]];
                [_years addObject:yearString];
            }
            
            NSMutableArray *tempYears=[[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<_years.count; i++) {
                NSString *temp=[_years objectAtIndex:i];
                if (![tempYears containsObject:temp]) {
                    [tempYears addObject:temp];
                }
            }
            
            _years=tempYears;
            [self dateGet];
            
            NSDate * newDate = [NSDate date];
            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            fmt.dateFormat = @"yyyy-MM-dd";
            NSString *dateString = [fmt stringFromDate:newDate];
            NSString *year = [dateString substringToIndex:4];

            
            

            if (self.years.count == 0) {
                
            }else {
              NSInteger  indexOfObject = [self.years indexOfObject:year];
                NSString *month = [dateString substringWithRange:NSMakeRange(5, 2)];
                DLog(@"年份%@--月份%@--%@",year,month,self.years);
                NSInteger indexOfObjectOfMonth = [self.month indexOfObject:month];
                
                [_areaPickerView selectRow:indexOfObject inComponent:0 animated:YES];
                [_areaPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
                self.yearStr = year;
                self.monthStr = month;
            }
            [self.tabV reloadData];

               
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)dataEdit:(NSArray*)arr
{
    for(int i = 0;i<arr.count;i++)
    {
        DLog(@"111");
        [self.years addObject:[NSString stringWithFormat:@"%@.%@",[[arr[i] objectAtIndex:0]  objectForKey:@"year"],[[arr[i] objectAtIndex:0] objectForKey:@"month"]]];
        DLog(@"222");
    }
}

-(void)dateGet
{
//    NSString* el = [[dataSourceArr[dataSourceArr.count-1] objectAtIndex:0] objectForKey:@"year"];
//    NSString* la = [[dataSourceArr[0] objectAtIndex:0] objectForKey:@"year"];
//    
//    for(int i = (int)[el integerValue];i<=(int)[la integerValue];i++)
//    {
//        [self.numOfYear addObject:[NSString stringWithFormat:@"%d",i]];
//    }
}

-(void)popPick
{
    DLog(@"111");
    if(self.bigV ==nil)
    {
        self.bigV= [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-44, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        self.bigV.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:0.3];
        [self.view addSubview:self.bigV];
        
        self.backV= [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-244, UI_SCREEN_WIDTH, 224)];
        self.backV.backgroundColor = [UIColor whiteColor];
        [self.bigV addSubview:self.backV];

        self.pick=[[UIPickerView alloc] initWithFrame:CGRectZero];
        self.pick.backgroundColor=[UIColor whiteColor];
        self.pick.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.pick.layer.borderColor = LINE_COLOR.CGColor;
        self.pick.layer.borderWidth = 1.0;
        _pick.tag = 1000;
        self.pick.delegate=self;
        self.pick.dataSource=self;
        self.pick.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 180);
        self.pick.showsSelectionIndicator = YES;
        [self.backV addSubview:self.pick];
        
        UIView* vi = [[UIView alloc] initWithFrame:CGRectMake(0, 180, UI_SCREEN_WIDTH, 44)];
        vi.backgroundColor = [UIColor whiteColor];
        [self.backV addSubview:vi];
        
        UIButton* cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 80, 44)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:LINE_COLOR forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(missPick) forControlEvents:UIControlEventTouchUpInside];
    
        UIButton* sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-15-80, 0, 80, 44)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(goChoseSearch) forControlEvents:UIControlEventTouchUpInside];
        
        [vi addSubview:sureBtn];
        [vi addSubview:cancelBtn];
    }

        Animation_Appear 0.2];
        self.bigV.transform = CGAffineTransformMake(1, 0, 0, 1, 0, -UI_SCREEN_HEIGHT);
        [UIView commitAnimations];
    
}

-(void)goChoseSearch
{
    Animation_Appear 0.2];
    self.bigV.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    [UIView commitAnimations];
    self.flag = 1;
    
    [self postChoseSearch];
}

-(void)postChoseSearch
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=2&month=%@&year=%@",self.monthStr,self.yearStr];
    NSString *str=MOBILE_SERVER_URL(@"gongshilist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"%@",body);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            self.status=2;
            [dataSourceArr removeAllObjects];
            if([[[responseObject objectForKey:@"content"] objectForKey:@"list"] isKindOfClass:[NSArray class]])
            {
                NSArray* temp = [[responseObject objectForKey:@"content"] objectForKey:@"list"] ;
                dataSourceArr = [NSMutableArray arrayWithArray:temp];
                DLog(@"==%@==",[[dataSourceArr[0] objectAtIndex:0]objectForKey:@"allgongshi"]);
            }
                [self.tabV reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)missPick
{
    Animation_Appear 0.2];
    self.bigV.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    [UIView commitAnimations];
    self.flag = 1;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(component==0)
    {
        return self.years.count;
    }else if(component==1)
    {
        return self.month.count;
    }
   return 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(self.where==2)
    {
        [self postOneTime];
    }else
    {
        [self postTimeDetail];
    }
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _areaPickerView) {
        
//        NSDictionary *tempDic=[dataSourceArr objectAtIndex:component];
        
        if (component == 0) {
            NSString * year = [NSString stringWithFormat:@"%@年", self.years[row]];
            return year;
        }else if(component==1)
        {
            
            NSString * month = [NSString stringWithFormat:@"%@月", self.month[row]];
            return month;
//            return self.month[row];
        }
        
    }else if(pickerView == _pick){
        
        if(component==0)
        {
            return self.numOfYear[row];
        }else if(component==1)
        {
            return self.month[row];
        }

    
    }
    
       return nil;
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    if(component==0)
    {
        self.yearStr = self.years[row];
    }else if(component==1)
    {
        NSDate * newDate = [NSDate date];
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString* dateString = [fmt stringFromDate:newDate];
        
        NSString * month = [dateString substringWithRange:NSMakeRange(5, 2)];
        int nowDate = [month intValue];
        NSInteger indexOfObjectOfMonth = [self.month indexOfObject:month];
        
        NSInteger monthSelectedIndex = [pickerView selectedRowInComponent:1];
        NSString *seletedMonth = [self.month objectAtIndex:monthSelectedIndex];
        int seletedDate = [seletedMonth intValue];
        
        if (seletedDate > nowDate) {
            [_areaPickerView selectRow:indexOfObjectOfMonth inComponent:1 animated:YES];
            self.monthStr = month;
        }else {
            self.monthStr = self.month[row];
        }
    }
}

-(void)postOneTime {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@""];
    NSString *str=MOBILE_SERVER_URL(@"shuju.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"%@~~",body);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            if([[[responseObject valueForKey:@"content"] valueForKey:@"list"] isKindOfClass:[NSArray class]]){
                NSArray* temp=[[responseObject valueForKey:@"content"] valueForKey:@"list"];
                dataSourceArr = [NSMutableArray arrayWithArray:temp];
                DLog(@"^&%@",dataSourceArr);
                
                if ([dataSourceArr isKindOfClass:[NSMutableArray class]]) {
                    [self dataEdit:dataSourceArr];
                }else{
                    dataSourceArr=nil;
                }
                [self dateGet];
                [self.tabV reloadData];
                }
           
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}


@end
