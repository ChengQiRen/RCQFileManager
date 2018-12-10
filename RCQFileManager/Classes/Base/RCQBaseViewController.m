//
//  RCBaseViewController.m
//  RCSandboxFilesFramework
//
//  Created by 任成 on 2018/6/20.
//  Copyright © 2018年 任成. All rights reserved.
//

#import "RCQBaseViewController.h"
#import "RCQGenerlDefine.h"
@interface RCQBaseViewController () <RCQNavigationBarDataSource, RCQNavigationBarDelegate>

@end

@implementation RCQBaseViewController


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect rect = self.navgationBar.frame;
    rect.size.width = self.view.frame.size.width;
    self.navgationBar.frame = rect;
    [self.view bringSubviewToFront:self.navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = [self navUIBaseViewControllerPreferStatusBarStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
}


#pragma mark - LMJNavUIBaseViewControllerDataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar {
    return YES;
}


- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - DataSource
/**头部标题*/
- (NSMutableAttributedString*)RCQNavigationBarTitle:(RCQNavigationBar *)navigationBar {
    return [self changeTitle:self.title?:self.navigationItem.title?:@"沙盒"];
}

/** 背景图片 */
//- (UIImage *)RCQNavigationBarBackgroundImage:(RCQNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)mcNavigationBackgroundColor:(RCQNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}

/** 是否隐藏底部黑线 */
- (BOOL)mcNavigationIsHideBottomLine:(RCQNavigationBar *)navigationBar {
    return NO;
}

/** 导航条的高度 */
- (CGFloat)mcNavigationHeight:(RCQNavigationBar *)navigationBar {
    return kStatusBarHeight + kNavigationBarHeight;
}

- (UIImage *)RCQNavigationBarBackgroundImage:(RCQNavigationBar *)navigationBar {
    return nil;
}

/** 导航条的左边的 view */
//- (UIView *)RCQNavigationBarLeftView:(RCQNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)RCQNavigationBarRightView:(RCQNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)RCQNavigationBarTitleView:(RCQNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
- (UIImage *)RCQNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RCQNavigationBar *)navigationBar {
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        return [self imagesNamedFromCustomBundle:@"back_gray@2x"];
    }
    return [self imagesNamedFromCustomBundle:@"back_close@2x"];
}
/** 导航条右边的按钮 */
//- (UIImage *)RCQNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RCQNavigationBar *)navigationBar
//{
//
//}

- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName {
    NSString *imageName = [@"rc_" stringByAppendingString:imgName];
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"RCQFileManager.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (bundle == nil) {
        bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"Frameworks/RCQFileManager.framework/RCQFileManager.bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:imageName ofType:@"png"]];
    }
}


#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RCQNavigationBar *)navigationBar
{
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(RCQNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(RCQNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}


- (RCQNavigationBar *)navgationBar {
    // 父类控制器必须是导航控制器
    if(!_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]] && [self navUIBaseViewControllerIsNeedNavBar]) {
        _navgationBar = [[RCQNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0)];
        _navgationBar.dataSource = self;
        _navgationBar.mcDelegate = self;
        [self.view addSubview:_navgationBar];
    }
    return _navgationBar;
}



- (void)changeNavigationBarTranslationY:(CGFloat)translationY {
    self.navgationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)changeNavgationTitle:(NSMutableAttributedString *)title {
    self.navgationBar.title = title;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    self.navgationBar.title = [self changeTitle:title];
}

- (void)changeNavigationBarHeight:(CGFloat)height {
    CGRect tempRect = self.navgationBar.frame;
    tempRect.size.height = height;
    self.navgationBar.frame = tempRect;
}

- (void)changeNavgationBarBackgroundColor:(UIColor *)backgroundColor {
    self.navgationBar.backgroundColor = backgroundColor;
}

@end
