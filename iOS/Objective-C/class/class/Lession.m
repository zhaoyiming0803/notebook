//
//  Lession.m
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Lession.h"

@implementation Lession

-(instancetype) initWithName: (NSString*)name Hours:(NSInteger) hours {
    self = [super init];
    if (self) {
        self.name = name;
        self.hours = hours;
    }
    return self;
}

@end
