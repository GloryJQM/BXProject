//
//  RegisterViewController.h
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptchaView.h"
#import "EnterphonenumberView.h"

@interface RegisterViewController : UIViewController<CaptchaViewdelegate> {
    
    UIScrollView* _scrollView;
    int page;
    int type;
    int isRegist;
    EnterphonenumberView *enterphonenumber;
    
}

@property(nonatomic,strong)NSMutableArray       *labelArray;
@property(nonatomic,strong)NSMutableArray       *circyArray;
@property(nonatomic,strong)NSMutableArray       *viewArray;
@property(nonatomic,strong)NSMutableArray       *strArray;
@property(nonatomic)int isRegist;
@property(nonatomic)int type;

@property (nonatomic,strong) void(^ registBlock)(BOOL finish, NSDictionary *dic);

-(id)initAsRegisterWindow;
-(id)initAsFindPasswordWindow;

@end
