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

@interface NotepadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NoteEditDelegate>

@property ObjectFileManager *manager;
@property NSArray* noteList;


@property (weak, nonatomic) IBOutlet UITableView *notepadTableView;
@end
