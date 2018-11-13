//
//  SearchListViewController.h
//  Lemuji
//
//  Created by quanmai on 15/7/17.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartCell.h"
#import "GGView.h"

@interface SearchListViewController : UIViewController{
    NSMutableArray *selectDataSource;
    NSMutableArray *resultDataSource;
}
@property (nonatomic,strong)MJRefreshHeaderView* headView;
@property (nonatomic,strong)MJRefreshFooterView* footView;
@property (nonatomic,assign)int curPage;
@property (nonatomic, assign) BOOL shouldDoRequest;
@property (nonatomic, assign) BOOL isJuHeGoods;
@property (nonatomic, strong) NSString *juheCid;
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, strong) NSString *searchCid;
/*规格*/
@property(nonatomic,strong) UIWindow *myGGView;
@property(nonatomic,strong) UIView *bodyView;
@property(nonatomic,strong) ShopCartCell *shopCell;
@property(nonatomic,strong) NSDictionary *comDetailDic;
@property(nonatomic,strong) UILabel *redPointInGGViewLabel;
@property(nonatomic,strong) UILabel *allPriceLab;
@property(nonatomic,strong) NSMutableArray *ggArr;
@property(nonatomic,assign) NSInteger selectedGoodsCount;
@property(nonatomic,assign) CGFloat attrPay;
@property (nonatomic,strong)NSMutableArray* subGG;

/*规格前三个属性title*/
@property (nonatomic,strong)NSString* firstStr;
@property (nonatomic,strong)NSString* secondStr;
@property (nonatomic,strong)NSString* thirdStr;

@property(nonatomic,assign) CGFloat  onePay;
@property(nonatomic,assign) CGFloat  allPay;

@end
