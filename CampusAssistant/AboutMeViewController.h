//
//  AboutMeViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectFileManager.h"

@interface AboutMeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property ObjectFileManager *manager;

@property(strong,nonatomic) UITableView *tableView;
@property NSArray *contentArray;
@property NSArray *imageArray;

-(instancetype)init;
@end
