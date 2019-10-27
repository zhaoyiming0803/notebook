//
//  Computer.h
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Computer : NSObject {
    @public
    NSString* _name;
    
    @protected
    NSInteger _price;
    
    @private
    NSString* _company;
}

@property (copy, nonatomic) NSString* address;

- (instancetype) initWithName: (NSString*) name Price: (NSInteger)price Company: (NSString*) company Address: (NSString*) address;

// 多态：相同的消息有不同的实现。1、要有继承 2、要有方法重写
- (void) showPrice;


@end

