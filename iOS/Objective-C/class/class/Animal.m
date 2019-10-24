//
//  Animal.m
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (void) printBaseInfo {
    NSLog(@"name: %@, age: %ld", self.name, self.age);
}

- (NSString*) description {
    return [NSString stringWithFormat:@"name: %@, age: %ld", self.name, self.age];
}

@end
