//
//  Book.m
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Book.h"

@implementation Book

-(instancetype) initWithName: (NSString*)name Pages: (NSInteger) pages {
    self = [super init];
    if (self) {
        self.name = name;
        self.pages = pages;
    }
    return self;
}

@end
