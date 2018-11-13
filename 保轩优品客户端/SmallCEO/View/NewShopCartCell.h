//
//  NewShopCartCell.h
//  SmallCEO
//
//  Created by nixingfu on 15/9/28.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumSelectView.h"
#import "ShopCartNumChangeView.h"

@protocol NewShopCartCellDelegate <NSObject>

-(void)changeCommodityNumWithIndex:(NSInteger)index   num:(NSString *)num;
-(void)beginEditWithIndex:(NSInteger)index;
-(void)selectAttrAtIndex:(NSInteger)index;
-(void)selectNameLabel:(NSInteger)index;

@optional

- (void)selectStatusDidchange:(NSInteger)index;
- (void)clickDeleteButton:(NSInteger)index;
- (void)didClickAtIndex:(NSInteger)index;

@end


@interface NewShopCartCell : UITableViewCell<UITextFieldDelegate>{
    UILabel *nameLabel;
    UILabel *formatLabel;
    
}

@property(nonatomic,assign) id<NewShopCartCellDelegate> delegate;
@property(nonatomic,strong) UIButton *choseComBtn;
@property(nonatomic,strong) UIButton *finishBtn;
@property(nonatomic,strong) NSMutableDictionary *myDic;
@property(nonatomic,strong) NumSelectView *numSelect;
@property(nonatomic,strong) UILabel* priceLab;
@property(nonatomic,strong) UILabel* subtotalLab;
@property(nonatomic,strong) UILabel* nameLab;
@property(nonatomic,strong) UIImageView* picImg;
@property(nonatomic,strong) UILabel* thLab;
@property(nonatomic,strong) UILabel* formatLab;
@property(nonatomic,strong) UIImageView *imageArrowView;
@property(nonatomic,strong) ShopCartNumChangeView *numChangeV;


-(void)updateWithDic:(NSMutableDictionary *)dic isEdit:(BOOL)bol;
-(void)updataWhenOnly:(NSDictionary*)dic;
-(void)updataWhenHome:(NSDictionary*)dic;
-(void)setGGWith:(NSString*)one andTwo:(NSString*)two andThree:(NSString*)three;
- (void)resetDeleteButtonStatus:(NSInteger)status;
/*商品清单*/
-(void)updateWithDicFromGoodList:(NSMutableDictionary *)dic isEdit:(BOOL)bol;

@end
