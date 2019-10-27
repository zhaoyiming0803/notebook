//
//  Dog.m
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Dog.h"

@implementation Dog 
    
-(instancetype) initWithName: (NSString*) name Age:(NSInteger) age Sex:(NSString*) sex {
    self = [super init];
    if (self) {
        self->_name = name;
        self->_age = age;
        self->_sex = sex;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"name: %@, age: %ld, sex: %@", self->_name, self->_age, self->_sex];
}

@end
