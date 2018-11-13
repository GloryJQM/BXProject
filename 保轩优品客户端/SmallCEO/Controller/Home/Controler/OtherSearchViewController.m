//
//  OtherSearchViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/8/30.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OtherSearchViewController.h"
#import "OtherTableViewCell.h"
#import "OtherDetailController.h"
#import "CustomSearchTextField.h"
@interface OtherSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CustomSearchTextField *searchTextField;
@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;
@property (nonatomic, assign) NSInteger curP;
@property (nonatomic, copy) NSString *textStr;

@property (nonatomic, strong) UIImageView *backImageView;
@end

@implementation OtherSearchViewController
- (void)dealloc {
    [_header free];
    [_footer free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.curP = 1;
    [self createNavigationView];
    [self creationTableView];
}

- (void)createNavigationView {
    if (!_searchTextField) {
        self.searchTextField = [[CustomSearchTextField alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH - 20 - 40, 30)];
        _searchTextField.placeholder = @" 输入商家名称";
        self.navigationItem.titleView = self.searchTextField;
        self.searchTextField.delegate = self;
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        self.searchTextField.inputAccessoryView = btnT;
        [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        UIImage *image = [UIImage imageNamed:@"icon-sousuo@2x"];
        [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = bar;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTextField becomeFirstResponder];
    });
}

- (void)missKeyBoard {
    [self.searchTextField resignFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.textStr = textField.text;
    [self getDataForList];
}

- (void)searchAction {
    
}

- (void)creationTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = NO;
    
    [_tableView registerClass:[OtherTableViewCell class] forCellReuseIdentifier:@"OtherTableViewCell"];
    
    _header = [[MJRefreshHeaderView alloc]init];
    _header.scrollView = _tableView;

    __block typeof(self) weakSelf = self;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        weakSelf.curP = 1;
        [weakSelf getDataForList];
    };
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        weakSelf.curP++;
        [weakSelf getDataForList];
    };
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-53, UI_SCREEN_HEIGHT/4-50, 106, 106)];
    _backImageView.image = [UIImage imageNamed:@"pho-zanwushuju@2x"];
    [self.view addSubview:_backImageView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* adrList = @"OtherTableViewCell";
    OtherTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:adrList];
    if(cell == nil) {
        cell = [[OtherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adrList];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    [cell addLineWithY:129.5 X:15 width:UI_SCREEN_WIDTH - 30];
    [cell setDictionary:_dataArray[indexPath.row] isFujin:NO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString * body = [NSString stringWithFormat:@"act=3&shop_id=%@",[self.dataArray[indexPath.row] objectForKey:@"id"]];
    [RCLAFNetworking postWithUrl:@"shopApi.php" BodyString:body isPOST:YES success:^(id responseObject) {
        NSDictionary *dic = [NSDictionary dictionary];
        dic = [responseObject objectForKey:@"shop_info"];
        OtherDetailController *vc = [[OtherDetailController alloc]init];
        vc.dataDic = dic;
        vc.dicDic = _dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } fail:nil];
}

- (void)getDataForList {
    NSString *gps=[[PreferenceManager sharedManager] preferenceForKey:@"gps"];
    NSArray *tempGps=[gps componentsSeparatedByString:@","];
    CLLocationCoordinate2D from;
    if (tempGps.count==2) {
        from.longitude=[[tempGps objectAtIndex:0] doubleValue];
        from.latitude=[[tempGps objectAtIndex:1] doubleValue];
    }
    
    NSString *body = [NSString stringWithFormat:@"act=2&cid=%@&p=%ld&number_of_page=10&lat=%f&lng=%f&keyword=%@", _cid,(long)self.curP,from.latitude,from.longitude, self.textStr];
    
    [RCLAFNetworking noSVPPostWithUrl:@"shopApi.php" BodyString:body success:^(id responseObject) {
        if (self.curP == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            [self.dataArray addObject:dic];
        }
        if (self.dataArray.count > 0) {
            _backImageView.hidden = YES;
        }else {
            _backImageView.hidden = NO;
        }
        [_tableView reloadData];
        [_footer endRefreshing];
        [_header endRefreshing];
    } fail:^(NSError *error) {
        [_footer endRefreshing];
        [_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
