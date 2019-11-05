//
//  main.m
//  memory
//
//  Created by 赵一鸣 on 2019/11/5.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import <Foundation/Foundation.h>

// 内存分区：
// 1、栈区：系统控制分配和回收，函数中定义的变量都是在栈区
// 2、堆区：由程序员控制开辟内存和回收内存
// 3、常量区：字符、数字等。
// 4、静态区：保存的内容不会消失，当程序完全退出之后才会消失
// 5、代码区： 存放源代码

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        for (int i = 0; i < 5; i++) {
            int a = 10;
            a += 1;
            printf("%d\n", a);
        }
        
        printf("------\n");
        
        for (int i = 0; i < 5; i++) {
            // 编译过程中，静态变量只初始化一次
            static int a = 10;
            a += 1;
            printf("%d\n", a);
        }
    }
    
    @autoreleasepool {
        // 在堆内存中分配4个字节的空间，用来存放 int 类型的数据
        int *a = malloc(4);
        *a = 100;
        printf("%p\n", a);
        printf("%d\n", *a);
        
        // 回收内存，对内存的数据，是程序员自己管理，所以不用的内存要及时回收
        free(a);
    }
    
    @autoreleasepool {
        int *a = NULL;
        
        // 下面这块内存没有被回收，导致内存泄露
        // a = malloc(4);
        
        a = malloc(8);
        
        free(a);
    }
    
    @autoreleasepool {
        int *a = malloc(4);
        *a = 100;
        free(a);
        
        // 野指针，继续使用已经被回收的内存
        // *a = 200;
    }
    
    return 0;
}
