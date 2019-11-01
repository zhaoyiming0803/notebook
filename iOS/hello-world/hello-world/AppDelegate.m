//
//  AppDelegate.m
//  hello-world
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // iOS13之后，appdelegate的指责发生了变化，具体的可以参考https://developer.apple.com/videos/play/wwdc2019/42 这个session。
    // 简单的说和UI生命周期相关的回调都交给了 SceneDelegate 这个delegate，
    // 而 appdelegate 主要负责 app 生命周期相关的回调。
    // 对于window来说，作为一个特殊的UI，也自然的变成了 SceneDelegate 的一个 property，我们可以在 SceneDelegate 的头文件中找到它，
    // 并在 willConnectToSession 这个函数中使用
    return YES;
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
}


@end
