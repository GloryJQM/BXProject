//
//  HomeNewViewController.m
//  WanHao
//
//  Created by Cai on 14-6-6.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "GeneralPageViewController.h"
#import "CustomTypeImageView.h"
#import "CommodityDetailViewController.h"
#import "Reachability.h"
#import "ProductDetailsViewController.h"
#import "SearchListViewController.h"
#import "SearchViewController.h"
#import "UpOrDownButton.h"
#import "TabSelectView.h"
//todo 2014-0615 设为999会引发爆机，要找下原因
#define HEAD_VIEW_TAG 9990

#define searchMoveDistance 35

@interface GeneralPageViewController () <CustomTypeImageViewDelegate, TabSelectViewDelegate>
{
    UIView   *_stopView;
    UIScrollView *buttonScr ;
    UILabel*labelName;
    BOOL        _istab_show;
    BOOL        _update_flag;
    
    UIView      *_gouwucheView;
    UILabel     *_gouwucheLab;
    
    UIView      *_pageTitleView;
    UILabel     *_pageTitleLab;
    
    NSDictionary *poster;
    NSMutableArray *customViews;
    UIView          *choseView;
    UIView              *shadowView;
    UIView              *allGoodsChoseView;
    UIView              *profitChoseView;
    UIView              *priceChoseView;
    TabSelectView       *tabBlackView;
    TabSelectView       *profitBlackView;
    TabSelectView       *priceBlackView;
    TabSelectView       *tabView;
    long                seletedIndex;
    BOOL                isOut;
    NSString            *cid;
    NSString            *act;
    NSString            *order;

}

@property (nonatomic, strong) NSString *originUrlString;
@property (nonatomic, strong) NSDictionary *goodsAllDic;
@property (nonatomic, strong) NSArray *goodsAllArray;
@property (nonatomic, copy)   NSMutableArray *timersArray;
@property (nonatomic, copy)   NSMutableArray  *itemsArray;
@property (nonatomic, assign) NSInteger allScrollViewContentOriginH;
@property(nonatomic,strong)   NSMutableArray *countdownRecord;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic,assign)int curP;
@property (nonatomic, assign) NSInteger curTabIndex;

@end


@implementation GeneralPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        _update_flag = YES;
    }
    return self;
}

- (void)dealloc
{
    [header free];
}
-(void)reloadHomeCustomView
{
    [_itemsArray removeAllObjects];
}
-(void)cityreloadHomeView
{
    [_itemsArray removeAllObjects];
    [self requestdata];
}
- (void)createChoseView {
    if (!choseView) {
        /*选项卡*/
        choseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 42)];
        choseView.backgroundColor = WHITE_COLOR_3;
        [self.view addSubview:choseView];
        
        NSArray *btnNames = @[@"全部店铺",@"会员价",@"参考利润"];
        BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
        if (!isVip) {
            btnNames = @[@"全部店铺",@"分类筛选",@"智能排序"];
        }
        CGFloat btnW = UI_SCREEN_WIDTH/3.0-2;
        for (int i = 0; i < 2; i ++) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 41.5*i, UI_SCREEN_WIDTH, 0.5)];
            line.backgroundColor = LINE_COLOR;
            [choseView addSubview:line];
            
            UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(btnW+(btnW+1)*i, 0, 1, 41)];
            line2.backgroundColor = LINE_COLOR;
            [choseView addSubview:line2];
        }
        
        for (int i = 0; i < 3; i ++) {
            UpOrDownButton  *choseBtn = [[UpOrDownButton alloc]  init];
            choseBtn.rightView.image = [UIImage imageNamed:@"down"];
            choseBtn.frame = CGRectMake(i*(btnW+1), 0.5, btnW, 41);
            choseBtn.titleLab.text = btnNames[i];
            choseBtn.backgroundColor = WHITE_COLOR_3;
            choseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            choseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [choseView addSubview:choseBtn];
            choseBtn.tag = 10086+i;
            [choseBtn addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}
- (void)createClassView {
    for (UIView *view in shadowView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in allGoodsChoseView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in tabView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in profitBlackView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in priceBlackView.subviews) {
        [view removeFromSuperview];
    }
    [shadowView removeFromSuperview];
    [allGoodsChoseView removeFromSuperview];
    [profitChoseView removeFromSuperview];
    [priceChoseView removeFromSuperview];
    [tabBlackView removeFromSuperview];
    [tabView removeFromSuperview];
    [profitBlackView removeFromSuperview];
    [priceBlackView removeFromSuperview];
    /*展开的选项卡的背景*/
    shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, -(UI_SCREEN_HEIGHT-42)-200, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-42)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.7;
    [self.view addSubview:shadowView];
    [shadowView addTarget:self action:@selector(hideChoseView) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat allH = UI_SCREEN_HEIGHT-64-choseView.maxY;
    NSArray *children = _allDataArray;
    CGFloat counH = children.count *42.0;
    if (counH<=allH) {
        allH = counH;
    }
    
    allGoodsChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH)];
    allGoodsChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:allGoodsChoseView];
    
    profitChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    profitChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:profitChoseView];
    
    priceChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, -83, UI_SCREEN_WIDTH, 83)];
    priceChoseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceChoseView];
    
    /*二级分类*/
    tabBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0f, 0, UI_SCREEN_WIDTH/2.0f, allH) isBlack:YES kinds:0];
    tabBlackView.delegate=self;
    NSDictionary *dic= self.allDataArray[0];
    [tabBlackView updateWithArr:dic[@"children"]];
    [allGoodsChoseView addSubview:tabBlackView];
    tabBlackView.hidden=NO;
    
    /*一级分类*/
    tabView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/2.0f, allH) isBlack:NO kinds:0];
    tabView.delegate=self;
    [allGoodsChoseView addSubview:tabView];
    
    /*利润二级分类*/
    profitBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    profitBlackView.delegate=self;
    [profitChoseView addSubview:profitBlackView];
    
    /*会员价二级分类*/
    priceBlackView=[[TabSelectView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 83) isBlack:YES kinds:1];
    priceBlackView.delegate=self;
    [priceChoseView addSubview:priceBlackView];
    [tabView updateWithArr:self.allDataArray];
    BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
    if (isVip) {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"会员价最高"},@{@"cat_name":@"会员价最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"参考利润最高"},@{@"cat_name":@"参考利润最低"}]];
    }else {
        [priceBlackView updateWithArr:@[@{@"cat_name":@"销量最高"},@{@"cat_name":@"销量最低"}]];
        [profitBlackView updateWithArr:@[@{@"cat_name":@"价格最高"},@{@"cat_name":@"价格最低"}]];
    }
}
#pragma mark - 筛选事件
- (void)choseBtnClick:(UpOrDownButton *)sender {
    
    //CGFloat allH = 165.0f;
    CGFloat allH = UI_SCREEN_HEIGHT-choseView.maxY-64;
    NSArray *children = _allDataArray;
    CGFloat counH = children.count *42.0;
    if (counH<=allH) {
        allH = counH;
    }
    CGFloat othH = 83.0f;
    CGFloat choseViewHight = 42;
    if (seletedIndex != 0) {
        UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
        oldBtn.rightView.image = [UIImage imageNamed:@"down.png"];
    }
    if (isOut == YES)
    {
        if ( seletedIndex == sender.tag) {
            if (sender.tag == 10086) {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                
            }else if (sender.tag == 10088) {
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                
            }else {
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                
            }
            sender.rightView.image = [UIImage imageNamed:@"down.png"];
            
            shadowView.frame = CGRectMake(0, -(UI_SCREEN_HEIGHT-choseViewHight), UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
            
            isOut = NO;
        }else {
            if (sender.tag == 10086) {
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                allGoodsChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, allH);
            }else if (sender.tag == 10088) {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                priceChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                profitChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
            }else {
                allGoodsChoseView.frame = CGRectMake(0, -allH, UI_SCREEN_WIDTH, allH);
                profitChoseView.frame = CGRectMake(0, -othH, UI_SCREEN_WIDTH, othH);
                priceChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
            }
            sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        }
    }
    else if (isOut == NO)
    {
        if (sender.tag == 10086) {
            allGoodsChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, allH);
        }else if (sender.tag == 10088) {
            profitChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
        }else {
            priceChoseView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, othH);
        }
        sender.rightView.image = [UIImage imageNamed:@"home_up.png"];
        shadowView.frame = CGRectMake(0, choseViewHight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-choseViewHight);
        isOut = YES;
    }
    
    seletedIndex = sender.tag;
    //    self.curTabIndex = 0;
}

- (void)hideChoseView {
    UpOrDownButton *oldBtn = (UpOrDownButton *)[choseView viewWithTag:seletedIndex];
    [self choseBtnClick:oldBtn];
}
//底部tab选择点击
-(void)tabView:(TabSelectView *)view clickAtIndex:(NSInteger)index{
    
    if (view==tabBlackView) {
        //进行请求
        self.curP = 1;
        NSDictionary *dic = self.allDataArray[self.curTabIndex];
        NSArray *arr = dic[@"children"];
        NSDictionary *dic1 = arr[index];
        cid = dic1[@"cid"];
        [self requestdata];
        [self hideChoseView];
    }else if (view == profitBlackView) {
        //利润分类
        self.curP=1;
        BOOL isVip = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"];
        if (isVip) {
            act = @"profit";
        }else {
            act = @"fprice";
        }
        if (index == 0) {
            order = @"desc";
        }else {
            order = @"asc";
        }
        
        if (seletedIndex != 0) {
            isOut = YES;
            [self hideChoseView];
        }
    }else if (view == priceBlackView) {
        //供货价分类
        self.curP=1;
        if (index == 0) {
            act = @"sellnum";
            order = @"desc";
        }else {
            act = @"sellnum";
            order = @"asc";
        }
        //[self doRequest:self.searchBar.text];
        if (seletedIndex != 0) {
            isOut = YES;
            [self hideChoseView];
        }
    }else{
        self.curTabIndex = index;
        NSArray *tempSubCate=[[self.allDataArray objectAtIndex:index] valueForKey:@"children"];
        if ([tempSubCate isKindOfClass:[NSArray class]]) {
            /*有二级分类*/
            if (tempSubCate.count>0) {
                tabBlackView.hidden=NO;
                [tabBlackView updateWithArr:tempSubCate];
            }
            /*无二级分类*/
            else{
                tabBlackView.hidden=YES;
                [self hideChoseView];
            }
        }else{
            tabBlackView.hidden=YES;
            [self hideChoseView];
        }
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.curP = 1;
    cid =@"1";
    seletedIndex = 0;
    isOut = NO;
    self.allDataArray = [NSMutableArray array];
    
//    [self createChoseView];
    
    _itemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    customViews =[[NSMutableArray alloc] initWithCapacity:0];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHomeCustomView) name:@"reloadhomecustom" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityreloadHomeView) name:@"cityreloadhomecustom" object:nil];

    _timersArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#eeeeee"];
    //_isLoadApp = YES;
    
    if (C_IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    
    self.allScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,UI_SCREEN_HEIGHT-64.0 )];
    self.allScrollView.delegate=self;
    self.allScrollView.backgroundColor =[UIColor whiteColor];
    //_allScrollView.contentSize = CGSizeMake(320.0, 1540.0/2.0);
    self.allScrollView.showsVerticalScrollIndicator = NO;
    self.allScrollView.tag = 3000;
    self.allScrollView.alwaysBounceVertical=YES;
    [self.view addSubview:self.allScrollView];
    
    header=[[MJRefreshHeaderView alloc] init];
    header.delegate=self;
    header.scrollView=self.allScrollView;
    
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    [_itemsArray removeAllObjects];
    [self updateAppPage];
}

-(void)updateAppPage{
    [_itemsArray removeAllObjects];
    [self requestdata];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (C_IOS7) {
        self.navigationController.navigationBar.translucent = YES;
    }
    [self requestdata];
}



-(void)setUrl:(NSString *)ursString {
    self.originUrlString = ursString;
}

- (void)requestdata {
    //测试
//     NSString *url = MOBILE_SERVER_URL(@"api/newindex_08.php");
    
    [SVProgressHUD show];
    //每次请求request的alloc会产生0.1mb的内存
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:self.originUrlString]];
    [request setHTTPMethod:@"GET"];    
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [header endRefreshing];
        [SVProgressHUD dismiss];
        id backgroundColor = [responseObject objectForKey:@"background_color"];
        if (backgroundColor != nil)
        {
            self.allScrollView.backgroundColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@", backgroundColor]];
        }
        self.goodsAllDic = responseObject;
    
        self.title=[responseObject valueForKey:@"title"];
        
        NSLog(@">>>>>>>>>>%@",self.goodsAllDic);
        
        self.goodsAllArray = [self.goodsAllDic objectForKey:@"content"];
        
        if (_itemsArray.count <= 0) {
            [self createCustomView];
        }
        else{
            [self reloaditemdatas];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
    
}
//此次页面的创建只会出现一次，之后的数据请求只刷相应数据
-(void)createCustomView
{
    
    for (int i=0; i<customViews.count; i++) {
        UIView *view=[customViews objectAtIndex:i];
        if (view!=nil) {
            [view removeFromSuperview];
        }
    }
    [customViews removeAllObjects];
    
    float curorigin_y = _pageTitleView.frame.origin.y+_pageTitleView.frame.size.height;
    
    for (int i = 0; i < _goodsAllArray.count; i++ ) {
        
        NSDictionary *tempdic = [_goodsAllArray objectAtIndex:i];
        int curtype = [[tempdic objectForKey:@"type"] intValue];
        if (curtype == 22) {
            float custom_w =[[NSString stringWithFormat:@"%@",[tempdic objectForKey:@"width"]] floatValue]/2.0*adapterFactor ;
            float custom_h =[[NSString stringWithFormat:@"%@",[tempdic objectForKey:@"height"]] floatValue]/2.0*adapterFactor ;
            CustomTypeImageView *vi22 = [[CustomTypeImageView alloc] initWithFrame:CGRectMake(0, curorigin_y, custom_w, custom_h) ContentDic:tempdic];
            vi22.backgroundColor = [UIColor clearColor];
            vi22.custypeDelegate = self;
            vi22.tag = i+1;
            [_allScrollView addSubview:vi22];
            
            
            curorigin_y += custom_h ;
            
            
            NSDictionary *itemtempdic22 = [NSDictionary dictionaryWithObjectsAndKeys:vi22,@"item",[NSString stringWithFormat:@"%d",curtype],@"type" ,[NSString stringWithFormat:@"%d",i],@"curindex",nil];
            [_itemsArray addObject:itemtempdic22];
            
            [customViews addObject:vi22];
            
        }
    }
    
    self.allScrollViewContentOriginH = curorigin_y-5;
    self.allScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.allScrollViewContentOriginH);
    
}

-(void)reloaditemdatas
{
    int timerIndex= 0;
    if (_itemsArray.count > 0) {
        for (int i = 0; i <_itemsArray.count; i++) {
            NSDictionary *itemtempdic = [[NSDictionary alloc] initWithDictionary:[_itemsArray objectAtIndex:i]];
            int type = [[itemtempdic objectForKey:@"type"] intValue];

            if (type == 22) {
                CustomTypeImageView *vi22 = (CustomTypeImageView *)[itemtempdic objectForKey:@"item"];
                [vi22 CustomTypeViewLaodDatas:[NSDictionary dictionaryWithDictionary:[_goodsAllArray objectAtIndex:[[itemtempdic objectForKey:@"curindex"] intValue]]]];
                
            }
        }
    }

    int originY=_pageTitleView.frame.origin.y+_pageTitleView.frame.size.height;
    DLog(@"yuandian坐标是%d",originY);
    for (UIView *temp in customViews) {
        CGRect rect=temp.frame;
        rect.origin.y=originY;
        temp.frame=rect;
        originY=originY+temp.frame.size.height;
    }
    
    //    NSLog(@"originY:%f  allScrollViewContentOriginH:%d",(originY-_allScrollView.frame.size.height),allScrollViewContentOriginH);
    self.allScrollViewContentOriginH=originY;
    self.allScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, originY);
}

-(void)loadProductShopDetail:(NSInteger)type shop_id:(NSInteger)shop_id aid:(NSInteger)aid {
    NSString *body = [NSString stringWithFormat:@"aid=%ld",(long)aid];
    NSString *url = MOBILE_SERVER_URL(@"productshopdetail_lemuji.php");
    [SVProgressHUD show];
    //NSString *url = MOBILE_SERVER_URL(@"api/productshopdetail.php");
    //NSString *body = [NSString stringWithFormat:@"type=%d&shop_id=%d&aid=%d",type,shop_id,aid];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"---------%@",body);
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
            [SVProgressHUD dismiss];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}

-(void)loadProductShoplist:(NSInteger)type cid:(NSInteger)cid
{
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"searchlist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"type=%d&cid=%d",type,cid];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
//        [self pushSearchViewController:cid withKeyWord:@""];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        _stopView.hidden = YES;
    }];
    [op start];
}

-(void)loadBrandProductlist:(NSInteger)type cid:(NSInteger)cid
{
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"searchlist.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"type=%d&cid=%d",type,cid];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        [self pushBrandViewController:cid withKeyWord:@""];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        _stopView.hidden = YES;
    }];
    [op start];
}



-(void)pushBrandViewController:(NSInteger)ID withKeyWord:(NSString *)keyword{
    
//    LMJBrandListViewController *vc = [[LMJBrandListViewController alloc] init];
//    vc.title = @"品牌";
//    [vc searchListMin:0 end:LENGTH cat_id:ID keyword:keyword pro_type:1 hot:1 price:@"" withRefreshType:@""];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)cheackUrl:(NSString *)url{
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



-(void)gotoGoodsList:(int)type linkvale:(NSString *)lValue title:(NSString *)keyword
{
    if (type == 1) {
        //html网页
        if (lValue.length > 0 && lValue != nil) {
            [self cheackUrl:lValue];
        }
    }

    else if (type == 3) {
        //商品详情页
        if (lValue.length > 0 && lValue != nil) {
            //            [self loadProductShopDetail:2 shop_id:0 aid:[lValue intValue]];
            [self productshopdetailWithAid:[NSString stringWithFormat:@"%@",lValue]];
        }
    }
    else if (type == 4) {
//        SearchListViewController *vc=[[SearchListViewController alloc] init];
//        vc.shouldDoRequest = YES;
//        vc.searchCid = lValue;
        SearchViewController *search = [[SearchViewController alloc]init];
        BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:search];
        navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //search.shouldRequest = YES;
        [self.navigationController presentViewController:navi animated:YES completion:nil];
        //SearchViewController *search = [[SearchViewController alloc]init];
        //[self.navigationController pushViewController:search animated:YES];
    }
    else if (type == 6)
    {
        //apppage
        if (lValue.length > 0 && lValue != nil) {
            NSString *tempUrl = [NSString stringWithFormat:@"getapppage.php?pageid=%@",lValue];
            NSString *url = MOBILE_SERVER_URL(tempUrl);
            __weak GeneralPageViewController *weakSelf=self;
            GeneralPageViewController *vc=[[GeneralPageViewController alloc] init];
            [vc setUrl:url];
            vc.successChangeAppPageBlock=^(void){
                [weakSelf updateAppPage];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    else if (type == 30)
    {
        //apppage 添加
        if (lValue.length > 0 && lValue != nil) {
            [self dealApppageChangeType:@"addapppage" pageid:lValue];
            
        }
    }
    else if (type == 31)
    {
        //apppage 删除
        if (lValue.length > 0 && lValue != nil) {
            [self dealApppageChangeType:@"delapppage" pageid:lValue];

        }
    }
}

#pragma mark - 详情接口
/*商品详情接口*/
-(void)productshopdetailWithAid:(NSString *)aid
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    NSString *str=MOBILE_SERVER_URL(@"productshopdetail_lemuji.php");
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
            
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
            [SVProgressHUD dismiss];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}



-(void)morebtnclick:(UIButton *)btn
{
    
    int curArrTag = btn.tag /20-1;
    
    NSDictionary *itemsdic = [[NSDictionary alloc] initWithDictionary:[_goodsAllArray objectAtIndex:curArrTag]];
    DLog(@"-------iteminde----%d--------%@",curArrTag,itemsdic);
    NSString *right_linktype = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"right_title_link_type"]];
    NSString *right_linkvalue = [NSString stringWithFormat:@"%@",[itemsdic objectForKey:@"right_title_link_value"]];
    if (right_linktype.length > 0 && right_linkvalue.length > 0) {
        [self gotoGoodsList:[right_linktype intValue] linkvale:right_linkvalue title:@""];
    }
    
    
}


-(void)CustomTypeImageViewButton:(int)curbtn CurView:(CustomTypeImageView *)curVi
{
    int curArrTag = curVi.tag - 1;
    NSDictionary *itemsdic = [_goodsAllArray objectAtIndex:curArrTag];
    NSArray *itemArr = [itemsdic objectForKey:@"content"];
    DLog(@"得到的数值是%@",itemsdic);
    int ind = curbtn - 10;
    if (itemArr.count > ind) {
        NSDictionary *itemdic = [itemArr objectAtIndex:ind];
        NSString *keyword = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"title"]];
        [self gotoGoodsList:[[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"link_type"]] intValue] linkvale:[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"link_value"]] title:keyword];
    }
}

-(void)dealApppageChangeType:(NSString *)type pageid:(NSString *)pageId
{
    
//     添加 type=addapppage,apppage_id
//    删除apppage：参数：type=delapppage,apppage_id
    
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=%@&apppage_id=%@",type,pageId];
    NSString *str=MOBILE_SERVER_URL(@"myapppage_lemuji.php");
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.successChangeAppPageBlock) {
                    self.successChangeAppPageBlock();
                }
                [self.navigationController popViewControllerAnimated:NO];
            });
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


@end
