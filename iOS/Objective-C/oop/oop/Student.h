//
//  Student.h
//  oop
//
//  Created by 赵一鸣 on 2019/10/19.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Student : Person {
    NSInteger _height;
    NSString* _school;
}

@property(assign, nonatomic) NSInteger num;

- (NSInteger) height;
- (NSString*) school;
- (void) setHeight :(NSInteger)height;
- (void) setSchool :(NSString*)school;

@end
