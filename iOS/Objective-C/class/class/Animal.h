//
//  Animal.h
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Animal : NSObject

@property(copy, nonatomic) NSString* name;
@property(assign, nonatomic) NSInteger age;

- (void) printBaseInfo;

// 重写 NSObject 的方法 description，但是不能显式调用
// 返回值类型为字符串
// 在具体使用的时候，可以直接使用 NSLog 打印实例化的对象
- (NSString*) description;

@end

