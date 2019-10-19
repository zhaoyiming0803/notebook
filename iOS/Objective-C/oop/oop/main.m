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
        
        Teacher *teacher = [Teacher new];
        [teacher showSchool];
        
        printf("printf 打印\r\n");
    }
    return 0;
}
