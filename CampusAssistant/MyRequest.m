//
//  MyRequest.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-28.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "MyRequest.h"

@implementation MyRequest
static MyRequest* sharedManager = nil;

+(MyRequest*) sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


-(void)sendRequestWithPath:(NSString*) path andParams:(NSMutableDictionary*) params forMethod:(NSString*) httpMethod{
    [self.delegate requestBegin];//通知调用者请求开始
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//对路径进行编码
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:kHostName customHeaderFields:nil];//初始化网络引擎
    
    MKNetworkOperation *op = [engine operationWithPath:path params:params httpMethod:httpMethod];//初始化网络操作对象
    
    
    NSLog(@"本次请求Host:%@,Path:%@",kHostName,path);//打印结果
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {//请求成功时调用的block
        NSData *data = [completedOperation responseData];    //首先获得返回的数据
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//将该数据转换为dictionary
        NSNumber *code = [resDict objectForKey:@"code"];//回去response的code
        
        NSLog(@"sendRequestWithPath，结果：code:%d,msg:%@,data:%@",[code integerValue],[resDict objectForKey:@"msg"],resDict);//打印结果
        
        if ([code integerValue] != 200) {//如果code不等于200说明有错误msg
            NSString *msg = [resDict objectForKey:@"msg"];
            [self.delegate requestSuccessWithMsg:msg];      //调用delegate的方法
        }else{
            NSDictionary *data = [resDict objectForKey:@"data"];
            [self.delegate requestSuccess:data];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {//请求失败时调用的block
        NSString *err = [error localizedDescription];
        NSLog(@"本次请求失败，结果：error:%@",err);//打印结果
        
        [self.delegate requestFailed:error];
    }];
    
    [engine enqueueOperation:op];//将operation加入队列
    
}
@end
