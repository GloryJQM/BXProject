//
//  CommentTableViewCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/11/6.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "RatingBar.h"
#import "pyItemRatingScoreCustomView.h"
@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 12, 83, 78)];
        _goodsImageView.backgroundColor = [UIColor cyanColor];
        [self addSubview:_goodsImageView];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+14, 15, UI_SCREEN_WIDTH - CGRectGetMaxX(_goodsImageView.frame)-14-26, 40)];
        self.titleLabel.text = @"半亩花田超小颗粒海藻面膜保湿 免洗清洁收缩毛孔";
        self.titleLabel.textColor = [UIColor colorFromHexCode:@"#434343"];
        
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+14, CGRectGetMaxY(self.titleLabel.frame)+10, UI_SCREEN_WIDTH - CGRectGetMaxX(_goodsImageView.frame)-14-26, 20)];
        self.priceLabel.text = @"￥20";
        self.priceLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
        
        self.priceLabel.numberOfLines = 0;
        self.priceLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.priceLabel];
        
        
        UILabel *argueLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(_goodsImageView.frame)+20, 90, 20)];
        argueLabel.text = @"综合评价";
        argueLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
        
        argueLabel.numberOfLines = 0;
        argueLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:argueLabel];

        RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(argueLabel.frame)+16, CGRectGetMaxY(_goodsImageView.frame)+14, 180, 30)];
        
        [self addSubview:bar];
        
        self.argueTextView = [[UITextView alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(argueLabel.frame)+30, UI_SCREEN_WIDTH-65-18-18-20, 130/2)];
        self.argueTextView.text = @"写下对商品的评价, 改进我们的服务";
        self.argueTextView.backgroundColor = [UIColor colorFromHexCode:@"f9f9f9"];
        self.argueTextView.layer.borderWidth = 1;
        self.argueTextView.layer.cornerRadius = 5;
//        self.argueTextView.delegate = self;
        self.argueTextView.layer.borderColor = [UIColor colorFromHexCode:@"dddddd"].CGColor;
        [self addSubview:self.argueTextView];
        
        
        UIButton * photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        photoBtn.frame = CGRectMake(UI_SCREEN_WIDTH-65-18, CGRectGetMaxY(argueLabel.frame)+30, 65, 65);
        photoBtn.backgroundColor = [UIColor cyanColor];
        [self addSubview:photoBtn];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(photoBtn.frame)+16, UI_SCREEN_WIDTH, 200)];
        [self addSubview:bottomView];
        
        UIView * intervalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 11)];
        intervalView.backgroundColor = [UIColor colorFromHexCode:@"f3f4f6"];
        [bottomView addSubview:intervalView];
        
        
        UILabel *datailArgueLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(intervalView.frame)+18, 90, 20)];
        datailArgueLabel.text = @"详细评价";
        datailArgueLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
        
        datailArgueLabel.numberOfLines = 0;
        datailArgueLabel.font = [UIFont boldSystemFontOfSize:15];
        [bottomView addSubview:datailArgueLabel];

        
        NSArray *titleJudgeArr=@[@"描述相符", @"发货速度", @"服务咨询"];
        
        for (int i=0; i<3; i++) {
            pyItemRatingScoreCustomView *vi = [[pyItemRatingScoreCustomView alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(datailArgueLabel.frame)+18+30*i, self.frame.size.width, 28.0) titleStr:[NSString stringWithFormat:@"%@",[titleJudgeArr objectAtIndex:i]]];
            vi.itemscoreIndex = 90+i;
//            vi.itemDelegate = self;
            [bottomView addSubview:vi];
//            [_scoreItemArr addObject:vi];
        }


    }
    return self;
}


//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
