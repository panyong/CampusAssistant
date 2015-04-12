//
//  TopicVC.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import "TopicBL.h"
#import "TopicCell.h"

@interface TopicVC : UIViewController<UITableViewDelegate,UITableViewDataSource,TopicDelegate>
@property(weak,nonatomic) UITableView* tableView;

@property(strong,nonatomic)TopicBL *bl;

@property NSArray* topicArray;
@property int count;
@end
