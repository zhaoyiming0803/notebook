//
//  YMRegionItem.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/11.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMRegionItem.h"

@implementation YMRegionItem

- (void) configWithDictionary:(NSDictionary *)dictionary {
    if (!dictionary) {
        return;
    }
    self.regionId = (NSInteger)dictionary[@"id"] || 0;
    self.regionName = (NSString *)dictionary[@"region_name"];
}

@end
