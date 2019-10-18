//
//  main.m
//  test-Objective-C
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 导入基础库，包含了诸如 字符串、数组、字典 ... 各种 Objective-C 的基础 API
#import <Foundation/Foundation.h>

// 每个文件的入口函数：main
int main(int argc, const char * argv[]) {
    // 自动释放池，在当前语句块内的代码，执行完之后，内存就自动释放
    @autoreleasepool {
        // 打印，相当于 JS 中的 console.log 或 其他语法的 print
        NSLog(@"Hello Objective-C");
    }
    return 0;
}
