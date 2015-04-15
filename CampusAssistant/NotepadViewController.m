//
//  NotepadViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-15.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "NotepadViewController.h"
#import "ImageConfig.h"

@interface NotepadViewController ()

@end

@implementation NotepadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notepadTableView.dataSource = self;
    self.notepadTableView.delegate = self;
    
    self.manager = [[ObjectFileManager alloc] init];
    
    self.noteList = [_manager readNotes];
    
    //设置右上角按钮
    UIImage *addImage = [UIImage imageNamed:kTimetable_addCourse_icon];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:addImage style:UIBarButtonItemStylePlain target:self action:@selector(addNote:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void)publishSuccess{
    _noteList = [_manager readNotes];
    [self.notepadTableView reloadData];
}

#pragma mark - 右上角按钮响应事件
-(void)addNote:(id)sender{
    NoteEditingViewController *noteEditingVC = [[NoteEditingViewController alloc] initWithNibName:@"NoteEditingViewController" bundle:nil];
    noteEditingVC.delegate  = self;
    [self.navigationController pushViewController:noteEditingVC animated:YES];
}


#pragma mark - tableviewdelegate方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"topicCell";
    
    NotepadTableViewCell *cell = (NotepadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NotepadTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    NoteModel *note = [self.noteList objectAtIndex:indexPath.row];
    
    //初始化Label
    [cell.noteTitle setText:note.noteTitle];
    [cell.noteTime setText:note.noteTime];
    [cell.noteContent setText:note.noteContent];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.noteList.count;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteModel *note = [self.noteList objectAtIndex:indexPath.row];
    
    NSLog(@"NoteId:%i",note.noteId);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
