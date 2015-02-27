//
//  AppDelegate.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-26.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "AppDelegate.h"
#import "ObjectFileManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //实例化主故事版
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ObjectFileManager *manager = [ObjectFileManager sharedManager];
    
    //如果已经登录则将rootVC设置为主VC，否则设置为LoginVC
    if ([manager checkLoginInfo]) {
        
        UITabBarController *mainVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        self.window.rootViewController = mainVC;
        
    }else{
        
        UIViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.window.rootViewController = loginVC;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
