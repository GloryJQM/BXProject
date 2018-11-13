//
//  FielMangerCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "FielMangerCell.h"

@implementation FielMangerCell {
    UIView *imgBackView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:_customImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, UI_SCREEN_WIDTH - 85, 20)];
        _titleLabel.textColor = App_Main_Color;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, UI_SCREEN_WIDTH - 85, 80)];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_detailLabel];
        
        imgBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, UI_SCREEN_WIDTH, 50)];
        imgBackView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:imgBackView];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, UI_SCREEN_WIDTH, 50)];
        self.bottomView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:self.bottomView];
        
        NSArray *titles = @[@"保存图片",@"复制文案",@"一键分享"];
        for (int i = 0; i < 3; i ++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(UI_SCREEN_WIDTH - 75*(i+1), 6, 65, 30);
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:App_Main_Color];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [self.bottomView addSubview:btn];
            switch (i) {
                case 0:
                    self.saveBtn = btn;
                    break;
                case 1:
                    self.textCopyBtn = btn;
                    break;
                case 2:
                    self.shareBtn = btn;
                    break;
                    
                default:
                    break;
            }
        }

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, UI_SCREEN_WIDTH, 8)];
        lineView.backgroundColor = LINE_SHALLOW_COLOR;
        [self.bottomView addSubview:lineView];
        
    }
    return self;
}

- (void)updateWith:(NSDictionary *)dic
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
    [self.customImageView af_setImageWithURL:url];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(self.titleLabel.frame.size.width, FLT_MAX)];
    self.titleLabel.frame=CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, titleSize.height);

    
    self.detailLabel.text= [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    CGSize detailSize=[self.detailLabel sizeThatFits:CGSizeMake(self.detailLabel.frame.size.width, FLT_MAX)];
    self.detailLabel.frame=CGRectMake(self.detailLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame)+5, self.detailLabel.frame.size.width, detailSize.height);
    
    [self addView:[dic valueForKey:@"picarr"]];
}



- (void)addView:(NSArray *)array
{
    //cell复用的时候, 图片重复加载解决方法
    //在加载之前, 移除掉之前的 View
    for (UIView *view in imgBackView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat off = 3;
    CGFloat width = (UI_SCREEN_WIDTH - 85 - 2*off) / 3;
    CGFloat OFF = width +off;
    CGFloat StartHight = CGRectGetMaxY(self.detailLabel.frame)+5;
    CGFloat maxHight = 0;
    
    if (StartHight < 75) {
        StartHight = 75;
    }
 
    for (int i = 0; i < array.count; i++) {        
        NSInteger index = i % 3;
        NSInteger page = i / 3;
 
        UIImageView * photo = [[UIImageView alloc] initWithFrame:CGRectMake(75 + index * OFF, page * OFF, width, width)];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"picurl"]]];
        [photo af_setImageWithURL:url];
        [imgBackView addSubview:photo];
        if (i == array.count - 1) {
            maxHight = CGRectGetMaxY(photo.frame);
        }
    }
    imgBackView.frame = CGRectMake(0, StartHight, UI_SCREEN_WIDTH, maxHight);
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(imgBackView.frame)+5, UI_SCREEN_WIDTH, 50);
}

@end
