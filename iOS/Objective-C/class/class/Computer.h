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

// 多态：不同对象对同一消息的不同响应方式。父类型的指针指向子类型。多态的前提是继承和子类对父类方法的重写。
- (void) showPrice;

- (void) showName;

@end

