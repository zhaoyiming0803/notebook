//
//  main.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/2.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    // 从给定的类名初始化应用程序对象
    // 也就是初始化 UIApplication 或者子类对象的一个实例
    // 如果在这里给定的是 nil，那么系统会默认 UIApplication 类
    // 也就主要是这个类来控制和协调应用程序的运行，可以用静态方法 sharedApplication 来获取它。

    // 从给定的应用程序委托类，初始化一个应用程序委托

    // 启动主事件循环，并开始接收事件
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
