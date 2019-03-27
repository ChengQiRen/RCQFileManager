//
//  RCGenerlDefine.h
//  RCSandboxFilesManager
//
//  Created by 任成 on 2018/6/20.
//  Copyright © 2018年 任成. All rights reserved.
//

#ifndef RCGenerlDefine_h
#define RCGenerlDefine_h


#import "RCQBaseViewController.h"
// Status bar height.
#define kStatusBarHeight (is_iPhoneX ? 44.f : 20.f)

/** 导航栏*/
#define kNavigationBarHeight 44.f

#define kNavigationHeight (kNavigationBarHeight + kStatusBarHeight)

#define kTabBarHeight  (49 + kTabBarSafeBottomHeight)

#define kTabBarSafeBottomHeight is_iPhoneX ? 34 : 0

#define kWidth [UIScreen mainScreen].bounds.size.width

#define kHeight [UIScreen mainScreen].bounds.size.height

#define is_iPhoneX (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) ||CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(896, 414)))

// 图片路径
#define kRCSandboxFilesSrcName(file)               [@"RCQFileManager.bundle" stringByAppendingPathComponent:file]

#define kRCSandboxImage(file)                 [UIImage imageNamed:kRCSandboxFilesSrcName(file)]

#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif




#endif /* RCGenerlDefine_h */
