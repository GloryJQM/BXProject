//
//  ApplicationReturnsViewController.h
//  Lemuji
//
//  Created by huang on 15/8/11.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationReturnsViewController : UIViewController{
    UIPickerView *reasonPickerView;
    UITextField *selectReasonTextLabel;
    UITextField *explanationTextField;
    UIScrollView *allScrollView;
    
    
    NSInteger curSelectRow;
    NSString *curString;
}

@property (nonatomic, assign) NSString *returnMoney;
@property(nonatomic,strong) NSString *orderId;

@end
