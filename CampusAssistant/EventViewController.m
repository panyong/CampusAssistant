//
//  EventViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-17.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "EventViewController.h"
#import "ImageConfig.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "KVNProgress.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eventTitle.delegate = self;
    _eventTime.delegate = self;
    _eventLocation.delegate = self;
    
    NSDate *nowDate = [NSDate date];
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    [_datePicker setMinimumDate:nowDate];
    UIButton *selectDateButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 50, 30)];
    [selectDateButton setTitle:@"确定" forState:UIControlStateNormal];
    [selectDateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [selectDateButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    UIView *datePickView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300)];
    [datePickView addSubview:_datePicker];
    [datePickView addSubview:selectDateButton];
    _eventTime.inputView =  datePickView;
    
    
    
    
    //设置右上角按钮
    UIImage *addImage = [UIImage imageNamed:kTimetable_addCourse_icon];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:addImage style:UIBarButtonItemStylePlain target:self action:@selector(addEvent:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];

    
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

-(void) selectTime{
    NSDate *selectDate = [_datePicker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:selectDate];
    
    [_eventTime setText:dateAndTime];
    
    [_eventTime resignFirstResponder];
}

-(void)addEvent:(id)sender{
    NSString *eventTitle = _eventTitle.text;
    NSString *eventTime = _eventTime.text;
    NSString *eventLocation = _eventLocation.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:eventTime];
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,
                                                                      NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                [KVNProgress showErrorWithStatus:error.localizedFailureReason];
            }
            else if (!granted)
            {
                [KVNProgress showErrorWithStatus:@"用户已拒绝日历请求"];
            }
            else
            {
                [KVNProgress showSuccessWithStatus:@"添加日历事件成功"];
                [self.navigationController popViewControllerAnimated:YES];
                EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
                myEvent.title     = [NSString stringWithFormat:@"事件:%@ 地点:%@",eventTitle,eventLocation];
                myEvent.startDate =  [date initWithTimeInterval:-5*60 sinceDate:date];
                
                myEvent.endDate   = [date initWithTimeInterval:1*60 sinceDate:date];
                myEvent.allDay = NO;
                [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
                NSError *err;
                [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
                
//                if (err == nil) {
//                    [KVNProgress showSuccessWithStatus:@"添加日历事件成功"];
//                    [self.navigationController popViewControllerAnimated:YES];
//                    
//                }else{
//                    [KVNProgress showErrorWithStatus:err.localizedFailureReason];
//                }

            }});
    }
            ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_eventLocation resignFirstResponder];
    [_eventTime resignFirstResponder];
    [_eventTitle resignFirstResponder];
    
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [_eventLocation resignFirstResponder];
    [_eventTime resignFirstResponder];
    [_eventTitle resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_eventLocation resignFirstResponder];
    [_eventTime resignFirstResponder];
    [_eventTitle resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
