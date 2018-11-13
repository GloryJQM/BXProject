//
//  PayFinishViewController.h
//  Lemuji
//
//  Created by Cai on 15-8-4.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALView.h"
#import "ConfirmDetailVC.h"

@interface PayFinishViewController : UIViewController

@property (nonatomic, strong)UILabel * twoLabel;
@property (nonatomic, strong)UIView * buttomView;
@property(nonatomic,strong) NSString   *shareOrderId;
@property(nonatomic,strong) NSMutableDictionary  *shareDic;
@property(nonatomic,strong) ALView  *alview;
@property(nonatomic,strong) NSString *orderTitle;

@end
