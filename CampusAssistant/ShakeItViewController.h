//
//  ShakeItViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeItDelegate.h"
#import "ShakeItBL.h"

@interface ShakeItViewController : UIViewController<ShakeItDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@property(strong,nonatomic) ShakeItBL *shakeItBl;
@property(weak,nonatomic) UITableView *courseTabel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end
