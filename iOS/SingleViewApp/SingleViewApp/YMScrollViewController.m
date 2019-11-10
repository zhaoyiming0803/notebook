//
//  ScrollViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMScrollViewController.h"

@interface YMScrollViewController ()<UIScrollViewDelegate>

@end

@implementation YMScrollViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Scroll View";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
    
    for (int i = 0; i < colorArray.count; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            view.backgroundColor = colorArray[i];
            view;
        })];
    }
    
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll: %f", scrollView.contentOffset.x);
};

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
};

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
}

@end
