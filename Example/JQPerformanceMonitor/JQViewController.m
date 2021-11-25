//
//  JQViewController.m
//  JQPerformanceMonitor
//
//  Created by vidonia on 11/25/2021.
//  Copyright (c) 2021 vidonia. All rights reserved.
//

#import "JQViewController.h"
#import "JQCatonViewController.h"

@interface JQViewController ()

@end

@implementation JQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)tableViewCatonTest:(id)sender {
    JQCatonViewController *vc = [JQCatonViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
