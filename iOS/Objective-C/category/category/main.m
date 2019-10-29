//
//  main.m
//  category
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+SelfExtensions.h"
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString* str1 = @"this is a extention";
        [str1 sayHello];
        
        // 自定义的同名方法，会覆盖原有方法
        NSString* str2 = [str1 substringToIndex:2];
        NSLog(@"str2: %@", str2);
        
        Person* p = [[Person alloc] init];
        [p say];
    }
    return 0;
}
