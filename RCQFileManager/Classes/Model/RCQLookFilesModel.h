//
//  RCLookFilesModel.h
//  RCSandboxFilesManager
//
//  Created by 任成 on 2018/6/5.
//  Copyright © 2018年 任成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCLookFilesModel : NSObject

@property(nonatomic, copy)   NSString                       *fileName;  // 文件名
@property(nonatomic, copy)   NSString                       *fileOwner; // 所有人
@property(nonatomic, strong) NSDate                         *filemTime; // 创建时间
@property(nonatomic, assign) BOOL                           isDir;      // 是否是文件夹
@property(nonatomic, strong) NSMutableArray<RCLookFilesModel *>    *nodes;      // 子节点
@property(nonatomic, assign) NSInteger                      fileSize;   // 文件大小
@property(nonatomic, copy)   NSString                      *filePath;   // 文件位置

@end
