//
//  RegisterViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-2-3.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegisterDelegate.h"
#import "LoginAndRegisterBusiness.h"
#import "KVNProgress.h"

@interface RegisterViewController : UIViewController<UITextViewDelegate,LoginAndRegisterDelegate>
@property LoginAndRegisterBusiness *bl;
@property(strong,nonatomic) KVNProgress *imgIndicator;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UITextField *userNickname;
@property (weak, nonatomic) IBOutlet UITextField *userPwd2;

- (IBAction)register:(id)sender;

@end
