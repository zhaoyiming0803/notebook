//
//  Person.h
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(weak, nonatomic) id<Ticket> ticketDelegate;

- (void) buyTicket;

@end

NS_ASSUME_NONNULL_END
