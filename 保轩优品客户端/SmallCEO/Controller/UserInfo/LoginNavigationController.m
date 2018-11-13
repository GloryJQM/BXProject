//
//  LoginNavigationController.m
//  chufake
//
//  Created by pan on 13-12-26.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "LoginNavigationController.h"
#import "RegisterViewController.h"
@interface LoginNavigationController ()

@end

@implementation LoginNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewController = [[LoginViewController alloc] init];
        [self pushViewController:_viewController animated:NO];
        
        self.navigationBar.translucent = NO;
        
        [self.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        
//        UIColor *color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"peterrivercolor.png"]];
        
        [self.navigationBar lt_setBackgroundColor:WHITE_COLOR];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.delegate = self;
}


-(void)customBackButton
{
    DLog(@"%lu",(unsigned long)self.viewControllers.count);
    DLog(@"%@",self.viewControllers);
    if (self.viewControllers.count >= 1 && self.viewControllers.count < 3) {//进入登录模块
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 15, 29)];
        if(C_IOS7){
            backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        }
        [backBtn setImage:[UIImage imageNamed:@"Button-fanhui@2x"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        ((UIViewController *)[self.viewControllers objectAtIndex:0]).navigationItem.leftBarButtonItem = backItem;
        
    }else if (self.viewControllers.count == 3){//进入注册协议
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 15, 29)];
        if(C_IOS7){
            backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        }
        [backBtn setImage:[UIImage imageNamed:@"Button-fanhui@2x"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        ((UIViewController *)[self.viewControllers objectAtIndex:2]).navigationItem.leftBarButtonItem = backItem;
    }
    
}

-(void)pushRegistration:(UIButton *)btn{
    
    RegisterViewController *viewController = [[RegisterViewController alloc] init];
    [self pushViewController:viewController animated:YES];
}

-(void)backPop
{
    [self popViewControllerAnimated:YES];
}
-(void)backPop:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self customBackButton];
    self.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;

    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
        viewController.edgesForExtendedLayout = UIRectEdgeAll;
    if ([viewController respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)]){
        viewController.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    DLog(@"pnvc controller will show! navigationController");
}

@end
