//
//  SetNowWeekViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetNowWeekDelegate.h"

@interface SetNowWeekViewController : UIViewController

@property(weak,nonatomic) id<SetNowWeekDelegate> delegate;

- (IBAction)didSelected:(id)sender;
- (IBAction)cancleSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *nowWeekPickerVIew;


@property NSMutableArray *weekArray;
@end
