//
//  SingleTests.h
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import <UIKit/UIKit.h>

void test_responseToSelector(void);
void test_hookTest(void);
void test_perform_mulArg(void);
void test_inherit(void);

void test_directSendTouch(UIView *baseView);
void test_viewTouchHook_initView(UIView *baseView);
void test_aspectTouchHook_initView(UIView *baseView);
void test_msTouchHook_initView(UIView *baseView);
void test_btnAction_initView(UIViewController *baseVc, SEL actionSel);
void test_btnAction_andGesture_initView(UIViewController *baseVc, SEL actionSel, SEL gestureSel);

void test_fps(UIViewController *baseVc, SEL dlSel);
void test_ping();
void test_monitoring_runLoop();

void test_forwardInvocation_hook();

void test_view(UIView *baseView);
void test_aspect_hook(UIView *baseView);
void test_aspect_hook_custom();

void test_metaClass();
void test_metaClass_response();

void test_ms_hook();
