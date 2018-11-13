//
//  FreightStateView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/8/3.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "FreightStateView.h"
@interface FreightStateView(){
    CGFloat _y;
    NSDictionary *_freight_info;
}

@end
@implementation FreightStateView
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic is_point_type:(NSInteger)is_point_type{
    self = [super initWithFrame:CGRectMake(4, 0, UI_SCREEN_WIDTH - 4 - 61, 100)];
    if (self) {
        self.image = [UIImage imageNamed:@"filloutback@2x"];
        _y = y;
        _freight_info = dataDic;
        if (is_point_type == 1) {
            [self creationView1];
        }else if (is_point_type == 0) {
            [self creationView];
        }
    }
    return self;
}

- (void)creationView {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, self.width - 30, 20)];
    NSString *title = [NSString stringWithFormat:@"%@", _freight_info[@"title"]];
    if ([title isBlankString]) {
        titleLabel.text = title;
    }
    titleLabel.text = @"运费说明";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    CGFloat miny = titleLabel.maxY + 20;
    NSArray *array = _freight_info[@"list"];
    if ([array isKindOfClass:[NSArray class]] && array != nil) {
        for (int i = 0; i < array.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, miny, 4, 4)];
            view.backgroundColor = [UIColor colorFromHexCode:@"#99A5B5"];
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            [self addSubview:view];
            
            UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(view.maxX + 12, view.minY, self.width - view.maxX - 24, 20)];
            content.text = [NSString stringWithFormat:@"%@", array[i]];
            content.textAlignment = NSTextAlignmentLeft;
            content.numberOfLines = 0;
            content.font = [UIFont systemFontOfSize:14];
            content.textColor = Color74828B;
            CGSize titleSize = [content sizeThatFits:CGSizeMake(self.width - view.maxX - 24, 50)];
            content.frame = CGRectMake(view.maxX + 12, view.minY - 8, self.width - view.maxX - 24, titleSize.height);
            [self addSubview:content];
            
            miny = content.maxY + 10 + 6;
        }
    }
    self.frame = CGRectMake(8, _y - miny, UI_SCREEN_WIDTH - 8 - 61, miny + 20);

}

- (void)creationView1 {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, self.width - 30, 20)];
    NSString *title = [NSString stringWithFormat:@"%@", _freight_info[@"title"]];
    titleLabel.text = @"运费说明";
    if ([title isBlankString]) {
        titleLabel.text = title;
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    NSArray *listArray = _freight_info[@"list"];
    if (![listArray isBlankArray]) {
        return;
    }
    
    CGFloat viewY = titleLabel.maxY + 10;
    for (int i = 0; i < listArray.count; i++) {
        NSDictionary *dataDic = listArray[i];
        UIView *backView = [[UIView alloc] init];
        [self addSubview:backView];
        
        UIView *imageview = [[UIView alloc] initWithFrame:CGRectMake(12, 4, 8, 8)];
        imageview.backgroundColor = [UIColor colorFromHexCode:@"#99A5B5"];
        imageview.layer.cornerRadius = 4;
        imageview.layer.masksToBounds = YES;
        [backView addSubview:imageview];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(imageview.maxX + 12, 0, self.width - imageview.maxX - 24, 20)];
        content.text = [NSString stringWithFormat:@"%@", dataDic[@"title"]];
        content.textAlignment = NSTextAlignmentLeft;
        content.numberOfLines = 0;
        content.font = [UIFont systemFontOfSize:14];
        content.textColor = Color74828B;
        CGSize titleSize = [content sizeThatFits:CGSizeMake(self.width - imageview.maxX - 24, 50)];
        content.frame = CGRectMake(imageview.maxX + 12, 0, self.width - imageview.maxX - 24, titleSize.height);
        [backView addSubview:content];
        
        
        CGFloat view2Y = content.maxY + 8;
        NSArray *array = dataDic[@"list"];
        if ([array isBlankArray]) {
            for (int j = 0; j < array.count; j++) {
                UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(content.x, view2Y, 8, 8)];
                imageview1.image = [UIImage imageNamed:@"freightimage@2x"];
                [backView addSubview:imageview1];
                
                UILabel *content1 = [[UILabel alloc] initWithFrame:CGRectMake(imageview1.maxX + 12, 4, self.width - imageview1.maxX - 24, 20)];
                content1.text = [NSString stringWithFormat:@"%@", array[j]];
                content1.textAlignment = NSTextAlignmentLeft;
                content1.numberOfLines = 0;
                content1.font = [UIFont systemFontOfSize:14];
                content1.textColor = Color74828B;
                CGSize titleSize1 = [content1 sizeThatFits:CGSizeMake(self.width - imageview1.maxX - 24, 50)];
                content1.frame = CGRectMake(imageview1.maxX + 12, imageview1.minY - 4, self.width - imageview1.maxX - 24, titleSize1.height);
                [backView addSubview:content1];
                
                view2Y = content1.maxY + 10;
            }
        }
        
        backView.frame = CGRectMake(0, viewY, self.width, view2Y);
        viewY = backView.maxY;
    }
    
    self.frame = CGRectMake(8, _y - viewY + 10, UI_SCREEN_WIDTH - 8 - 61, viewY + 20);
}
@end
