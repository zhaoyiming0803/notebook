//
//  ViewController.m
//  hello-world
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

// UIView 的生命周期：
// init > willMoveToSuperview > didMoveToSuperview > willMoveToWindow > didMoveToWindow

#import "ViewController.h"

@interface TestUIView : UIView

@end

@implementation TestUIView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"TestUIView init");
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    NSLog(@"will move to super view");
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    NSLog(@"did move to super view");
}

- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    NSLog(@"will move to window");
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    NSLog(@"did move to window");
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:({
//        UILabel* label = [[UILabel alloc] init];
//        label.text = @"hello world";
//        [label sizeToFit];
//        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size
//                                   .height/2);
//        label;
//    })];
    
    TestUIView* view1 = [[TestUIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    view1.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view1];
    
//    UIView* view2 = [[UIView alloc] init];
//    view2.backgroundColor = [UIColor blueColor];
//    view2.frame = CGRectMake(150, 150, 100, 100);
//    [self.view addSubview:view2];
}


@end
