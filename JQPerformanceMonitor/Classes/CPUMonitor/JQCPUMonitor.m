//
//  JQCPUMonitor.m
//  JQPerformanceMonitor
//
//  Created by jiaqian wang on 2021/11/25.
//

#import "JQCPUMonitor.h"
#import <CrashReporter/PLCrashReporter.h>
#import <CrashReporter/PLCrashReporter.h>
#import <CrashReporter/PLCrashReport.h>
#import <CrashReporter/PLCrashReportTextFormatter.h>

@interface JQCPUMonitor ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore_t;
@property (nonatomic, assign) CFRunLoopActivity runloopActivity;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic) CFRunLoopObserverRef observer;
@property (nonatomic, strong) NSDate *date;

@end

@implementation JQCPUMonitor

+ (instancetype)monitor {
    static JQCPUMonitor *monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [JQCPUMonitor new];
    });
    return monitor;
}

+ (void)startMonitor {
    [[JQCPUMonitor monitor] startMonitor];
}

+ (void)endMonitor {
    [[JQCPUMonitor monitor] endMonitor];
}


- (void)startMonitor {
    
    self.isMonitoring = YES;
        
    [self addRunLoopObserver];
    
    [self cpuMonitoring];
}


- (void)endMonitor {
    self.isMonitoring = NO;
    CFRelease(self.observer);
}


- (void)addRunLoopObserver {
    
    if (self.observer) {
        return;
    }

    self.semaphore_t = dispatch_semaphore_create(0);

    self.observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, NSIntegerMax, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (activity != self.runloopActivity) {
            switch (activity) {
                case kCFRunLoopBeforeTimers:
                    NSLog(@"observer kCFRunLoopBeforeTimers");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"observer kCFRunLoopBeforeSources");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"observer kCFRunLoopBeforeWaiting");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"observer kCFRunLoopAfterWaiting");
                    break;
                default:
                    break;
            }
        }
        self.runloopActivity = activity;
        dispatch_semaphore_signal(self.semaphore_t);
    });


    CFRunLoopRef mainLoop = CFRunLoopGetCurrent();
    CFRunLoopAddObserver(mainLoop, self.observer, kCFRunLoopCommonModes);
}

- (void)cpuMonitoring {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 开启持续的loop来监控
        NSInteger timeout = 0;
        while (self.isMonitoring) {
            
            long result = dispatch_semaphore_wait(self.semaphore_t, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * 60));
            
            if (result != 0) { // 超时
                if (!self.observer) {
                    self.semaphore_t = 0;
                    self.runloopActivity = 0;
                    timeout = 0;
                    return;
                }
                
                if (self.runloopActivity == kCFRunLoopBeforeSources || self.runloopActivity == kCFRunLoopAfterWaiting) {
                    timeout += 1;
                    if (timeout < 5) {
                        continue;
                    }
                    
                    if ([[NSDate date] timeIntervalSinceDate:self.date] < 3.f) {
                        continue;
                    }
                                        
                    self.date = [NSDate date];
                    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD
                                                                                       symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
                    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
                    NSData *data = [crashReporter generateLiveReport];
                    PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
                    NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
                                                                              withTextFormat:PLCrashReportTextFormatiOS];
                    NSLog(@"---------卡顿信息\n%@\n--------------", report);
                }
            }
            
            timeout = 0;
        }
    });
}

@end
