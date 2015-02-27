//
//  RegisterViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-2-3.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UITextField *userNickname;

@property (weak, nonatomic) IBOutlet UITextField *userPwd2;
- (IBAction)register:(id)sender;
@end
