//
//  RCLookFilesTableViewCell.h
//  RCSandboxFilesManager
//
//  Created by 任成 on 2018/6/5.
//  Copyright © 2018年 任成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCQLookFilesTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *fileImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *sizeLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@end
