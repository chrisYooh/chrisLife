//
//  BaseClassA.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import "BaseClassA.h"

@implementation BaseClassA

- (void)testFunc1 {
    NSLog(@"Test Func1");
}

- (void)testArg1:(NSString *)aStr arg2:(NSString *)bStr arg3:(int)cVal {
    NSLog(@"%@", aStr);
    NSLog(@"%@", bStr);
    NSLog(@"%d", cVal);
}

- (void)inheritFunc1 {
    NSLog(@"A Called");
}

+ (void)baseAPlus {
    
}

- (void)baseASub {
    
}

@end
