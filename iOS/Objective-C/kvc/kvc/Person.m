//
//  Person.m
//  kvc
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void) resetPropertiesForSex:(NSString*)sex Age:(NSInteger)age {
    NSDictionary* dic = @{
        @"sex": sex,
        @"age": [NSString stringWithFormat:@"%ld", age]
    };
    [self setValuesForKeysWithDictionary:dic];
}

@end
