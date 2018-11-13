//
//  GeneralPageViewController.h
//  WanHao
//
//  Created by csl on 14-10-30.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GeneralPageViewController : UIViewController <UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>{
    MJRefreshHeaderView *header;
}

-(void)setUrl:(NSString *)ursString;


@property (nonatomic, strong) UIScrollView *allScrollView;
@property(nonatomic,strong) void(^successChangeAppPageBlock)(void);

@end
