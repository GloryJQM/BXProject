//
//  SearchSelectCell.m
//  Lemuji
//
//  Created by quanmai on 15/7/17.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "SearchSelectCell.h"

@interface SearchSelectCell (){
    
}

@end

@implementation SearchSelectCell
@synthesize titleLable;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        imageV.backgroundColor=[UIColor clearColor];
//        imageV.layer.cornerRadius=0;
        imageV.image=[UIImage imageNamed:@"icon-sousuo@2x.png"];
        imageV.contentMode=UIViewContentModeCenter;
        [self addSubview:imageV];
        
        titleLable=[[UILabel alloc] initWithFrame:CGRectMake(44, 0, UI_SCREEN_WIDTH-54, 44)];
        titleLable.textColor=BLACK_COLOR;
        titleLable.font=[UIFont boldSystemFontOfSize:15];
        titleLable.backgroundColor=[UIColor clearColor];
        [self addSubview:titleLable];
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
