//
//  DrawLabelAndButton.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-30.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "DrawLabelAndButton.h"
#import "CourseConfig.h"

@implementation DrawLabelAndButton
//static DrawLabelAndButton* sharedManager = nil;

#pragma mark - 单例初始化


-(DrawLabelAndButton*) initWithMainViewFrame:(CGRect) mainViewFrame{
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedManager = [[self alloc] init];
//        
//        [sharedManager calWidthAndHeightWithMainViewFrame:mainViewFrame];
//        
//        [sharedManager initParams];
//    });
//    return sharedManager;
    
    self = [super init];
    
    if (self) {
        [self calWidthAndHeightWithMainViewFrame:mainViewFrame];
        [self initParams];
    }
    
    return self;
}


#pragma mark - 初始化week和section数组
//初始化week和section数组
-(void) initParams{

  
//    int hour = [dateComponent hour];
//    int minute = [dateComponent minute];
//    int second = [dateComponent second];
    
    NSArray *array = [self getMonthAndDay];
    NSString *dayStr = [array objectAtIndex:1];
    int day = dayStr.intValue;
    
    NSString *mon = [NSString stringWithFormat:@"%i\n%@",day,kMon];
    NSString *tue = [NSString stringWithFormat:@"%i\n%@",day+1,kTue];
    NSString *wed = [NSString stringWithFormat:@"%i\n%@",day+2,kWed];
    NSString *thu = [NSString stringWithFormat:@"%i\n%@",day+3,kThu];
    NSString *fir = [NSString stringWithFormat:@"%i\n%@",day+4,kFir];
    NSString *sat = [NSString stringWithFormat:@"%i\n%@",day+5,kSat];
    NSString *sun = [NSString stringWithFormat:@"%i\n%@",day+6,kSun];
    
    self.weeksArray = [[NSArray alloc] initWithObjects:mon,tue,wed,thu,fir,sat,sun,nil];
    self.sectionsArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];

}


#pragma mark - 计算时间
-(NSArray*)getMonthAndDay{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSLog(@"当前时间：%@",now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    //    int year = [dateComponent year];
    int month = [dateComponent month];
    int day = [dateComponent day];
    
    NSString *monthStr = [NSString stringWithFormat:@"%i",month];
    NSString *dayStr = [NSString stringWithFormat:@"%i",day];
    
    NSArray *array = [[NSArray alloc] initWithObjects:monthStr,dayStr, nil];
    
    return array;
}

//计算主要的数据
-(void)calWidthAndHeightWithMainViewFrame:(CGRect)mainViewFrame{
    //获取主屏幕的宽度和和滚动视图的高度
    int frmWidth = mainViewFrame.size.width;
    
    //获取weekLabel的原点
    self.point = mainViewFrame.origin;
    
    //目前先设定这些
    self.weekHeight = 30;
    self.sectionWidth = 20;
    
    self.weekWidth = (frmWidth - self.sectionWidth) / 7;
    self.sectionHeight = 46;

}


#pragma mark - 实例方法
//获得指定btn的frame
-(CGRect ) getBtnFrameforWeek:(int)week andSection:(int)section andSectionCount:(int) count{
    
    float x = self.point.x + self.sectionWidth + ((week - 1)* self.weekWidth) + 1.5;
    float y = ((section - 1) * self.sectionHeight) + 2;
    
    CGRect frame = CGRectMake(x, y, self.weekWidth - 3, self.sectionHeight*count - 4);
    
    return frame;
}

//获得weekLabel的frame
-(NSMutableArray*) getWeekLabelsFrame{
    NSMutableArray *labelArray = [[NSMutableArray alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.point.x, 0, self.sectionWidth, self.weekHeight)];
    
    NSArray *array = [self getMonthAndDay];
    NSString *month = [NSString stringWithFormat:@"%@月",[array objectAtIndex:0]];
    [label setText:month];
    [label setAdjustsFontSizeToFitWidth:YES];
    label.layer.borderWidth = 0.5;
    [label setTextColor:[self colorWithHexNumber:0x858CB alpha:0.6]];
    
    [labelArray addObject:label];
    
    for (int i = 0; i < 7; i++) {
        float x = self.point.x + self.sectionWidth + (self.weekWidth * i);
        float y = 0;
        CGRect rect = CGRectMake(x, y, self.weekWidth, self.weekHeight);
        
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        
        [label setText:[self.weeksArray objectAtIndex:i]];
        
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setTextColor:[self colorWithHexNumber:0x858CB alpha:0.6]];
        
        label.layer.borderWidth = 0.3;
        
        [labelArray addObject:label];
    }
    
    return labelArray;
}

#pragma mark - 获取十六进制的color
- (UIColor*)colorWithHexNumber:(NSUInteger)hexColor alpha:(CGFloat)alpha{
    float r = ((hexColor>>16) & 0xFF) / 255.0f;
    float g = ((hexColor>>8) & 0xFF) / 255.0f;
    float b = (hexColor & 0xFF) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}


//获得sectionLabel的frame
-(NSMutableArray *)getSectionLabelsFrame{
    NSMutableArray *labelArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 12; i++) {
        float x = self.point.x;
        float y = (self.sectionHeight * i);
        
        CGRect rect = CGRectMake(x, y, self.sectionWidth, self.sectionHeight);
        
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        
        [label setText:[self.sectionsArray objectAtIndex:i]];
        
        [label setTextColor:[UIColor blueColor]];
        
        label.layer.borderWidth = 0.3;

        [label setTextColor:[self colorWithHexNumber:0x858CB alpha:0.6]];
        
        [labelArray addObject:label];
    }
    
    return labelArray;
}

-(float)getContentSizeHeight{
    self.contentSizeHeight = self.sectionHeight * 15 + 6;
    return self.contentSizeHeight;
}
@end
