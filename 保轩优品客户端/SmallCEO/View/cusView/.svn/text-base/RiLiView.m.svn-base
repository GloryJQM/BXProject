//
//  RiLiView.m
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "RiLiView.h"

@implementation RiLiView
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andYear:(int)year andMonth:(int)month :(NSDictionary *)dic withStep:(BOOL)isStep
{
    self = [super initWithFrame:frame];
    if(self)
    {
        NSDate* now = [NSDate date];
        NSDateFormatter* fa = [[NSDateFormatter alloc]init];
        fa.dateFormat = @"yyyy-MM-dd";
        NSString* dateStr = [fa stringFromDate:now];
        NSArray* arr = [dateStr componentsSeparatedByString:@"-"];
        DLog(@"%@",arr);
        
        self.date = [[DateOut alloc]init];
        int allDay = [self.date allDayInYear:year andMonth:month];
        self.all = allDay;
        int firstDay = [self.date theFirstDayIsInYear:year andMonth:month];
        self.RfirstDay = firstDay;
        int lastDay = [self.date theLastDayInLastMonth:year and:month];
        
        [self getTimeWith:dic withStep:isStep];
        int row = 0;
        if(allDay==28 && firstDay == 1)
        {
            row = 4;
        }else if(firstDay == 7 &&  allDay>29)
        {
            row = 6;
        }else if(firstDay == 6 &&  allDay>30)
        {
            row = 6;
        }else
        {
            row = 5;
        }
        
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, row*44);
        float width = (UI_SCREEN_WIDTH-30)/7;
        
        for(int i=0;i<row*7;i++)
        {
            UIView* vi = [[UIView alloc]initWithFrame:CGRectMake(15+(i%7)*width, 0+(i/7)*44, width, 44)];
            vi.backgroundColor = [UIColor whiteColor];
            self.dateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, width, 20)];
            self.dateLab.font = GFB_FONT_XT 14];
            self.dateLab.textAlignment = NSTextAlignmentCenter;
            self.dateLab.tag = year*10000+month*100+i-firstDay+2;
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whichOne:)];
            self.dateLab.userInteractionEnabled =   NO;
            [self.dateLab addGestureRecognizer:tap];
            
            self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 30, 17)];
            self.timeLab.text = @"";
            self.timeLab.textColor = [UIColor colorFromHexCode:@"008CD6"];
            self.timeLab.font = GFB_FONT_XT 8];
            
            if((i+1)<firstDay)
            {
                self.dateLab.textColor = LINE_COLOR;
                self.dateLab.text = [NSString stringWithFormat:@"%d",lastDay-(firstDay-1)+i+1];
            }else if((i+1)>=firstDay && (i+1)<=allDay+(firstDay-1))
            {
                self.dateLab.userInteractionEnabled = YES;
                self.dateLab.textColor = LAB_COLOR;
                self.dateLab.text = [NSString stringWithFormat:@"%d",i+1-firstDay+1];
                DLog(@"%ld",self.arrTime.count);
                self.timeLab.text = self.arrTime[i+1-firstDay];
                if ([self.timeLab.text isEqualToString:@"0"]) {
                    self.timeLab.hidden = YES;
                }
                
                if (isStep == YES) {
                    NSString *curDay=[self.arrDay objectAtIndex:(i+1-firstDay)];
                    if ([curDay intValue]!=0) {
                        UIImageView *imageView=[[UIImageView alloc ] initWithFrame:CGRectMake(13, 15, 29/2, 31/2)];
                        imageView.image = [UIImage imageNamed:@"iconfont-jiaoyin.png"];
                        [vi addSubview:imageView];
                    }
  
                }
                
                if(year == [arr[0] integerValue] && month == [arr[1] integerValue] && (i+1-firstDay)>=[arr[2] integerValue])
                {
                    self.dateLab.textColor = LINE_COLOR;
                    self.dateLab.userInteractionEnabled = NO;
                }
                
            }else
            {
                self.dateLab.textColor = LINE_COLOR;
                self.dateLab.text = [NSString stringWithFormat:@"%d",i+1-allDay-(firstDay-1)];
            }
            [vi addSubview:self.dateLab];
            [vi addSubview:self.timeLab];
            
            [self addSubview:vi];
        }
        return self;
    }
    return nil;
}

-(long)whichOne:(id)sender
{
    UILabel* lab = (UILabel*)[sender view];
    NSString* str = [NSString stringWithFormat:@"%ld",lab.tag];
    int day = (int)[[str substringFromIndex:6] integerValue];
    DLog(@"%ld",self.arrTime.count);
    DLog(@"%@",self.arrTime);
    DLog(@"%d",day);
    
    if ([delegate respondsToSelector:@selector(giveUp:work:)]) {
        [delegate giveUp:lab.tag work:[self.arrTime[day-1] floatValue]];
    }
    
    return lab.tag;
}



-(void)getTimeWith:(NSDictionary*)dic withStep:(BOOL)isStep
{
    self.arrDay = [NSMutableArray arrayWithCapacity:0];
    self.arrTime = [NSMutableArray arrayWithCapacity:0];
    NSArray* temp = [dic objectForKey:@"days"];
    
    
    for(int i =0;i<self.all;i++)
    {
        [self.arrDay addObject:@"0"];
        [self.arrTime addObject:@""];
    }
    
    
    for(int i =0;i<self.all;i++)
    {
        for(int j = 0;j<temp.count;j++)
        {
            NSString *day=[temp[j] objectForKey:@"days"];
            NSString *money=[NSString stringWithFormat:@"%@",[temp[j] objectForKey:@"money"]];
            if([[temp[j] objectForKey:@"days"] integerValue]==(i+1))
            {
                [self.arrDay replaceObjectAtIndex:i withObject:day];
                if (isStep == NO) {
                    [self.arrTime replaceObjectAtIndex:i withObject:money];
                }
            }
        }
    }
}

@end
