//
//  main.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// *** Objective-C 不能多继承，一个类只能继承一个父类

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "Pig.h"
#import "Duck.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Animal* dog = [[Animal alloc] init];
        dog.name = @"xiaoming";
        dog.age = 18;
        [dog printBaseInfo];
        
        Pig* pig = [[Pig alloc] init];
        pig.name = @"xiaohong";
        pig.age = 19;
        pig.love = @"sleep";
        NSLog(@"pig love %@", pig.love);
        [pig printBaseInfo];
        
        Duck* duck = [[Duck alloc] init];
        duck.name = @"xiaohua";
        duck.age = 20;
        [duck printBaseInfo];
        
        NSLog(@"duck base info: %@", duck);
    }
    
    return 0;
}
