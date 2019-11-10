//
//  main.m
//  block
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 浅谈 iOS 之 Block http://www.cocoachina.com/articles/25762
// ***** Objective-C中的Block http://www.cocoachina.com/articles/10891
// ***** 深入研究Block用weakSelf、strongSelf、@weakify、@strongify解决循环引用 https://blog.csdn.net/qq_30513483/article/details/52587551

#import <Foundation/Foundation.h>
#import "Person.h"

void logBlock (NSInteger (^callback)(void)) {
    NSLog(@"closure value = %ld", callback());
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 返回值类型(^block名称)(用逗号分割的参数类型) = ^(以逗号分隔的参数类型 参数)
        NSInteger (^block1) (NSInteger, NSInteger) = ^(NSInteger a, NSInteger b) {
            return a + b;
        };
        
        NSLog(@"%ld", block1(1, 2));
        
        void (^block2) (void) = ^() {
            NSLog(@"无返回值无形参");
        };
        block2();
        
        void (^block3) (NSInteger a, NSInteger b) = ^(NSInteger a, NSInteger b) {
            NSLog(@"有形参无返回值, %ld", a + b);
        };
        block3(1, 2);
        
        // block 数据类型的语法会降低整个代码的阅读性，所以常使用 typedef 来定义 block 类型
        typedef void (^Block4) (NSInteger);
        Block4 block4 = ^(NSInteger a) {
            NSLog(@"自定义一个 block, %ld", a);
        };
        block4(4);
        
        typedef NSInteger (^Block5) (void);
        NSInteger num1 = 10;
        Block5 block5 = ^(void) {
            return num1;
        };
        logBlock(block5);
        
        // 通过 block 进行闭包的变量是 const 的。也就是说不能在 block 中直接修改这些变量
        // 有时候确实需要在 block 中处理变量，我们可以用 __block 关键字来声明变量，这样就可以在 block 中修改变量了。
        __block NSInteger num2 = 100;
        typedef void (^Block6) (void);
        Block6 block6 = ^(void) {
            num2 += 100;
        };
        block6();
        NSLog(@"num2 = %ld", num2);
        
        typedef NSString* (^Block7) (NSString* a, NSString* b);
        Block7 block7 = ^(NSString* a, NSString* b) {
            return [a stringByAppendingString:b];
        };
        NSLog(@"block7: %@", block7(@"1", @"2"));
        
        // 在类和对象中使用 block
        NSString* str = @"hello Block";
        Person* person = [[Person alloc] init];
        person.block = ^(NSString* a, NSString* b) {
            return [[a stringByAppendingString:b] stringByAppendingString:str];
        };
        NSLog(@"person info: %@", person.block(@"1", @"2"));
    }
    return 0;
}
