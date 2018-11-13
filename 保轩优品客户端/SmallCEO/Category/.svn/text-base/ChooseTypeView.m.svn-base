//
//  ChooseTypeView.m
//  SmallCEO
//
//  Created by huang on 2017/6/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ChooseTypeView.h"
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define RGB(r, g, b) RGBA(r,g,b,1)

@implementation ChooseTypeView

-(instancetype)initWithCompleteBlock:(void (^)(NSInteger ))completeBlock andType:(NSInteger)type{
    self = [super init];
    if (self) {
        self.type = type;
        [self setupUI];
        if (completeBlock) {
            self.doneBlock = ^(NSInteger chooseType) {
                completeBlock(chooseType);
            };
        }
    }
    return self;
}
-(void)setupUI {
    NSArray *arr = @[@"全部", @"现金", @"积分", @"金币"];
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-300)];
    backView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    [self addSubview:backView];
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    self.backgroundColor = RGBA(0, 0, 0, 0);
    [self layoutIfNeeded];
    
    //提到最前
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 20)];
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.text = @"选择交易类型";
    titleL.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleL];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 1)];
    lineV.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [backView addSubview:lineV];
    
    //选择模块
    for (int i = 0 ; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((j + 1) * 10 + j * (UI_SCREEN_WIDTH - 30) / 2, 40 + 10 + (1 + i) * 10  + i * (backView.height - 130) / 2 , (UI_SCREEN_WIDTH - 30) / 2, (backView.height - 130) / 2 )];
            [btn setTitle:arr[i * 2 + j] forState:UIControlStateNormal];
            btn.tag = i * 2 + j;
            btn.layer.cornerRadius = 3;
            btn.titleLabel.font = [UIFont systemFontOfSize:btn.height / 3];
            if (i * 2 + j == self.type) {
                btn.backgroundColor = [UIColor colorWithRed:213 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else {
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:[UIColor colorFromHexCode:@"#666666"] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
            
        }
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, backView.height - 40, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [backView addSubview:line];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, backView.height - 39, UI_SCREEN_WIDTH, 39)];
    cancelBtn.backgroundColor = White2_Color;
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
}
- (void)btnAction:(UIButton *)sender {
    self.doneBlock(sender.tag);
    [self dismiss];
}


#pragma mark - Action
-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.centerY = UI_SCREEN_HEIGHT/2;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.centerY = self.height*2;
        [self layoutIfNeeded];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
        //        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //        [self removeFromSuperview];
    }];
}

@end
