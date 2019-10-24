//
//  Duck.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Duck.h"

@implementation Duck

- (void) printBaseInfo {
    [super printBaseInfo]; // 继承父类的同时并重写
    NSLog(@"Duck can swimming");
}

@end
