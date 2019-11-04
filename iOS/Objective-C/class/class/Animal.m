//
//  Animal.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (void) printBaseInfo {
    NSLog(@"name: %@, age: %ld", self.name, self.age);
}

- (NSString*) description {
    return [NSString stringWithFormat:@"name: %@, age: %ld", self.name, self.age];
}

- (void) test1 {}

- (void) test2 {
    // respondsToSelector的作用：判断某个方法是否被实现，防止调用未实现的方法，导致异常
    if ([self respondsToSelector:@selector(test1)]) {
        NSLog(@"Animal 实现了 test1 方法");
    } else {
        NSLog(@"Animal 未实现 test1 方法");
    }
}

@end
