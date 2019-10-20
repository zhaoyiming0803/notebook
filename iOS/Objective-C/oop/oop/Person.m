//
//  Person.m
//  oop
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void) say {
    NSLog(@"%s", "人说话");
}

- (NSString *) love :(NSString *)a :(NSString *)b {
    NSLog(@"人喜欢%@和%@", a, b);
    return @"养成一个好习惯";
}

- (void) mySetName:(NSString*)name sex:(NSString*)sex age:(NSInteger)age {
    _name = name;
    _sex = sex;
    _age = age;
}

+ (void) eat :(NSString *)food {
    NSLog(@"人喜欢吃%@", food);
}

@end
