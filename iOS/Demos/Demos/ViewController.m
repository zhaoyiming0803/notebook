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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.redView];
    NSLog(@"point: %@", NSStringFromCGPoint(point));
    NSLog(@"view: %@", touch.view);
    
    NSLog(@"event: %@", event);
}


@end
