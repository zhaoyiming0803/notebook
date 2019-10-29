//
//  NSString+SelfExtensions.m
//  category
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "NSString+SelfExtensions.h"

#import <AppKit/AppKit.h>


@implementation NSString (SelfExtensions)

-(void) sayHello {
    NSLog(@"Hello, i am a extension");
}

// 自定义的同名方法，会覆盖原有方法
-(NSString*) substringToIndex:(NSInteger) str {
    return @"NSString 的 substringToIndex 方法被重写了，哈哈";
}

@end
