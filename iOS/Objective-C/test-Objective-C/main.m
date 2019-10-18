//
//  main.m
//  test-Objective-C
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 导入基础库，包含了诸如 字符串、数组、字典 ... 各种 Objective-C 的基础 API
#import <Foundation/Foundation.h>

// %p 表示输出这个指针,
// %d 表示后面的输出类型为有符号的10进制整形，
// %u 表示无符号10进制整型，
// %lu 表示输出无符号长整型整数 (long unsigned)

// 每个文件的入口函数：main
int main(int argc, const char * argv[]) {
    // 自动释放池，在当前语句块内的代码，执行完之后，内存就自动释放
    @autoreleasepool {
        // 打印，相当于 JS 中的 console.log 或 其他语法的 print
        NSLog(@"Hello Objective-C");
    }
    
    @autoreleasepool {
        // NSInteger: 在 64 位操作系统上是 long 型，否则是 int 型
        NSInteger a = 1;
        NSInteger b = 2;
        NSLog(@"%ld", a + b);
    }
    
    @autoreleasepool {
        NSInteger a = 1;
        
        a += 1;
        NSLog(@"%ld", a);
        
        a++;
        NSLog(@"%ld", a);
        
        float b = 10.1;
        NSLog(@"单精度浮点数b=%f", b);
        
        double c = 20.1;
        NSLog(@"双精度浮点数c=%f", c);
    }
    
    @autoreleasepool {
        NSString *a = @"a";
        NSLog(@"a变量的长度：%lu", (unsigned long)a.length);
    }
    
    @autoreleasepool {
        for (NSInteger i = 0; i < 3; i++) {
            if (i == 2) {
                break;
            } else {
                NSLog(@"循环第%ld次", i);
            }
        }
    }
    
    @autoreleasepool {
        NSInteger i = 0;
        
        while (i < 3) {
            i++;
        }
        
        NSLog(@"while循环之后的i为%lu", i);
    }
    
    @autoreleasepool {
        NSString *a = @"hello";
        NSString *b = [NSString stringWithFormat: @"%@-%u", a, 10];
        NSLog(@"字符串拼接数字后：%@", b);
    }
    
    @autoreleasepool {
        NSString *a = @"world";
        NSString *b = [a uppercaseString];
        NSLog(@"字符串变成大写：%@", b);
    }
    
    @autoreleasepool {
        NSString *a = @"Objective-C";
        
        NSString *b = [a substringWithRange: NSMakeRange(0, 9)];
        NSLog(@"字符串截取：%@", b);
        
        NSRange r;
        r.location = 0;
        r.length = 9;
        NSString *c = [a substringWithRange: r];
        NSLog(@"字符串截取：%@", c);
    }
    
    @autoreleasepool {
        NSArray *array = @[@1, @"2", @3.01];
        NSLog(@"%@", array[1]);
        
        // 在Objective-C 中，id 类型是一个独特的数据类型。在概念上，类似Java 的 Object 类，可以转换为任何数据类型。
        // 换句话说，id 类型的变量可以存放任何数据类型的对象。
        // 在内部处理上，这种类型被定义为指向对象的指针，实际上是一个指向这种对象的实例变量的指针。
        for (id item in array) {
            NSLog(@"%@", item);
        }
        
        NSLog(@"%lu", [array indexOfObject: @3.01]);
        
        NSMutableArray * mutableArray = [NSMutableArray arrayWithArray: array];
        [mutableArray addObject: @"13199990909"];
        [mutableArray insertObject: @"haha" atIndex: 1];
        
        for (id item in mutableArray) {
            NSLog(@"%@", item);
        }
    }
    
    return 0;
}
