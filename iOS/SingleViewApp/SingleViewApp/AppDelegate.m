//
//  AppDelegate.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/2.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 程序运行
// 会检测该程序是否使用了 storyBoard 作为界面设计，并设置了那个初始化的 ViewController
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

// 程序进入非活动状态
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

// 进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"%s", __func__);
}

// 即将进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

// 进入激活状态，比如从后台进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

// 结束
- (void)applicationWillTerminate:(UIApplication *)application {

}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"%s", __func__);
}

@end
