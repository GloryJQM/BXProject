//
//  PreLoginViewController.m
//  SmallCEO
//
//  Created by ni on 17/4/14.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PreLoginViewController.h"
#import "LoginNavigationController.h"

@interface PreLoginViewController ()

@property (nonatomic, assign) BOOL isShowTab;

@end

@implementation PreLoginViewController

#pragma mark 进入登录页的方法，在其他几个类里使用
+ (void)performIfLogin:(UIViewController *)viewController withShowTab:(BOOL)showTab loginAlreadyBlock:(loginAlreadyBlock)alreadyBlock loginSuccessBlock:(loginSuccessBlock)successBlock
{
    if (![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"]) {
        LoginNavigationController *logvc =  [[LoginNavigationController alloc] init];
        ((LoginNavigationController*)logvc).viewController.alreadyBlock = alreadyBlock;
        ((LoginNavigationController*)logvc).viewController.successBlock = successBlock;
        //((LoginNavigationController*)logvc).viewController.isShowTab = showTab;
        [viewController presentViewController:logvc animated:YES completion:nil];
    }else{
        alreadyBlock();
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}
- (void)createView {
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    image.image = [UIImage imageNamed:@"loginImage"];
    
    [self.view addSubview:image];
    DLog(@"%f    %f",UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT);
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-110, UI_SCREEN_HEIGHT-100, 100, 40)];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.borderColor = [UIColor clearColor].CGColor;
    loginBtn.layer.borderWidth = 1.0;
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2+10, UI_SCREEN_HEIGHT-100, 100, 40)];
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 5;
    registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtn.layer.borderWidth = 1.0;
    [self.view addSubview:registerBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
