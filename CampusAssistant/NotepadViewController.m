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
//    [_notepadTableView ]
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    
    NSArray *array = [[NSArray alloc]initWithArray:_noteList];
    
    NSArray *noteArray = [NoteModel objectArrayWithKeyValuesArray:array];
    
    NoteModel *note = [noteArray objectAtIndex:indexPath.row];
    
    //初始化Label
    cell.textLabel.text =  note.noteContent;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.detailTextLabel.text = note.noteTime;
    [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *array = [[NSArray alloc]initWithArray:_noteList];
        NSArray *noteArray = [NoteModel objectArrayWithKeyValuesArray:array];
        NoteModel *note = [noteArray objectAtIndex:indexPath.row];
        [_manager deleteNoteById:note.noteId];
//        _noteList = [_manager readNotes];
//        [_notepadTableView reloadData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [[NSArray alloc]initWithArray:_noteList];
    
    NSArray *noteArray = [NoteModel objectArrayWithKeyValuesArray:array];
    NoteModel *note = [noteArray objectAtIndex:indexPath.row];
    
    NoteEditingViewController *noteEditingVC = [[NoteEditingViewController alloc] initWithNibName:@"NoteEditingViewController" bundle:nil note:note];
    noteEditingVC.delegate  = self;
    [self.navigationController pushViewController:noteEditingVC animated:YES];
    
    NSLog(@"NoteId:%@",note.noteId);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noteList.count;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 128;
//}

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
