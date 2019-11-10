//
//  YMRegionListApi.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/10.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMRegionApi.h"
#import <AFNetworking.h>

@implementation YMRegionApi

//- (void)getRegionList {
//    NSString *urlString = @"https://api.0351zhuangxiu.com/tour/region/list?a=1&b=2";
//    NSURL *url = [NSURL URLWithString:urlString];
////    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
////    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"data: %@", data);
//    }];
//
//    [dataTask resume];
//}

- (void) getRegionList {
    NSString *urlString = @"https://api.0351zhuangxiu.com/tour/region/list?a=1&b=2";
//    NSURL *url = [NSURL URLWithString:urlString];
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
    
