//
//  BankCardManageViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankCardDetailsViewController.h"
#import "BankCardManageViewController.h"
#import "BankCardManagerTableViewCell.h"
#import "BindBankCardViewController.h"
#import "BindAlipayAccountViewController.h"
extern const CGFloat bankCardManagerCellHeight;

@interface BankCardManageViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIButton * addBankBtn;
    UIButton * xiuGaiBtn;
    UIImageView * zhiFuBaoLogo;
    UIView *moveView;
    int currtIndex;
}
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, copy)   NSMutableArray *bankCardArray;
@property (nonatomic, copy)   NSDictionary   *bankCardInfoDic;
@property (nonatomic, strong) UIView         *emptyInfoView;
@property (nonatomic, strong) UIView         *emptyAliInfoView;

@property (nonatomic, strong)UIScrollView * mainView;

@property (nonatomic, strong)UIView  * topView;
@property (nonatomic, strong)NSMutableArray * buttonArray;
@property (nonatomic, strong)UIView * zhiFuBaoBackView;

@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation BankCardManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提现方式管理";
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    [self createMainView];

    if (self.payType == 2) {
        UIButton * btn = (UIButton *)[self.topView viewWithTag:3001];
        [self movie:btn];
    }
}
#pragma mark - 顶部选项卡
- (void)topButton:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(UI_SCREEN_WIDTH / array.count * i, 0, UI_SCREEN_WIDTH / array.count, 35);
        btn.backgroundColor = WHITE_COLOR;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = LMJ_CT 15];
        [btn addTarget:self action:@selector(movie:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 3000 + i;
        [self.topView addSubview:btn];
        
        [self.buttonArray addObject:btn];
        
        if (i == 0) {
            [btn setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];//初始化时默认选中的按钮的颜色
            btn.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
            currtIndex = (int)btn.tag;
        }else {
            [btn setTitleColor:[UIColor colorFromHexCode:@"252525"] forState:UIControlStateNormal];//其余按钮的颜色
        }
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,  35, UI_SCREEN_WIDTH, 2)];
    line.backgroundColor = [UIColor colorFromHexCode:@"cecece"];
    [self.topView addSubview:line];
    
    moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/2.0, 2)];
    moveView.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    [line addSubview:moveView];
    
    
    
}

- (void)movie:(UIButton *)sender
{
    
    [sender setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];//被点击的按钮要改变的颜色
    for (UIButton * button in self.buttonArray) {
        if (![sender isEqual:button]) {
            [button setTitleColor:[UIColor colorFromHexCode:@"252525"] forState:UIControlStateNormal];//其余按钮要改变到的颜色
            button.backgroundColor = WHITE_COLOR;
        }
    }
    
    moveView.frame = CGRectMake((sender.tag-3000)*UI_SCREEN_WIDTH/2.0, 0, UI_SCREEN_WIDTH/2.0, 2);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.mainView setContentOffset:CGPointMake(UI_SCREEN_WIDTH * (sender.tag - 3000), 0) animated:YES];
    }];
    
    if (sender.tag == 3000) {
        
        addBankBtn.hidden = NO;
    }else{
        addBankBtn.hidden = YES;
        [self getAliPayAccountData];
    }
    currtIndex = (int)sender.tag;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMyBankCardInfo];
    [self getAliPayAccountData];
}
- (void)createZhiFuBaoView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 70.0)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.zhiFuBaoBackView addSubview:mainView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    zhiFuBaoLogo = imageView;
   
    [mainView addSubview:imageView];
    
    UILabel *cardNumLabel = [[UILabel alloc] init];
    cardNumLabel.text = [NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"card"]];
    cardNumLabel.frame = CGRectMake(15 + CGRectGetMaxX(imageView.frame), 25, 200, 20);
    [mainView addSubview:cardNumLabel];
    self.accountLabel = cardNumLabel;
    
    UIView *userNameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mainView.frame) + 10, UI_SCREEN_WIDTH, 50)];
    UILabel *cardHolderLabel = [[UILabel alloc] init];
    cardHolderLabel.text = @"姓名";
    CGSize sizeForCardHolderLabel = [cardHolderLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 30)];
    cardHolderLabel.frame = CGRectMake(15, 10, sizeForCardHolderLabel.width, 30);
    [userNameView addSubview:cardHolderLabel];
    
    UILabel *cardHolderNameLabel = [[UILabel alloc] init];
    cardHolderNameLabel.text = [NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"name"]];
    cardHolderNameLabel.frame = CGRectMake(20 + CGRectGetMaxX(cardHolderLabel.frame), 10, 200, 30);
    [userNameView addSubview:cardHolderNameLabel];
    self.nameLabel = cardHolderNameLabel;
    
    userNameView.backgroundColor = [UIColor whiteColor];
    [self.zhiFuBaoBackView addSubview:userNameView];
    
    self.zhiFuBaoBackView.hidden = YES;

    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-37-69, UI_SCREEN_WIDTH, 44+25)];
    whiteView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.mainView addSubview:whiteView];
    
    xiuGaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiuGaiBtn.frame = CGRectMake(15, 10, UI_SCREEN_WIDTH-30, 44);
    [xiuGaiBtn setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
    xiuGaiBtn.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    xiuGaiBtn.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    xiuGaiBtn.layer.borderWidth = 1;
    [xiuGaiBtn setTitle:@"修改" forState:UIControlStateNormal];
    [xiuGaiBtn addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:xiuGaiBtn];
    
    
    self.emptyAliInfoView = [[UIView alloc] initWithFrame:self.zhiFuBaoBackView.frame];
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, UI_SCREEN_WIDTH, 20)];
    warningLabel.text = @"暂未绑定支付宝";
    warningLabel.textAlignment = NSTextAlignmentCenter;
    [self.emptyAliInfoView addSubview:warningLabel];
    [self.mainView addSubview:self.emptyAliInfoView];

}
#pragma mark - 按钮点击方法
- (void)editButtonClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"绑定支付宝"]) {
        BindAlipayAccountViewController *bindAlipayAccountVC = [[BindAlipayAccountViewController alloc] init];
        bindAlipayAccountVC.type = BindAlipayVCTypeAdd;
        [self.navigationController pushViewController:bindAlipayAccountVC animated:YES];
    }else {
        BindAlipayAccountViewController *bindAlipayAccountVC = [[BindAlipayAccountViewController alloc] init];
        bindAlipayAccountVC.type = BindAlipayVCTypeModify;
        bindAlipayAccountVC.oldInfoDic = self.accountInfoDic;
        bindAlipayAccountVC.successBlock = ^(NSDictionary *dic) {
            self.accountLabel.text = [dic objectForKey:@"card"];
            self.nameLabel.text = [dic objectForKey:@"name"];
        };
        [self.navigationController pushViewController:bindAlipayAccountVC animated:YES];
    }
}

- (void)getAliPayAccountData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"zhifubao.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"type=1"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               [SVProgressHUD dismiss];
                               if ([returnState isEqualToString:@"0"])
                               {
                                   [xiuGaiBtn setTitle:@"绑定支付宝" forState:UIControlStateNormal];
                                   self.zhiFuBaoBackView.hidden = YES;
                               }
                               else
                               {
                                   [xiuGaiBtn setTitle:@"修改" forState:UIControlStateNormal];
                                   self.zhiFuBaoBackView.hidden = NO;

                                   self.emptyAliInfoView.hidden = YES;
                                   self.accountInfoDic = [responseObject objectForKey:@"content"];
                                   self.accountLabel.text =[NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"card"]];
                                   self.nameLabel.text =[NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"name"]];
                                  
                                   [zhiFuBaoLogo af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"picurl"]]]];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

- (void)createMainView
{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 37)];
    self.topView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.topView];

    NSArray * topTitleArray = @[@"管理银行卡",@"管理支付宝"];
    [self topButton:topTitleArray];
    
    
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 37, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-37-64)];
    _mainView.contentSize   = CGSizeMake(UI_SCREEN_WIDTH*topTitleArray.count, UI_SCREEN_HEIGHT-37-64);
    _mainView.userInteractionEnabled =YES;
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.tag = 10086;
    _mainView.alwaysBounceHorizontal = NO;
    _mainView.alwaysBounceVertical = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.mainView];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar-37-69)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _tableView.backgroundColor = WHITE_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:self.tableView];
    
    addBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankBtn.frame = CGRectMake(15, UI_SCREEN_HEIGHT-37-64-59, UI_SCREEN_WIDTH-30, 44);
    [addBankBtn setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
    addBankBtn.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
    addBankBtn.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
    addBankBtn.layer.borderWidth = 1;
    [addBankBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBankBtn addTarget:self action:@selector(addBankCard) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:addBankBtn];
    
    
    self.zhiFuBaoBackView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-37-64-69)];
    _zhiFuBaoBackView.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self.mainView addSubview:_zhiFuBaoBackView];
    [self createZhiFuBaoView];
    
    self.emptyInfoView = [[UIView alloc] initWithFrame:self.tableView.frame];
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, UI_SCREEN_WIDTH, 20)];
    warningLabel.text = @"暂未绑定银行卡";
    warningLabel.textAlignment = NSTextAlignmentCenter;
    [self.emptyInfoView addSubview:warningLabel];
    self.emptyInfoView.hidden = YES;
    [self.mainView addSubview:self.emptyInfoView];
}



#pragma mark - 获取银行卡信息
- (void)getMyBankCardInfo
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"user_tixian.php");
    NSString *bodyStr = [NSString stringWithFormat:@"act=status"];
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithError:@"网络错误"];
                               }
                               
                               _bankCardInfoDic = responseObject;
                               _bankCardArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"bank_list"]];
                               self.emptyInfoView.hidden = _bankCardArray.count != 0;
                               
                               [self.tableView reloadData];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

#pragma mark - 按钮点击方法
- (void)addBankCard
{
    BindBankCardViewController *bindBankCardVC = [[BindBankCardViewController alloc] init];
    bindBankCardVC.addBankCardBlock = ^() {
        [self getMyBankCardInfo];
    };
    [self.navigationController pushViewController:bindBankCardVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bankCardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellForBill";
    BankCardManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil)
    {
        cell = [[BankCardManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    cell.bankNameLabel.text = [NSString stringWithFormat:@"%@", [[_bankCardArray objectAtIndex:indexPath.row] objectForKey:@"bank_name"]];
    NSString *bankCardNumStr = [NSString stringWithFormat:@"%@", [[_bankCardArray objectAtIndex:indexPath.row] objectForKey:@"card"]];
    if (bankCardNumStr.length > 4)
    {
        cell.bankCardInfoLabel.text = [NSString stringWithFormat:@"尾号%@", [bankCardNumStr substringFromIndex:bankCardNumStr.length - 4]];
    }
    else
    {
        cell.bankCardInfoLabel.text = bankCardNumStr;
    }

    [cell.bankImageView af_setImageWithURL:[NSURL URLWithString:[[_bankCardArray objectAtIndex:indexPath.row] objectForKey:@"picurl"]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == BankCardManageTypeDefalut)
    {
        BankCardDetailsViewController *bankCardDetailsVC = [[BankCardDetailsViewController alloc] init];
        bankCardDetailsVC.bankCardInfoDic = [_bankCardArray objectAtIndex:indexPath.row];
        bankCardDetailsVC.deleteBankCardBlock = ^() {
            [_bankCardArray removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:bankCardDetailsVC animated:YES];
    }
    else if (self.type == BankCardManageTypeSelect &&
             self.selectBankCardBlock != nil)
    {
        self.selectBankCardBlock(_bankCardInfoDic, [_bankCardArray objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return bankCardManagerCellHeight;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 10086) {
        int index = scrollView.contentOffset.x/UI_SCREEN_WIDTH+3000;
        if (currtIndex != index) {
            UIButton * btn = (UIButton *)[self.topView viewWithTag:index];
            [self movie:btn];
        }
    }
}
@end
