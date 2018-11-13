//
//  AdrListViewController.h
//  Lemuji
//
//  Created by chensanli on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdrListViewController;
@class AdrListTableViewCell;
@protocol AdrListVCDelegate <NSObject>

- (void)changeInformationName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address;

@optional
- (void)adrListViewController:(AdrListViewController *)adrListVC didDeleteAtIndex:(NSInteger)index;
- (void)adrListViewController:(AdrListViewController *)adrListVC didModifyAtIndex:(NSInteger)index withDataDic:(NSDictionary *)data;

@end

@interface AdrListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIView* nilView;
@property (nonatomic,strong) void(^hdBlock)(NSDictionary*,long);

@property (nonatomic, strong)id<AdrListVCDelegate> delegate;
@property (nonatomic,assign)long curChose;
@property (nonatomic,assign)int wp;
@property (nonatomic, copy) NSString *content;

@end
