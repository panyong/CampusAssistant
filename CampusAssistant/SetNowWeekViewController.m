//
//  SetNowWeekViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "SetNowWeekViewController.h"

@interface SetNowWeekViewController ()

@end

@implementation SetNowWeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择当期周数";
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    _weekArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 13; i++) {
        [_weekArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - pickerView代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_weekArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title = [NSString stringWithFormat:@"第%@周",[_weekArray objectAtIndex:row]];
    
    return title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelected:(id)sender {
    
    NSInteger  selectedRow = [_nowWeekPickerVIew selectedRowInComponent:0];
    NSString *nowWeek = [_weekArray objectAtIndex:selectedRow];
    
    NSLog(@"选择了%@",nowWeek);
    
    [self.delegate setnowWeekCompile:nowWeek];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancleSelect:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
