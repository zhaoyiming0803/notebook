//
//  Person.h
//  block
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^Block) (NSString* a, NSString* b);

@interface Person : NSObject

@property(nonatomic, copy) Block block;

@end

