//
//  HomeViewController.h
//  SmallCEO
//
//  Created by quanmai on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartCell.h"
#import "GGView.h"
#import "VerticalPageableScrollView.h"


#import "HomeCusViewFour.h"
#import "HomeCustViewThree.h"
#import "HomeCusViewSec.h"
#import "HomeCusViewOne.h"
#import "HomeCusViewFive.h"
#import "HomeCusViewSix.h"
#import "HomeCusViewEleven.h"
#import "HomeCusViewTwelve.h"

#import "SBTickView.h"
#import "SBTickerView.h"

#import "TipView.h"

@interface HomeViewController : UIViewController<MJRefreshBaseViewDelegate,HomeCusViewFourDelegate,HomeCustViewThreeDelegate,HomeCusViewSecDelegate,HomeCusViewOneDelegate,HomeCusViewFiveDelegate,HomeCusViewSixDelegate,HomeCusViewElevenDelegate,HomeCusViewTwelveDelegate,UIAlertViewDelegate>{
    
    UITableView *tableV;
    UIImageView *noDataImageV;
    
    NSArray *introduceImageArr;
    
    MJRefreshHeaderView *header;
    
    NSMutableArray *cateListArr;
    
    BOOL isGetCateTypeArr;
    NSString *isNeedGetType;
    NSArray *cateTypeArr;
    NSInteger curCatePage;
    NSInteger curMainCateIndex;
    NSString *curCid;
    
    //消息通知模块
    NSDictionary *noticeDictionary;
    TipView *noticeTipView;
    float itemOffsetY;

    NSMutableArray  *_timersArray;
    
    NSTimer         *_HomeCountDownTimer;
    NSString *_currentClock;
    
}

@property(nonatomic,strong) VerticalPageableScrollView *verticalPageView;
@property(nonatomic,assign) CGFloat allScrollViewContentOriginH;

@property(nonatomic,strong) NSMutableArray *customViews;
@property(nonatomic,strong) NSArray *goodsAllArray;
@property(nonatomic,strong) NSMutableArray *itemsArray;

@property(nonatomic,strong) NSMutableArray *clockTickers;
@property(nonatomic,strong) NSMutableArray *countdownRecord;

@property(nonatomic,strong) NSDictionary    *appDit;
@end
