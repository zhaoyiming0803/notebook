//
//  Ticket.h
//  protocol
//
//  Created by 赵一鸣 on 2019/10/29.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// *** 继承和面向接口（iOS架构思想篇）https://www.jianshu.com/p/39e6a8409476

// 面向接口的思想：
// 对于接口这一概念的支持，不同语言的实现形式不同。
// Java中，由于不支持多重继承，因此提供了一个Interface关键词。
// 而在C++中，通常是通过定义抽象基类的方式来实现接口定义的。
// Objective-C既不支持多重继承，也没有使用Interface关键词作为接口的实现（Interface作为类的声明来使用），而是通过抽象基类和协议（protocol）来共同实现接口的。
// OC中接口可以理解为Protocol，面向接口编程可以理解为面向协议编程。先看如下两端代码：

// 面向对象和面向接口的区别：
// 面向对象编程和面向协议编程最明显的区别在于程序设计过程中对数据类型的抽取（抽象）上，
// 面向对象编程使用类和继承的手段，数据类型是引用类型；
// 而面向协议编程使用的是遵守协议的手段，数据类型是值类型（Swift中的结构体或枚举）。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 一个协议可以扩展自另一个协议，例如下面的 Ticket 就扩展自 NSObject，如果需要扩展多个协议中间使用逗号分隔
@protocol Ticket <NSObject>

@required
- (void) buy;

@optional
- (void) sell;

@end

NS_ASSUME_NONNULL_END
