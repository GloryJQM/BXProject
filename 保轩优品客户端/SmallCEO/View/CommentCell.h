//
//  CommentCell.h
//  chufake
//
//  Created by pan on 13-12-6.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface CommentCell : UITableViewCell


@property(weak)         NSString *reuseIdentifierStr;
@property(strong)       UILabel *numberLabel;
@property (strong)      AMRatingControl *ratingControl;
@property (strong)      UILabel *timeLabel;
@property (strong)      UILabel *nameLabel;
@property (strong)      UILabel *contentLabel;

+ (float)calculateCellHeight:(NSString *)str;

@end
