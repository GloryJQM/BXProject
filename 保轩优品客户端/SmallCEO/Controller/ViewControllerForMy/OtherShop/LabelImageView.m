//
//  LabelImageView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "LabelImageView.h"

@implementation LabelImageView
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic block:(void(^)(NSInteger index, NSArray *array))block {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 100)];
    if (self) {
        self.imageArray = [NSMutableArray array];
        self.index = 0;
        self.finishBlock = block;
        
        
        self.backgroundColor = [UIColor whiteColor];
        UILabel * zhanshi = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 20)];
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc]initWithString:@"  小店展示"];
        NSTextAttachment *attch1 = [[NSTextAttachment alloc]init];
        attch1.image = [UIImage imageNamed:@"icon-guogai@2x"];
        attch1.bounds = CGRectMake(0, -3, 18, 18);
        NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch1];
        [attri1 insertAttributedString:string1 atIndex:0];
        zhanshi.attributedText = attri1;
        zhanshi.font = [UIFont systemFontOfSize:15];
        zhanshi.textColor = [UIColor blackColor];
        zhanshi.textAlignment = NSTextAlignmentCenter;
        [self addSubview:zhanshi];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, zhanshi.maxY + 10, UI_SCREEN_WIDTH - 10, 1)];
        line.backgroundColor = WHITE_COLOR2;
        [self addSubview:line];
        
        self.y = line.maxY;
        
        NSString *h5String=[NSString stringWithFormat:@"%@",[dataDic valueForKey:@"show_content"]];
        
        NSArray *arr = [h5String componentsSeparatedByString:@"\n"];
        NSMutableArray * contentArr = [NSMutableArray arrayWithArray:arr];
        
        
        for (int i= 0; i < contentArr.count; i++) {
            NSArray *imageArr = [NSString getImageArrWtihH5string:contentArr[i]];
            if (imageArr.count > 0) {
                for (int j =0 ; j < imageArr.count; j++) {
                    if (j == 0) {
                        [contentArr replaceObjectAtIndex:i withObject:imageArr[0]];
                    }else {
                        [contentArr insertObject:imageArr[j] atIndex:i + j];
                    }
                }
                [_imageArray addObject:contentArr[i]];
                [self addImageView:contentArr[i]];
            }else {
                //属于文字
                NSString *str = contentArr[i];
                str =  [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                str =  [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
                [contentArr replaceObjectAtIndex:i withObject:str];
                [self addLabel:str];
            }
        }
        
        self.frame = CGRectMake(0, y, UI_SCREEN_WIDTH, self.y + 10);

    }
    return self;
}

- (void)addImageView:(NSString *)imageUrl {
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.y + 10, UI_SCREEN_WIDTH, 234 / 375.0 * UI_SCREEN_WIDTH)];
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    self.y = imageView.maxY + 0;
    
    UIButton *btnI=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,UI_SCREEN_WIDTH, 210)];
    btnI .backgroundColor=[UIColor clearColor];
    btnI.layer.cornerRadius=0;
    btnI.tag = self.index;
    [btnI addTarget:self action:@selector(lookThroughPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btnI];
    self.index += 1;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}

- (void)addLabel:(NSString *)textStr {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.y + 10, UI_SCREEN_WIDTH - 20, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = textStr;
    label.textAlignment = NSTextAlignmentCenter;
    CGSize size = [label sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 20, CGFLOAT_MAX)];
    label.frame = CGRectMake(10, self.y + 10, UI_SCREEN_WIDTH - 20, size.height + 5);
    [self addSubview:label];
    
    self.y = label.maxY;
}

- (void)lookThroughPhoto:(UIButton *)sender {
    if (self.finishBlock) {
        self.finishBlock(sender.tag, _imageArray);
    }
}

@end
