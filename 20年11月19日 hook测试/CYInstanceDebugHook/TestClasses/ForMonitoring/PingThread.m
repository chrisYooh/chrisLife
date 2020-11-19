//
//  PingThread.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/9.
//

#import "PingThread.h"

@interface PingThread ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation PingThread

- (void)main {
    [self pingMainThread];
}

- (void)pingMainThread {
    while (!self.cancelled) {
        @autoreleasepool {
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.lock unlock];
            });
            
            static CFAbsoluteTime pingTime = 0;
            [_lock lock];
            if (CFAbsoluteTimeGetCurrent() - pingTime >= 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"123");
                    pingTime = CFAbsoluteTimeGetCurrent();
                });
            }
            
            [NSThread sleepForTimeInterval:0.1];
        }
    }
}
@end
