//
//  MyInfoViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/20.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BillsViewController.h"
#import "MyInfoViewController.h"
#import "PersonalInfoSettingsViewController.h"
#import "MyCollectionViewController.h"
#import "HelpAndFeedbackViewController.h"
#import "SettingsViewController.h"
#import "FeedbackViewController.h"
#import "CommissionViewController.h"
#import "SetViewController.h"
#import "AccountViewController.h"
#import "OrderViewController.h"
#import "UserBaseInfoView.h"

static NSString *const MyinfoCellStr = @"MyinfoCellStr";

@interface MyInfoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) UserBaseInfoView *userBaseInfoView;
@property (nonatomic, strong) UIView *functionView;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *tipArray;
@property (nonatomic, strong) NSMutableArray *functionArray;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor colorWithRed:48 / 255.0 green:48 / 255.0 blue:48 / 255.0 alpha:0.8];
    
    [self createNagivationBarView];

    //作为背景滑动层
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.3, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    _tableview.backgroundColor = WHITE_COLOR2;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
    [_tableview addSubview:self.userBaseInfoView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMyCenterData];
}

- (void)createNagivationBarView {
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账单" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(gotoBill)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
}
#pragma mark - 跳转事件
- (void)gotoSetInfo {
    PersonalInfoSettingsViewController *person = [PersonalInfoSettingsViewController new];
    [self.navigationController pushViewController:person animated:YES];
}

- (void)gotoBill {
    BillsViewController *billVC = [BillsViewController new];
    [self.navigationController pushViewController:billVC animated:YES];
}

- (void)gotoAccount:(id)sender {
    UITapGestureRecognizer *taps = (UITapGestureRecognizer *)sender;
    NSInteger d = [taps view].tag;
    if (d <= 2 ) {
        AccountViewController *account = [[AccountViewController alloc]init];
        if (d == 0) {
            account.type = @"金币";
        }else if (d == 1){
            account.type = @"积分";
        }else if (d == 2){
            account.type = @"代金券";
        }
        [self.navigationController pushViewController:account animated:YES];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyinfoCellStr forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *image = [[UIImageView alloc]init];
    [image sd_setImageWithURL:[NSURL URLWithString:_collectionArray[indexPath.item][@"icon"]]];
    CGFloat width = (140/750.0)*UI_SCREEN_WIDTH;
    
    image.frame = CGRectMake((cell.width - width) / 2, 17, width, width);
    image.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, image.maxY+10, cell.width, 15)];
    label.text = _collectionArray[indexPath.item][@"title"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //我的订单
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 1) {
        OrderViewController *order = [[OrderViewController alloc] init];
        order.isMyInfo = YES;
        [self.navigationController pushViewController:order animated:YES];
    }
    //我的佣金
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 4) {
        CommissionViewController *commission = [CommissionViewController new];
        [self.navigationController pushViewController:commission animated:YES];
    }
    //我的收藏
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 6)
    {
        MyCollectionViewController *collect= [[MyCollectionViewController alloc]init];
        [self.navigationController pushViewController:collect animated:YES];
    }
    //热点问题
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 2){
        HelpAndFeedbackViewController *help = [HelpAndFeedbackViewController new];
        [self.navigationController pushViewController:help animated:YES];
    }
    //设置
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 5) {
        SetViewController *set = [SetViewController  new];
        [self.navigationController pushViewController:set animated:YES];
    }
    //意见反馈
    if ([_collectionArray[indexPath.item][@"type"] integerValue] == 3) {
        FeedbackViewController *feedBackVC = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
}

#pragma mark - 获取我的页面的数据
- (void)getMyCenterData {
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"myCenterApi.php");
    [RequestManager startRequestWithUrl:str
                                   body:nil
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                            
                               NSArray *array = [responseObject objectForKey:@"menu_list"];
                               for (int i = 0; i < array.count; i ++) {
                                   NSDictionary *dic = [NSDictionary dictionary];
                                   dic = array[i];
                                   if ([[dic allKeys]containsObject:@"item_list"]) {
                                       self.tipArray = [NSArray array];
                                       self.tipArray = dic[@"item_list"];
                                   }
                               }
                               [self setViewOfdata:responseObject];
                               
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [self.view configBlankPage:EaseBlankPageTypeRefresh hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                                   [self getMyCenterData];
                               }];
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
#pragma  mark 部署数据
- (void)setViewOfdata:(NSDictionary *)dic {
    [self.userBaseInfoView setModelDictionary:dic];
    _functionArray = [[NSMutableArray alloc]init];
    NSString *gold = [NSString stringWithFormat:@" %@",dic[@"user_info"][@"gold_num"]];
    [_functionArray addObject:gold];
    NSString *points = [NSString stringWithFormat:@" %@",dic[@"user_info"][@"points_num"]];
    [_functionArray addObject:points];
    NSString *coupon = [NSString stringWithFormat:@" %@",dic[@"user_info"][@"coupon_num"]];
    [_functionArray addObject:coupon];
    NSString *lower = [NSString stringWithFormat:@" %@",dic[@"user_info"][@"lower_number"]];
    [_functionArray addObject:lower];
    
    _collectionArray = [[NSMutableArray alloc]init];
    _collectionArray = dic[@"menu_list"];
    
    [_functionView removeFromSuperview];
    _functionView = nil;
    
    [_tableview addSubview:self.userBaseInfoView];
    [_tableview addSubview:self.functionView];
    [_tableview addSubview:self.mainCollectionView];
    
}
#pragma mark - Getter
- (UserBaseInfoView *)userBaseInfoView {
    if (!_userBaseInfoView) {
        _userBaseInfoView = [[UserBaseInfoView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UserBaseInfoViewHeight)];
        _userBaseInfoView.backgroundColor = [UIColor colorWithRed:17 / 255.0 green:17 / 255.0 blue:17 / 255.0 alpha:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSetInfo)];
        [_userBaseInfoView addGestureRecognizer:tap];
    }
    return _userBaseInfoView;
}

- (UIView *)functionView {
    if (!_functionView) {
        CGFloat itemViewHeight = 90;
        _functionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.userBaseInfoView.maxY, UI_SCREEN_WIDTH, itemViewHeight)];
        _functionView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titles = _functionArray;
        
        NSArray *images = @[@"icon-jinbi@2x",@"icon-jifen@2x",@"icon-daijinquan@2x",@"icon-tuijian@2x"];
        NSArray *texts = @[@"金币余额", @"积分", @"代金券", @"推荐"];
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *subItemView = [[UIView alloc] initWithFrame:CGRectMake(idx * (UI_SCREEN_WIDTH / 4.0), 0, UI_SCREEN_WIDTH / 4.0, itemViewHeight)];
            [_functionView addSubview:subItemView];
            
            //图片
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 8 - 10, 10, 20, 20)];
            imageView.image = [UIImage imageNamed:images[idx]];
            [subItemView addSubview:imageView];
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.maxY + 10, subItemView.width, 20)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.text = texts[idx];
            [subItemView addSubview:titleLabel];
            
            if (idx == 2) {
                imageView.frame = CGRectMake(UI_SCREEN_WIDTH / 8 - 13, 10, 27, 20);
            }
            //底部价格
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.maxY, subItemView.width, 20)];
            textLabel.textColor = [UIColor grayColor];
            if (idx == 1) {
                NSString *str = [NSString stringWithFormat:@"%ld", (long)[_functionArray[idx] integerValue]];
               textLabel.text = str;
            }else {
                textLabel.text = _functionArray[idx];
            }
            
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:15.0];
            [subItemView addSubview:textLabel];
            //右侧竖线
            UILabel *hLineView = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 4.0, 5, 2.0, _functionView.height - 10)];
            hLineView.backgroundColor = BACK_COLOR;
            [subItemView addSubview:hLineView];
            
            //手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoAccount:)];
            
            [subItemView addGestureRecognizer:tap];
            UIView *singleTapView = [tap view];
            singleTapView.tag = idx;

        }];
    }
    
    return _functionView;
}
//最下面的collectionview
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView)
    {
        NSInteger countPerRow = 3;
        CGFloat interval = 0;
        CGFloat itemWidth = (UI_SCREEN_WIDTH - interval) / (countPerRow * 1.0);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        flowLayout.minimumLineSpacing = interval / 2.0;
        flowLayout.minimumInteritemSpacing = interval / 2.0;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.functionView.maxY + 10, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - self.functionView.maxY - interval / 2.0-49 - 10) collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MyinfoCellStr];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
    }
    
    return _mainCollectionView;
}

@end
