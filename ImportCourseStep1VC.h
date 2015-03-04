//
//  ImportCourseStep1VC.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImportCourseStep1VC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stuNo;
@property (weak, nonatomic) IBOutlet UITextField *stuPwd;

- (IBAction)nextStep:(id)sender;
@end
