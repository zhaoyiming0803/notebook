//
//  main.m
//  block
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 返回值类型(^block名称)(用逗号分割的参数类型) = ^(以逗号分隔的参数类型 参数)
        NSInteger(^block1)(NSInteger, NSInteger) = ^(NSInteger a, NSInteger b) {
            return a + b;
        };
        
        NSLog(@"%ld", block1(1, 2));
    }
    return 0;
}
