//
//  Lession.h
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lession : NSObject

@property(copy, nonatomic) NSString* name;
@property(assign, nonatomic) NSInteger hours;

-(instancetype) initWithName: (NSString*)name Hours:(NSInteger) hours;

@end

