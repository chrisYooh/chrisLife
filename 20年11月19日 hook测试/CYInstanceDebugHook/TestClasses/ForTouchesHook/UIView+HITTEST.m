//
//  UIView+HITTEST.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/10.
//

#import <CYToolkit/CYToolkit.h>

#import "UIView+HITTEST.h"

@implementation UIView (HITTEST)

+ (void)load {
    __weak typeof(self) weakSelf = self;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [weakSelf cySwizzlingInstanceMethodWithOriginalSel:@selector(hitTest:withEvent:) swizzledSel:@selector(cy_hitTest:withEvent:)];
        [weakSelf cySwizzlingInstanceMethodWithOriginalSel:@selector(pointInside:withEvent:) swizzledSel:@selector(cy_pointInside:withEvent:)];
//    });
}

- (UIView *)cy_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    printf("%s hitTest called...\n", NSStringFromClass([self class]).UTF8String);
    return [self cy_hitTest:point withEvent:event];
}

- (BOOL)cy_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    printf("%s pointInside called...\n", NSStringFromClass([self class]).UTF8String);
    return [self cy_pointInside:point withEvent:event];
}

@end
