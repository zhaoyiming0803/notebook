//
//  main.m
//  oop
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 使用 control + command + 上下箭头，可以在 .h 和 .m 文件之间切换

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

@interface Teacher : Person {}

    @property(copy, nonatomic) NSString* school;

    -(void) showSchool;

@end

@implementation Teacher

    -(void) showSchool {
        NSLog(@"%@", @"北京大学");
    }

@end

int main(int argc, const char * argv[]) {
    // [[class alloc] init] 和 [class new] 都是用来动态分配内存并实例化类
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        p.name = @"zhangsan";
        p.sex = @"man";
        p.children = @[@"a", @"b"];
        
        [p say];
        NSString* res = [p love :@"code" :@"basketball"];
        NSLog(@"%@", res);
        [Person eat:@"banana"];
        
        Student *stu = [[Student alloc] init];
        stu.num = 100;
        
        // 如果一个成员变量是按照官方的规范添加的 set/get 方法，即使没有使用 @property 添加属性，也可以使用点语法，例：
        [stu setHeight:180];
        NSLog(@"学生身高是%ld", stu.height);
        [stu setSchool:@"北京大学"];
        NSLog(@"在%@读书", stu.school);
        
        Teacher *teacher = [Teacher new];
        [teacher showSchool];
        
        printf("printf 打印\r\n");
        
        // C 数组允许定义可存储 相同类型 数据项的变量
        // 结构是 C 编程中另一种用户自定义的可用的数据类型，它允许我们存储 不同类型 的数据项。
        // 结构用于表示一条记录，假设您想要跟踪图书馆中书本的动态，您可能需要跟踪每本书的下列属性：
        struct Books {
           char  title[50];
           char  author[50];
           char  subject[50];
           int   book_id;
        };
        
        struct Books book = {"C 语言", "RUNOOB", "编程语言", 123456};
        book.title[0] = 'B';
        NSLog(@"book占用的空间：%ld", sizeof(book));
        NSLog(@"%s", book.title);
        
        char str1[] = "hello"; // 定义一个字符数组
        char* str2 = "world";  // 定义一个指针类型的字符串
        NSLog(@"%s", str1);
        NSLog(@"%ld", sizeof(str1)); // 占用字节数6，会自动加一个 \0
        NSLog(@"%s", str2);
        NSLog(@"%ld", sizeof(str2));
        
        // 字符数组是一个数组，每个元素的值都可以改变。
        // 而字符串指针指向的是一个常量字符串，它被存放在程序的静态数据区，一旦定义就不能改变。这是最重要的区别。
        
        // char* 表示指针类型的字符串，是存储在堆中的，在内存中的地址是连续的，一旦定义就不能改变
        // str2[0] = '1';
        // NSLog(@"%s", str2);
        str2 = "世界";
        
        // 双引号引起来的都是【字符串常量】，单引号引起来的都是【字符常量】。
        // 比如：‘a’ 和 “a” 完全不一样，在内存里前者占1个byte，后者占2个byte。
        str1[0] = '1';
        str1[1] = '2';
        NSLog(@"%s", str1);
    }
    return 0;
}
