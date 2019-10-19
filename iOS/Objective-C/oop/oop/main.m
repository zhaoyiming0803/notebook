//
//  main.m
//  oop
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc]init];
        p.name = @"zhangsan";
        p.sex = @"man";
        p.children = @[@"a", @"b"];
        
        [p say];
        NSString* res = [p love :@"code" :@"basketball"];
        NSLog(@"%@", res);
        [Person eat:@"banana"];
        
        Student *stu = [[Student alloc]init];
        stu.num = 100;
    }
    return 0;
}
