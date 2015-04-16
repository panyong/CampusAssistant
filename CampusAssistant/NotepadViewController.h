//
//  NotepadViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-15.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEditingViewController.h"
#import "NotepadTableViewCell.h"
#import "MJExtension/MJExtension.h"

@interface NotepadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NoteEditDelegate>

@property ObjectFileManager *manager;
@property NSMutableArray* noteList;


@property (weak, nonatomic) IBOutlet UITableView *notepadTableView;
@end
