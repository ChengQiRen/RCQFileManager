//
//  RCQNavigationBar.h
//  Huizhen
//
//  Created by 任成 on 2018/6/1.
//  Copyright © 2018年 Moca Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RCQNavigationBar;
// 主要处理导航条
@protocol  RCQNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)RCQNavigationBarTitle:(RCQNavigationBar *)navigationBar;

/** 背景图片 */
- (UIImage *)RCQNavigationBarBackgroundImage:(RCQNavigationBar *)navigationBar;
 /** 背景色 */
- (UIColor *)mcNavigationBackgroundColor:(RCQNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)mcNavigationIsHideBottomLine:(RCQNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)mcNavigationHeight:(RCQNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)RCQNavigationBarLeftView:(RCQNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)RCQNavigationBarRightView:(RCQNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)RCQNavigationBarTitleView:(RCQNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)RCQNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RCQNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)RCQNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RCQNavigationBar *)navigationBar;
@end


@protocol RCQNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RCQNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(RCQNavigationBar *)navigationBar;
/** 右边的按钮的长按 */
-(void)rightButtonLongGestureEvent:(UIButton *)sender navigationBar:(RCQNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(RCQNavigationBar *)navigationBar;
@end


@interface RCQNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** 标题 */
@property (weak, nonatomic) UIView *titleView;

/** 左按钮 */
@property (weak, nonatomic) UIView *leftView;

/** 右按钮 */
@property (weak, nonatomic) UIView *rightView;

/** 富文本标题 */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** 数据源协议 */
@property (assign, nonatomic) id<RCQNavigationBarDataSource> dataSource;

/** 代理协议 */
@property (assign, nonatomic) id<RCQNavigationBarDelegate> mcDelegate;

/** 背景图片 */
@property (weak, nonatomic) UIImage *backgroundImage;

@end
