//
//  main.m
//  string
//
//  Created by 赵一鸣 on 2019/10/23.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 使用 NSString 创建的字符串，是放在一块连续的内存中，所以定义之后不能再修改。相当于 C 语言中的指针类型的字符串
        NSString* str1 = @"Hello Objective-C";
        NSLog(@"str1 = %@", str1);
        
        NSString* str2 = [NSString stringWithString:str1];
        NSLog(@"str2 = %@", str2);
        
        NSString* str3 = [str1 stringByAppendingString:@", I love you"];
        NSLog(@"str3 = %@", str3);
        
        // 使用 NSMutableString 创建的字符串，可以增删改，相当于 C 语言中的字符数组
        NSMutableString* str4 = [[NSMutableString alloc] init];
        [str4 appendFormat:@"My name is zhaoyiming"];
        [str4 insertString:@", i love codeing and play ping pang ball!" atIndex:str4.length];
        [str4 insertString:@"Hello, " atIndex:0];
        NSLog(@"str4 = %@", str4);
        
        // ... 更多字符串使用方法，可以在今后的实战中根据业务场景使用。
    }
    
    return 0;
}
