//
//  main.m
//  foundation
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CGPoint point = CGPointMake(200, 200);
        CGSize size = CGSizeMake(200, 200);
        CGRect rect = CGRectMake(0, 0, 100, 100);
        // CGRect 是 NSRect 的别名，CGPoint 和 CGSize 同理
        
        NSNumber* num = [[NSNumber alloc] initWithInt:100];
        NSLog(@"initWithInt: %@", num);
        
        NSValue* rectVal = [NSValue valueWithRect:rect];
        NSValue* pointVal = [NSValue valueWithPoint:point];
        NSValue* sizeVal = [NSValue valueWithSize:size];
        
        NSLog(@"rectVal: %@", rectVal);
        NSLog(@"pointVal: %@", pointVal);
        NSLog(@"sizeVal: %@", sizeVal);
        
        NSDate* date = [[NSDate alloc] init];
        NSLog(@"date: %@", date);
        
        NSDateFormatter* formatedDate = [[NSDateFormatter alloc] init];
        formatedDate.dateFormat = @"yyyy年mm月dd日 HH时mm分ss秒";
        NSLog(@"formatedDate: %@", [formatedDate stringFromDate:date]);
    }
    return 0;
}
