//
//  Person.h
//  oop
//
//  Created by 赵一鸣 on 2019/10/18.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 面向对象的三个特性：
// 封装：把客观事物封装成抽象的类，并且类可以把自己的数据和方法只让可信的类或者对象操作，对不可信的进行信息隐藏。
// 继承：减少代码重复度，可以使用现有类的所有功能，并在无需重新编写原来的类的情况下对这些功能进行扩展。
// 多态：父类型声明的对象指向子类型，允许将子类类型的指针赋值给父类类型的指针

#import <Foundation/Foundation.h>

@interface Person : NSObject

// 属性关键字：

// 属性类型相关
// assign 默认的，一般用于非对象类型的属性，NSInteger double 等
// retain 用于对象类型的属性
// copy 多用于 NSString 类型的属性

// 线程相关：
// nonatomic 默认的，适用于单线程
// atomic 适用于多线程

// 访问权限相关：
// readonly 只生成 getter 方法
// readwrite 默认的，生成 getter 和 setter 方法

// 方法生成相关：
// setter 重命名自动生成的 setter 方法
// getter 重命名自动生成的 getter 方法

// OC导入类#import与@class的区别 https://blog.csdn.net/SkewRain/article/details/25306107
// 关于 atomic 和 nonatomic 的区别：https://www.jianshu.com/p/7288eacbb1a2
// 关于 copy 和 strong 的区别：https://www.jianshu.com/p/bb3d0c62f5c9
// 关于 OC property 指示符：https://blog.csdn.net/lingyun_blog/article/details/41779955
// c++ 中引用和指针的简单介绍：https://www.zhihu.com/question/37608201
// OC 属性、属性关键字用法大全 https://www.jianshu.com/p/98db9087a6e7
@property(copy, nonatomic) NSString* name;
@property(copy, nonatomic) NSString* sex;
@property(assign, nonatomic) NSInteger age;
@property(strong, nonatomic) NSArray* children;

// 重命名 setter 方法的时候，不要忘记方法名后面的冒号
@property(copy, nonatomic, setter = mySetGirlFriend:, getter = myGetGirlFriend) NSString* girlFriend;

- (void) say;

- (NSString *)love :(NSString*)a :(NSString*)b;
- (void) mySetName :(NSString*)name sex:(NSString*)sex age:(NSInteger)age;

+ (void) eat :(NSString *)food;

@end
