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
#import "DeleteCellView.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate>

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) NSMutableArray *dataArray;

@end

@implementation TableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"TableView";
//        self.dataArray = @[].mutableCopy;
        self.dataArray = [[NSMutableArray alloc] initWithArray:@[]];
        for (int i = 0; i < 20; i++) {
            [self.dataArray addObject:@(i)] ;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}

// 每个 cell 进入视图，都要执行当前函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell 的复用机制：先去系统回收池获取 cell
    // 如果能取到，则直接复用
    // 如果没有可用的 cell，则再次创建
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
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

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    tableViewCell.alpha = 0.5;
    DeleteCellView *deleteCellView = [[DeleteCellView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
    
    __weak typeof(self) wxself = self;
    [deleteCellView showDeleteViewFromPoint:rect.origin clickBlock:^{
        NSLog(@"clickBlock");
        __strong typeof(self)strongSelf = wxself;
        [strongSelf.dataArray removeLastObject];
        [self.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
 
@end
