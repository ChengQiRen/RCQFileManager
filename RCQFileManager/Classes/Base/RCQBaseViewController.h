//
//  RCBaseViewController.h
//  RCSandboxFilesFramework
//
//  Created by 任成 on 2018/6/20.
//  Copyright © 2018年 任成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCQNavigationBar.h"


@interface RCQBaseViewController : UIViewController

- (void)changeNavigationBarTranslationY:(CGFloat)translationY;

- (void)changeNavgationTitle:(NSMutableAttributedString *)title;

- (void)changeNavigationBarHeight:(CGFloat)height;

- (void)changeNavgationBarBackgroundColor:(UIColor *)backgroundColor;

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@property (strong, nonatomic) RCQNavigationBar *navgationBar;

- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;

@end
