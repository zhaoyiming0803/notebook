//
//  main.m
//  array
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// NSArray与NSMutableArray的区别 https://www.jianshu.com/p/7274d74a2283

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSArray* arr1 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
        NSArray* arr1 = @[@"1", @"2", @"3"];
        NSLog(@"arr1: %@", arr1);
        NSLog(@"arr1.length: %ld", arr1.count);
        NSLog(@"指定索引对应的元素：%@", [arr1 objectAtIndex:2]);
        
        // 从一个数组拷贝数据到另一数组
        NSMutableArray* arr2 = [[NSMutableArray alloc] initWithArray:arr1];
        NSLog(@"arr2 %@", arr2);
    }
    return 0;
}
