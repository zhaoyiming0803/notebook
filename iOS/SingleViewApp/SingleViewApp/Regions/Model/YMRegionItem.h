//
//  YMRegionItem.h
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/11.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMRegionItem : NSObject

@property(nonatomic, assign, readwrite) NSInteger regionId;
@property(nonatomic, copy, readwrite) NSString *regionName;

- (void) configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
