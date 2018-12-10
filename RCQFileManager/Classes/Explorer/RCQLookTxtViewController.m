//
//  LookTxtViewController.m
//  VMEET
//
//  Created by GJF on 2018/6/13.
//  Copyright © 2018年 Jinfj. All rights reserved.
//

#import "RCQLookTxtViewController.h"

@interface RCQLookTxtViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *txtLabel;
@end

@implementation RCQLookTxtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat a = self.view.frame.size.height;
    CGFloat b = kNavigationHeight;
    CGFloat c = kTabBarSafeBottomHeight;
    CGFloat scroll_height = a - (b + c);
    self.scrollView.frame = CGRectMake(0, kNavigationHeight, self.view.frame.size.width, scroll_height);
    NSString *text = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    self.txtLabel.text = text;
    
    CGSize strSize = [text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
    
    CGFloat height = strSize.height;
    self.txtLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
    // Do any additional setup after loading the view.
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UILabel *)txtLabel {
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc] init];
        _txtLabel.font = [UIFont systemFontOfSize:11];
        _txtLabel.numberOfLines = 0;
        [self.scrollView addSubview:_txtLabel];
    }
    return _txtLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
