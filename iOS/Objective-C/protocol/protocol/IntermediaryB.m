//
//  B.m
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "IntermediaryB.h"

@implementation IntermediaryB

- (instancetype) init {
    self = [super init];
    if (self) {
        // ...
    }
    return self;
}

- (void) sell {
    NSLog(@"B sell ticket");
}

- (void) buy {
    NSLog(@"B buy ticket");
}

@end
