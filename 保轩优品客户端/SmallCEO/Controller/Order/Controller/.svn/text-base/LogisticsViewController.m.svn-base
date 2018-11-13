//
//  LogisticsViewController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/13.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "LogisticsViewController.h"
#import "SuspendedView.h"
@interface LogisticsViewController ()<SuspendedViewDelegate>{
    SuspendedView *_suspendedView;
    
    UIImageView *image;
    UIButton *imageButton;
    UILabel *orderNumber;
    UILabel *sourceLabel;
    UILabel *phoneLabel;
    
    UIScrollView *scrillView;
}

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单跟踪";
    self.view.backgroundColor = backWhite;
    [self creationView];
}

- (void)creationView {
    
    if (self.logistics_ids.count == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
        imageView.image = [UIImage imageNamed:@"logisticsImage@2x"];
        [self.view addSubview:imageView];
        return;
    }
    
    NSMutableArray *logistics_ids = [NSMutableArray array];
    for (int i = 0; i < self.logistics_ids.count; i++) {
        NSString *str = [NSString stringWithFormat:@"包裹%d", i + 1];
        [logistics_ids addObject:str];
    }
    
    _suspendedView = [[SuspendedView alloc] initWithSuspendedViewStyle:SuspendedViewStyleVaule3];
    _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, SuspendedViewHeight);
    _suspendedView.delegate = self;
    _suspendedView.items = logistics_ids;
    _suspendedView.backgroundColor = [UIColor whiteColor];
    _suspendedView.currentItemIndex = 0;
    [self.view addSubview:_suspendedView];
    [self atItemIndex:_suspendedView.currentItemIndex];
    
    if (self.logistics_ids.count == 1) {
        _suspendedView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 1);
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, SuspendedViewHeight-0.5, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_suspendedView addSubview:line];
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, _suspendedView.maxY, UI_SCREEN_WIDTH, 110)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
    [firstView addSubview:image];
    
    imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, image.height - 20, image.width, 20)];
    imageButton.backgroundColor = Color334C6B;
    imageButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [image addSubview:imageButton];
    
    orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(image.maxX + 12, image.minY, UI_SCREEN_WIDTH - image.maxX - 24, 20)];
    orderNumber.textColor = Color74828B;
    orderNumber.font = [UIFont systemFontOfSize:14];
    orderNumber.textAlignment = NSTextAlignmentLeft;
    [firstView addSubview:orderNumber];
    
    sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(image.maxX + 12, orderNumber.maxY + 6, UI_SCREEN_WIDTH - image.maxX - 24, 20)];
    sourceLabel.textColor = Color74828B;
    sourceLabel.font = [UIFont systemFontOfSize:14];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    [firstView addSubview:sourceLabel];
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(image.maxX + 12, sourceLabel.maxY + 6, UI_SCREEN_WIDTH - image.maxX - 24, 20)];
    phoneLabel.textColor = Color74828B;
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [firstView addSubview:phoneLabel];
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.maxY + 10, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64 - 10 - firstView.maxY)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    scrillView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, UI_SCREEN_WIDTH, secondView.height - 50)];
    [secondView addSubview:scrillView];
}

- (void)didClickView:(SuspendedView *)view atItemIndex:(NSInteger)index {
    [self atItemIndex:index];
}

- (void)atItemIndex:(NSInteger)index {
    NSString *bodyStr = [NSString stringWithFormat:@"logistics_id=%@", self.logistics_ids[index]];
    [RCLAFNetworking postWithUrl:@"getLogistics.php" BodyString:bodyStr isPOST:YES success:^(id responseObject) {
        DLog(@"%@", responseObject);
        [self creationScroll:responseObject[@"cont"]];
    } fail:nil];
}

- (void)creationScroll:(NSDictionary *)dataDic {
    NSDictionary *proinfo = dataDic[@"proinfo"];
    [image sd_setImageWithURL:[NSURL URLWithString:proinfo[@"main_img_url"]]];
    [imageButton setTitle:[NSString stringWithFormat:@"共%@件商品", proinfo[@"nums"]] forState:UIControlStateNormal];
    orderNumber.text = [NSString stringWithFormat:@"货运单号: %@", dataDic[@"logistics_number"]];
    sourceLabel.text = [NSString stringWithFormat:@"承接来源: %@", dataDic[@"logistics_company_name"]];
    phoneLabel.text = [NSString stringWithFormat:@"官方电话: %@", dataDic[@"logistics_tel"]];
    
    NSArray *array = dataDic[@"logistics_traces"];
    if (![array isKindOfClass:[NSArray class]] || array== nil) {
        return;
    }
    
    [scrillView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat y = 0;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[array.count - i - 1];
        
        NSString *AcceptTime = [NSString stringWithFormat:@"%@", dic[@"AcceptTime"]];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 90, 20)];
        timeLabel.font = [UIFont systemFontOfSize:16];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = [AcceptTime timeTypeHourStr];
        [scrillView addSubview:timeLabel];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, timeLabel.maxY, 90, 10)];
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.text = [AcceptTime timeTypeMonthDayStr];
        [scrillView addSubview:dateLabel];
        
        UIImageView *image1 = [[UIImageView alloc] init];
        if (i == 0) {
            image1.frame = CGRectMake(timeLabel.maxX + 4, timeLabel.minY, 23, 23);
            image1.image = [UIImage imageNamed:@"locationSele@2x"];
        }else {
            image1.frame = CGRectMake(timeLabel.maxX + 10.5, timeLabel.minY, 10, 10);
            image1.image = [UIImage imageNamed:@"locationNo@2x"];
        }
        [scrillView addSubview:image1];
        
//        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(dateLabel.maxX + 50, timeLabel.minY, UI_SCREEN_WIDTH - dateLabel.maxX - 65, 20)];
//        statusLabel.textColor = Color334C6B;
//        statusLabel.font = [UIFont boldSystemFontOfSize:15];
//        statusLabel.textAlignment = NSTextAlignmentLeft;
//        statusLabel.text = @"已发货";
//        [scrillView addSubview:statusLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.numberOfLines = 0;
        contentLabel.text = [NSString stringWithFormat:@"%@", dic[@"AcceptStation"]];
        CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - dateLabel.maxX - 65, 100)];
        contentLabel.frame = CGRectMake(dateLabel.maxX + 50, timeLabel.minY, UI_SCREEN_WIDTH - dateLabel.maxX - 65, contentSize.height);
        [scrillView addSubview:contentLabel];
        
        if (i != array.count - 1) {
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(timeLabel.maxX + 15, image1.maxY, 1, 100)];
            lineView.image = [UIImage imageNamed:@"locationLine@2x"];
            [scrillView addSubview:lineView];
        }
        
        if (i == 0) {
            timeLabel.textColor = Color334C6B;
            dateLabel.textColor = Color334C6B;
            contentLabel.textColor = Color334C6B;
        }else {
            timeLabel.textColor = ColorB0B8BA;
            dateLabel.textColor = ColorB0B8BA;
            contentLabel.textColor = ColorB0B8BA;
        }
        
        y += 100;
    }
    scrillView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, y + 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
