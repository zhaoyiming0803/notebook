//
//  main.m
//  struct
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 浅谈 OC 与结构体 https://www.jianshu.com/p/f1b2085c4179

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        struct Person {
            NSString *name;
            NSString *sex;
            NSInteger age;
        };
        
        struct Person p = { @"zhaoyiming", @"man", 18 };
        NSLog(@"%@", p.name);
        
        // OC 初始化结构体跟 C 的数组很像，所以用下面这种方式，编译器无法分辨是给 p 重新赋值为一个结构体，还是重新赋值一个数组
        // 如果是赋值为一个数组，则与 p 定义时的结构体类型不匹配，会报错
        
        // p = { @"zhangsan", @"man", 180 };
        
        // 非结构体变量可以直接修改, 结构体变量需要强转或者通过另一个结构体变量来进行修改
        
        // 基于上面的问题，可以用以下方式解决
        
        // 1、初始化一个临时变量
        struct Person tempP = { @"zhangsan", @"man", 19 };
        p = tempP;
        
        NSLog(@"%@", p.name);
        
        // 2、强转
        p = (struct Person){ @"lisi", @"man", 20 };
        NSLog(@"%@", p.name);
        
        // 在OC中struct是值类型的，也就是说当将一个结构体赋值给另一个结构体时，二者实际上是相互独立互不影响的。
        // 当使用@property修饰的结构体，我们虽然表面是可以直接访问到，但是实际上我们是调用的编译器自动生成的get方法，这样就会有问题。
        // 因为struct是值类型，所以get方法会返回一个完全独立的struct，而这种修改是完全没有意义的，所以，编译器就禁止了这种调用。
        // 当使用@public修饰struct时，外部是直接访问到的该struct，而不是该struct的一个值拷贝，所以是可以的。
    }
    return 0;
}
