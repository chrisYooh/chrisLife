//
//  SingleTests.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import <objc/runtime.h>
#import <CYToolkit/CYToolkit.h>
#import "Aspects_mz.h"

#import "BaseClassA.h"
#import "SubClassB.h"

#import "ViewA.h"
#import "ViewB.h"
#import "ButtonC.h"

#import "PingThread.h"

#import "SingleTests.h"

#pragma mark -

void __sendTouchOnView(UIView *tarView) {
    
    UITouch *tmpTouch = [[UITouch alloc] init];
    NSSet<UITouch *> *tmpSet = [NSSet setWithObject:tmpTouch];
    UIEvent *tmpEvent = [[UIEvent alloc] init];
    [tarView touchesBegan:tmpSet withEvent:tmpEvent];
}

#pragma mark -

void test_responseToSelector() {
    
    BaseClassA *tmpA = [[BaseClassA alloc] init];
    
    NSLog(@"父类实现方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"testFunc1")]);
    NSLog(@"父类未实现方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"testFunc2")]);
    NSLog(@"父类未定义方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"testFunc3")]);
    
    SubClassB *tmpB = [[SubClassB alloc] init];
    
    NSLog(@"子类实现方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"testFunc1")]);
    NSLog(@"子类未实现方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"testFunc2")]);
    NSLog(@"子类未定义方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"testFunc3")]);
    
    /* 关于TouchesBegan */
    
    NSLog(@"父类Touch方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"touchesBegan:withEvent:")]);
    NSLog(@"父类Touch方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"touchesBegan:withEvent:")]);
}

void test_hookTest(void) {
    
    [SubClassB cyInstanceDebugHook:NSSelectorFromString(@"testFunc1")];
    
    SubClassB *tmpB = [[SubClassB alloc] init];
    NSLog(@"子类实现方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"testFunc1")]);
    NSLog(@"子类实现hook方法: %d", [tmpB respondsToSelector:NSSelectorFromString(@"cy_testFunc1")]);
    
    BaseClassA *tmpA = [[BaseClassA alloc] init];
    NSLog(@"父类实现方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"testFunc1")]);
    NSLog(@"父类实现hook方法: %d", [tmpA respondsToSelector:NSSelectorFromString(@"cy_testFunc1")]);

    [tmpB testFunc1];
    [tmpB performSelector:NSSelectorFromString(@"cy_testFunc1")];
    
    [tmpA testFunc1];
    [tmpA performSelector:NSSelectorFromString(@"cy_testFunc1")];
}

void test_perform_mulArg(void) {
    
    BaseClassA *tmpA = [[BaseClassA alloc] init];
    [tmpA testArg1:@"111" arg2:@"222" arg3:3];

    NSMethodSignature *singture = [tmpA methodSignatureForSelector:@selector(testArg1:arg2:arg3:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singture];
    [invocation setTarget:tmpA];
    [invocation setSelector:@selector(testArg1:arg2:arg3:)];
    
    NSString *arg1 = @"333";
    NSString *arg2 = @"444";
    int arg3 = 5;
    [invocation setArgument:&arg1 atIndex:2];
    [invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
    
    [invocation invoke];
}

void test_inherit(void) {
    
    SubClassB *tmpB = [[SubClassB alloc] init];
    [BaseClassA cyInstanceDebugHook:@selector(inheritFunc1)];
    [SubClassB cyInstanceDebugHook:@selector(inheritFunc1)];
    [tmpB inheritFunc1];
}

void test_directSendTouch(UIView *baseView) {
    
    UITouch *tmpTouch = [[UITouch alloc] init];
    NSSet<UITouch *> *tmpSet = [NSSet setWithObject:tmpTouch];
    UIEvent *tmpEvent = [[UIEvent alloc] init];
    
    NSLog(@"准备touchBegan");
    [baseView touchesBegan:tmpSet withEvent:tmpEvent];
    NSLog(@"完成touchBegan");
    
    [UIResponder cyInstanceDebugHook:NSSelectorFromString(@"touchesBegan:withEvent:")];
    
//    NSLog(@"视图touch方法: %d", [baseView respondsToSelector:NSSelectorFromString(@"touchesBegan:withEvent:")]);
//    NSLog(@"视图cy_touch方法: %d", [baseView respondsToSelector:NSSelectorFromString(@"cy_touchesBegan:withEvent:")]);

//    Method touchMethod = class_getInstanceMethod([baseView class], NSSelectorFromString(@"touchesBegan:withEvent:"));
//    IMP touchImp = method_getImplementation(touchMethod);
//
//    Method cy_touchMethod = class_getInstanceMethod([baseView class], NSSelectorFromString(@"cy_touchesBegan:withEvent:"));
//    IMP cy_touchImp = method_getImplementation(cy_touchMethod);
//
//    NSMethodSignature *singture = [baseView methodSignatureForSelector:@selector(touchesBegan:withEvent:)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singture];
//    [invocation setTarget:baseView];
//    [invocation setSelector:NSSelectorFromString(@"cy_touchesBegan:withEvent:")];
//
//    [invocation setArgument:&tmpSet atIndex:2];
//    [invocation setArgument:&tmpEvent atIndex:3];
//
//    [invocation invoke];
    
    NSLog(@"Hook后 准备touchBegan");
    [baseView touchesBegan:tmpSet withEvent:tmpEvent];
    NSLog(@"Hook后 完成touchBegan");
}

void test_viewTouchHook_initView(UIView *baseView) {
    
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(100, 100, 100, 100)];
    
//    [ViewA cyInstanceDebugHook:NSSelectorFromString(@"touchesBegan:withEvent:")];
    [ViewB cyInstanceDebugHook:NSSelectorFromString(@"touchesBegan:withEvent:")];
}

void test_aspectTouchHook_initView(UIView *baseView) {
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(100, 100, 100, 100)];
    
    [baseView aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
    
        NSLog(@"%@ TouchBegan:withEvent:", [aspectInfo.instance class]);
            
    } error:nil];
    
    __sendTouchOnView(tmpViewB);
}

void test_msTouchHook_initView(UIView *baseView) {
//    NSLog(@"Hook 方法在 UIResponder+MS中");
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(100, 100, 100, 100)];
    
//    [UIView cyInstanceDebugHook:@selector(nextResponder) handleSuperClasses:NO];
//    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:) handleSuperClasses:NO];
//    [ViewB cyInstanceDebugHook:@selector(touchesBegan:withEvent:) handleSuperClasses:NO];
//    [ViewA cyInstanceDebugHook:@selector(touchesBegan:withEvent:) handleSuperClasses:NO];
//    [UIView cyInstanceDebugHook:@selector(touchesBegan:withEvent:) handleSuperClasses:NO];
//    [UIViewController cyInstanceDebugHook:@selector(touchesBegan:withEvent:) handleSuperClasses:NO];
    
//    __sendTouchOnView(tmpViewB);
    
//    [NextResponderView cyInstanceDebugHook:@selector(cyTouchesBegan) handleSuperClasses:NO];
//    [tmpViewB cyTouchesBegan];
}

void test_btnAction_initView(UIViewController *baseVc, SEL actionSel) {
    
    UIView *baseView = baseVc.view;
    
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(50, 50, 100, 100)];
    
    ButtonC *tmpButtonC = [[ButtonC alloc] init];
    [tmpButtonC setTitle:@"点我" forState:UIControlStateNormal];
    [tmpButtonC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tmpButtonC setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    tmpButtonC.backgroundColor = [UIColor whiteColor];
    [tmpViewA addSubview:tmpButtonC];
    [tmpButtonC setFrame:CGRectMake(150, 150, 100, 100)];
    
    [UIResponder cyInstanceDebugHook:@selector(touchesBegan:withEvent:)];
    
    [tmpButtonC addTarget:baseVc action:actionSel forControlEvents:UIControlEventTouchDown];
}

void test_btnAction_andGesture_initView(UIViewController *baseVc, SEL actionSel, SEL gestureSel) {
    
    UIView *baseView = baseVc.view;
    
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(50, 50, 100, 100)];
    
    ButtonC *tmpButtonC = [[ButtonC alloc] init];
    [tmpButtonC setTitle:@"点我" forState:UIControlStateNormal];
    [tmpButtonC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tmpButtonC setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    tmpButtonC.backgroundColor = [UIColor whiteColor];
    [tmpViewA addSubview:tmpButtonC];
    [tmpButtonC setFrame:CGRectMake(150, 150, 100, 100)];
    
    [ButtonC cyInstanceDebugHook:@selector(touchesBegan:withEvent:)];
    [ButtonC cyInstanceDebugHook:@selector(touchesCancelled:withEvent:)];
    [ButtonC cyInstanceDebugHook:@selector(touchesEnded:withEvent:)];

    [tmpButtonC addTarget:baseVc action:actionSel forControlEvents:UIControlEventTouchUpInside];
    
//    [NSClassFromString(@"UIGestureEnvironment") cyInstanceDebugHook:NSSelectorFromString(@"updateForEvent:window:") handleSuperClasses:NO];
    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:)];
    
    UILongPressGestureRecognizer *tmpGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:baseVc action:gestureSel];
//    tmpGesture.cancelsTouchesInView = NO;
//    tmpGesture.delaysTouchesBegan = YES;
    tmpGesture.delaysTouchesEnded = NO;
    tmpGesture.delegate = baseVc;
    [tmpButtonC addGestureRecognizer:tmpGesture];
}

void test_fps(UIViewController *baseVc, SEL dlSel) {
    CADisplayLink *tmpLink = [CADisplayLink displayLinkWithTarget:baseVc selector:dlSel];
    [tmpLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
}

void test_ping() {
    static PingThread *tmpThread = nil;
    static dispatch_once_t tmpThread_token;
    dispatch_once(&tmpThread_token, ^{
        tmpThread = [[PingThread alloc] init];
    });
    
    [tmpThread start];
}

void __runloop_handle() {
    static int count = 0;
    static CFAbsoluteTime lastTime = 0;
    count++;
//    NSLog(@"RUNLOOP %d", count);
    
    CFAbsoluteTime threshold = CFAbsoluteTimeGetCurrent() - lastTime;
    if (threshold >= 1.0) {
        NSLog(@"%d", count);
        lastTime = CFAbsoluteTimeGetCurrent();
        count = 0;
    }
}

void test_monitoring_runLoop() {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        __runloop_handle();
        });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
}

void test_forwardInvocation_hook() {
    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:)];
    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:)];
    [UIView cyInstanceDebugHook:@selector(hitTest:withEvent:)];
    
    [BaseClassA cyInstanceDebugHook:@selector(testFunc2)];

}

void test_view(UIView *baseView) {
    
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(100, 100, 100, 100)];
    
//    [ViewA cyInstanceDebugHook:@selector(touchesBegan:withEvent:)];
//    [ViewB cyInstanceDebugHook:@selector(touchesBegan:withEvent:)];
    
//#3    0x00000001a6c690d4 in -[UIView(Geometry) _hitTest:withEvent:windowServerHitTestWindow:] ()
//#4    0x00000001a67ce76c in -[UIWindow _hitTestLocation:inScene:withWindowServerHitTestWindow:event:] ()

//#6    0x00000001a69dd2a8 in __46-[UIWindowScene _topVisibleWindowPassingTest:]_block_invoke ()
//#7    0x00000001a69dd860 in -[UIWindowScene _enumerateWindowsIncludingInternalWindows:onlyVisibleWindows:asCopy:stopped:withBlock:] ()
//#8    0x00000001a69dd1a0 in -[UIWindowScene _topVisibleWindowPassingTest:] ()
//#10    0x00000001a67ce85c in -[UIWindow _targetWindowForPathIndex:atPoint:forEvent:windowServerHitTestWindow:] ()
//#22    0x00000001a677bbcc in -[UIApplication _run] ()

    [UIView cyInstanceDebugHook:@selector(_hitTest:withEvent:windowServerHitTestWindow:)];
    [UIWindow cyInstanceDebugHook:@selector(_hitTestLocation:inScene:withWindowServerHitTestWindow:event:)];
    [UIWindowScene cyInstanceDebugHook:@selector(_topVisibleWindowPassingTest:)];
    [UIWindowScene cyInstanceDebugHook:@selector(_enumerateWindowsIncludingInternalWindows:onlyVisibleWindows:asCopy:stopped:withBlock:)];
    [UIWindow cyInstanceDebugHook:@selector(_targetWindowForPathIndex:atPoint:forEvent:windowServerHitTestWindow:)];

//    [UIWindowScene cyInstanceDebugHook:@selector(_topVisibleWindowPassingTest:)];
//    [UIWindow cyInstanceDebugHook:@selector(_hitTestToPoint:forEvent:windowServerHitTestWindow:)];
//    [UIWindow cyInstanceDebugHook:@selector(_hitTestLocation:inScene:withWindowServerHitTestWindow:event:)];
//    __sendTouchOnView(tmpViewB);
}

void test_aspect_hook(UIView *baseView) {
    
    ViewA *tmpViewA = [[ViewA alloc] init];
    tmpViewA.backgroundColor = [UIColor yellowColor];
    [baseView addSubview:tmpViewA];
    [tmpViewA setFrame:CGRectMake(50, 50, 300, 300)];
    tmpViewA.tag = 1;
    
    ViewB *tmpViewB = [[ViewB alloc] init];
    tmpViewB.backgroundColor = [UIColor redColor];
    [tmpViewA addSubview:tmpViewB];
    [tmpViewB setFrame:CGRectMake(100, 100, 100, 100)];
    tmpViewB.tag = 2;

    ViewA *tmpViewC = [[ViewA alloc] init];
    tmpViewC.backgroundColor = [UIColor greenColor];
    [tmpViewA addSubview:tmpViewC];
    [tmpViewC setFrame:CGRectMake(200, 200, 10, 10)];
    tmpViewC.tag = 3;
    
//    NSLog(@"%p %p %p", tmpViewA, tmpViewB, tmpViewC);
//
//    NSLog(@"AA %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewA class]), NSStringFromClass(object_getClass(tmpViewA)), tmpViewA, tmpViewA.tag);
//    NSLog(@"BB %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewB class]), NSStringFromClass(object_getClass(tmpViewB)), tmpViewB, tmpViewB.tag);
//    NSLog(@"CC %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewC class]), NSStringFromClass(object_getClass(tmpViewC)), tmpViewC, tmpViewC.tag);

//    [ViewA aspect_hookSelector:@selector(hitTest:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSLog(@"%@(%@, %p) hitTest  %d", NSStringFromClass([aspectInfo.instance class]), NSStringFromClass(object_getClass(aspectInfo.instance)), aspectInfo.instance,
//            ((UIView *)aspectInfo.instance).tag);
//    } error:nil];
//
//    [UIView aspect_hookSelector:@selector(hitTest:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSLog(@"%@(%@, %p) hitTest  %d", NSStringFromClass([aspectInfo.instance class]), NSStringFromClass(object_getClass(aspectInfo.instance)), aspectInfo.instance,
//            ((UIView *)aspectInfo.instance).tag);
//    } error:nil];

//    NSLog(@"AA %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewA class]), NSStringFromClass(object_getClass(tmpViewA)), tmpViewA, tmpViewA.tag);
//    NSLog(@"BB %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewB class]), NSStringFromClass(object_getClass(tmpViewB)), tmpViewB, tmpViewB.tag);
//    NSLog(@"CC %@(%@, %p) hitTest  %d", NSStringFromClass([tmpViewC class]), NSStringFromClass(object_getClass(tmpViewC)), tmpViewC, tmpViewC.tag);
    
//    [baseView aspect_hookSelector:@selector(hitTest:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSLog(@"%@(%@) hitTest", NSStringFromClass([aspectInfo.instance class]), NSStringFromClass(object_getClass(aspectInfo.instance)));
//    } error:nil];

}

void test_aspect_hook_custom() {
    
    BaseClassA *a1 = [[BaseClassA alloc] init];
    SubClassB *b1 = [[SubClassB alloc] init];

    [BaseClassA cyInstanceDebugHook:@selector(testFunc1)];
    [SubClassB cyInstanceDebugHook:@selector(testFunc1)];
    [SubClassB cyInstanceDebugHook:@selector(testFunc1)];
    
//    [SubClassB aspect_hookSelector:@selector(testFunc1) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSLog(@"%@(%@, %p) testFunc", NSStringFromClass([aspectInfo.instance class]), NSStringFromClass(object_getClass(aspectInfo.instance)), aspectInfo.instance);
//    } error:nil];
//
//    [BaseClassA aspect_hookSelector:@selector(testFunc1) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        NSLog(@"%@(%@, %p) testFunc", NSStringFromClass([aspectInfo.instance class]), NSStringFromClass(object_getClass(aspectInfo.instance)), aspectInfo.instance);
//    } error:nil];


    [a1 testFunc1];
    [b1 testFunc1];
}

void test_metaClass() {
    BaseClassA *a1 = [[BaseClassA alloc] init];
    
    Class a1Class = [a1 class];
    Class a1RealClass = object_getClass(a1);
    Class metaClass = object_getClass(a1RealClass);
    Class rootMetaClass = object_getClass(metaClass);
    
    Class rootMetaSuper = class_getSuperclass(rootMetaClass);
    NSLog(@"%@ %d %d", NSStringFromClass(rootMetaClass), class_isMetaClass(rootMetaSuper), class_isMetaClass(@"NSObject"));
    Class ssClass = class_getSuperclass(rootMetaSuper);
    NSLog(@"%@ %d", NSStringFromClass(ssClass), class_isMetaClass(ssClass));
    
    
    NSLog(@"%@ %@ %@ %@ %d %d %d %d %d",
          NSStringFromClass(a1Class),
          NSStringFromClass(a1RealClass),
          NSStringFromClass(rootMetaClass),
          NSStringFromClass(object_getClass(rootMetaClass)),
          class_isMetaClass(a1Class),
          class_isMetaClass(a1RealClass),
          class_isMetaClass(rootMetaClass),
          class_isMetaClass(object_getClass(rootMetaClass)),
          class_isMetaClass(object_getClass([rootMetaClass class]))
          );

    BOOL isA1ClassMeta = class_isMetaClass(a1Class);
    BOOL isA1RealClassMeta = class_isMetaClass(a1RealClass);

    
    NSLog(@"%d %d %d %d",
          isA1ClassMeta,
          isA1RealClassMeta,
          class_isMetaClass(object_getClass(a1Class)),
          class_isMetaClass(object_getClass(a1RealClass))
          );
}

void test_metaClass_response() {
    
    SubClassB *tmpB = [[SubClassB alloc] init];
    Class classB = [tmpB class];
    
//    Class metaClassB = object_getClass("SubClassB");
}

void test_ms_hook() {
    
//    BaseClassA *a1 = [[BaseClassA alloc] init];
//
//    Class class = [a1 class];
//
//    SEL originalSelector = @selector(testFunc1);
//    SEL swizzledSelector = swizzledSel;
//
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//    method_exchangeImplementations(originalMethod, swizzledMethod);
}
