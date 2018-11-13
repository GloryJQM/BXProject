//
//  MyGoodsSearchViewController.m
//  SmallCEO
//
//  Created by nixingfu on 16/1/11.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "MyGoodsSearchViewController.h"
#import "NavSearchBar.h"
#import "MyGoodsCell.h"
#import "MyGoodStatisticsViewController.h"
#import "FielMangerViewController.h"

@interface MyGoodsSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate> {
    NSMutableArray *resultDataSource;
    NSInteger curSelectEditIndex;
    NSInteger xiaJiaSelectEditIndex;
    NSInteger cancleSelectEditIndex;
    NSIndexPath * xiaJiaPath;
    NSString * price;
    NSString * low;
    NSString * high;
    UIView *noDataView;
}
@property (nonatomic, strong)UILabel * nowLabel;
@property (nonatomic, strong) UILabel * orginLabel;
@property (nonatomic, strong) UILabel * vi;
@property (nonatomic, strong)UIView * areaView;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong) UITextField *sellPriceTextFiled;
@property (nonatomic,strong) NavSearchBar *searchBar;
@property (nonatomic,strong) UITableView *selectTableV;
@property (nonatomic,strong) UITableView *resultTableView;
@property (nonatomic,strong) MJRefreshHeaderView* headView;
@property (nonatomic,strong) MJRefreshFooterView* footView;
@property (nonatomic,assign) int curPage;
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, assign) BOOL isClickKey;

@end


@implementation MyGoodsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    
    self.view.backgroundColor=[UIColor whiteColor];
    resultDataSource=[[NSMutableArray alloc] initWithCapacity:0];
    [self addObserver:self forKeyPath:@"nowLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    
    self.searchBar=[[NavSearchBar alloc] initWithFrame:CGRectMake(-10, 7, UI_SCREEN_WIDTH-2*50, 30)];
    self.searchBar.delegate=self;
    
    UIView *temp=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    temp.backgroundColor=[UIColor clearColor];
    [temp addSubview:self.searchBar];
    
    self.navigationItem.titleView=temp;
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[[UIImage imageNamed:@"icon-sousuo@2x"] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    self.resultTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    self.resultTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.resultTableView.delegate=self;
    self.resultTableView.dataSource=self;
    self.resultTableView.backgroundColor=MONEY_COLOR;
    self.resultTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.resultTableView];
    
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=self.resultTableView;
    self.headView.delegate=self;
    
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=self.resultTableView;
    self.footView.delegate=self;

    [self.searchBar becomeFirstResponder];
    
    noDataView = [[UIView alloc] initWithFrame:self.resultTableView.bounds];
    [self.resultTableView addSubview:noDataView];
    noDataView.hidden = YES;
    
    UIImageView *imgVi = [[UIImageView alloc] init];
    imgVi.frame = CGRectMake(UI_SCREEN_WIDTH/2-90/2+IPHONE4HEIGHT(5), 135-IPHONE4HEIGHT(40), 90-IPHONE4HEIGHT(10), 90-IPHONE4HEIGHT(10));
    imgVi.image = [UIImage imageNamed:@"gj_tanhao.png"];
    [noDataView addSubview:imgVi];
    
    UILabel * noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无产品";
    noDataWarningLabel.textColor = DETAILS_COLOR;
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:14.0f];
    [noDataView addSubview:noDataWarningLabel];
    
    [self key];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.searchBar resignFirstResponder];
}
#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"nowLabel.text"])
    {
        self.sellPriceTextFiled.text = self.nowLabel.text;
    }
}
-(void)rightBtnClick{
    [self postGoodsWithCatID:self.searchBar.text];
    self.curPage = 1;
    [self.searchBar resignFirstResponder];
}
-(void)dealloc
{
    [self.headView free];
    [self.footView free];
    [self removeObserver:self forKeyPath:@"nowLabel.text"];
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        self.curPage=1;
        [self postGoodsWithCatID:self.searchBar.text];
    }else
    {
        self.curPage++;
        [self postGoodsWithCatID:self.searchBar.text];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self postGoodsWithCatID:searchBar.text];
    self.curPage = 1;
    [self.searchBar resignFirstResponder];
}
-(void)missKeyBoard{
    [self.searchBar resignFirstResponder];
}
#pragma mark - key
- (void)key
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 313)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    UIView * fiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 96)];
    
    fiView.backgroundColor = MONEY_COLOR;
    [_areaView addSubview:fiView];
    
    
    UILabel * teLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 14, UI_SCREEN_WIDTH / 5, 20)];
    teLabel.text = @"售价 ￥";
    teLabel.font = [UIFont systemFontOfSize:14];
    
    NSString* thStr = teLabel.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"CECECE"] range:NSMakeRange(3,thStr.length-3)];
    
    teLabel.attributedText = str;
    
    [fiView addSubview:teLabel];
    
    self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(18 + UI_SCREEN_WIDTH / 5, 14, UI_SCREEN_WIDTH / 4, 20)];
    
    _nowLabel.text = @"0.00";
    _nowLabel.font = [UIFont systemFontOfSize:14];
    
    self.sellPriceTextFiled = [[UITextField alloc] initWithFrame:self.nowLabel.frame];
    self.sellPriceTextFiled.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [fiView addSubview:self.sellPriceTextFiled];
    self.sellPriceTextFiled.hideStatus = @"1";
    
    self.orginLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2, 14, UI_SCREEN_WIDTH / 2 - 18, 20)];
    _orginLabel.text = @"参考价 ￥4600";
    _orginLabel.font = [UIFont systemFontOfSize:13];
    _orginLabel.textColor = [UIColor colorFromHexCode:@"9595A2"];
    _orginLabel.textAlignment = NSTextAlignmentRight;
    [fiView addSubview:_orginLabel];
    
    
    UIView * keyLine1 = [[UIView alloc] initWithFrame:CGRectMake(18, 96 / 2, UI_SCREEN_WIDTH - 18, 1)];
    keyLine1.backgroundColor = LINE_SHALLOW_COLOR;
    [fiView addSubview:keyLine1];
    
    self.vi = [[UILabel alloc] initWithFrame:CGRectMake(18, 64, UI_SCREEN_WIDTH, 44 - 25)];
    _vi.text = @"价格可调节范围: 4400 - 4700";
    _vi.font = [UIFont systemFontOfSize:13];
    _vi.textColor = [UIColor colorFromHexCode:@"9595A2"];
    [fiView addSubview:_vi];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 96, UI_SCREEN_WIDTH, 1)];
    line1.backgroundColor = LINE_SHALLOW_COLOR;
    [fiView addSubview:line1];
    
    for (int i = 0; i < 9; i++) {
        
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        UIButton * btn = [[UIButton alloc] initWithFrame: CGRectMake(index * (UI_SCREEN_WIDTH / 3 - 82 / 3), page * (217 / 4) + 97, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4) ];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:21];
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i;
        btn.backgroundColor = [UIColor whiteColor];
        [_areaView addSubview:btn];
        
        
    }
    
    for (int i = 1; i < 4; i++) {
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 3 - 82 / 3) *(i),  97, 1, 313 - 97)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0,  217 / 4 * i + 97, UI_SCREEN_WIDTH - 82, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
    }
    
    UIView * keyLine3 = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 83, 97, 1, 313  - 97)];
    keyLine3.backgroundColor = LINE_SHALLOW_COLOR;
    
    UIButton * dianbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dianbtn.frame = CGRectMake(0, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 81 / 3, 217 / 4);
    [dianbtn setTitle:@"." forState:UIControlStateNormal];
    [dianbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    dianbtn.titleLabel.font = [UIFont systemFontOfSize:21];
    
    [dianbtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:dianbtn];
    
    
    UIButton * zerobtn = [UIButton buttonWithType:UIButtonTypeSystem];
    zerobtn.frame = CGRectMake(UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4);
    [zerobtn setTitle:[NSString stringWithFormat:@"%d", 0] forState:UIControlStateNormal];
    [zerobtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    zerobtn.titleLabel.font = [UIFont systemFontOfSize:21];
    [zerobtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:zerobtn];
    
    UIButton * hiderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hiderBtn.frame = CGRectMake((UI_SCREEN_WIDTH / 3 - 82 / 3) * 2, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4);
    [hiderBtn setImage:[UIImage imageNamed:@"s_key.png"] forState:UIControlStateNormal];
    [hiderBtn addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:hiderBtn];
    
    
    UIButton * quxiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaobtn.frame = CGRectMake(UI_SCREEN_WIDTH - 82, 97, 82, 313 / 2 - 97 / 2);
    [quxiaobtn setTitle:@"a" forState:UIControlStateNormal];
    [quxiaobtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [quxiaobtn setImage:[UIImage imageNamed:@"backspace.png"] forState:UIControlStateNormal];
    [_areaView addSubview:quxiaobtn];
    
    UIButton * quedingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    quedingBtn.frame = CGRectMake(UI_SCREEN_WIDTH - 82, 313 / 2 - 97 / 2 + 97, 82, 313 / 2 - 97 / 2);
    [quedingBtn addTarget:self action:@selector( queding:) forControlEvents:UIControlEventTouchUpInside];
    [quedingBtn setTitle:@"确定" forState:UIControlStateNormal];
    quedingBtn.backgroundColor = [UIColor colorFromHexCode:@"0d85ff"];
    [quedingBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [_areaView addSubview:quedingBtn];
}

- (void)huoqu:(UIButton *)sender
{
    if (self.isClickKey == NO) {
        _isClickKey = YES;
        _nowLabel.text = sender.currentTitle;
        
        if ([sender.currentTitle isEqualToString:@"a"]) {
            
            _nowLabel.text = @"";
        }else{
            _nowLabel.text = sender.currentTitle;
        }
    }else{
        [self changeTextFieldContent:sender.currentTitle];
    }
}

- (void)changeTextFieldContent:(NSString *)titleStr
{
    if ([titleStr isEqualToString:@""]) {
        
        //        [self.textField resignFirstResponder];
    }else if ([self.nowLabel.text isEqualToString:@"0.00"]) {
        
        self.nowLabel.text = 0;
        
    }else if([titleStr isEqualToString:@"a"]) {
        //如果文本框中有内容则 删除最后一个文本框中的最后一个字符
        if (self.nowLabel.text.length > 0) {
            //先获取文本框中的内容
            NSMutableString * mutableStr = [NSMutableString stringWithString: self.nowLabel.text];
            //将文本框中 的内容移除最后一个字符
            [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
            NSLog(@"%@", titleStr);
            self.nowLabel.text = mutableStr;
        }
    } else {
        NSString * newStr = [NSString stringWithFormat:@"%@%@", self.nowLabel.text, titleStr];
        NSLog(@"%@", titleStr);
        self.nowLabel.text = newStr;
    }
}

- (void)queding:(UIButton *)btn
{
    if ([_nowLabel.text floatValue] >= [low floatValue] && [_nowLabel.text floatValue] <= [high floatValue]) {
        
        UIAlertView * lert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定修改售价" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        lert.tag = 2000;
        [lert show];
        [self postPrice:btn];
    }else{
        
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title  message:@"您输入不在范围内, 请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
    
    self.isClickKey = NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 2000) {
        [self hidePickerView];
        
        [self postGoodsWithCatID:self.searchBar.text];
    }
    if (buttonIndex == 1 && alertView.tag == 5000) {
        [self postXiaJia];
    }
    if (buttonIndex == 1 && alertView.tag == 5001) {
        [self postShangJia];
    }
    
    if (buttonIndex == 1 && alertView.tag == 5002) {
        [self postCancle];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return resultDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [NSString stringWithFormat:@"%@",[[resultDataSource objectAtIndex:indexPath.row] objectForKey:@"subject"]];
    CGFloat hightForTitle = [self getLengthWithStr:title];
    return 128 + hightForTitle;
}
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 96, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return ceilf(rect.size.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellIndentifier = @"cell";
    MyGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[MyGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fiel.tag = indexPath.row;
    
    [cell.fiel addTarget:self action:@selector(fielManger:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.jiage.tag = indexPath.row;
    [cell.jiage addTarget:self action:@selector(popPickerView:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell updateWith:[resultDataSource objectAtIndex:indexPath.row]];
    cell.xiaJiaBtn.tag = indexPath.row;
    [cell.xiaJiaBtn addTarget:self action:@selector(xiaJia:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.cancelBtn.tag =  indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.StatisticsBtn.tag = indexPath.row;
    [cell.StatisticsBtn addTarget:self action:@selector(Statistics:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}
#pragma mark - 弹出和消失
- (void)popPickerView:(UIButton *)sender
{
    [self.searchBar resignFirstResponder];
    
    [self.sellPriceTextFiled becomeFirstResponder];
    curSelectEditIndex=sender.tag;
    
    price = [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"price"];
    
    low = [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"lowprice"];
    
    high = [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"powprice"];
    
    _nowLabel.text = [NSString stringWithFormat:@"%@", [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"price"]];
    self.sellPriceTextFiled.text = _nowLabel.text;
    _vi.text =[NSString stringWithFormat:@"价格可调节范围:%@ - %@" ,[[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"lowprice"], [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"powprice"]];
    _orginLabel.text = [NSString stringWithFormat:@"参考价 ￥%@", [[resultDataSource objectAtIndex:sender.tag] objectForKey:@"F_Price"]];
    
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.backView.backgroundColor=[UIColor colorFromHexCode:@"000000" alpha:0.7];
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.backView];
    [window addSubview:self.areaView];
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 313, UI_SCREEN_WIDTH, 313);
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    [self.sellPriceTextFiled resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 313);
    [UIView commitAnimations];
    
    [self performSelector:@selector(back) withObject:nil afterDelay:0.3];
    
}
- (void)back
{
    self.backView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
}

- (void)fielManger:(UIButton *)sender
{
    FielMangerViewController * vc = [[FielMangerViewController alloc] init];
    vc.flag = 1;
    vc.aID = [[resultDataSource objectAtIndex:sender.tag] objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)xiaJia:(UIButton *)sender
{
    
    xiaJiaPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    xiaJiaSelectEditIndex = sender.tag;
    MyGoodsCell * cell = (MyGoodsCell *)[self.resultTableView cellForRowAtIndexPath:xiaJiaPath];
    if ([cell.xiaJiaBtn.titleLabel.text isEqualToString:@"点击下架"]) {
        
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定下架" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 5000;
        [alert show];
    }else
    {
        
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title  message:@"确定上架" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert1.tag = 5001;
        [alert1 show];
    }
}
#pragma mark - http
-(void)postXiaJia
{
    if(xiaJiaSelectEditIndex>=resultDataSource.count){
        return;
    }
    
    NSString * strID = [[resultDataSource objectAtIndex:xiaJiaSelectEditIndex] objectForKey:@"id"];
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"id=%@&type=1",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            self.curPage=1;
            [self postGoodsWithCatID:self.searchBar.text];

        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}
-(void)postPrice:(UIButton *)sender
{
    if(sender.tag>=resultDataSource.count){
        return;
    }
    
    NSString * strID = [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"id"];
    
    NSString * strAID = [[resultDataSource objectAtIndex:curSelectEditIndex] objectForKey:@"aid"];
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"price=%@&id=%@&aid=%@", _nowLabel.text, strID, strAID];
    
    NSString *str=MOBILE_SERVER_URL(@"editprice.php");
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}


-(void)postGoodsWithCatID:(NSString *)searchText
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"p=%d&catid=0&subject=%@", self.curPage, searchText];
    NSString *str=MOBILE_SERVER_URL(@"myproductlist.php");
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            if(self.curPage == 1)
            {
                [resultDataSource removeAllObjects];
            }
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"content"];
            
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                [resultDataSource addObjectsFromArray:tempArray];
                if (resultDataSource.count == 0) {                    
                    noDataView.hidden = NO;
                }else {
                    noDataView.hidden = YES;
                }
            }
            [self.resultTableView reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
    
}

-(void)postShangJia
{
    if(xiaJiaSelectEditIndex>=resultDataSource.count){
        return;
    }
    
    NSString * strID = [[resultDataSource objectAtIndex:xiaJiaSelectEditIndex] objectForKey:@"id"];
    
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"id=%@&type=3",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            self.curPage=1;
            [self postGoodsWithCatID:self.searchBar.text];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

- (void)cancel:(UIButton *)btn
{
    cancleSelectEditIndex = btn.tag;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定删除" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 5002;
    [alert show];
}
- (void)Statistics:(UIButton *)sender
{
    MyGoodStatisticsViewController *vc = [MyGoodStatisticsViewController new];
    vc.goodsID = [NSString stringWithFormat:@"%@",[[resultDataSource objectAtIndex:sender.tag] objectForKey:@"id"]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)postCancle {
    if(cancleSelectEditIndex>=resultDataSource.count){
        return;
    }
    
    NSString * strID = [[resultDataSource objectAtIndex:cancleSelectEditIndex] objectForKey:@"id"];
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"&id=%@&type=2",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismissWithSuccess:@"删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.curPage=1;
                [self postGoodsWithCatID:self.searchBar.text];
            });
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}
@end
