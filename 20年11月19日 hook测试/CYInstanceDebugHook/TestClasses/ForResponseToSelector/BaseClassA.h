//
//  BaseClassA.h
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseClassA : UIView

// 实现了testFunc1
- (void)testFunc1;

// 未实现testFunc2
- (void)testFunc2;

// 未定义testFunc3

- (void)testArg1:(NSString *)aStr arg2:(NSString *)bStr arg3:(int)cVal;

- (void)inheritFunc1;

+ (void)baseAPlus;
- (void)baseASub;

@end

NS_ASSUME_NONNULL_END
