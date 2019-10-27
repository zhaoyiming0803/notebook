//
//  Student.m
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Student.h"

@implementation Student

-(instancetype) initWithBook: (Book*) book Lession: (Lession*) lession {
    self = [super init];
    if (self) {
        self.book = book;
        self.lession = lession;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"book: %@, lession: %@", self.book, self.lession];
}

@end
