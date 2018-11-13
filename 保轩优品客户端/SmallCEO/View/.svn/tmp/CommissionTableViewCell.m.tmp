//
//  CommissionTableViewCell.m
//  SmallCEO
//
//  Created by huang on 2017/3/9.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "CommissionTableViewCell.h"

@implementation CommissionTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CompanyServeVCCell";
    CommissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CommissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle= UITableViewCellSelectionStyleNone;
        self.contentView.height = 60;
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];

        [self.contentView addSubview:_headImage];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 150, 20)];
        //name.text = DataArray[indexPath.row][@"1"];
        [self.contentView addSubview:_moneyLabel];
        
        _detail = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 150, 20)];
        _detail.text = @"推荐好友获得";
        _detail.font = [UIFont systemFontOfSize:14];
        _detail.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detail];
        
        _time = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-110, 10, 100, 20)];
        //time.text = DataArray[indexPath.row][@"t"];
        _time.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_time];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-110, 30, 100, 20)];
        //date.text = DataArray[indexPath.row][@"date"];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLabel];
//        UIImageView *headImage=[[UIImageView alloc] init];
//        headImage.frame = CGRectMake(20, 10, 40, 40);
//        headImage.backgroundColor = [UIColor clearColor];
//        //        headImage.image = [UIImage imageNamed:@"app_logo"];
//        [self.contentView addSubview:headImage];
//        _headImageView = headImage;
//        
//        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImage.maxX+10 , 10, UI_SCREEN_WIDTH / 2.0 - 15, 40.0)];
//        nameLabel.font = [UIFont systemFontOfSize:15.0];
//        nameLabel.textAlignment = NSTextAlignmentLeft;
//        nameLabel.textColor = [UIColor colorFromHexCode:@"666666"];
//        [self.contentView addSubview:nameLabel];
//        _nameLabel = nameLabel;
        
        //        UIImageView *headImage=[[UIImageView alloc] init];
        //        headImage.frame = CGRectMake(20, 10, 40, 40);
        //        headImage.backgroundColor = [UIColor clearColor];
        //        headImage.image = [UIImage imageNamed:@"app_logo"];
        //        [self.contentView addSubview:headImage];
    }
    return self;
}


@end
