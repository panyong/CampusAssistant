//
//  ObjectFileManager.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ObjectFileManager.h"
#import "MJExtension/MJExtension.h"

@implementation ObjectFileManager

static ObjectFileManager* sharedManager = nil;

+(ObjectFileManager*) sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

//将字典数据写入相应的文件
-(BOOL) writeDictionary:(NSDictionary*) dic IntoFile:(NSString*) fileName{
    [self.delegate writeBegin];
    
    NSLog(@"PL:");
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:fileName];
    
    BOOL flag = [dic writeToFile:filePath atomically:NO];
    
    if (flag) {
        [self.delegate writeSuccess];
        return YES;
        
    }else{
        [self.delegate writeFailedWithMsg:[NSString stringWithFormat:@"写入文件%@失败",fileName]];
        return NO;
    }
}

//从指定的文件中读取对象
-(BOOL) readDictionaryFromFile:(NSString*) fileName{
    [self.delegate readBegin];
    
    NSLog(@"PL:readDictionaryFromFile");
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:fileName];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    

    BOOL flag = dic.count > 0;
    
    if (flag) {
        [self.delegate readSuccess:dic];
        
        NSLog(@"PL:readSuccess");
        
        return YES;
        
    }else{
        [self.delegate readFailedWithMsg:[NSString stringWithFormat:@"读取文件%@失败",fileName]];
        
        NSLog(@"PL:readFailedWithMsg");
        
        return NO;
    }
}



//判断用户信息中得userToken是否存在，如果存在则表示登陆成功，返回YES，否则返回NO
-(BOOL) checkLoginInfo{
    [self.delegate readBegin];
    
    //获取用户信息并写入到Dic中
    NSString *filePath = [self applicationDocumentsDirectoryFile:@"LoginInfo.plist"];
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
    NSString *filePath = [self applicationDocumentsDirectoryFile:@"LoginInfo.plist"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:user.userName forKey:@"userName"];
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:user.userNickname forKey:@"userNickname"];
    [dic setObject:user.userToken forKey:@"userToken"];
    
    return [dic writeToFile:filePath atomically:NO];
}

-(BOOL) writeUserInfoWithDic:(NSDictionary*) dic{
    [self.delegate writeBegin];
    
    NSString *filePath = [self applicationDocumentsDirectoryFile:@"LoginInfo.plists"];
    
    BOOL flag =  [dic writeToFile:filePath atomically:NO];
    
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
    
    return path;
}

@end
