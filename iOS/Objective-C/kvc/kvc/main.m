//
//  main.m
//  kvc
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// KVC 应用场景：
// 比如 APP 中的 UIViewTabbar 属性是只读的，但是我们想自定义 tab 的样式，将某个 tab 突显出来，就可以使用这种方法

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person* person = [[Person alloc] init];
        
        // 只读属性直接赋值会报错
        // person.name = @"zhaoyiming";
        
        [person setValue:@"zhaoyiming" forKey:@"name"];
        NSLog(@"name: %@", person.name);
        NSLog(@"name: %@", [person valueForKey:@"name"]);
        
        [person resetPropertiesForSex:@"man" Age:18];
        NSLog(@"sex: %@, age: %ld", person.sex, person.age);
    }
    return 0;
}
