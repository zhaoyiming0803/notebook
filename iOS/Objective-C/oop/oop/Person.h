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

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

// 关于 atomic 和 nonatomic 的区别：https://www.jianshu.com/p/7288eacbb1a2
// 关于 copy 和 strong 的区别：https://www.jianshu.com/p/bb3d0c62f5c9
// 关于 OC property 指示符：https://blog.csdn.net/lingyun_blog/article/details/41779955
// c++ 中引用和指针的简单介绍：https://www.zhihu.com/question/37608201
@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic) NSString *sex;
@property(assign, nonatomic) NSInteger *age;
@property(strong, nonatomic) NSArray *children;

-(void) say;

-(NSString *)love :(NSString *)a :(NSString *)b;

+(void) eat :(NSString *)food;

@end

NS_ASSUME_NONNULL_END
