//
//  SubApplication.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/9.
//

#import <CYToolkit/CYToolkit.h>
#import "SubApplication.h"

@implementation SubApplication

+ (void)load {
//    static dispatch_once_t once_token;
//    dispatch_once(&once_token, ^{
        [UIApplication cyInstanceDebugHook:@selector(_run)];
//    });
}

- (void)sendEvent:(UIEvent *)event {
//    NSLog(@"Send Event %d %d !!!!!", event.type, event.subtype);
    [super sendEvent:event];
}

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
//    NSLog(@"Action %@ %@ --> %@   %d %d!!!!!", NSStringFromSelector(action), NSStringFromClass([sender class]), NSStringFromClass([target class]), event.type, event.subtype);
    return [super sendAction:action to:target from:sender forEvent:event];
}

@end
