//
//  ViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/2.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "TourWebViewController.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"TableView";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// 每个 cell 进入视图，都要执行当前函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell 的复用机制：先去系统回收池获取 cell
    // 如果能取到，则直接复用
    // 如果没有可用的 cell，则再次创建
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    
    [cell layoutTableCellTitle:[NSString stringWithFormat:@"主标题 - section - %ld", indexPath.section] sourceLabel:[NSString stringWithFormat:@"副标题 - row - %ld", indexPath.row] timeLabel:@"3分钟前"];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"主标题 - section - %ld", indexPath.section];
//    cell.textLabel.textColor = [UIColor redColor];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"副标题 - row - %ld", indexPath.row];
//    cell.detailTextLabel.textColor = [UIColor blueColor];
//    cell.imageView.image = [UIImage imageNamed:@"./icon.bundle/red-packet@3x.png"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TourWebViewController *controller = [[TourWebViewController alloc] init];
    controller.title = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSLog(@"%@", controller.title);
    [self.navigationController pushViewController:controller animated:YES];
}

@end
