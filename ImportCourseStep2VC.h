//
//  ImportCourseStep2VC.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-9.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportCourseBL.h"
#import "ImportCourseDelegate.h"

@interface ImportCourseStep2VC : UIViewController<UITextFieldDelegate,ImportCourseDelegate>
@property(strong,nonatomic) ImportCourseBL *bl;

@property NSData *picData;
@property (weak, nonatomic) IBOutlet UIImageView *verifyCodeImage;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
- (IBAction)nextStep:(id)sender;
- (IBAction)cancleStep:(id)sender;

-(ImportCourseStep2VC*)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*) bundle picData:(NSData*)picData;
//-(void) initImageData:(NSData *)pic;
@end
