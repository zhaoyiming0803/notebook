//
//  main.m
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntermediaryA.h"
#import "IntermediaryB.h"
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IntermediaryA* a = [[IntermediaryA alloc] init];
        [a sell];
        
        IntermediaryB* b = [[IntermediaryB alloc] init];
        [b sell];
        
        Person* p = [[Person alloc] init];
        
        p.ticketDelegate = a;
        [p buyTicket];
        
        p.ticketDelegate = b;
        [p buyTicket];
        
    }
    return 0;
}
