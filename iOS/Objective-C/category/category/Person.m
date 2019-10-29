//
//  Person.m
//  category
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Person.h"

// 在 .m 文件中定义的 interface，外部是不能直接调用的，相当于私有方法
@interface Person ();

-(NSString*) getName;

@end

@implementation Person

-(void) say {
    NSString* str = @"Hello ";
    NSString* str2 = [str stringByAppendingString: [self getName] ];
    NSLog(@"%@", str2);
};

-(NSString*) getName {
    return @"zhaoyiming";
}

@end
