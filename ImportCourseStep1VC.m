//
//  ImportCourseStep1VC.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseStep1VC.h"

@interface ImportCourseStep1VC ()

@end

@implementation ImportCourseStep1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stuPwd.delegate = self;
    
    self.stuNo.delegate = self;
    
    self.title = @"导入课程第一步";
    // Do any additional setup after loading the view.
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

#pragma 继续按钮
- (IBAction)nextStep:(id)sender {
    
    if ([self validateText]) {
        
        NSLog(@"下一步");
    }
}

-(BOOL) validateText{
    NSString *stuNo = self.stuNo.text;
    NSString *stuPwd = self.stuPwd.text;
    
    
    if (stuNo.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"学号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    if (stuPwd.length == 0  ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}

@end
