//
//  TableViewCell.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "TableViewCell.h"

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
}

@end
