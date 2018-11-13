//
//  CustomAnnotationView.m
//  Lemuji
//
//  Created by huang on 15/8/12.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomAnnotation.h"

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation CustomAnnotationView

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier type:(ButtonCountType)type
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        CGFloat selfHeight =162;
        CGFloat itemHeight =108;
        CGFloat itemWidth  =260;
        
        self.backgroundColor=[UIColor clearColor];
        CustomAnnotation *mapItem = (CustomAnnotation *)self.annotation;
        
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        positionLabel.backgroundColor = [UIColor whiteColor];
        positionLabel.numberOfLines = 2;
        positionLabel.textAlignment = NSTextAlignmentLeft;
        NSString *positionStr = type == ButtonCountTypeOnlySure ? @"店铺地址" : @"提货地址";
        positionLabel.text = [NSString stringWithFormat:@"%@:%@", positionStr, mapItem.positionStr];
        positionLabel.font = [UIFont systemFontOfSize:14.0];
        CGSize sizeForPositionLabel = [positionLabel sizeThatFits:CGSizeMake(itemWidth-40-13, 200)];
        
        positionLabel.frame = CGRectMake(13, 13, sizeForPositionLabel.width, sizeForPositionLabel.height);
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 50, itemWidth-53, 15)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = mapItem.contactInformation;
        timeLabel.font = [UIFont systemFontOfSize:14.0];
        timeLabel.textColor=SUB_TITLE;
        timeLabel.textAlignment = NSTextAlignmentLeft;
        
        CGRect frame = self.frame;
        frame.size = CGSizeMake(itemWidth, selfHeight);
        self.frame = frame;
        
        UIButton *selectPositionBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        selectPositionBtn.frame = CGRectMake(0, 75, self.frame.size.width/2 , 33);
        [selectPositionBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
        selectPositionBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        selectPositionBtn.backgroundColor = myRgba(247, 248, 243, 1);
        [selectPositionBtn addTarget:self action:@selector(clickShopDetail) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *nagivationBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        nagivationBtn.frame = CGRectMake(itemWidth-40, 0, 40, 75);
        [nagivationBtn setImage:[UIImage imageNamed:@"csl_map_nav.png"] forState:UIControlStateNormal];
        nagivationBtn.backgroundColor = [UIColor clearColor];
        nagivationBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [nagivationBtn addTarget:self action:@selector(clickNagivation) forControlEvents:UIControlEventTouchUpInside];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -10-27, frame.size.width, itemHeight)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = [LINE_SHALLOW_COLOR CGColor];
        self.contentView.layer.masksToBounds=NO;
        UILabel *separateLine = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth-40, 15, 0.5, 75-30)];
        separateLine.backgroundColor = SUB_TITLE;
        separateLine.alpha=0.5;
        UILabel *separateLineBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 74.5, itemWidth, 0.5)];
        separateLineBottom.backgroundColor = SUB_TITLE;
        separateLineBottom.alpha=0.5;
        
        [self.contentView addSubview:selectPositionBtn];
        
        [self.contentView addSubview:separateLineBottom];
        [self.contentView addSubview:separateLine];
        [self.contentView addSubview:positionLabel];
        [self.contentView addSubview:timeLabel];
        [self.contentView addSubview:nagivationBtn];
        [self addSubview:self.contentView];
        self.contentView.hidden = YES;
        
        self.index = mapItem.index;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"iconfontdingwei.png"] imageWithMinimumSize:CGSizeMake(20, 20)]];
        imageView.frame = CGRectMake((self.frame.size.width-40)/2.0, self.frame.size.height/2.0-20, 40, 40);
        imageView.contentMode=UIViewContentModeCenter;
        [self addSubview:imageView];
        
        
        if (type == ButtonCountTypeOnlySure)
        {
            [selectPositionBtn setTitle:@"确定" forState:UIControlStateNormal];
            selectPositionBtn.width = self.frame.size.width;
        }
        else
        {
            [selectPositionBtn setTitle:@"选择到该店提货" forState:UIControlStateNormal];
            selectPositionBtn.width = self.frame.size.width ;
        }
    }
    
    return self;
}




- (void)clickNagivation
{
    if (self.returnBlock)
    {
        self.returnBlock(self.index, ButtonClickTypeNagivation);
    }
}

- (void)clickShopDetail
{
    if (self.returnBlock)
    {
        self.returnBlock(self.index, ButtonClickTypeSelect);
    }
}

- (void)showDetailInfo
{
    [self showTitleAndImage:YES];
}

- (void)showTitleAndImage:(BOOL)show
{
    self.contentView.hidden = !show;
}

@end
