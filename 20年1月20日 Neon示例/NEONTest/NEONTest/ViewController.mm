//
//  ViewController.m
//  NEONTest
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#include <arm_neon.h>
#include <vector>
#include <random>
#include <iostream>
#import "NeonTest200119.hpp"

using namespace std;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testMul();
    testMul_neon();
    
    testCharMul();
    testCharMul_neon();
    
    testCvLoopLogic_normal();
    testCvLoopLogic_pointAdd();
    testCvLoopLogic_neon();
}


@end
