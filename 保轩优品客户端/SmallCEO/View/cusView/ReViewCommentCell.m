//
//  ReViewCommentCell.m
//  WanHao
//
//  Created by Lai on 14-4-18.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ReViewCommentCell.h"

@implementation ReViewCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftImagV = [[UIImageView alloc] init];
        _leftImagV.backgroundColor = [UIColor clearColor];
        _leftImagV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_leftImagV];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_titleLabel];
        
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _timeLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_timeLabel];
        
        
        _ratBg=[[UIView alloc]init];
        _ratBg.frame=CGRectMake(60, 50, UI_SCREEN_WIDTH-70, 80);
        _ratBg.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_ratBg];
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _descriptionLabel.font = [UIFont systemFontOfSize:15.0];
        _descriptionLabel.text=@"描述相符：";
        [_ratBg.self addSubview:_descriptionLabel];
        
        _qualityLabel = [[UILabel alloc] init];
        _qualityLabel.backgroundColor = [UIColor clearColor];
        _qualityLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _qualityLabel.font = [UIFont systemFontOfSize:15.0];
        _qualityLabel.text=@"发货速度：";
        [_ratBg.self addSubview:_qualityLabel];
        
        _speedLabel = [[UILabel alloc] init];
        _speedLabel.backgroundColor = [UIColor clearColor];
        _speedLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _speedLabel.font = [UIFont systemFontOfSize:15.0];
        _speedLabel.text=@"服务咨询：";
        [_ratBg.self addSubview:_speedLabel];
        
        _speed_star = [[AMRatingControl alloc] initWithLocation:CGPointZero emptyColor:[UIColor colorFromHexCode:@"#FF7F66"] solidColor:[UIColor colorFromHexCode:@"#FF7F66"] andMaxRating:5];
        _speed_star.userInteractionEnabled = NO;
        [_ratBg.self addSubview:_speed_star];
        
        _quality_star = [[AMRatingControl alloc] initWithLocation:CGPointZero emptyColor:[UIColor colorFromHexCode:@"#FF7F66"] solidColor:[UIColor colorFromHexCode:@"#FF7F66"] andMaxRating:5];
        _quality_star.userInteractionEnabled = NO;
        [_ratBg.self addSubview:_quality_star];
        
        _description_star = [[AMRatingControl alloc] initWithLocation:CGPointZero emptyColor:[UIColor colorFromHexCode:@"#FF7F66"] solidColor:[UIColor colorFromHexCode:@"#FF7F66"] andMaxRating:5];
        _description_star.userInteractionEnabled = NO;
        [_ratBg.self addSubview:_description_star];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.numberOfLines = 0;
        _contentLabel.frame = CGRectMake(0, 60, UI_SCREEN_WIDTH-70, 20);
        [_ratBg.self addSubview:_contentLabel];
        
    }
    
    
    return self;
    
}

-(void)layoutSubviews{
    
    _leftImagV.frame = CGRectMake(8, 8, 50, 50);// CGPointMake(50, self.frame.size.height / 2.0);
    _titleLabel.frame = CGRectMake(60, 8, UI_SCREEN_WIDTH-70, 20);
    _timeLabel.frame = CGRectMake(60, 30, 250, 20);
    _description_star.frame = CGRectMake(80,0, 250, 20);
    _quality_star.frame = CGRectMake(80,20,  250, 20);
    _speed_star.frame = CGRectMake(80, 40, 250, 20);
    _descriptionLabel.frame = CGRectMake(0, 0, 80, 20);
    _qualityLabel.frame = CGRectMake(0, 20, 80, 20);
    _speedLabel.frame = CGRectMake(0, 40, 80, 20);
    
}

-(void)setViewDit:(id)viewDit{
    
    
    NSLog(@"icon_urlimage%@",[viewDit objectForKey:@"picurl"]);
    [_leftImagV af_setImageWithURL:[NSURL URLWithString:[viewDit objectForKey:@"picurl"]]];
    _titleLabel.text = [viewDit objectForKey:@"subject"];
    
    NSArray *list = [[viewDit objectForKey:@"commentdetail"] objectForKey:@"list"];
    if (list.count <= 0) {
        return;
    }
    NSDictionary *starDic = [list objectAtIndex:0];
    
    _contentLabel.text = [starDic objectForKey:@"comment_content"];
    _timeLabel.text = [starDic objectForKey:@"log_time"];
    
    _description_star.rating = [[starDic objectForKey:@"describe_comment_lvl"] integerValue];
    _quality_star.rating = [[starDic objectForKey:@"consignment_comment_lvl"] integerValue];
    _speed_star.rating = [[starDic objectForKey:@"service_comment_lvl"] integerValue];
    
    CGRect rect = [_contentLabel.text boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    CGFloat height = rect.size.height >= 20 ?rect.size.height:20;
    _contentLabel.frame =CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, _contentLabel.frame.size.width, height);
    _ratBg.frame=CGRectMake(_ratBg.frame.origin.x, _ratBg.frame.origin.y, _ratBg.frame.size.width, height+60);
    
    
}


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
