//
//  TopicViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import "TopicBL.h"
#import "TopicCell.h"
#import "ImageConfig.h"

@interface TopicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,TopicDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)TopicBL *bl;

@property NSArray* topicArray;
@property int count;

@end
