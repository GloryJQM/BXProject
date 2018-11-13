//
//  pyStarRatingCustomView.m
//  WanHao
//
//  Created by Cai on 15-3-17.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "pyStarRatingCustomView.h"

@interface pyStarRatingCustomView()
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,assign) CGFloat starWidth;

@end

@implementation pyStarRatingCustomView

- (id)initWithFrame:(CGRect)frame scoreImgFrame:(CGRect)scoreFrame selImgName:(NSString *)selimgName normalImgName:(NSString *)norimgName
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.bottomView = [[UIView alloc] initWithFrame:scoreFrame];
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        
        self.topView.clipsToBounds = YES;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        //
        CGFloat width = frame.size.width/5.0;
        self.starWidth = width;
        
        for(int i = 0;i<1;i++){
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scoreFrame.size.width, scoreFrame.size.height)];
            img.image = [UIImage imageNamed:norimgName];
            [self.bottomView addSubview:img];
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:img.frame];
//            img2.center = img.center;
            img2.image = [[UIImage imageNamed:norimgName] imageWithColor:myRgba(249, 86, 81, 1)];;
            [self.topView addSubview:img2];
        }
        
        self.touchEnable = YES;
        
    }
    return self;
}

-(void)setViewColor:(UIColor *)backgroundColor{
    if(_viewColor!=backgroundColor){
        self.backgroundColor = backgroundColor;
        self.topView.backgroundColor = backgroundColor;
        self.bottomView.backgroundColor = backgroundColor;
    }
}
-(void)setStarNumber:(NSInteger)starNumber{
    if(_starNumber!=starNumber){
        _starNumber = starNumber;
        self.topView.frame = CGRectMake(0, 0, self.starWidth*starNumber, self.bounds.size.height);
    }
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    if(self.touchEnable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth)+1;
        self.topView.frame = CGRectMake(0, 0, self.starWidth*count, self.bounds.size.height);
        if(count>5){
            _starNumber = 5;
        }else{
            _starNumber = count;
        }
        
        if (_starNumber > 0) {
            _isSelectedFlag = YES;
        }else{
            _isSelectedFlag = NO;
        }
        if ([_starratingDelegate respondsToSelector:@selector(ratingScoreSelectWithFlag:withCount:)]) {
            [_starratingDelegate ratingScoreSelectWithFlag:_isSelectedFlag withCount:_starNumber];
        }
        
       
        
    }
}
-(void)pan:(UIPanGestureRecognizer *)gesture{
    if(self.touchEnable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth)+1;
        
        if(count>=1 && count<=6 && _starNumber!=count){
            self.topView.frame = CGRectMake(0, 0, self.starWidth*count, self.bounds.size.height);
            _starNumber = count;
            if (_starNumber > 5) {
                _starNumber = 5;
            }
            
            
            if (_starNumber > 0) {
                _isSelectedFlag = YES;
            }else{
                _isSelectedFlag = NO;
            }
            if ([_starratingDelegate respondsToSelector:@selector(ratingScoreSelectWithFlag:withCount:)]) {
                [_starratingDelegate ratingScoreSelectWithFlag:_isSelectedFlag withCount:_starNumber];
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
