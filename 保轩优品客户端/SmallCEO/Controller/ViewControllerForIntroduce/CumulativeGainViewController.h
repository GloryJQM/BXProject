//
//  CumulativeGainViewController.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/12.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CumulativeGainViewController : UIViewController

@property (nonatomic, assign)BOOL isClick;
@property (nonatomic, strong)NSMutableArray * buttonArray;
@property (nonatomic, strong)NSMutableArray * labelArray;
@property (nonatomic, assign)BOOL isFirst;
@property (nonatomic, assign)int  tempTitleTag;


@end
