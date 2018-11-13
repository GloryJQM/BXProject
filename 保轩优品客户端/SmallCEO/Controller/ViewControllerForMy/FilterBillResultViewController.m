//
//  FilterBillResultViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/27.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BillsDetailViewController.h"
#import "BillTableViewCell.h"
#import "FilterBillResultViewController.h"

@interface FilterBillResultViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FilterBillResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账单筛选结果";
    
    [self createMainView];
    // Do any additional setup after loading the view.
}

- (void)createMainView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *monthAndYearString = [NSString stringWithFormat:@"%@", [[self.filteredBillData allKeys] objectAtIndex:0]];
    NSArray *currentMonthBillArray = [[self.filteredBillData objectForKey:monthAndYearString] objectForKey:@"list"];
    
    return currentMonthBillArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellForBill";
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil)
    {
        cell = [[BillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSString *monthAndYearString = [NSString stringWithFormat:@"%@", [[self.filteredBillData allKeys] objectAtIndex:0]];
    NSArray *currentMonthBillArray = [[self.filteredBillData objectForKey:monthAndYearString] objectForKey:@"list"];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@", [[currentMonthBillArray objectAtIndex:indexPath.row] objectForKey:@"create_time"]];
    cell.timeLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
    NSString *money = [NSString stringWithFormat:@"%@", [[currentMonthBillArray objectAtIndex:indexPath.row] objectForKey:@"money"]];
    if ([[money substringToIndex:1] isEqualToString:@"-"])
    {
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [money substringFromIndex:1]];
        cell.type = BillTypeExport;
    }
    else
    {
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@", money];
        cell.type = BillTypeImport;
    }
    
    cell.billCharacterLabel.text = [NSString stringWithFormat:@"%@", [[currentMonthBillArray objectAtIndex:indexPath.row] objectForKey:@"remark"]];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 24.5)];
    headerView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH - 20, 24.5)];
    textLabel.font = [UIFont systemFontOfSize:13.0];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents * component = [calendar components:unitFlags fromDate:self.filterDate];
    textLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", [component year], [component month], [component day]];
    [headerView addSubview:textLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *monthAndYearString = [NSString stringWithFormat:@"%@", [[self.filteredBillData allKeys] objectAtIndex:0]];
    NSArray *currentMonthBillArray = [[self.filteredBillData objectForKey:monthAndYearString] objectForKey:@"list"];
    NSString *billID = [[currentMonthBillArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    BillsDetailViewController *billDetailsVC = [[BillsDetailViewController alloc] init];
    //billDetailsVC.billID = billID;
    [self.navigationController pushViewController:billDetailsVC animated:YES];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
