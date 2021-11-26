//
//  JQViewController.m
//  JQPerformanceMonitor
//
//  Created by vidonia on 11/25/2021.
//  Copyright (c) 2021 vidonia. All rights reserved.
//

#import "JQViewController.h"
#import "JQCatonViewController.h"
#import "JQCPUMonitor.h"

@interface JQViewController ()

@end

@implementation JQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [JQCPUMonitor startMonitor];
}

- (IBAction)tableViewCatonTest:(id)sender {
    JQCatonViewController *vc = [JQCatonViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [NSThread sleepForTimeInterval:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
