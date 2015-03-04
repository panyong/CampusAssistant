//
//  ImportCourseStep1VC.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportCourseBL.h"
#import "ImportCourseDelegate.h"
#import "KVNProgress.h"

@interface ImportCourseStep1VC : UIViewController<UITextFieldDelegate,ImportCourseDelegate>
@property(strong,nonatomic) ImportCourseBL *bl;

@property(strong,nonatomic) KVNProgress *imgIndicator;
@property (weak, nonatomic) IBOutlet UITextField *stuNo;
@property (weak, nonatomic) IBOutlet UITextField *stuPwd;

- (IBAction)nextStep:(id)sender;
@end
