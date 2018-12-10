//
//  RCQLookFilesViewController.m
//  RCQSandboxFilesManager
//
//  Created by 任成 on 2018/6/5.
//  Copyright © 2018年 任成. All rights reserved.
//

#import "RCQFileExlporeViewController.h"
#import "RCQLookTxtViewController.h"
#import "RCQGenerlDefine.h"
#import "RCQLookFilesTableViewCell.h"

@interface RCQFileExlporeViewController () <UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation RCQFileExlporeViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect rect = self.tableView.frame;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height - kNavigationHeight - 1;
    self.tableView.frame = rect;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count == 1) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat a = self.view.frame.size.height;
    CGFloat b = kNavigationHeight;
    CGFloat c = kTabBarSafeBottomHeight;
    self.tableView.frame = CGRectMake(0, kNavigationHeight + 1, kWidth, a - b - c - 1);
}

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //在这里获取应用程序Documents文件夹里的文件及文件夹列表
        NSString *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *shahe = [docDirs substringToIndex:docDirs.length - [@"Documents" length] - 1];
        self.fileList = [self loadFilesWithDir:shahe];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - 递归循环调用
- (NSMutableArray<RCLookFilesModel *> *)loadFilesWithDir:(NSString *)dir {
    // docFiles是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *docFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    NSMutableArray *fileList = [NSMutableArray array];
    for (NSString *name in docFiles) {
        RCLookFilesModel *fileObj = [[RCLookFilesModel alloc] init];
        fileObj.fileName = name;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[dir stringByAppendingPathComponent:name] error:nil];
        fileObj.filemTime = [fileAttributes objectForKey:@"NSFileCreationDate"];
        fileObj.fileSize = [[fileAttributes objectForKey:@"NSFileSize"] integerValue];
        fileObj.fileOwner = [fileAttributes objectForKey:@"NSFileGroupOwnerAccountName"];
        fileObj.filePath = [dir stringByAppendingPathComponent:name];
        fileObj.isDir = [[fileAttributes objectForKey:@"NSFileType"] isEqualToString:NSFileTypeDirectory];
        if (fileObj.isDir) {
            fileObj.nodes = [self loadFilesWithDir:fileObj.filePath];
        }
        // 去除隐藏文件
        if (![fileObj.fileName hasPrefix:@"."]) {
            [fileList addObject:fileObj];
        }
//        NSLog(@"\n");
//        NSLog(@"%@", fileAttributes);
    }
    return fileList;
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    return self.navigationController;
}

#pragma mark - delegate   - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCQLookFilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RCQLookFilesTableViewCell" forIndexPath:indexPath];
    RCLookFilesModel *fileObj = self.fileList[indexPath.row];
    
    cell.titleLabel.text = fileObj.isDir ? [NSString stringWithFormat:@"%@ (%lu)", fileObj.fileName, (unsigned long)fileObj.nodes.count] : fileObj.fileName;//文件名
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];//日期
    cell.timeLabel.text = [dateFormatter stringFromDate:fileObj.filemTime];
    
    //文件大小
    NSString *sizeStr;
    if (fileObj.fileSize > 1048576 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2fGB", (double)(fileObj.fileSize/1048576/1024)];
    }
    else if (fileObj.fileSize > 1048576) {
        sizeStr = [NSString stringWithFormat:@"%.2fMB", (double)(fileObj.fileSize/1048576)];
    }
    else {
        sizeStr = [NSString stringWithFormat:@"%.2fKB", (double)(fileObj.fileSize/1024)];
    }
    
    cell.sizeLabel.text = sizeStr;
    
    NSArray *strDivision = [cell.titleLabel.text componentsSeparatedByString:@"."];
    NSString *strIntercept = [strDivision lastObject];
 
    cell.contentView.alpha = 1.;
    cell.userInteractionEnabled = YES;
    if ([strIntercept isEqualToString:@"png"] || [strIntercept isEqualToString:@"jpg"] || [strIntercept isEqualToString:@"jpeg"] || [strIntercept isEqualToString:@"gif"]) {
        cell.fileImageView.image = [UIImage imageWithContentsOfFile:fileObj.filePath];
    }
    else if (fileObj.isDir) {
        cell.fileImageView.image = [self imagesNamedFromCustomBundle:@"folder"];
        cell.sizeLabel.hidden = YES;
        if (fileObj.nodes.count == 0) {
            cell.userInteractionEnabled = NO;
            cell.contentView.alpha = 0.4;
        }
    }
    else {
        cell.sizeLabel.hidden = NO;
        NSString *imagePath = strIntercept;
        UIImage *img = [self imagesNamedFromCustomBundle:imagePath];
        if (!img) {
            img = [self imagesNamedFromCustomBundle:@"unknown"];
        }
        cell.fileImageView.image = img;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    UIView *viewTemp1 = [[UIView alloc] init];
    viewTemp1.backgroundColor = [UIColor whiteColor];
    viewTemp1.frame=CGRectMake(0, 0, self.view.frame.size.width, 59);
    cell.backgroundView = [[UIView alloc] init];
    [cell.backgroundView addSubview:viewTemp1];
    cell.backgroundColor = [UIColor clearColor];
}


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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    RCLookFilesModel *fileObj = self.fileList[indexPath.row];
    [[NSFileManager defaultManager] removeItemAtPath:fileObj.filePath error:nil];
    [self.fileList removeObject:fileObj];
    // 移除tableView中的数据
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCLookFilesModel *fileObj = self.fileList[indexPath.row];
    if (fileObj.isDir) {
        if (!fileObj.nodes || fileObj.nodes.count == 0) {
            NSLog(@"文件夹为空");
            return;
        }
        RCQFileExlporeViewController *viewController = [[self.class alloc] init];
        viewController.fileList = fileObj.nodes;
        viewController.navigationItem.title = fileObj.fileName;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else {
        if ([fileObj.fileName.pathExtension isEqualToString:@"txt"]) {
            RCQLookTxtViewController *txtVc = [RCQLookTxtViewController new];
            txtVc.filePath = fileObj.filePath;
            [self.navigationController pushViewController:txtVc animated:YES];
        }
//        NSString *preview = [_dataFileArray objectAtIndex:indexPath.row];
//        NSString *path = [docDirs stringByAppendingPathComponent:preview];
//        //准备文档的Url
//        _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
//        [_documentController setDelegate:self];
//        //当前APP打开  需实现协议方法才可以完成预览功能
//        [_documentController presentPreviewAnimated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RCQLookFilesTableViewCell class] forCellReuseIdentifier:@"RCQLookFilesTableViewCell"];
        [self.view addSubview:_tableView];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
