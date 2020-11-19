//
//  SubClassB.m
//  CYInstanceDebugHook
//
//  Created by Chris Yang on 2020/11/6.
//

#import "SubClassB.h"

@implementation SubClassB

- (void)testFunc1 {
    NSLog(@"BBBB");
}

- (void)inheritFunc1 {
//    [super inheritFunc1];
    NSLog(@"B Called");
}

+ (void)subBPlus {
    
}

- (void)subBSub {
    
}

@end
