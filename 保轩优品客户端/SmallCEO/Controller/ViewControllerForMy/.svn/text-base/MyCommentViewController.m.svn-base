//
//  MyCommentViewController.m
//  SmallCEO
//
//  Created by nixingfu on 16/3/14.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "MyCommentViewController.h"
#import "SelctTab.h"
#import "ReViewCommentCell.h"
#import "ReviewUncommentCell.h"
#import "ArgueViewController.h"

#define LENGTH 10
@interface MyCommentViewController ()<UITableViewDataSource, UITableViewDelegate,MJRefreshBaseViewDelegate,UncommentDelegate>{
    UIScrollView *_scrollView;
    SelctTab     *_tapView;
    UIView       *_noDatasView;
    NSInteger    _scrollIndex;
    UILabel      *circyView;
    
}
@property (strong, nonatomic)  MJRefreshHeaderView *header;
@property (strong, nonatomic)  MJRefreshFooterView *footer;
@property (strong, nonatomic)  UITableView *commentTableView;
@property (strong, nonatomic)  UITableView *unCommentTableView;
@property (nonatomic ,strong)  NSMutableArray *commentArray;
@property (nonatomic ,strong)  NSMutableArray *unCommentArray;
@property (assign, nonatomic)  NSInteger curPage;


@end

@implementation MyCommentViewController


- (void)dealloc
{
    [_header free];
    [_footer free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的点评";
    self.view.backgroundColor = WHITE_COLOR;
    
    self.curPage = 1;
    _scrollIndex = 0;
    _commentArray = [[NSMutableArray alloc] init];
    _unCommentArray= [[NSMutableArray alloc] init];
    
    _tapView = [[SelctTab alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50.0)];
    _tapView.backgroundColor = [UIColor whiteColor];
    _tapView.titleArray = @[@"已点评",@"未点评"];
    
    __block MyCommentViewController* vc = self;
    [_tapView setTopTapSelectBlock:^(NSInteger index, NSString *titleStr) {
        [vc topSelext:index title:titleStr];
    }];
    [self.view addSubview:_tapView];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50.0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-50-64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(2*self.view.frame.size.width, 0);
    [self.view addSubview:_scrollView];
    
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _commentTableView.backgroundColor = [UIColor whiteColor];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.separatorStyle = NO;
    [_scrollView addSubview:_commentTableView];
    
    _unCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _unCommentTableView.delegate = self;
    _unCommentTableView.dataSource = self;
    _unCommentTableView.separatorStyle = NO;
    _unCommentTableView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_unCommentTableView];
    
    _header = [[MJRefreshHeaderView alloc] init];
    _header.scrollView = _commentTableView;
    _header.delegate = self;
    
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.scrollView = _commentTableView;
    _footer.delegate = self;
    
    _noDatasView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-50-64)];
    _noDatasView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noDatasView];
    UIImageView *nodataImg = [[UIImageView alloc] initWithFrame:CGRectMake((_noDatasView.frame.size.width-383.0/2.0)/2.0, (_noDatasView.frame.size.height-388.0/2.0)/2.0, 383.0/2.0, 388.0/2.0)];
    nodataImg.image = [UIImage imageNamed:@"kongbai_null.png"];
    [_noDatasView addSubview:nodataImg];
    _noDatasView.hidden = YES;
    
    circyView = [[UILabel alloc]initWithFrame:CGRectMake(270*adapterFactor, 25/2.0, 50.0, 25.0)];
    circyView.backgroundColor = [UIColor clearColor];
    circyView.text = @"";
    circyView.textColor=[UIColor redColor];
    [self.view addSubview:circyView];
    
    //    [self loadCommentData];
}
-(void)topSelext:(NSInteger)index title:(NSString *)titleStr{
    
    _noDatasView.hidden = YES;
    self.curPage = 1;
    _scrollIndex = index;
    if (index==0) {
        //请求点评数据
        [self refresh:_commentTableView];
        [self loadCommentData];
        
    } else {
        //请求未点评数据
        [self refresh:_unCommentTableView];
        [self loadUnCommentData];
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(index * self.view.frame.size.width, 0);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    _noDatasView.hidden = YES;
    self.curPage = 1;
    if (_scrollIndex==0) {
        //请求点评数据
        [self refresh:_commentTableView];
        [self loadCommentData];
        
    } else {
        //请求未点评数据
        [self refresh:_unCommentTableView];
        [self loadUnCommentData];
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollIndex * self.view.frame.size.width, 0);
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        if (index == _scrollIndex) {
            return;
        }
        _scrollIndex = index;
        [_tapView btnSelectIndexInSelctTab:index];
        self.curPage = 1;
        if (index==0) {
            [self refresh:_commentTableView];
            [self loadCommentData];
        } else {
            [self refresh:_unCommentTableView];
            [self loadUnCommentData];
        }
    }
}
#pragma mark - MJRefresh
- (void)refresh:(UITableView *)tempView
{
    self.header.scrollView=tempView;
    self.footer.scrollView=tempView;
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (refreshView == _header) {
        self.curPage = 1;
        if (_scrollIndex == 0) {
            [self loadCommentData];
            
        }else {
            [self loadUnCommentData];
            
        }
    }else {
        self.curPage ++;
        if (_scrollIndex == 0) {
            [self loadCommentData];
            
        }else {
            [self loadUnCommentData];
        }
    }
}

-(void)loadCommentData{
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"comment.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:
                                [NSURL URLWithString:url]];
    NSString *body = [NSString stringWithFormat:@"type=getComment&p=%ld",(long)self.curPage];
    DLog(@"dody:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject: %@", responseObject);
        NSDictionary* item = (NSDictionary *)responseObject;
        NSInteger uncomment_num=[[item objectForKey:@"uncomment_num"] integerValue];
        if (uncomment_num>0) {
            circyView.text = [NSString stringWithFormat:@"%ld",(long)uncomment_num];
        }else {
            circyView.text = @"";
        }
        if (self.curPage == 1) {
            [_commentArray removeAllObjects];
        }
        if ([[responseObject objectForKey:@"content"]count]>0){
            
            [_commentArray addObjectsFromArray: [responseObject objectForKey:@"content"]];
        }
        if (_commentArray.count <= 0) {
            _noDatasView.hidden = NO;
        }
        [_commentTableView reloadData];
        [SVProgressHUD dismiss];
        [_header endRefreshing];
        [_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@",operation.responseString);
        if (operation.response.statusCode != 200) {
            [SVProgressHUD dismissWithError:@"网络错误"];
        }
        [SVProgressHUD dismiss];
        [_header endRefreshing];
        [_footer endRefreshing];
    }];
    [op start];
}

-(void)loadUnCommentData {
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"comment.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:
                                [NSURL URLWithString:url]];
    NSString *body = [NSString stringWithFormat:@"type=getUncomment&p=%ld",(long)self.curPage];
    DLog(@"dody:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject: %@", responseObject);
        NSInteger uncomment_num=[[responseObject objectForKey:@"uncomment_num"] integerValue];
        if (uncomment_num>0) {
            circyView.text = [NSString stringWithFormat:@"%ld",(long)uncomment_num];
        }else {
            circyView.text = @"";
        }
        if (self.curPage == 1) {
            [_unCommentArray removeAllObjects];
        }
        if ([[responseObject objectForKey:@"content"]count]>0){
            
            [_unCommentArray addObjectsFromArray: [responseObject objectForKey:@"content"]];
        }
        if (_unCommentArray.count <= 0) {
            _noDatasView.hidden = NO;
        }
        [_unCommentTableView reloadData];
        [SVProgressHUD dismiss];
        [_header endRefreshing];
        [_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error:%@",operation.responseString);
        if (operation.response.statusCode != 200) {
            [SVProgressHUD showErrorWithStatus:@"网络错误" duration:1.0f];
        }
        [_header endRefreshing];
        [_footer endRefreshing];
    }];
    [op start];
}
#pragma - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_commentTableView) {
        return [_commentArray count];
    }else if(tableView==_unCommentTableView){
        return [_unCommentArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView) {
        NSArray *list = [[_commentArray[indexPath.row] objectForKey:@"commentdetail"] objectForKey:@"list"];
        if ([list isKindOfClass:[NSArray class]] && list.count >= 1) {
            NSDictionary *starDic = [list objectAtIndex:0];
            
            NSString *connectStr = [NSString stringWithFormat:@"%@",[starDic objectForKey:@"comment_content"]];
            CGRect rect = [connectStr boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
            CGFloat height = rect.size.height >= 20 ?rect.size.height:20;
            
            return height+120;
        }else{
            return 140;
        }
        
    }else if(tableView==_unCommentTableView){
        return 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView) {
        ReViewCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (cell == nil) {
            cell = [[ReViewCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell setViewDit:[_commentArray objectAtIndex:indexPath.row]];
        return cell;
    }else{
        ReviewUncommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uncomment"];
        if (cell == nil) {
            cell = [[ReviewUncommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"uncomment"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.cellTableView = tableView;
            cell.delegate = self;
        }
        cell.indexPath = indexPath;
        [cell setViewDit:[_unCommentArray objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;
}
//评价按钮点击事件
-(void)UncommentBtnIndex:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ArgueViewController * vc = [[ArgueViewController alloc] init];
    vc.orderID = [_unCommentArray[indexPath.row] objectForKey:@"order_id"];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    [arr addObject:_unCommentArray[indexPath.row]];
    NSDictionary *dataDic = @{@"goodsinfo":arr};
    vc.dataDic = dataDic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
