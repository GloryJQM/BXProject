//
//  InviteDealerViewController.m
//  SmallCEO
//
//  Created by quanmai on 15/8/27.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "InviteDealerViewController.h"
#import "FielMangerViewController.h"

@implementation InviteDealerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分销商邀请";
    
    UIFont *textFont = IS_IPHONE6PLUS ? [UIFont systemFontOfSize:18.0] : [UIFont systemFontOfSize:12.0];
    UIView *tView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 55)];
    tView.backgroundColor=[UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:tView];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 55)];
    lable.textColor=[UIColor lightGrayColor];
    lable.font=textFont;
    lable.text=@"邀请码";
    lable.backgroundColor=[UIColor clearColor];
    [tView addSubview:lable];
    
    UILabel *codeLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, UI_SCREEN_WIDTH-130, 55)];
    codeLable.textColor=[UIColor blackColor];
    codeLable.font=LMJ_CT 15];
    codeLable.text=self.inviteCodeString;
    codeLable.textAlignment=NSTextAlignmentCenter;
    codeLable.backgroundColor=[UIColor clearColor];
    [tView addSubview:codeLable];
    
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-80, 11, 65, 34)];
    btnT.backgroundColor=App_Main_Color;
    [btnT addTarget:self action:@selector(copyCode) forControlEvents:UIControlEventTouchUpInside];
    [btnT setTitle:@"复制" forState:UIControlStateNormal];
    [btnT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnT.titleLabel.font=[UIFont systemFontOfSize:14];
    [tView addSubview:btnT];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 54.5, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor=LINE_SHALLOW_COLOR;
    [tView addSubview:line];
    
    UILabel *intorductLable=[[UILabel alloc] init];
    intorductLable.textColor=[UIColor blackColor];
    intorductLable.font = textFont;
    if (IS_IPHONE6PLUS)
    {
        intorductLable.frame = CGRectMake(40, 55+8, UI_SCREEN_WIDTH-80, 120);
    }
    else
    {
        intorductLable.frame = CGRectMake(40, 55+8, UI_SCREEN_WIDTH-80, 60);
    }
    intorductLable.text=@"下载完成后，您的朋友注册时将此6位数字填入邀请码一栏即可成为您的分销商，届时您的分销商上产生的了收益时，您将获得分成";
    intorductLable.backgroundColor=[UIColor clearColor];
    intorductLable.numberOfLines=0;
    intorductLable.lineBreakMode=NSLineBreakByWordWrapping;
    [self.view addSubview:intorductLable];
    
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(intorductLable.frame), UI_SCREEN_WIDTH, 0.5)];
    line1.backgroundColor=LINE_SHALLOW_COLOR;
    [self.view addSubview:line1];

    UIButton *selectInviteFileButton = [[UIButton alloc] initWithFrame:CGRectMake(38.5, CGRectGetMaxY(line1.frame) + 15, UI_SCREEN_WIDTH - 77, 36)];
    [selectInviteFileButton setTitle:@"选择分销商邀请文案" forState:UIControlStateNormal];
    [selectInviteFileButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectInviteFileButton setBackgroundColor:App_Main_Color];
    selectInviteFileButton.layer.cornerRadius = 5.0;
    selectInviteFileButton.titleLabel.font = textFont;
    [selectInviteFileButton addTarget:self action:@selector(choseDoc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectInviteFileButton];
    
    UILabel *tipLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectInviteFileButton.frame) + 11, UI_SCREEN_WIDTH, 34)];
    tipLabel.textColor=[UIColor colorFromHexCode:@"a4a4a4"];
    tipLabel.font = textFont;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font=[UIFont boldSystemFontOfSize:13];
    tipLabel.text=@"更利于您的推广";
    tipLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tipLabel];
}


-(void)choseDoc{
    FielMangerViewController *vc=[[FielMangerViewController alloc] init];
    vc.flag=3;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)copyCode{
    if (![self.inviteCodeString isKindOfClass:[NSString class]]) {
        return;
    }
    [[UIPasteboard generalPasteboard] setPersistent:YES];
    [[UIPasteboard generalPasteboard]  setValue:self.inviteCodeString forPasteboardType:[UIPasteboardTypeListString objectAtIndex:0]];
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"复制成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
