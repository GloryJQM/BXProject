//
//  CitySearchResultViewController.m
//  Jiang
//
//  Created by huang on 2017/1/10.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "CitySearchResultViewController.h"

@interface CitySearchResultViewController ()

@end

@implementation CitySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = [UIColor colorFromHexCode:@"F0F0F0"];
    self.tableView.rowHeight = 50.0;
    //self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:@"匹配结果为空！"
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -100.0;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredCitys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr = @"CitySearchResultVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.filteredCitys[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectFilteredCitysBlock)
    {
        self.selectFilteredCitysBlock(self.filteredCitys[indexPath.row]);
    }
}

#pragma mark - Setter
- (void)setFilteredCitys:(NSArray *)filteredCitys
{
    _filteredCitys = filteredCitys;
    [self.tableView reloadData];
}

@end
