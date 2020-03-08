//
//  ViewController.m
//  test
//
//  Created by 赵一鸣 on 2020/3/5.
//  Copyright © 2020 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

#include  <stdio.h>
#define  PI  3.14159
#define  R   5.3

void fn() {
    printf("circumference=%.5f: ",PI * R);
    printf("Area=%.5f: ", PI * R * R * 1/2);
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fn();
}


@end
