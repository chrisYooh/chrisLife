//
//  NextResponderView.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/9.
//

#import "NextResponderView.h"

@implementation NextResponderView

- (void)cyTouchesBegan {
    
    SEL tmpSel = _cmd;
    tmpSel = @selector(cyTouchesBegan);
    
    id nextResponder = [self nextResponder];
    NSString *selName = NSStringFromSelector(tmpSel);
    NSLog(@"SEL %@ Called", selName);

    if ([nextResponder respondsToSelector:tmpSel]) {
        [nextResponder performSelector:tmpSel];
    } else {
        NSLog(@"%@ 无法响应方法 %@", NSStringFromClass([nextResponder class]), selName);
    }
    
}

@end
