//
//  NoteEditingViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-15.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "NoteEditingViewController.h"

@interface NoteEditingViewController ()

@end

@implementation NoteEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[ObjectFileManager alloc] init];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil note:(NoteModel *)note{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.note = note;
    }
    
    return self;
}


//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_noteContent resignFirstResponder];
    [_noteTitle resignFirstResponder];
    
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [_noteContent resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_noteTitle resignFirstResponder];
    return YES;
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

- (IBAction)publishIt:(id)sender {
    NSString *noteTitle = _noteTitle.text;
    NSString *noteContent = _noteContent.text;
    
    if (noteContent == nil || [noteContent isEqualToString:@""] || noteTitle == nil || [noteTitle isEqualToString:@""]) {
        [KVNProgress showErrorWithStatus:@"标题和内容不能为空"];
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *noteTime = [formatter stringFromDate:[[NSDate alloc] init]];
    
    NSArray *noteList = [_manager readNotes];
    
    int noteId = 1;
    if (noteList != nil){
        noteId = noteList.count * 10 + 1;
    }
    
    NoteModel *note = [[NoteModel alloc] init];
    if (_note != nil) {
        note.noteId = _note.noteId;
    }else{
        note.noteId = noteId;
    }
    note.noteTitle = noteTitle;
    note.noteContent = noteContent;
    note.noteTime = noteTime;
    
    if([_manager writeNote:note]){
        [KVNProgress showSuccessWithStatus:@"添加/更新成功"];
        [self.delegate publishSuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [KVNProgress showSuccessWithStatus:@"添加/更新失败"];
    }
}
@end
