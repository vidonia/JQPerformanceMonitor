//
//  JQCatonMonitor.m
//  JQUIKit_Example
//
//  Created by jiaqian wang on 2021/11/24.
//  Copyright © 2021 vidonia. All rights reserved.
//

#import "JQCatonMonitor.h"

@interface JQCatonMonitor ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore_t;
@property (nonatomic, assign) CFRunLoopActivity runloopActivity;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic) CFRunLoopObserverRef observer;

@end

@implementation JQCatonMonitor

+ (instancetype)monitor {
    static JQCatonMonitor *monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [JQCatonMonitor new];
    });
    return monitor;
}

+ (void)startMonitor {
    
    [JQCatonMonitor monitor].isMonitoring = YES;
        
    [[JQCatonMonitor monitor] addRunLoopObserver];
    
    [[JQCatonMonitor monitor] cpuMonitoring];
}

+ (void)endMonitor {
    [JQCatonMonitor monitor].isMonitoring = NO;
}

- (void)addRunLoopObserver {
    
    if (self.observer) {
        return;
    }
    
    self.semaphore_t = dispatch_semaphore_create(0);

    self.observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, NSIntegerMax, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        self.runloopActivity = activity;
        dispatch_semaphore_signal(self.semaphore_t);
    });
    CFRunLoopRef mainLoop = CFRunLoopGetMain();
    CFRunLoopAddObserver(mainLoop, self.observer, kCFRunLoopCommonModes);
}

- (void)cpuMonitoring {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 开启持续的loop来监控
        NSInteger timeout = 0;
        while (self.isMonitoring) {
            long result = dispatch_semaphore_wait(self.semaphore_t, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1));
            if (result != 0) { // 超时
                if (!self.observer) {
                    self.semaphore_t = 0;
                    self.runloopActivity = 0;
                    timeout = 0;
                    return;
                }
                if (self.runloopActivity == kCFRunLoopBeforeSources || self.runloopActivity == kCFRunLoopAfterWaiting) {
                    timeout += 1;
                    NSLog(@"---------------------------%ld",timeout);
                    if (timeout < 2) {
                        continue;
                    }
                    NSLog(@"---------卡顿信息\n%@\n--------------",@"");
                }
                timeout = 0;
            }
        }
    });
}

@end
