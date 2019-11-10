//
//  NormalViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMNormalViewController.h"

@interface YMNormalViewController ()

@end

@implementation YMNormalViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.title = @"Normal view";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self.view addSubview:view];
}

- (void) viewClick {
    NSLog(@"viewClick");
}

@end
