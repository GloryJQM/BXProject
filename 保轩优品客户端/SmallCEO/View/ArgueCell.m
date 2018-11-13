//
//  ArgueCell.m
//  SmallCEO
//
//  Created by XuMengFan on 15/11/8.
//  Copyright © 2015年 lemuji. All rights reserved.
//

#import "ArgueCell.h"
#import "ArgueModel.h"

@interface ArgueCell ()<pyItemRatingScoreCustomViewDelegate/*,argueViewDelegate*/>



@end

@implementation ArgueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.argueView];
    }
    return self;
}

#pragma mark - Getter

- (argueView *)argueView
{
    if (_argueView == nil) {
        self.argueView = [[argueView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
        //self.argueView.delegate = self;
    }
    return _argueView;
}

#pragma mark - Public

- (void)assignmentWithArray:(NSArray *)array
{
    [self.argueView assignmentWithDataArray:array];
}

- (NSArray *)getAllControllersValueOnCell
{
    NSString * titleStr = self.argueView.titleLabel.text;
    NSString * totalValueStr = [NSString stringWithFormat:@"%ld", self.argueView.zongHeStartNum];
    NSString * adviceStr = self.argueView.argueTextView.text;
    NSString * descriptionStr = [self.argueView.starString substringWithRange:NSMakeRange(0, 1)];
    NSString * speedStr = [self.argueView.starString substringWithRange:NSMakeRange(2, 1)];
    NSString * consultStr = [self.argueView.starString substringWithRange:NSMakeRange(4, 1)];
    return @[titleStr, totalValueStr, adviceStr, descriptionStr, speedStr, consultStr];
}

- (void)assignmentWithModel:(ArgueModel *)model
{
    [self.argueView assignmentWithModel:model];
}

- (ArgueModel *)getCellModel
{
    ArgueModel * model = [[ArgueModel alloc] init];
    model.goodsName = self.argueView.titleLabel.text;
    model.totalValueNum = self.argueView.zongHeStartNum;
    model.adviceStr = self.argueView.argueTextView.text;
    model.descriptionNum = [[self.argueView.starString substringWithRange:NSMakeRange(0, 1)] integerValue];
    model.speedNum = [[self.argueView.starString substringWithRange:NSMakeRange(2, 1)] integerValue];
    model.consultNum = [[self.argueView.starString substringWithRange:NSMakeRange(4, 1)] integerValue];
    return model;
}

//#pragma mark - argueViewDelegate
//
//- (void)getViewData:(NSArray *)dataArray
//{
//    if ([self.delegate respondsToSelector:@selector(getCellNewData:objecte:)]) {
//        [self.delegate getCellNewData:dataArray objecte:self];
//    }
//}
//
//- (void)getNewModel:(ArgueModel *)model
//{
//    if ([self.delegate respondsToSelector:@selector(getNewModel:objecte:)]) {
//        [self.delegate getNewModel:model objecte:self];
//    }
//}


#pragma mark - System

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
