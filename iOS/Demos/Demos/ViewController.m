//
//  ViewController.m
//  Demos
//
//  Created by 赵一鸣 on 2019/11/13.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, readwrite, strong) UIView *redView;
@property(nonatomic, readwrite, strong) UIView *blueView;
@property(nonatomic, readwrite, assign) CGPoint beginPoint;
@property(nonatomic, readwrite, assign) CGPoint endPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(300, 100, 100, 100)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = touches.anyObject;
//    CGPoint point = [touch locationInView:self.redView];
//    NSLog(@"point: %@", NSStringFromCGPoint(point));
//    NSLog(@"view: %@", touch.view);
//
//    NSLog(@"event: %@", event);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"my view controller: %s", __func__);
    self.beginPoint = [touches.anyObject locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.endPoint = [touches.anyObject locationInView:self.view];
    
    if (self.beginPoint.x < self.endPoint.x) {
        self.view.backgroundColor = [UIColor redColor];
    } else {
        self.view.backgroundColor = [UIColor blueColor];
    }
}


@end
