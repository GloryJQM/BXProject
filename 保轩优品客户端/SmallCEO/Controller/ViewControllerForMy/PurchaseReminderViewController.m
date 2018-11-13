//
//  PurchaseReminderViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "PurchaseReminderViewController.h"
#import "PurchaseReminderCell.h"
@interface PurchaseReminderViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    UILabel *noDataWarningLabel;

}

@property (nonatomic, strong)UITableView * purchaseReminderView;
@property (nonatomic, assign)int curPage;

@property (nonatomic, strong)NSMutableArray * purchaseDataArray;
@end

@implementation PurchaseReminderViewController

- (void)dealloc
{
    [_headerView free];
    [_footView free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买提醒";
    self.curPage=1;

    self.purchaseDataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.purchaseReminderView];
    
    self.headerView = [[MJRefreshHeaderView alloc] init];
    self.headerView.scrollView = _purchaseReminderView;
    self.headerView.delegate = self;
    
    self.footView = [[MJRefreshFooterView alloc] init];
    self.footView.scrollView = _purchaseReminderView;
    self.footView.delegate = self;
    
    [self postPurchaseData];
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无记录";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    noDataWarningLabel.hidden = NO;
    [self.purchaseReminderView addSubview:noDataWarningLabel];
}
- (void)viewWillDisappear:(BOOL)animated {
    /*退出界面关闭cell的所有定时器,不然会内存暴涨*/
    for (PurchaseReminderCell *cell in self.purchaseReminderView.visibleCells) {
        [cell stopTimer];
    }
    
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headerView)
    {
        self.curPage=1;

        [self postPurchaseData];

    }else
    {
        self.curPage++;
        [self postPurchaseData];

    }
}

- (UITableView *)purchaseReminderView
{
    if (_purchaseReminderView == nil) {
        self.purchaseReminderView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
        _purchaseReminderView.delegate = self;
        _purchaseReminderView.dataSource = self;
        _purchaseReminderView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _purchaseReminderView;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.purchaseDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"PurchaseReminder";
    PurchaseReminderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[PurchaseReminderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
    }
    [cell updateCellData:self.purchaseDataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self deleteCoupon:indexPath.row];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
-(void)deleteCoupon:(NSInteger)index
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&act=del_remind&remind_id=%@", [[[self.purchaseDataArray objectAtIndex:index] objectForKey:@"remind_id"] URLEncodedString]];
//     NSString*body=@"";
    NSString *str=MOBILE_SERVER_URL(@"group_buy.php");
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
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.purchaseDataArray];
            [array removeObjectAtIndex:index];
            self.purchaseDataArray = array;
            [SVProgressHUD dismissWithSuccess:@"删除成功"];
            [self.purchaseReminderView reloadData];
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

-(void)postPurchaseData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=remind_list&page=%d", self.curPage];
    NSString *str=MOBILE_SERVER_URL(@"group_buy.php");
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
            
            
            NSArray *tempArray = [responseObject objectForKey:@"list"];
            
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.purchaseDataArray removeAllObjects];
                }
                [self.purchaseDataArray addObjectsFromArray:tempArray];
                
                noDataWarningLabel.hidden = self.purchaseDataArray.count == 0 ?NO:YES;
            }
            
            [_purchaseReminderView reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络成功"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headerView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headerView endRefreshing];
    }];
    [op start];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135+9;
    
}


@end
