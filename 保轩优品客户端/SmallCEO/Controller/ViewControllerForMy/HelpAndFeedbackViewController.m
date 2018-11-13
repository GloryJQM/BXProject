//
//  HelpAndFeedbackViewController.m
//  SmallCEO
//
//  Created by huang on 15/10/13.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

//static const CGFloat tableViewHeaderViewHeight = 26.0;
static const CGFloat extraHeightForEachCellView = 40.0;
//static const CGFloat tableViewMaxHeight = 350.0;

#import "FeedbackViewController.h"
#import "HelpAndFeedbackViewController.h"
#import "ProductDetailsViewController.h"
#import "Reachability.h"

@interface HelpAndFeedbackViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sectionDetailArray;
@property (nonatomic, strong) NSMutableArray *detailsHeightArray;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) CGFloat cellsTotalHeight;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;

@end

@implementation HelpAndFeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"热点问题";
    
    self.detailsHeightArray = [NSMutableArray new];
    self.sectionDetailArray = [NSMutableArray new];
    
    [self calculateDetailsHeight];
    [self createMainView];
    self.curPage = 1;
    [self getHotQuestionData];
}

- (void)createMainView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mainTableView = tableView;
    //刷新
    _header = [[MJRefreshHeaderView alloc]init];
    _header.scrollView = tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        self.curPage = 1;
        [self getHotQuestionData];
    };
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.scrollView = tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        self.curPage++;
        [self getHotQuestionData];
    };
}
- (void)createNagivationBarView
{
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"意见反馈" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(feedback)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
}

#pragma mark - 计算内容的高度
- (void)calculateDetailsHeight
{
    if (self.detailsHeightArray.count > 0)
    {
        [self.detailsHeightArray removeAllObjects];
    }
    
    self.cellsTotalHeight = 0;
    for (int i = 0; i < self.sectionDetailArray.count; i++)
    {
        NSString *detail = [NSString stringWithFormat:@"%@", [[self.sectionDetailArray objectAtIndex:i] objectForKey:@"subject"]];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, nil];
        CGRect frame = [detail boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 100, UI_SCREEN_HEIGHT)
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes context:nil];
        [self.detailsHeightArray addObject:[NSNumber numberWithDouble:frame.size.height]];
        self.cellsTotalHeight += (frame.size.height + extraHeightForEachCellView);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionDetailArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellStrForSettingsVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.sectionDetailArray objectAtIndex:indexPath.row] objectForKey:@"subject"]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cheackUrl:[NSString stringWithFormat:@"%@", [[self.sectionDetailArray objectAtIndex:indexPath.row] objectForKey:@"url"]]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.detailsHeightArray objectAtIndex:indexPath.row] doubleValue] + extraHeightForEachCellView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return tableViewHeaderViewHeight;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableViewHeaderViewHeight)];
//    headerView.backgroundColor = BACK_COLOR;
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width - 30, tableViewHeaderViewHeight)];
//    titleLabel.font = [UIFont systemFontOfSize:14.0];
//    titleLabel.text = @"热点问题";
//    [headerView addSubview:titleLabel];
//
//    return headerView;
//}

#pragma mark - 点击方法
- (void)feedback {
    FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

#pragma mark - 网络请求方法
- (void)getHotQuestionData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"help.php");
    NSString *param = [NSString stringWithFormat:@"p=%ld",(long)self.curPage];
    [RequestManager startRequestWithUrl:str
                                   body:param
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                                   return;
                               }
                               if (self.curPage == 1) {
                                   [self.sectionDetailArray removeAllObjects];
                               }
                               [self.sectionDetailArray addObjectsFromArray:[responseObject objectForKey:@"content"]];
                               [self calculateDetailsHeight];
//                               CGFloat height = self.cellsTotalHeight + tableViewHeaderViewHeight;
//                               height = height < tableViewMaxHeight ? height : tableViewMaxHeight;
//                               self.mainTableView.scrollEnabled = !(height < tableViewMaxHeight);
//                               CGRect frame = self.mainTableView.frame;
//                               frame.size.height = height;
//                               self.mainTableView.frame = frame;
                               [self.mainTableView reloadData];
                               [SVProgressHUD dismiss];
                               [_footer endRefreshing];
                               [_header endRefreshing];
                           }failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               [_footer endRefreshing];
                               [_header endRefreshing];
                           }];
}

#pragma mark -
-(void)cheackUrl:(NSString *)url
{
    //8.4
    [SVProgressHUD show];
    Reachability* reach = [Reachability reachabilityWithHostName:@"app.lemuji.com"];
    if ([reach currentReachabilityStatus] != NotReachable)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            ProductDetailsViewController *viewController = [[ProductDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController loadWebView:url];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismissWithError:@"网络错误"];
        });
    }
}

@end
