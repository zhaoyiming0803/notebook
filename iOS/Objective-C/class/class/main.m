//
//  main.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// *** Objective-C 不能多继承，一个类只能继承一个父类
// *** 继承和面向接口（iOS架构思想篇）https://www.jianshu.com/p/39e6a8409476

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "Pig.h"
#import "Duck.h"
#import "Dog.h"
#import "Apple.h"
#import "Book.h"
#import "Lession.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Animal* animal = [[Animal alloc] init];
        animal.name = @"xiaoming";
        animal.age = 18;
        [animal printBaseInfo];
        
        [animal test2];
        
        Pig* pig = [[Pig alloc] init];
        pig.name = @"xiaohong";
        pig.age = 19;
        pig.love = @"sleep";
        NSLog(@"pig love %@", pig.love);
        [pig printBaseInfo];
        
        // alloc 分配内存
        // init  初始化内存并返回初始化完成的内存地址
        Duck* duck = [[Duck alloc] init];
//        Duck* duck = [Duck new];
        duck.name = @"xiaohua";
        duck.age = 20;
        [duck printBaseInfo];
        
        NSLog(@"duck base info: %@", duck);
    }
    
    @autoreleasepool {
        Dog* dog = [[Dog alloc] initWithName:@"xiaohei" Age:10 Sex:@"woman"];
        NSLog(@"dog: %@", dog);
    }
    
    @autoreleasepool {
        Apple* apple = [[Apple alloc] initWithName:@"Mac book" Price:13000 Company:@"Apple" Address:@"America"];
        NSLog(@"apple: %@", apple);
        
        // private 私有成员变量不能被继承，所以也就不能在子类内部或通过其实例化的对象访问。
//        apple->_company = @"苹果公司";
        
        // protected 受保护的成员变量可以被继承，但是只能在类内部访问，不能通过实例化的对象访问。
//        apple->_price = 100;
        [apple showPrice];
        
        Computer* computer = [[Apple alloc] initWithName:@"Mac book pro" Price:14000 Company:@"Apple" Address:@"America"];
        [computer showPrice];
        [computer showName];
    }
    
    @autoreleasepool {
        // 面向对象很重要的一条原则：每个对象各自做好各自的事情
        Book* book = [[Book alloc] initWithName:@"iOS从入门到精通" Pages:300];
        Lession* lession = [[Lession alloc] initWithName:@"iOS" Hours:100];
        Student* student = [[Student alloc] initWithBook:book Lession:lession];
        NSLog(@"book name: %@", student.book.name);
        NSLog(@"lession hours: %ld", student.lession.hours);
    }
    
    return 0;
}
