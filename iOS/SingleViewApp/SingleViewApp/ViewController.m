//
//  ViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/2.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// 每个 cell 进入视图，都要执行当前函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row: %ld", indexPath.row);
    // UITableViewCell 的复用机制：先去系统回收池获取 cell
    // 如果能取到，则直接复用
    // 如果没有可用的 cell，则再次创建
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.textLabel.text = @"主标题";
    cell.textLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.text = @"副标题";
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.imageView.image = [UIImage imageNamed:@"./icon.bundle/red-packet@3x.png"];
    return cell;
}

@end
