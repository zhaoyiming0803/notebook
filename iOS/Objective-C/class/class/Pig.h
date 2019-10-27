//
//  Pig.h
//  class
//
//  Created by 赵一鸣 on 2019/10/24.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Animal.h"


@interface Pig : Animal

// 使用 property 定义的属性，其实默认是受保护的成员变量，只是多了一些 get/set 及一些属性描述
@property(copy, nonatomic) NSString* love;

@end

