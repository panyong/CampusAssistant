//
//  ObjectFileManager.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ObjectFileManager.h"
#import "MJExtension/MJExtension.h"
#import "CourseConfig.h"

#define kUserInfoFileName @"LoginInfo.plist"

@implementation ObjectFileManager

//static ObjectFileManager* sharedManager = nil;

-(ObjectFileManager*) init{
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedManager = [[self alloc] init];
//    });
//    return sharedManager;
    self = [super init];
    
    if (self) {
        
    }
    
    return  self;
}

#pragma mark-删除所有的存储文件
-(void)removeAllFile{
    NSFileManager *fileManager=[NSFileManager defaultManager];//获取单例的文件管理器实例
    
    NSString *uerInfoFile = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    NSString *semesterFile = [self applicationDocumentsDirectoryFile:kSemesterFileName];
    NSString *courseInfoFile = [self applicationDocumentsDirectoryFile:kCourseFileName];
    NSString *notePath = [self applicationDocumentsDirectoryFile:kNoteFileName];
    
    [fileManager removeItemAtPath:uerInfoFile error:nil];
    [fileManager removeItemAtPath:semesterFile error:nil];
    [fileManager removeItemAtPath:courseInfoFile error:nil];
    [fileManager removeItemAtPath:notePath error:nil];
}

#pragma mark - note相关方法
-(BOOL)writeNote:(NoteModel *)note{
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:kNoteFileName];
    
    NSMutableArray *noteList = self.readNotes;
    
    if (noteList == nil) {
        noteList = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:note.noteId,@"noteId",note.noteTitle,@"noteTitle",note.noteContent,@"noteContent",note.noteTime,@"noteTime", nil];
    
    [noteList addObject:dic];

    NSArray *noteArray = [[NSArray alloc] initWithArray:noteList];
    
    BOOL flag = [noteArray writeToFile:filePath atomically:YES];
    
    return flag;
}

-(NSMutableArray *)readNotes{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kNoteFileName];
    NSMutableArray *noteList = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    return noteList;
}

-(BOOL)deleteNoteById:(NSString*)noteId{
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:kNoteFileName];
    
    NSArray *noteArrayTemp = [NoteModel objectArrayWithFile:filePath];
    NSMutableArray *noteList = [[NSMutableArray alloc] initWithArray:noteArrayTemp];
    NSMutableArray *noteList2 = [[NSMutableArray alloc] init];
    for (NoteModel *note in noteList) {
        if (![note.noteId isEqualToString:noteId]) {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:note.noteId,@"noteId",note.noteTitle,@"noteTitle",note.noteContent,@"noteContent",note.noteTime,@"noteTime", nil];
            
            [noteList2 addObject:dic];
        }
    }
    
    NSArray *noteArray = [[NSArray alloc] initWithArray:noteList2];
    BOOL flag = [noteArray writeToFile:filePath atomically:YES];
    
    return flag;
}

-(BOOL)updateNote:(NoteModel *)note{
    [self deleteNoteById:note.noteId];
    BOOL flag =  [self writeNote:note];

    return flag;
}

#pragma mark - 读取用户昵称
-(NSString *)getNickname{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *userNickname = [infoDic objectForKey:@"userNickname"];
    
    return userNickname;
}

#pragma mark - 读取用户信息
-(UserInfoModel *)getUserInfo{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    UserInfoModel *user = [UserInfoModel objectWithKeyValues:infoDic];
    
    return user;
}


#pragma mark - 获取学期信息
-(Semester*)getSemesterInfo{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kSemesterFileName];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    Semester *semester = [Semester objectWithKeyValues:dic];
    
    return semester;
}

#pragma mark - 设置学期信息
-(void)setSemester:(Semester *)semester{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kSemesterFileName];
    
    NSDictionary *dic = semester.keyValues;
    
    [dic writeToFile:filePath atomically:YES];
}


#pragma  将字典数据写入相应的文件
-(BOOL)writeDictionary:(NSDictionary *)dic IntoFile:(NSString *)fileName{
    [self.delegate writeBegin];
    
    NSLog(@"开始写入文件%@",fileName);
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:fileName];
    
    BOOL flag = [dic writeToFile:filePath atomically:YES];
    
    if (flag) {
        [self.delegate writeSuccess];
        return YES;
        
    }else{
        [self.delegate writeFailedWithMsg:[NSString stringWithFormat:@"写入文件%@失败",fileName]];
        return NO;
    }
}

#pragma  从指定的文件中读取对象
-(BOOL)readDictionaryFromFile:(NSString *)fileName{
    [self.delegate readBegin];
    
    NSLog(@"开始读取文件%@",fileName);
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:fileName];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    BOOL flag = dic.count > 0;
    
    if (flag) {
        [self.delegate readSuccess:dic];
        
        NSLog(@"读取文件成功%@",fileName);
        
        return YES;
        
    }else{
        [self.delegate readFailedWithMsg:[NSString stringWithFormat:@"读取文件%@失败",fileName]];
        
        NSLog(@"读取文件失败%@",fileName);
        
        return NO;
    }

}


//判断用户信息中得userToken是否存在，如果存在则表示登陆成功，返回YES，否则返回NO
-(BOOL) checkLoginInfo{
    [self.delegate readBegin];
    
    //获取用户信息并写入到Dic中
    NSString *filePath = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *userToken = [infoDic objectForKey:@"userToken"];//获取userToken
    
    if (userToken.length == 0) {
        [self.delegate readFailedWithMsg:@"读取文件失败"];
        return NO;
    }else{
        [self.delegate readSuccess:infoDic];
        return YES;
    }
}

//将用户信息写入到属性列表中
-(BOOL) writeUserInfo:(UserInfoModel*) user{
    NSString *filePath = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:user.userName forKey:@"userName"];
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:user.userNickname forKey:@"userNickname"];
    [dic setObject:user.userToken forKey:@"userToken"];
    
    return [dic writeToFile:filePath atomically:YES];
}

-(BOOL) writeUserInfoWithDic:(NSDictionary*) dic{
    [self.delegate writeBegin];
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:kUserInfoFileName];
    
    BOOL flag =  [dic writeToFile:filePath atomically:YES];
    
    if (flag) {
        [self.delegate writeSuccess];
        return YES;
    }else{
        [self.delegate writeFailedWithMsg:@"写入失败"];
        return NO;
    }
}

//对文件进行预处理，判断在Documents目录下是否存在plist文件，如果不存在则从资源目录下复制一个。
-(void)createEditableCopyOfDatabaseIfNeeded:(NSString*) fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];//获取单例的文件管理器实例
    NSString *writableDBPath=[self applicationDocumentsDirectoryFile:fileName];
    
    BOOL dbexits=[fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        NSString *defaultDBPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        
        NSError *error;
        BOOL success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        
        if (!success) {
            NSAssert1(0,@"错误写入文件：‘%@’",[error localizedDescription]);
        }
    }
}

//获取放置在沙箱Documents目录下的文件的完整路径
-(NSString *)applicationDocumentsDirectoryFile:(NSString*) fileName
{
    NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path=[documentDirectory stringByAppendingPathComponent:fileName];
    
//    NSFileManager *fileManager=[NSFileManager defaultManager];//获取单例的文件管理器实例
//    [fileManager removeItemAtPath:path error:nil];
    
    return path;
}

@end
