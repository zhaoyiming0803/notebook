//
//  TableViewCell.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *sourceLabel;
@property(nonatomic, strong, readwrite) UILabel *timeLabel;
@property(nonatomic, strong, readwrite) UIImageView *rightImageView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 150, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:14];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 70, 100, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:14];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];
        
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 20, 70, 70)];
            self.rightImageView.backgroundColor = [UIColor redColor];
            self.rightImageView;
        })];
        
        [self.contentView addSubview:({
            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 70, 40, 20)];
            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
            [self.deleteButton setTitle:@"Y" forState:UIControlStateHighlighted];
            self.deleteButton.backgroundColor = [UIColor redColor];
            [self.deleteButton addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
            self.deleteButton;
        })];
    }
    return self;
}

- (void) layoutTableCellTitle:(NSString*) titleLabel sourceLabel:(NSString *)sourceLabel timeLabel:(NSString *)timeLabel {
    self.titleLabel.text = titleLabel;
    
    self.sourceLabel.text = sourceLabel;
    [self.sourceLabel sizeToFit];
    
    self.timeLabel.text = timeLabel;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(
                                      self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15,
                                      self.sourceLabel.frame.origin.y,
                                      self.timeLabel.frame.size.width,
                                      self.timeLabel.frame.size.height
                                    );
    self.rightImageView.image = [UIImage imageNamed:@"icon.bundle/jnt.png"];
}

- (void) deleteCell {
    NSLog(@"deleteCell");
}

@end
