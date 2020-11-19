//
//  ViewController.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import <objc/runtime.h>
#import <CYToolkit/CYToolkit.h>
#import "SingleTests.h"
#import "ViewController.h"

@interface ViewController ()
<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    test_responseToSelector();
//    test_hookTest();
//    test_perform_mulArg();
//    test_inherit();
    
//    test_directSendTouch(self.view);
//    test_viewTouchHook_initView(self.view);
//    test_aspectTouchHook_initView(self.view);
//    test_msTouchHook_initView(self.view);
//    test_btnAction_initView(self, @selector(buttonClicked:));
//    test_btnAction_andGesture_initView(self, @selector(buttonClicked:), @selector(gestureTapped:));
//    test_fps(self, @selector(dlCallback));
//    test_ping();
//    test_monitoring_runLoop();
//    test_forwardInvocation_hook();
    
//    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:)];
//    [UIView cyInstanceDebugHook:@selector(pointInside:withEvent:)];
//
    test_view(self.view);
//    test_aspect_hook(self.view);
//    test_aspect_hook_custom();
//    test_metaClass();
//    test_ms_hook();
    
    
//    [UIViewController cyInstanceDebugHook:@selector(viewDidAppear:)];
    
//    [UIApplication cyInstanceDebugHook:@selector(run) handleSuperClasses:NO];
//    [NSRunLoop currentRunLoop];
    
//    [self forwardInvocation:nil];
    
    
}

- (void)dlCallback {
    
    static int count = 0;
    static CFAbsoluteTime lastTime = 0;
    count++;
    NSLog(@"RUNLOOP %d", count);
    
//    CFAbsoluteTime threshold = CFAbsoluteTimeGetCurrent() - lastTime;
//    if (threshold >= 1.0) {
//        NSLog(@"%d", count);
//        lastTime = CFAbsoluteTimeGetCurrent();
//        count = 0;
//    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
}

#pragma mark

- (void)gestureTapped:(UIGestureRecognizer *)gesture {
    NSLog(@"Gesture responsed");
}

- (void)buttonClicked:(UIButton *)button {
    NSLog(@"Button Clicked");
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ViewController");
//}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer API_AVAILABLE(ios(7.0)) {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer API_AVAILABLE(ios(7.0)) {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveEvent:(UIEvent *)event API_AVAILABLE(ios(13.4), tvos(13.4)) API_UNAVAILABLE(watchos) {
    return YES;
}

@end
