//
//  ViewController.m
//  demo-NSThread
//
//  Created by 赵一鸣 on 2019/11/30.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", [NSThread currentThread]);
    
    [self detachNewThreadSelector];
    [self detachNewThreadWithBlock];
    [self detachNewThreadSelectorByInstance];
    [self detachNewThreadWithBlockByInstance];
}

- (void) detachNewThreadWithBlock {
    [NSThread detachNewThreadWithBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"%d = %@", i, [NSThread currentThread]);
        }
    }];
}

- (void) detachNewThreadSelector {
    [NSThread detachNewThreadSelector:@selector(runThread) toTarget:self withObject:nil];
}

- (void) runThread {
    for (int j = 5; j < 10; j++) {
        NSLog(@"%d = %@", j, [NSThread currentThread]);
    }
}

- (void) detachNewThreadSelectorByInstance {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    thread.name = @"detachNewThreadSelectorWithInstance";
    [thread start];
}

- (void) detachNewThreadWithBlockByInstance {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        for (int i = 0; i < 5; i++) {
            [NSThread sleepForTimeInterval:1]; // 延时n秒执行
            NSLog(@"%d = %@", i, [NSThread currentThread]);
        }
    }];
    thread.name = @"detachNewThreadWithBlockByInstance";
    [thread start];
}

@end
