//
//  AboutMeViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectFileManager.h"
#import "SetNowWeekViewController.h"

@interface AboutMeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SetNowWeekDelegate,UIAlertViewDelegate>

@property ObjectFileManager *manager;
@property SetNowWeekViewController *setNowWeelVC;

@property(strong,nonatomic) UITableView *tableView;

@property NSArray *titleArray;
@property NSArray *detailArray;
@property NSArray *imageArray;

-(instancetype)init;
@end
