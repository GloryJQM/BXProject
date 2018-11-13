//
//  ReviewUncommentCell.h
//  WanHao
//
//  Created by Lai on 14-4-21.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UncommentDelegate <NSObject>
-(void)UncommentBtnIndex:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end

@interface ReviewUncommentCell : UITableViewCell{
    UIView *_ratBg;
    UIImageView  *_leftImagV;
    UILabel      *_titleLabel;
    UILabel      *_priceLabel;
    UILabel      *_countLabel;
    UIButton     *_btn;
    NSString     *_reuseIdentifier;
    NSArray      *_idArray;
}

-(void)setViewDit:(id)viewDit;
@property (nonatomic,strong) UITableView    *cellTableView;
@property (nonatomic,strong) NSIndexPath    *indexPath;

@property (weak) id<UncommentDelegate> delegate;

@end
