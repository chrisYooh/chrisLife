//
//  UIResponder+MS.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import <CYToolkit/CYToolkit.h>

#import "UIResponder+MS.h"

@implementation ViewB (MS)

+ (void)load {
//    [super load];
    
//    [self cySwizzlingInstanceMethodWithOriginalSel:@selector(touchesBegan:withEvent:) swizzledSel:@selector(cy_touchesBegan:withEvent:)];
}

//- (void)cy_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@ Function Called1", [self class]);
//    [self cy_touchesBegan:touches withEvent:event];
//}

@end
