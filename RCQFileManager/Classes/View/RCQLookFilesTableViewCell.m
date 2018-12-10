//
//  RCLookFilesTableViewCell.m
//  RCSandboxFilesManager
//
//  Created by 任成 on 2018/6/5.
//  Copyright © 2018年 任成. All rights reserved.
//

#import "RCQLookFilesTableViewCell.h"

@implementation RCQLookFilesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self fileImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat fileImageViewX = 15;
    CGFloat fileImageViewY = 10;
    CGFloat fileImageViewW = self.contentView.frame.size.height - 2 * fileImageViewY;
    CGFloat fileImageViewH = fileImageViewW;
    self.fileImageView.frame = CGRectMake(fileImageViewX, fileImageViewY, fileImageViewW, fileImageViewH);
    
    
    CGFloat titleLabelX = fileImageViewX + fileImageViewW + 10;
    CGFloat titleLabelY = fileImageViewY;
    CGFloat titleLabelW = self.contentView.frame.size.width - titleLabelX - 20;
    CGFloat titleLabelH = fileImageViewH * 0.65;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat sizeLabelX = titleLabelX;
    CGFloat sizeLabelY = titleLabelY + titleLabelH;
    CGFloat sizeLabelW = 100;
    CGFloat sizeLabelH = fileImageViewH - titleLabelH;
    self.timeLabel.frame = CGRectMake(sizeLabelX, sizeLabelY, sizeLabelW, sizeLabelH);
    
    CGFloat timeLabelX = sizeLabelX + sizeLabelW;
    CGFloat timeLabelY = sizeLabelY;
    CGFloat timeLabelW = 80;
    CGFloat timeLabelH = sizeLabelH;
    self.sizeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
}

- (UIImageView *)fileImageView {
    if (!_fileImageView) {
        _fileImageView = [[UIImageView alloc] init];
        _fileImageView.contentMode = UIViewContentModeScaleAspectFill;
        _fileImageView.clipsToBounds = YES;
        [self.contentView addSubview:_fileImageView];
    }
    return _fileImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_sizeLabel];
    }
    return _sizeLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
