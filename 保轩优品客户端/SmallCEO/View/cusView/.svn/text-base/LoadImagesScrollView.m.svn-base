//
//  LoadImagesScrollView.m
//  Lemuji
//
//  Created by quanmai on 15/7/27.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "LoadImagesScrollView.h"
#import "JJPhotoManeger.h"

@interface LoadImagesScrollView ()<JJPhotoDelegate>

@property (nonatomic, copy) NSMutableArray *imageViewArr;

@end

@implementation LoadImagesScrollView
@synthesize imageUrlArr;
@synthesize contentUrlArr;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewArr = [[NSMutableArray alloc] initWithCapacity:0];
        self.downImageArr=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)addImageToScrollView:(int)index{
    if (index==0) {
        [self.downImageArr removeAllObjects];
    }
    DLog(@"imageArr:%@",imageUrlArr);
    static float curY=0;
    
    if (index>=imageUrlArr.count) {
        if ([self.loadDelegate respondsToSelector:@selector(gameOver)]) {
            [self.loadDelegate gameOver];
        }
        return;
    }
    if (index==0) {
        curY=0;
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
    }

    UIImageView *temp=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    temp.tag = index;
    temp.backgroundColor=[UIColor whiteColor];
    [self addSubview:temp];

    [_imageViewArr addObject:temp];
    
    NSString *urlString=[imageUrlArr objectAtIndex:index];
    urlString=[urlString stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    __weak UIImageView *weakImage=temp;
    [temp setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        float mult=image.size.height/image.size.width;
        float imageHeight=mult*UI_SCREEN_WIDTH;
        
        if([urlString isEndssWith:@".gif"]){
            UIWebView *web=[[UIWebView alloc] initWithFrame:CGRectMake(0, curY,UI_SCREEN_WIDTH, imageHeight)];
            web.backgroundColor=[UIColor whiteColor];
            [self addSubview:web];
            web.scalesPageToFit=YES;
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            
        }else{
            weakImage.frame=CGRectMake(0, curY,UI_SCREEN_WIDTH, imageHeight);
            weakImage.image=image;
        }

        UIButton *btnI=[[UIButton alloc] initWithFrame:CGRectMake(0, curY,UI_SCREEN_WIDTH, imageHeight)];
        btnI .backgroundColor=[UIColor clearColor];
        btnI.layer.cornerRadius=0;
        btnI.tag=index;
        [btnI addTarget:self action:@selector(lookThroughPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnI];
        
        [self.downImageArr addObject:image];
        curY=curY+imageHeight;
        
        //避免在滚动的时候图片还没加载玩导致滚动不流畅
        self.contentSize=CGSizeMake(UI_SCREEN_WIDTH, curY+400);
        if (index==imageUrlArr.count-1) {
            self.contentSize=CGSizeMake(UI_SCREEN_WIDTH, curY);
        }
        [self addImageToScrollView:index+1];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [self addImageToScrollView:index+1];
    }];
}

-(void)lookThroughPhoto:(UIButton *)button {
    UIImageView *view = (UIImageView *)[_imageViewArr objectAtIndex:button.tag];
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    mg.viewController = [self viewController].navigationController;
    [mg showLocalPhotoViewer:_imageViewArr selecView:view];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
