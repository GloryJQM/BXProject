//
//  ShopCategoryCell.m
//  WanHao
//
//  Created by csl on 14-12-23.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ShopCategoryCell.h"

@implementation ShopCategoryCell
@synthesize cellLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellLabel = [[UILabel alloc] init];
        cellLabel.frame=CGRectMake(0, 12, 75, 16);
        cellLabel.backgroundColor = [UIColor clearColor];
        cellLabel.textAlignment=NSTextAlignmentCenter;
        cellLabel.textColor = [UIColor blackColor];
        cellLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:cellLabel];
        
        UIView *line=[[UIView alloc ] initWithFrame:CGRectMake(0, 39, self.frame.size.width, 1)];
        line.backgroundColor=myRGBA(217, 217, 217, 0.5);
        [self.contentView addSubview:line];
        
        
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor =[UIColor colorFromHexCode:@"#7fb80e"];
        cellLabel.textColor=[UIColor whiteColor];
    }
    else {
         self.backgroundColor =myRGBA(235, 235, 235, 1);
        cellLabel.textColor= [UIColor blackColor];
        
    }


    // Configure the view for the selected state
}

@end
