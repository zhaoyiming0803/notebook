//
//  main.m
//  test-Objective-C
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *arr = @[@1, @2, @3, @4];
        NSLog(@"%@", arr);
        
        for (id item in arr) {
            NSLog(@"%@", item);
        }
        
        NSString *str = @"hello Objective-C";
        NSLog(@"%@", str);
        
    }
    return 0;
}
