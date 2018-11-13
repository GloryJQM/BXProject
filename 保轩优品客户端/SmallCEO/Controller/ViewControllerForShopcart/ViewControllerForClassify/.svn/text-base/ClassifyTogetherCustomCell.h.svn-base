//
//  ClassifyCustomCell.h
//  WanHao
//
//  Created by wuxiaohui on 14-2-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ClassifyChoseDelegate <NSObject>
//-(void)claddifyChoseBtnIndex:(NSInteger)index withTabeleView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withID:(NSInteger)ID withName:(NSString *)name;
//@end

@protocol ClassifyTogetherDelegate <NSObject>

//-(void)claddifyTogetherBtnIndex:(NSInteger)index withTabeleView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withID:(NSInteger)ID withName:(NSString *)name;
-(void)claddifyTogetherBtnIndex:(NSInteger)index withTabeleView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withID:(NSInteger)ID withName:(NSString *)name itemdic:(NSDictionary *)item;
@end

@interface ClassifyTogetherCustomCell : UITableViewCell{
    UIImageView  *_leftImagV;
    UILabel      *_titleLabel;
    UILabel      *_subTLabel;
    UIImageView  *_rightImageV;
    NSString     *_reuseIdentifier;
    NSArray *_idArray;
    
    //聚合二级随意显示
    BOOL        _image;
}

//@property (weak) id<ClassifyChoseDelegate> delegate;
@property (weak) id<ClassifyTogetherDelegate> delegate;
@property (nonatomic,strong) UITableView    *cellTableView;
@property (nonatomic,strong) NSIndexPath    *indexPath;
@property (nonatomic ,strong) NSMutableArray    *btnArray;
-(void)setViewDit:(id)viewDit;

@end
