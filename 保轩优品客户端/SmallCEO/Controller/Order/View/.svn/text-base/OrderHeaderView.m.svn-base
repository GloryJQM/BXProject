//
//  OrderHeaderView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/8/9.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderHeaderView.h"
@interface OrderHeaderView(){
    UILabel *titleLabel;
    UILabel *supplierLabel;
}
@end
@implementation OrderHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationView];
    }
    return self;
}

- (void)creationView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = Color0E0E0E;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLabel];

    supplierLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 115, 15, 100, 20)];
    supplierLabel.textAlignment = NSTextAlignmentRight;
    supplierLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:supplierLabel];
    [view addLineWithY:49.5];
}

- (void)setHeaderModel:(NSDictionary *)headerDic {
    titleLabel.text = [NSString stringWithFormat:@"订单编号: %@", headerDic[@"order_title"]];
    CGSize titleSize = [titleLabel sizeThatFits:CGSizeMake(200, 20)];
    titleLabel.frame = CGRectMake(15, 15, titleSize.width, 20);
    NSString *status_value = [NSString stringWithFormat:@"%@", headerDic[@"status_value"]];
    supplierLabel.text = [NSString stringWithFormat:@"%@", headerDic[@"status_content"]];
    supplierLabel.textColor = [status_value getStatusColor];
}



@end
