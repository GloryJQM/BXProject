//
//  CustomTabBarController.m
//  chufake
//
//  Created by pan on 13-11-11.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "CustomTabBarController.h"
#import "UIColor+FlatUI.h"
#import "LoginViewController.h"
#import "APService.h"
#import "MyGoodsViewController.h"
#import "EditPwdWithOldPwdViewController.h"
@interface CustomTabBarController () {
    NSMutableArray          *_tabbarArr ;
    NSMutableArray          *_tabbarNormalUrlArr ;
    NSMutableArray          *_tabbarSelectedUrlArr ;
    NSMutableArray          *_tabbarImgArr;
}
@end

@implementation CustomTabBarController

#define kTag  998

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.frame = [[UIScreen mainScreen] bounds];
        _preIndex = 0;
    }
    return self;
}

- (UIView *)loadTabs {
    _tabbarNormalUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    _tabbarSelectedUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    _tabbarArr = [[NSMutableArray alloc] initWithCapacity:0];
    _tabbarImgArr = [[NSMutableArray alloc] initWithCapacity:0];
    redTipArr=[[NSMutableArray alloc] initWithCapacity:0];

    //使用全局变量的目的是为了保证在项目启动后当前类每一次使用到tabbar_ItemImgs数据是一致的

    [_tabbarNormalUrlArr removeAllObjects];
    [_tabbarSelectedUrlArr removeAllObjects];
    
    
    _tabbarArr =[[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar_ItemImgs"];
    for (int i = 0; i < _tabbarArr.count; i ++) {
        NSDictionary *dic  = _tabbarArr[i];
        [_tabbarNormalUrlArr addObject:[dic objectForKey:@"before_des_picurl"]];
        [_tabbarSelectedUrlArr addObject:[dic objectForKey:@"after_des_picurl"]];
    }
    if (!_tabbarArr.count) {
        NSArray *array = @[@"sshou20150612@2x", @"sfen20150612@2x", @"stui20150612@2x", @"schee20150612@2x", @"sshang20150612@2x"];
        NSArray *array1 = @[@"sshou20150612_1@2x", @"sfen20150612_1@2x", @"stui20150612_1@2x", @"schee20150612_1@2x", @"sshang20150612_1@2x"];
        _tabbarNormalUrlArr = [NSMutableArray arrayWithArray:array];
        _tabbarSelectedUrlArr = [NSMutableArray arrayWithArray:array1];
    }

    const float kWidth = self.view.frame.size.width;

    UIImageView *tabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 51)];
    tabBar.userInteractionEnabled = YES;
    tabBar.backgroundColor=[UIColor colorFromHexCode:@"f8f8f8"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0.5)];
    lineView.backgroundColor=myRgba(100, 100, 100, 0.2);
    [tabBar addSubview:lineView];
    lineView.layer.masksToBounds=NO;
    lineView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    lineView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    lineView.layer.shadowOpacity = 1.0;//不透明度
    lineView.layer.shadowRadius = 2.0;//半径
    
    const int tabNum =_tabbarArr.count > 0 ? _tabbarArr.count : 5;
    
    _tabSelectedBG = [[UIView alloc] init];
    _tabSelectedBG.frame = CGRectMake(0, 2, tabBar.frame.size.width/tabNum, tabBar.frame.size.height);
    _tabSelectedBG.backgroundColor = [UIColor whiteColor];
    _tabSelectedBG.hidden = YES;
    [tabBar addSubview:_tabSelectedBG];
    
    
    for (int i=0; i <tabNum; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i *kWidth/tabNum + (kWidth/tabNum - 50)/2.0, 0, 50, 50)];
        img.contentMode = UIViewContentModeScaleAspectFit;

        //使用网上请求下来的图片
        if (i < _tabbarNormalUrlArr.count && i < _tabbarSelectedUrlArr.count) {
            //为了避免后台数据出错，给的数组不一致以至于数组越界
            NSString *normalUrlStr = [NSString stringWithFormat:@"%@",[_tabbarNormalUrlArr objectAtIndex:i]];
            NSString *selectedUrlStr = [NSString stringWithFormat:@"%@",[_tabbarSelectedUrlArr objectAtIndex:i] ];
            DLog(@"图片是否存在---%d----",[[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:selectedUrlStr]]);
            if (i == 0) {
                if ([selectedUrlStr containsString:@"http"]) {
                    [img sd_setImageWithURL:[NSURL URLWithString:selectedUrlStr]];
                }else {
                    img.image = [UIImage imageNamed:selectedUrlStr];
                }
                
            }else{
                if ([normalUrlStr containsString:@"http"]) {
                    [img sd_setImageWithURL:[NSURL URLWithString:normalUrlStr]];
                }else {
                    img.image = [UIImage imageNamed:normalUrlStr];
                }
                
                
            }
        }
        [tabBar addSubview:img];
        [_tabbarImgArr addObject:img];
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i *kWidth/tabNum, 2, kWidth/tabNum, 49)];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag = kTag+i;
        [tabBar addSubview:btn];
        
        /* 中间图标变大隐藏
        if (i==2) {
            CGSize size=CGSizeMake(52, 60);
            btn.frame=CGRectMake(i * kWidth / tabNum, -12, kWidth / tabNum, size.height);
            img.frame=CGRectMake(i * kWidth / tabNum, -12, kWidth / tabNum, size.height);
        }
         */
        
        if (i == 0) {
            btn.selected = YES;
        }

        UILabel *redLable=[[UILabel alloc] initWithFrame:CGRectMake((i+1) *kWidth/tabNum-30-3  , 2+3, 15, 15)];
        redLable.backgroundColor= ColorD0011B;
        redLable.layer.cornerRadius=redLable.frame.size.height/2;
        redLable.textColor=[UIColor whiteColor];
        redLable.text=@"0";
        redLable.hidden=YES;
        redLable.font=[UIFont systemFontOfSize:12];
        redLable.textAlignment=NSTextAlignmentCenter;
        redLable.layer.masksToBounds=YES;
        [tabBar addSubview:redLable];
        [redTipArr addObject:redLable];
    }
    
    return tabBar;
}

-(void)setTipText:(NSString *)tipText withTag:(int)tag{
    int index = tag > 0 ? tag : 3;
    UILabel *temp=(UILabel *)[redTipArr objectAtIndex:index];
    temp.hidden=NO;
    temp.text=tipText;
    if ([tipText intValue]==0) {
        temp.hidden=YES;
    }
}

- (void)tabSelected:(UIButton *)btn {
    int index = (int)btn.tag - kTag;
    self.selectedIndex = index;
}

- (void)selecteButton:(UIButton *)btn {
    int index = (int)btn.tag - kTag;
    if (_preIndex != index) {
        
        UIImageView *oldimg = (UIImageView *)[_tabbarImgArr objectAtIndex:_preIndex];
        UIImageView *newImg = (UIImageView *)[_tabbarImgArr objectAtIndex:index];
        
        if (_tabbarNormalUrlArr.count > 0) {
            //使用网上请求下来的图片
            if (_preIndex < _tabbarNormalUrlArr.count && _preIndex < _tabbarSelectedUrlArr.count) {
                //为了避免后台数据出错，给的数组不一致以至于数组越界
                NSString *normalUrlStr = [NSString stringWithFormat:@"%@",[_tabbarNormalUrlArr objectAtIndex:_preIndex] ];
                
                if ([normalUrlStr containsString:@"http"]) {
                    [oldimg sd_setImageWithURL:[NSURL URLWithString:normalUrlStr]];
                }else {
                    oldimg.image = [UIImage imageNamed:normalUrlStr];
                }
                
                
                NSString *selectedUrlStr = [NSString stringWithFormat:@"%@",[_tabbarSelectedUrlArr objectAtIndex:index]];
                
                if ([selectedUrlStr containsString:@"http"]) {
                    [newImg sd_setImageWithURL:[NSURL URLWithString:selectedUrlStr]];
                }else {
                    newImg.image = [UIImage imageNamed:selectedUrlStr];
                }
            }else{
                
                newImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_tab%d",index]];
                
                oldimg.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_tab%d_s",_preIndex]];
            }   
        }
        ((UIButton *)[self.view viewWithTag:kTag +_preIndex]).selected = NO;
        btn.selected = YES;
        _preIndex = index;
    }
}

#warning 点击tabbaritem 的响应方法，判断是否登录
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    id btn = [self.tabsView viewWithTag:selectedIndex + kTag];   
    /* 会员先隐藏
     if (selectedIndex == 2 && ![[PreferenceManager sharedManager] preferenceForKey:@"isvip"]) {
        UIAlertView *art = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"此功能仅向会员开放，请先到钱钱串购买商品成为会员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [art show];
        return;
    }
     */
    NSNumber *type = [[PreferenceManager sharedManager] preferenceForKey:@"tabbarType"];
//    if ( selectedIndex == 2  || selectedIndex == 4){//点击购物车和账户，需要判断是否已登录
    if ( selectedIndex == 3  || selectedIndex == 4 ||selectedIndex == 2){//点击购物车和账户、订单，需要判断是否已登录
        {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LoginViewController performIfLogin:self withShowTab:YES loginAlreadyBlock:^{
                    DLog(@"-------用户已登录---%ld",(long)((UIButton *)btn).tag);
                    if (type && selectedIndex==type.integerValue) {
                        UINavigationController *nav=[self.viewControllers objectAtIndex:_preIndex];
                        MyGoodsViewController *vc=[[MyGoodsViewController alloc] init];
                        [nav pushViewController:vc animated:YES];
                    }else{
                        [super setSelectedIndex:selectedIndex];
                        if ([btn isKindOfClass:[UIButton class]]) {
                            [self selecteButton:btn];
                        }
                    }

                } loginSuccessBlock:^(BOOL selectSetPayPassword) {
                    if (type && selectedIndex==type.integerValue) {
                        UINavigationController *nav = [self.viewControllers objectAtIndex:_preIndex];
                        MyGoodsViewController *vc = [[MyGoodsViewController alloc] init];
                        vc.shouldPushToSetPayPasswordPage = selectSetPayPassword;
                        [nav pushViewController:vc animated:YES];
                    }
                    else
                    {
                        [super setSelectedIndex:selectedIndex];
                        if ([btn isKindOfClass:[UIButton class]]) {
                            [self selecteButton:btn];
                            if (selectSetPayPassword)
                            {
                                UINavigationController *nav=[self.viewControllers objectAtIndex:selectedIndex];
                                EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
                                editPwdVC.type = EditPasswordTypePayPasswordWithoutVerifyCode;
                                editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
                                [nav pushViewController:editPwdVC animated:YES];
                            }
                        }
                    }
                }];
            });
        }
    }
    else{
        [super setSelectedIndex:selectedIndex];
        if ([btn isKindOfClass:[UIButton class]]) {
            [self selecteButton:btn];
        }
    }
}

@end
