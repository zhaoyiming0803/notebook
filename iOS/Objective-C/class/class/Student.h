//
//  Student.h
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "Lession.h"

// 复合类型：由多个类共同构成的新类，就是复合类型
@interface Student : NSObject

@property(retain, nonatomic) Book* book;
@property(retain, nonatomic) Lession* lession;

-(instancetype) initWithBook: (Book*) book Lession: (Lession*) lession;

@end

