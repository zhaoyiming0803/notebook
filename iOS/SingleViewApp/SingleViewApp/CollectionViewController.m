//
//  CollectionViewViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/8.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CollectionViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor orangeColor];
        self.tabBarItem.title = @"Collection View";
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        // 先注册 cell 类型用于重用
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        
        [self.view addSubview:collectionView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end
