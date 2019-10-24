//
//  Duck.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Duck.h"

@implementation Duck

// 重写 init 方法
// instancetype init 方法返回的实例对象类型
// 老版本的 OC ，init 方法的返回值类型是 id 类型，因为 id 是泛型，不能确定其具体类型，所以会造成很多隐患，后面改成了 instancetype
// instancetype 代表 init 方法所在的那个类所初始化的对象的类型，比 id 类型更加具体、安全
// 区别是：id 可以作为参数类型使用，但 instancetype 不能作为参数类型
- (instancetype) init {
    self = [super init];
    if (self) {
        NSLog(@"Duck class be instantiated");
    }
    return self;
}

- (void) printBaseInfo {
    [super printBaseInfo]; // 继承父类的同时并重写
    NSLog(@"Duck can swimming");
}

// id 泛型，"不确定"的对象类型
- (id) testFunc {
    return @"testFunc";
}

@end
