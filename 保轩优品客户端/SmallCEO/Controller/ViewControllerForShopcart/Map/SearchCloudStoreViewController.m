//
//  SearchCloudStoreViewController.m
//  SmallCEO
//
//  Created by huang on 16/4/28.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "SearchCloudStoreViewController.h"

#import "CloudStoreSearchBar.h"
#import "SearchResultNotFoundViewController.h"

@interface SearchCloudStoreViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) CloudStoreSearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchResultTableView;

@property (nonatomic, strong) NSArray *matchAnnotations;

@end

@implementation SearchCloudStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CloudStoreSearchBar *searchBar=[[CloudStoreSearchBar alloc] initWithFrame:CGRectMake(-10, 7, UI_SCREEN_WIDTH-2*50, 30)];
    searchBar.delegate = self;
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.layer.borderWidth = 1;
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    temp.backgroundColor=[UIColor clearColor];
    [temp addSubview:searchBar];
    
    self.navigationItem.titleView=temp;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"icon-sousuo@2x"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self.view addSubview:self.searchResultTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

#pragma mark - 
- (void)rightBtnClick
{
    if (self.searchBar.text.length == 0)
        return;
    
    if (self.matchAnnotations.count == 0)
    {
        [self pushToResultNotFoundViewController];
    }
    else if (self.selectBlock)
    {
        self.selectBlock([self.matchAnnotations objectAtIndex:0]);
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchBar.text.length == 0)
        return;
    
    if (self.matchAnnotations.count == 0)
    {
        [self pushToResultNotFoundViewController];
    }
    else if (self.selectBlock)
    {
        self.selectBlock([self.matchAnnotations objectAtIndex:0]);
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0)
        return;
    
    self.matchAnnotations = [self filterWithSearchString:searchText];
    [self.searchResultTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock)
    {
        
        self.selectBlock([self.matchAnnotations objectAtIndex:indexPath.row]);
        [self.searchBar endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.matchAnnotations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *searchCloudStoreStr = @"searchCloudStoreStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCloudStoreStr];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:searchCloudStoreStr];
    }
    
    cell.textLabel.text = [[self.matchAnnotations objectAtIndex:indexPath.row] shopName];
    cell.detailTextLabel.text = [[self.matchAnnotations objectAtIndex:indexPath.row] contactInformation];
    UILabel *label = [UILabel new];
    label.text = [[self.matchAnnotations objectAtIndex:indexPath.row] cityName];
    [label sizeToFit];
    cell.accessoryView = label;

    return cell;
}

#pragma mark - 筛选关键字的方法
- (NSArray *)filterWithSearchString:(NSString *)searchString
{
    NSMutableArray *matchAnnotations = [NSMutableArray new];
    for (CustomAnnotation *annotation in self.annotations) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchString];
        if ([predicate evaluateWithObject:annotation.shopName]||[predicate evaluateWithObject:annotation.title]||[predicate evaluateWithObject:annotation.contactInformation])
        {
            [matchAnnotations addObject:annotation];
        }
    }

    return [matchAnnotations copy];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.searchResultTableView)
    {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - Getter
- (UITableView *)searchResultTableView
{
    if (!_searchResultTableView)
    {
        _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar)];
        _searchResultTableView.tableFooterView = [UIView new];
        _searchResultTableView.dataSource = self;
        _searchResultTableView.delegate = self;
        [self.view addSubview:_searchResultTableView];
    }
    
    return _searchResultTableView;
}

#pragma mark - 隐藏键盘
-(void)missKeyBoard
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Push To ViewController
- (void)pushToResultNotFoundViewController
{
    [self missKeyBoard];
    SearchResultNotFoundViewController *vc = [SearchResultNotFoundViewController new];
    vc.searchedStr = self.searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
