//
//  BillViewController.m
//  Jiang
//
//  Created by peterwang on 17/2/28.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "BillsViewController.h"
#import "BillSuspendView.h"
#import "BillsTableViewCell.h"
#import "BillsDetailViewController.h"
#import "XHDatePickerView.h"
#import "ChooseTypeView.h"
@interface BillsViewController ()<BillSuspendedViewDelegate,UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate,UIAlertViewDelegate>{

}

@property (nonatomic, strong) BillSuspendView *suspendedView;//上方选项条
@property (nonatomic, strong) UIScrollView  *mainScrollView;//huadong
@property (nonatomic, strong) NSMutableArray *tableViewDatas;//tableview的数据
@property (nonatomic, strong) NSMutableArray *MjheaderViews;//
@property (nonatomic, strong) NSMutableArray *MjfooterViews;//
@property (nonatomic, strong) NSMutableArray  *tableViews;//tableview数组
@property (nonatomic, assign) NSInteger curPage;//当前页数
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) MJRefreshFooterView *footerView;
@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger deleteTag;
@property (nonatomic, strong) NSMutableArray *monthNumber;//月数
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *nameStr;
@end

@implementation BillsViewController

-(void)dealloc
{
    for (int i = 0; i<_MjfooterViews.count; i++) {
        MJRefreshHeaderView *header = _MjheaderViews[i];
        MJRefreshFooterView *footer = _MjfooterViews[i];
        [header free];
        [footer free];
    }
}
- (void)creatBackView
{
    _imageArray = [NSMutableArray array];
    for (int i = 0; i < self.suspendedView.items.count;i++ ) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-75, UI_SCREEN_HEIGHT/4-50, 150, 150)];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:@"icon-tishi2@2x"];
        UITableView *currentTableView = self.tableViews[i];
        [currentTableView addSubview:imageView];
        [_imageArray addObject:imageView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    self.billType = All;
    self.tableViewDatas = [NSMutableArray array];
    [self createNavi];
    [self suspendedView];
    [self setupMainView];
    [self creatBackView];
    //加载数据
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    self.date = [formatter stringFromDate:[NSDate date]];
//    self.date = @"";
    self.curPage = 1;
    [self loadMyDatas];
}
- (void)createNavi {
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(chooseType)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;

}

- (void)setupMainView
{
    self.tableViewDatas = [NSMutableArray new];
    self.tableViews = [NSMutableArray new];
    self.MjfooterViews = [NSMutableArray new];
    self.MjheaderViews = [NSMutableArray new];
    [self.view addSubview:self.suspendedView];
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.suspendedView.maxY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT  - self.suspendedView.height-20)];
    self.mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH * self.suspendedView.items.count, self.mainScrollView.height);
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.scrollEnabled = NO;
    [self.view addSubview:self.mainScrollView];
    for (NSInteger i = 0; i < self.suspendedView.items.count; i++) {
        //[self.tableViewDatas addObject:[NSNull null]];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, self.mainScrollView.height-BillSuspendedViewHeight)];
        [self.tableViews addObject:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = WHITE_COLOR;
        tableView.tableFooterView = [UIView new];
        
        [self.mainScrollView addSubview:tableView];
        [tableView registerClass:[BillsTableViewCell class] forCellReuseIdentifier:@"BillsCell"];
        

        self.headerView = [[MJRefreshHeaderView alloc] init];
        self.headerView.scrollView = tableView;
        self.headerView.delegate = self;
        __weak BillsViewController *vc = self;
        self.headerView.beginRefreshingBlock = ^(MJRefreshBaseView * view){
            [vc loadMyDatas];
        };
         [self.MjheaderViews addObject:_headerView];
        self.footerView = [[MJRefreshFooterView alloc] init];
        self.footerView.scrollView = tableView;
        self.footerView.delegate = self;
        self.footerView.beginRefreshingBlock = ^(MJRefreshBaseView *view){
            [vc loadMoreDatas];
        };
        [self.MjfooterViews addObject:_footerView];
    }
    
}

#pragma mark-UITabViewDtaSouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableViews[0]]) {
        return self.tableViewDatas.count;
    }else if ([tableView isEqual:self.tableViews[1]])
    {
        return   self.tableViewDatas.count;
    }else {
       
        return   self.tableViewDatas.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //改变单元格分割线长度
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    BillsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[BillsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BillsCell"];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    if (self.tableViewDatas.count > indexPath.row) {
        if ([self.tableViewDatas[indexPath.row][@"number"] doubleValue] > 0 ) {
            cell.tipImage.image = [UIImage imageNamed:@"pho-shouru"];
            cell.detailLabel.text = self.tableViewDatas[indexPath.row][@"remark"];
        }else {
            cell.tipImage.image = [UIImage imageNamed:@"pho-zhichu@2x"];
            cell.detailLabel.text = self.tableViewDatas[indexPath.row][@"remark"];
        }
        cell.moneyLabel.text = self.tableViewDatas[indexPath.row][@"number"];
        cell.dateLabel.text =  self.tableViewDatas[indexPath.row][@"log_time"];
    }
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAction:)];
    longP.minimumPressDuration = 0.5f;
    [cell.contentView addGestureRecognizer:longP];
    return cell;
}
- (void)deleteAction:(UILongPressGestureRecognizer *)sender {
    //进行提醒
    if (sender.state == UIGestureRecognizerStateBegan) {
        UITableView *curT = self.tableViews[self.suspendedView.currentItemIndex];
        CGPoint point = [sender locationInView:curT];
        NSIndexPath *indexPath = [curT indexPathForRowAtPoint:point];
        self.deleteTag =  indexPath.row ;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认要删除吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *url = MOBILE_SERVER_URL(@"billApiNew.php");
        TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"act=2&id=%@", self.tableViewDatas[self.deleteTag][@"id"]];
        [request  setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        
        AFHTTPRequestOperation *op_yue = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op_yue.responseSerializer = [AFJSONResponseSerializer serializer];
        [op_yue setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[@"is_success"] integerValue] == 1) {
//                [self.tableViewDatas removeObjectAtIndex:self.deleteTag];
//                UITableView *cur = self.tableViews[self.suspendedView.currentItemIndex];
//                [cur reloadData];
                [self loadMyDatas];
            }else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
            }
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
        [op_yue start];
    }
}
//根据 ****-**-** 获取****年*月
- (NSString *)getDateByDate:(NSString *)date{
    NSArray *arr;
    if ([date containsString:@"."]) {
       arr = [date componentsSeparatedByString:@"."];
    }else{
      arr = [date componentsSeparatedByString:@"-"];
    }
    
    NSInteger month = [arr[1] integerValue];
    return [NSString stringWithFormat:@"%@年%ld月", arr[0], (long)month];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.billType == All) {
        return 40;
    }else {
        return 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //
    NSString *date;
    if (self.tableViewDatas.count == 0) {
        date = self.date;
    }else {
        date = self.monthNumber[section];
    }
    if (self.billType == All) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, UI_SCREEN_WIDTH - 40, 20)];
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        label.text = [self getDateByDate:date];
        
        
        UIButton *datePickerButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 30, 10, 20, 20)];
        [datePickerButton setImage:[UIImage imageNamed:@"icon-riqixuanze@2x_03"] forState:UIControlStateNormal
         ];
        [datePickerButton addTarget:self action:@selector(Datepicker) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:datePickerButton];
        view.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:227 / 255.0 blue:227 / 255.0 alpha:1];
        return view;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, UI_SCREEN_WIDTH - 40, 20)];
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        label.text = [self getDateByDate:date];
        UIButton *datePickerButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 30, 10, 20, 20)];
        [datePickerButton setImage:[UIImage imageNamed:@"icon-riqixuanze@2x_03"] forState:UIControlStateNormal
         ];
        [datePickerButton addTarget:self action:@selector(Datepicker) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:datePickerButton];
        view.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:227 / 255.0 blue:227 / 255.0 alpha:1];
        //添加收入，支出
        if (self.suspendedView.currentItemIndex == 0) {
            //有收入，有支出
            CGFloat getValue = 0;
            CGFloat outValue = 0;
            for (NSDictionary *dic in self.tableViewDatas) {
                NSString *money = dic[@"number"];
                if (money.floatValue > 0) {
                    getValue += money.floatValue;
                }else {
                    outValue += (-money.floatValue);
                }
            }
            UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, UI_SCREEN_WIDTH, 20)];
            des.font = [UIFont systemFontOfSize:12];
            des.textColor = [UIColor colorFromHexCode:@"#666666"];
            des.text = [NSString stringWithFormat:@"收入：%.2f 支出：%.2f", getValue,outValue];
            [view addSubview:des];
        }else if (self.suspendedView.currentItemIndex == 1){
            //收入
            CGFloat getValue = 0;
            for (NSDictionary *dic in self.tableViewDatas) {
                NSString *money = dic[@"number"];
                if (money.floatValue > 0) {
                    getValue += money.floatValue;
                }
            }
            UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, UI_SCREEN_WIDTH, 20)];
            des.font = [UIFont systemFontOfSize:12];
            des.textColor = [UIColor colorFromHexCode:@"#666666"];
            des.text = [NSString stringWithFormat:@"收入：%.2f", getValue];
            [view addSubview:des];
        }else if (self.suspendedView.currentItemIndex == 2){
            CGFloat outValue = 0;
            for (NSDictionary *dic in self.tableViewDatas) {
                NSString *money = dic[@"number"];
                if(money.floatValue < 0) {
                    outValue += (-money.floatValue);
                }
            }
            UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, UI_SCREEN_WIDTH, 20)];
            des.font = [UIFont systemFontOfSize:12];
            des.textColor = [UIColor colorFromHexCode:@"#666666"];
            des.text = [NSString stringWithFormat:@"支出：%.2f",outValue];
            [view addSubview:des];

        }
        return view;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillsDetailViewController *detail = [[BillsDetailViewController alloc]init];
    NSDictionary *dic = self.tableViewDatas[indexPath.row];
    detail.orderId = dic[@"id"];
    detail.money = dic[@"number"];

    if (self.billType == All) {
    }else if (self.billType == Cash){
        detail.act = @"现金";
    }else if (self.billType == Piont){
        detail.act = @"积分";
    }else if (self.billType == Gold){
        detail.act = @"金币";
    }
    if ([dic[@"number"] floatValue] > 0) {
        detail.type = NO;
    }else {
        detail.type = YES;
    }
    detail.moneyType = [NSString stringWithFormat:@"%@", dic[@"type"]];
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark - SuspendedViewDelegate
- (void)didClickView:(BillSuspendView *)view atItemIndex:(NSInteger)index
{
    [self.mainScrollView setContentOffset:CGPointMake(self.suspendedView.currentItemIndex * UI_SCREEN_WIDTH, 0) animated:NO];
    [self.tableViewDatas removeAllObjects];
    [self loadMyDatas];
}

#pragma mark - Refresh methods
- (void)loadMyDatas
{
    self.curPage = 1;
//    self.date = @"";
    [self getData:[NSString stringWithFormat:@"%ld",(long)_suspendedView.currentItemIndex] AndDate:self.date Andpage:[NSString stringWithFormat:@"%ld",(long)self.curPage]];
}

- (void)loadMoreDatas
{
    self.curPage++;
    [self getData:[NSString stringWithFormat:@"%ld", (long)_suspendedView.currentItemIndex] AndDate:self.date Andpage:[NSString stringWithFormat:@"%ld", (long)self.curPage]];
    
}
#pragma mark  http
- (void)getData:(NSString *)type AndDate:(NSString *)date Andpage:(NSString *)page{
    [SVProgressHUD show];
    NSString *str;
    NSString *bodyStr;
    NSString *dateStr = [NSString stringWithFormat:@"%@-01", date];
    if (self.billType == All) {
        str = MOBILE_SERVER_URL(@"billApiNew.php");
        bodyStr = [NSString stringWithFormat:@"type=%@&date=%@&p=%@",type,date,page];
    }else if (self.billType == Cash){
        str = MOBILE_SERVER_URL(@"moneyApiNew.php");
        bodyStr = [NSString stringWithFormat:@"type=%@&date=%@&p=%@&act=1",type,dateStr,page];
    }else if (self.billType == Piont) {
        str = MOBILE_SERVER_URL(@"pointsApi.php");
        bodyStr = [NSString stringWithFormat:@"type=%@&date=%@&p=%@&act=1",type,date,page];
    }else if (self.billType == Gold) {
        str = MOBILE_SERVER_URL(@"goldApi.php");
        bodyStr = [NSString stringWithFormat:@"type=%@&date=%@&p=%@&act=1",type,date,page];
    }
    
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               MJRefreshHeaderView *header = self.MjheaderViews[self.suspendedView.currentItemIndex];
                               MJRefreshFooterView *foot = self.MjfooterViews[self.suspendedView.currentItemIndex];
                               [header endRefreshing];
                               [foot endRefreshing];
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   if (self.curPage ==1) {
                                       [self.tableViewDatas removeAllObjects];
                                       for (NSDictionary *dic in responseObject[@"list"]) {
                                           [self.tableViewDatas addObject:dic];
                                       }
                                       DLog(@"%@", self.tableViewDatas);
                                   }else {
                                       
                                       for (NSDictionary *dic in responseObject[@"list"]) {
                                           [self.tableViewDatas addObject:dic];
                                       }

                                   }
                                   UITableView *currentTableView = self.tableViews[self.suspendedView.currentItemIndex];
                                   //此处进行数据处理，获取月
                                    NSMutableSet *set = [NSMutableSet set];
                                   for (NSDictionary *dic in self.tableViewDatas) {
                                       //获取月份集合
                                       NSString *yearAndMonth = dic[@"log_time"];
                                       yearAndMonth = [yearAndMonth substringToIndex:7];
                                       [set addObject:yearAndMonth];
                                   }
                                   NSArray *sortDesc =  @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
                                   self.monthNumber = [NSMutableArray arrayWithArray:[set sortedArrayUsingDescriptors:sortDesc]];
                                   DLog(@"月数数组：%@", self.monthNumber);
                                   [currentTableView reloadData];
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                               
                               [SVProgressHUD dismiss];
                               UIImageView *imageV = self.imageArray[self.suspendedView.currentItemIndex];
                               if (self.tableViewDatas.count == 0) {
                                   imageV.hidden = NO;
                               }else {
                                   imageV.hidden = YES;
                               }
                              
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               MJRefreshHeaderView *header = self.MjheaderViews[self.suspendedView.currentItemIndex];
                               MJRefreshFooterView *foot = self.MjfooterViews[self.suspendedView.currentItemIndex];
                               [header endRefreshing];
                               [foot endRefreshing];
                               UIImageView *image = self.imageArray[self.suspendedView.currentItemIndex];
                               if (self.tableViewDatas.count == 0) {
                                   image.hidden = NO;
                               }else {
                                   image.hidden = YES;
                               }

                           }];
}
#pragma  mark - 时间筛选
- (void)Datepicker {
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        self.date = [formatter stringFromDate:startDate];
        DLog(@"%@", self.date);
        self.curPage = 1;
        [self loadMyDatas];
    } andType:1];
    datepicker.maxLimitDate = [NSDate date];
    [datepicker show];
}
#pragma mark - 模块筛选
- (void)chooseType {
    ChooseTypeView *choooseType = [[ChooseTypeView alloc]initWithCompleteBlock:^(NSInteger chooseType) {
        DLog(@"当前选择的类型是%ld", (long)chooseType);
        self.curPage = 1;
//        self.date = @"";
        switch (chooseType) {
            case 0:
                self.billType = All;
                self.title = @"账单";
                [self loadMyDatas];
                break;
            case 1:
                self.billType = Cash;
                self.title = @"现金";
                [self loadMyDatas];
                break;
            case 2:
                self.billType = Piont;
                self.title = @"积分";
                [self loadMyDatas];
                break;
            case 3:
                self.billType = Gold;
                self.title = @"金币";
                [self loadMyDatas];
                break;
            default:
                break;
        }
    } andType:(NSInteger)self.billType];
    [choooseType show];
}
#pragma mark - Getter
- (BillSuspendView *)suspendedView
{
    if (!_suspendedView)
    {
        _suspendedView = [[BillSuspendView alloc] initWithSuspendedViewStyle:SuspendedViewStyleVaule3];
        _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, BillSuspendedViewHeight);
        //        _suspendedView.delegate = self;
        _suspendedView.items = @[@"全部", @"收入 ",@"支出 "];
        
        _suspendedView.backgroundColor = [UIColor whiteColor];
        _suspendedView.delegate = self;
        [self.view addSubview:_suspendedView];
    }
    return _suspendedView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
