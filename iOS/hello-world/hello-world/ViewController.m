//
//  ViewController.m
//  hello-world
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        UILabel* label = [[UILabel alloc] init];
        label.text = @"hello world";
        [label sizeToFit];
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size
                                   .height/2);
        label;
    })];
}


@end
