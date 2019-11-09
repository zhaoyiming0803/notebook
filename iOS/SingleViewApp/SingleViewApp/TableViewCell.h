//
//  TableViewCell.h
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

- (void) layoutTableCellTitle:(NSString*) titleLabel sourceLabel:(NSString *)sourceLabel timeLabel:(NSString *)timeLabel;

@end

NS_ASSUME_NONNULL_END
