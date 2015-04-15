//
//  NotepadTableViewCell.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-15.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotepadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteTime;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;


@end
