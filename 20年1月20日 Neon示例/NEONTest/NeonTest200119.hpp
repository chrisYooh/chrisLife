//
//  NeonTest200119.hpp
//  NEONTest
//
//  Created by Chris Yang on 2020/1/19.
//  Copyright © 2020 杨一凡. All rights reserved.
//

#ifndef NeonTest200119_hpp
#define NeonTest200119_hpp

#include <stdio.h>

/* 测试 float32 理想环境 neon4倍加速 */
void testMul(void);
void testMul_neon(void);

/* 测试 char(int8) 理想环境 neon16被加速 */
void testCharMul(void);
void testCharMul_neon(void);

void testCvLoopLogic_normal(void);
void testCvLoopLogic_pointAdd(void);
void testCvLoopLogic_neon(void);

#endif /* NeonTest200119_hpp */
