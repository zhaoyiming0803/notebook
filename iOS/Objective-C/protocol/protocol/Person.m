//
//  Person.m
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void) buyTicket {
    if ([self.ticketDelegate respondsToSelector:@selector(buy)]) {
        [self.ticketDelegate buy];
    }
}

@end
