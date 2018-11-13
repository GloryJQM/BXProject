//
//  TimeDetailViewController.h
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiLiView.h"


@interface TimeDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,RiliViewDelegate>{
    NSMutableArray *dataSourceArr;
    UILabel *tiplable;
}
@property (nonatomic,assign)int where;
@property (nonatomic,strong)NSString* obId;
@property (nonatomic,strong)NSString* memId;
@property (nonatomic,assign)long time;
@property (nonatomic,strong)NSDictionary* dic;
-(void)clickIt;

@property (nonatomic, assign)int curPage;
@property (nonatomic,strong) void(^popBlock)(int vcTag);

@property (nonatomic, strong)UIPickerView * areaPickerView;

@end
