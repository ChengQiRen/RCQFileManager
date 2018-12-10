//
//  RCQNavigationBar.m
//  Huizhen
//
//  Created by 任成 on 2018/6/1.
//  Copyright © 2018年 Moca Inc. All rights reserved.
//

#import "RCQNavigationBar.h"
#import "RCQGenerlDefine.h"
#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation RCQNavigationBar


#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupRCQNavigationBarUIOnce];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupRCQNavigationBarUIOnce];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.frame.size.width, self.leftView.frame.size.height);
    
    self.rightView.frame = CGRectMake(self.frame.size.width - self.rightView.frame.size.width, kStatusBarHeight, self.rightView.frame.size.width, self.rightView.frame.size.height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (kNavigationBarHeight - self.titleView.frame.size.height) * 0.5, MIN(self.frame.size.width - MAX(self.leftView.frame.size.width, self.rightView.frame.size.width) * 2 - kViewMargin * 2, self.titleView.frame.size.width), self.titleView.frame.size.height);
    
    CGRect tempRect = self.titleView.frame;
    tempRect.origin.x = (self.frame.size.width * 0.5 - self.titleView.frame.size.width * 0.5);
    self.titleView.frame = tempRect;
    
    self.bottomBlackLineView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5);
}



#pragma mark - Setter
- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHaveTapGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            isHaveTapGes = YES;
            *stop = YES;
        }
    }];
    
    if (!isHaveTapGes) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [titleView addGestureRecognizer:tap];
    }
    [self layoutIfNeeded];
}




- (void)setTitle:(NSMutableAttributedString *)title {
    // bug fix
    if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarTitleView:)]) {
        return;
    }
    
    /**头部标题*/
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.7, 44)];
    navTitleLabel.numberOfLines = 1;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
//    navTitleLabel.lineBreakMode = NSLineBreakByClipping;
    self.titleView = navTitleLabel;
}


- (void)setLeftView:(UIView *)leftView {
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    _leftView = leftView;
    if ([leftView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)leftView;
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.layer.contents = (id)backgroundImage.CGImage;
}


- (void)setRightView:(UIView *)rightView {
    [_rightView removeFromSuperview];
    [self addSubview:rightView];
    _rightView = rightView;
    if ([rightView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)rightView;
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([rightView isKindOfClass:[UIView class]] && rightView.tag == 6423423) {
        UIImageView *imgV = (UIImageView *)rightView;
        imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBtnClick:)];
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonLongGesture:)];
        [imgV addGestureRecognizer:tapGes];
        [imgV addGestureRecognizer:longGes];
    }
    [self layoutIfNeeded];
}



- (void)setDataSource:(id<RCQNavigationBarDataSource>)dataSource {
    _dataSource = dataSource;
    [self setupDataSourceUI];
}


#pragma mark - getter

- (UIView *)bottomBlackLineView {
    if(!_bottomBlackLineView) {
        CGFloat height = 1;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn {
    if ([self.mcDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        [self.mcDelegate leftButtonEvent:btn navigationBar:self];
    }
}


- (void)rightBtnClick:(UIButton *)btn {
    if ([self.mcDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        [self.mcDelegate rightButtonEvent:btn navigationBar:self];
    }
}

- (void)rightButtonLongGesture:(UIButton *)btn {
    if ([self.mcDelegate respondsToSelector:@selector(rightButtonLongGestureEvent:navigationBar:)]) {
        [self.mcDelegate rightButtonLongGestureEvent:btn navigationBar:self];
    }
}


- (void)titleClick:(UIGestureRecognizer*)Tap {
    UILabel *view = (UILabel *)Tap.view;
    if ([self.mcDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
        [self.mcDelegate titleClickEvent:view navigationBar:self];
    }
}


#pragma mark - custom

- (void)setupDataSourceUI {
    /** 导航条的高度 */
    if ([self.dataSource respondsToSelector:@selector(mcNavigationHeight:)]) {
        CGRect tempRect = self.frame;
        tempRect.size = CGSizeMake(kWidth, [self.dataSource mcNavigationHeight:self]);
        self.frame = tempRect;
    }
    else {
        CGRect tempRect = self.frame;
        tempRect.size = CGSizeMake(kWidth, kDefaultNavBarHeight);
        self.frame = tempRect;
    }
    
    /** 是否显示底部黑线 */
    if ([self.dataSource respondsToSelector:@selector(mcNavigationIsHideBottomLine:)]) {
        if ([self.dataSource mcNavigationIsHideBottomLine:self]) {
            self.bottomBlackLineView.hidden = YES;
        }
    }
    
    /** 背景图片 */
    if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarBackgroundImage:)]) {
        self.backgroundImage = [self.dataSource RCQNavigationBarBackgroundImage:self];
    }
    
    /** 背景色 */
    if ([self.dataSource respondsToSelector:@selector(mcNavigationBackgroundColor:)]) {
        self.backgroundColor = [self.dataSource mcNavigationBackgroundColor:self];
    }
    
    
    /** 导航条中间的 View */
    if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarTitleView:)]) {
        self.titleView = [self.dataSource RCQNavigationBarTitleView:self];
    }
    else if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarTitle:)]) {
        /**头部标题*/
        self.title = [self.dataSource RCQNavigationBarTitle:self];
    }
    
    
    /** 导航条的左边的 view */
    /** 导航条左边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarLeftView:)]) {
        self.leftView = [self.dataSource RCQNavigationBarLeftView:self];
    }
    else if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarLeftButtonImage:navigationBar:)]) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        UIImage *image = [self.dataSource RCQNavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        self.leftView = btn;
    }
    
    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarRightView:)]) {
        self.rightView = [self.dataSource RCQNavigationBarRightView:self];
    }
    else if ([self.dataSource respondsToSelector:@selector(RCQNavigationBarRightButtonImage:navigationBar:)]) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        UIImage *image = [self.dataSource RCQNavigationBarRightButtonImage:btn navigationBar:self];
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        self.rightView = btn;
    }
    
}

- (void)setupRCQNavigationBarUIOnce {
    self.backgroundColor = [UIColor whiteColor];
}

@end
