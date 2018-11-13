//
//  StandardButton.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/14.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "StandardButton.h"
@interface StandardButton(){
    CGFloat _y;
    NSDictionary *_dataDic;
    
    UIButton *seleButton;
    NSInteger _index;
    NSString *_goods_id;
    NSArray *_product_list;
}

@end
@implementation StandardButton
- (instancetype)initWithY:(CGFloat)y DictionAry:(NSDictionary *)dataDic index:(NSInteger)index block:(void (^) (NSString *idString, NSInteger index))block goods_id:(NSString *)goods_id product_list:(NSArray *)product_list {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 50)];
    if (self) {
        _index = index;
        self.finishBlock = block;
        _y = y;
        _dataDic = dataDic;
        _goods_id = goods_id;
        _product_list = product_list;
        [self creationButton];
    }
    return self;
}

- (void)creationButton {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 25, UI_SCREEN_WIDTH - 32, 20)];
    titleLabel.text = _dataDic[@"name"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = Color161616;
    [self addSubview:titleLabel];
    
    
    NSArray *array = _dataDic[@"data"];
    CGFloat space = 15.0;
    CGFloat y = titleLabel.maxY + 10;
    CGFloat x = space;
    CGFloat height = 40;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, 0, height);
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [UIColor colorFromHexCode:@"#E4E4E4"].CGColor;
        button.layer.borderWidth = 1;
        [button setTitleColor:[UIColor colorFromHexCode:@"#2A3034"] forState:UIControlStateNormal];
        [button setTitleColor:App_Main_Color forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@"%@", dic[@"name"]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 10 + i;
        
        CGSize sizeBut = [button.titleLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, height)];
        if ((UI_SCREEN_WIDTH - x - sizeBut.width - 30 - 10) <= 0) {
            x = space;
            y = button.maxY + space;
        }
        button.frame = CGRectMake(x, y, sizeBut.width + 30, height);
        [self addSubview:button];
        x = space + button.maxX;
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == array.count - 1) {
            self.frame = CGRectMake(0, _y, UI_SCREEN_WIDTH, button.maxY + space);
            [self addLineWithY:self.height - 0.5 X:15 width:UI_SCREEN_WIDTH - 30];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width - 8, button.height - 8, 8, 8)];
        imageView.tag = 100;
        imageView.image = [UIImage imageNamed:@"圆角.jpg"];
        [button addSubview:imageView];
        
        
        button.selected = NO;
        imageView.hidden = YES;
        
        NSString *idString = [NSString stringWithFormat:@"%@", dic[@"id"]];
        
        if ([_goods_id isEqualToString:idString]) {
            [self button:button];
        }
        
        
        if (![_product_list containsObject:idString]) {
            button.tag = 1000;
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            button.layer.borderColor = [UIColor colorFromHexCode:@"#E4E4E4"].CGColor;
        }
    }
}

- (void)button:(UIButton *)sender {
    if (sender.selected) {
        UIImageView *image1 = [seleButton viewWithTag:100];
        image1.hidden = YES;
        sender.layer.borderColor = [UIColor colorFromHexCode:@"#E4E4E4"].CGColor;
        seleButton = nil;
        if (self.finishBlock) {
            self.finishBlock(@"0",_index);
        }
    }else {
        
        seleButton.selected = !seleButton.selected;
        
        UIImageView *image1 = [seleButton viewWithTag:100];
        image1.hidden = YES;
        seleButton.layer.borderColor = [UIColor colorFromHexCode:@"#E4E4E4"].CGColor;
        
        UIImageView *image = [sender viewWithTag:100];
        image.hidden = NO;
        sender.layer.borderColor = Color334C6B.CGColor;
        seleButton = sender;
        
        NSDictionary *dic = _dataDic[@"data"][sender.tag - 10];
        if (self.finishBlock) {
            self.finishBlock(dic[@"id"],_index);
        }
    }
    
    
    sender.selected = !sender.selected;
    
    
    
}
@end
