//
//  Person.h
//  kvc
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(nonatomic, copy, readonly) NSString* name;
@property(nonatomic, copy) NSString* sex;
@property(nonatomic, assign) NSInteger age;

- (void) resetPropertiesForSex:(NSString*)sex Age:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
