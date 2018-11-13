//
//  MerchantView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "MerchantView.h"

@implementation MerchantView
- (instancetype)initWithy:(CGFloat)y dataDic:(NSDictionary *)dataDic {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 60)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * tuijianL = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 20)];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"  商家信息"];
        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
        attch.image = [UIImage imageNamed:@"icon-guogai@2x"];
        attch.bounds = CGRectMake(0, -3, 18, 18);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];
        tuijianL.attributedText = attri;
        tuijianL.font = [UIFont systemFontOfSize:15];
        tuijianL.textColor = [UIColor blackColor];
        tuijianL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tuijianL];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, tuijianL.maxY + 10, UI_SCREEN_WIDTH - 40, 1)];
        line.backgroundColor = WHITE_COLOR2;
        [self addSubview:line];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, line.maxY + 5, UI_SCREEN_WIDTH - 10, 20)];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = @"商户信息";
        [self addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"时间@2x"];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:@"时间@2x"] placeholderImage:nil];
        [self addSubview:imageView];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabel.maxY + 10,  UI_SCREEN_WIDTH - 40, 20)];
        NSMutableAttributedString *timeAttri = [[NSMutableAttributedString alloc]initWithString:@"  营业时间"];
        NSTextAttachment *timeAttch = [[NSTextAttachment alloc]init];
        timeAttch.image = imageView.image;
        timeAttch.bounds = CGRectMake(0, -3, 18, 18);
        NSAttributedString *timeString = [NSAttributedString attributedStringWithAttachment:timeAttch];
        [timeAttri insertAttributedString:timeString atIndex:0];
        timeLabel.attributedText = timeAttri;
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        
        NSArray *array = @[@"刷卡", @"停车", @"WIFI", @"可吸烟", @"无烟区"];
        NSArray *imageArray = @[@"刷卡@2x", @"停车@2x", @"wifi@2x", @"吸烟@2x", @"无烟@2x"];
        CGFloat width = (UI_SCREEN_WIDTH - 40) / 3;
        for (int i = 0; i < array.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:nil];
            imageView.image = [UIImage imageNamed:imageArray[i]];
            [self addSubview:imageView];
            
            self.height = timeLabel.maxY + 10 + i / 3 * 30;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 + i % 3 * width, self.height, width, 20)];
            NSString *titleStr = [NSString stringWithFormat:@"  %@", array[i]];
             NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:titleStr];
            NSTextAttachment *attch = [[NSTextAttachment alloc]init];
            attch.image = imageView.image;
            attch.bounds = CGRectMake(0, -3, 18, 18);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];
            label.attributedText = attri;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:label];
        }
        
        self.frame = CGRectMake(0, y, UI_SCREEN_WIDTH,self.height + 30);
    }
    return self;
}

@end
