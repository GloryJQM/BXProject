//
//  ChooseTypeView.h
//  SmallCEO
//
//  Created by huang on 2017/6/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^doneBlock)(NSInteger );
@interface ChooseTypeView : UIView
@property (nonatomic,strong)doneBlock doneBlock;
-(instancetype)initWithCompleteBlock:(void(^)(NSInteger ))completeBlock andType:(NSInteger)type;

-(void)show;
@property (nonatomic, assign) NSInteger type;
@end
