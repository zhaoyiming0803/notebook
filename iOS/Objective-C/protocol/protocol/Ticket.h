//
//  Ticket.h
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Ticket <NSObject>

@required
- (void) buy;

@optional
- (void) sell;

@end

NS_ASSUME_NONNULL_END
