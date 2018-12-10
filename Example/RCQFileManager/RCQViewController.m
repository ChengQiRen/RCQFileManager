//
//  RCQViewController.m
//  RCQFileManager
//
//  Created by rencheng11@icloud.com on 12/10/2018.
//  Copyright (c) 2018 rencheng11@icloud.com. All rights reserved.
//

#import "RCQViewController.h"
#import "RCQFileExploreViewController.h"

@interface RCQViewController ()

@end

@implementation RCQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openExplore:(UIButton *)sender {
    RCQFileExploreViewController *vc = [[RCQFileExploreViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
