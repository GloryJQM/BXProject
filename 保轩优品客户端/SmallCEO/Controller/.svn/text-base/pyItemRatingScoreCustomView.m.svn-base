//
//  pyItemRatingScoreCustomView.m
//  WanHao
//
//  Created by Cai on 15-3-17.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "pyItemRatingScoreCustomView.h"

#import "UIColor+FlatUI.h"

@interface pyItemRatingScoreCustomView ()
@property (nonatomic, strong)pyStarRatingCustomView * bar2;

@end
@implementation pyItemRatingScoreCustomView

-(id)initWithFrame:(CGRect)frame titleStr:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        _degreeArr = [[NSArray alloc] initWithObjects:@"差",@"一般",@"好",@"很好",@"非常好", nil];
        _degreeArr = [[NSArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
        
        UILabel *leftTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15,(frame.size.height - 15.0)/2.0,192.0/2.0, 15.0)];
        leftTitleLab.backgroundColor = [UIColor clearColor];
        leftTitleLab.textAlignment = NSTextAlignmentLeft;
        leftTitleLab.font = [UIFont systemFontOfSize:15.0];
        leftTitleLab.textColor = [UIColor colorFromHexCode:@"#333333"];
        leftTitleLab.text = title;
        [self addSubview:leftTitleLab];
        
        
         self.bar2 = [[pyStarRatingCustomView alloc] initWithFrame:CGRectMake(leftTitleLab.frame.origin.x + leftTitleLab.frame.size.width, (frame.size.height - 27.0)/2.0, 326.0/2.0, 27.0) scoreImgFrame:CGRectMake(0, 0, 328.0/2.0, 28.0) selImgName:@"py_writereview_score_redd.png" normalImgName:@"py_writereview_score_gray.png"];
    _bar2.starratingDelegate = self;
        [self addSubview:_bar2];
        
        
        _degreeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bar2.frame.origin.x + self.bar2.frame.size.width,(frame.size.height - 15.0)/2.0,frame.size.width - self.bar2.frame.origin.x - self.bar2.frame.size.width, 16.0)];
        _degreeLab.backgroundColor = [UIColor clearColor];
        _degreeLab.textAlignment = NSTextAlignmentCenter;
        _degreeLab.font = [UIFont systemFontOfSize:14.0];
        _degreeLab.textColor = [UIColor colorFromHexCode:@"#333333"];
        [self addSubview:_degreeLab];
    }
    return self;
}


-(void)ratingScoreSelectWithFlag:(BOOL)isSelect withCount:(NSInteger)countNum
{
    
    
    if ((countNum - 1) < _degreeArr.count) {
        _degreeLab.text = [NSString stringWithFormat:@"%@",[_degreeArr objectAtIndex:countNum - 1]];
        
        if ([_itemDelegate respondsToSelector:@selector(pyItemRatingCustomViewSelectWithIndex:starNum:)]) {
            [_itemDelegate pyItemRatingCustomViewSelectWithIndex:_itemscoreIndex starNum:countNum];
        }
    }
}

- (void)setStartNum:(NSInteger)startNum
{
    self.bar2.starNumber = startNum;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
