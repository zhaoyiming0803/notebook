//
//  Student.m
//  oop
//
//  Created by 赵一鸣 on 2019/10/19.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString*) school {
    return _school;
}

- (NSInteger) height {
    return _height;
}

- (void) setHeight :(NSInteger)height {
    _height = height;
}

- (void) setSchool :(NSString*)school {
    _school = school;
}

@end
