//
//  ViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/2.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.tabBarItem.title = @"红色";
    
    UIView* box = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    box.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:box];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushController)];
    [box addGestureRecognizer:tapGesture];
}

- (void) pushController {
    // 当有 UINavigationController 将当前 ViewController 作为 root view controller 初始化时
    // 就会给 self 添加上 navigationController 属性
//    NSLog(@"%@", self.navigationController);
    
    UIViewController* viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor purpleColor];
    viewController.navigationItem.title = @"页面标题";
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
//    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
