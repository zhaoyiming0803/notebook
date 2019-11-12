//
//  DeleteCellView.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMDeleteCellView.h"

@interface YMDeleteCellView()

@property(nonatomic, strong, readwrite) UIView *backgroundView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;
@property(nonatomic, copy, readwrite) dispatch_block_t clickBlock;

@end

@implementation YMDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            self.backgroundView.backgroundColor = [UIColor blackColor];
            self.backgroundView.alpha = 0.5;
            [self.backgroundView addGestureRecognizer:({
                UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_clickButton)];
                tapGesture;
            })];
            self.backgroundView;
        })];
        
        [self addSubview:({
            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            self.deleteButton.backgroundColor = [UIColor blueColor];
            [self.deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            self.deleteButton;
        })];
    }
    return self;
}

- (void) _clickButton{
    [self dismissDeleteView];
}

- (void) showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock {
    self.deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    self.clickBlock = [clickBlock copy];
    
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
    
//    [UIView animateWithDuration:1 animations:^{
//        CGFloat width = self.deleteButton.frame.size.width;
//        CGFloat height = self.deleteButton.frame.size.height;
//        self.deleteButton.frame = CGRectMake(self.frame.size.width / 2 - 100, self.frame.size.height / 2 - 100, width, height);
//    }];
    
    [UIView animateWithDuration:1  delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake(self.frame.size.width / 2 - 100, self.frame.size.height / 2 - 100, 200, 200);
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"complate");
        }
    }];
}

- (void) dismissDeleteView {
    [self removeFromSuperview];
    self.clickBlock();
}

@end
