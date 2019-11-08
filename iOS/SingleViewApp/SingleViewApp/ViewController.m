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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    cell.textLabel.text = @"主标题";
    cell.textLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.text = @"副标题";
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.imageView.image = [UIImage imageNamed:@"./icon.bundle/red-packet@3x.png"];
    return cell;
}

@end
