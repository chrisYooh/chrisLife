//
//  NeonTest200119.cpp
//  NEONTest
//
//  Created by Chris Yang on 2020/1/19.
//  Copyright © 2020 杨一凡. All rights reserved.
//

#include <stdlib.h>
#include <math.h>
#include <arm_neon.h>
#import <stdio.h>
#include <sys/time.h>
#include "NeonTest200119.hpp"

#pragma mark - Lab Test

static double __curTimestame(void) {
    timeval t;
    gettimeofday(&t, nullptr);
    return t.tv_sec + 1e-6 * t.tv_usec;
}

void testMul(void) {
    
    double time0 = __curTimestame();
    
    float val = 0.0f;
    float mul_left = 1.5;
    float mul_right = 4.3;
    for (int i = 0; i < 1000000000; i++) {
        val = mul_left * mul_right;
    }
    
    double time1 = __curTimestame();
    printf("「1.5 x 4.3」10亿次耗时 %.3f秒\n", time1 - time0);
}

void testMul_neon(void) {
    
    double time0 = __curTimestame();

    float32x4_t val;
    float32x4_t mul_left = vdupq_n_f32(1.5);
    float32x4_t mul_right = vdupq_n_f32(4.3);

    for (int i = 0; i < 1000000000; i += 4) {
        val = vmulq_f32(mul_left, mul_right);
    }
    
    double time1 = __curTimestame();
    printf("「1.5 x 4.3」10亿次耗时 (Neon) %.3f秒\n", time1 - time0);
}

void testCharMul(void) {
    
    double time0 = __curTimestame();
    
    char val = 0;
    char mul_left = 2;
    char mul_right = 3;
    for (int i = 0; i < 1000000000; i++) {
        val = mul_left * mul_right;
    }
    
    double time1 = __curTimestame();
    printf("「int8 2 x 3」10亿次耗时 %.3f秒\n", time1 - time0);
}

void testCharMul_neon(void) {
    
    double time0 = __curTimestame();

    int8x16_t val;
    int8x16_t mul_left = vdupq_n_s8(2);
    int8x16_t mul_right = vdupq_n_s8(3);

    for (int i = 0; i < 1000000000; i += 16) {
        val = vmulq_s8(mul_left, mul_right);
    }
    
    double time1 = __curTimestame();
    printf("「int8 2 x 3」10亿次耗时（Neon）%.3f秒\n", time1 - time0);
}

#pragma mark - Scene Test

static void __testCvLoopLogic_normal(int img_width, int img_height, unsigned char *p_image, double *p_modgrad) {

    for (int y = 0; y < img_height - 1; ++y) {
        unsigned char *scaled_image_row = p_image;
        unsigned char *next_scaled_image_row = p_image + img_width;
        
        double *modgrad_row = p_modgrad + img_width;
        for (int x = 0; x < img_width - 1; ++x) {
            int DA = next_scaled_image_row[x + 1] - scaled_image_row[x];
            int BC = scaled_image_row[x + 1] - next_scaled_image_row[x];
            int gx = DA + BC;
            int gy = DA - BC;
            double norm = sqrt((gx * gx + gy * gy) / 4.0);
            modgrad_row[x] = norm;
        }
    }
}

static void __testCvLoopLogic_pointAdd(int img_width, int img_height, unsigned char *p_image, double *p_modgrad) {

    unsigned char *tmpP00 = NULL;
    unsigned char *tmpP01 = NULL;
    unsigned char *tmpP10 = NULL;
    unsigned char *tmpP11 = NULL;
    double *tmpPModgrad_row = NULL;

    for (int y = 0; y < img_height - 1; ++y) {
        
        tmpP00 = p_image + y * img_width;
        tmpP01 = tmpP00 + 1;
        tmpP10 = p_image + (y + 1) * img_width;
        tmpP11 = tmpP10 + 1;
        tmpPModgrad_row = p_modgrad;
        
        for (int x = 0; x < img_width - 1; ++x) {
            int DA = *tmpP11 - *tmpP00;
            int BC = *tmpP01 - *tmpP10;
            int gx = DA + BC;
            int gy = DA - BC;

            double norm = sqrt((gx * gx + gy * gy) * 0.25);
            *tmpPModgrad_row = norm;
            
            tmpP00++;
            tmpP01++;
            tmpP10++;
            tmpP11++;

            tmpPModgrad_row++;
        }
    }
}

static void __testCvLoopLogic_neon(int img_width, int img_height, unsigned char *p_image, double *p_modgrad) {

    unsigned char *tmpP00 = NULL;
    unsigned char *tmpP01 = NULL;
    unsigned char *tmpP10 = NULL;
    unsigned char *tmpP11 = NULL;
    double *tmpPModgrad_row = NULL;

    for (int y = 0; y < img_height - 1; ++y) {
        
        tmpP00 = p_image + y * img_width;
        tmpP01 = tmpP00 + 1;
        tmpP10 = p_image + (y + 1) * img_width;
        tmpP11 = tmpP10 + 1;
        tmpPModgrad_row = p_modgrad;
        
        /* Norm */
        int x = 0;
        for (; x < img_width - 8; x += 4) {

            int32x4_t neonP00_s32_4 = vreinterpretq_s32_u32(vmovl_u16(vget_low_u16(vmovl_u8(vld1_u8(tmpP00)))));
            int32x4_t neonP01_s32_4 = vreinterpretq_s32_u32(vmovl_u16(vget_low_u16(vmovl_u8(vld1_u8(tmpP01)))));
            int32x4_t neonP10_s32_4 = vreinterpretq_s32_u32(vmovl_u16(vget_low_u16(vmovl_u8(vld1_u8(tmpP10)))));
            int32x4_t neonP11_s32_4 = vreinterpretq_s32_u32(vmovl_u16(vget_low_u16(vmovl_u8(vld1_u8(tmpP11)))));

            /* da = 11 - 00
             * bc = 01 - 10
             * gx = da - bc
             * gy = da + bc
             */
            int32x4_t neon_da = vsubq_s32(neonP11_s32_4, neonP00_s32_4);
            int32x4_t neon_bc = vsubq_s32(neonP01_s32_4, neonP10_s32_4);
            int32x4_t neon_gx = vaddq_s32(neon_da, neon_bc);
            int32x4_t neon_gy = vsubq_s32(neon_da, neon_bc);
            
            /* norm = (gx * gx + gy * gy) * 0.25 */
            float32x4_t neon_0_25 = vdupq_n_f32(0.25);
            float32x4_t neon_norm = vcvtq_f32_s32(vaddq_s32(vmulq_s32(neon_gx, neon_gx), vmulq_s32(neon_gy, neon_gy)));
            neon_norm = vmulq_f32(neon_norm, neon_0_25);
            neon_norm = vsqrtq_f32(neon_norm);
            
            for (int c = 0; c < 4; c++) {
                tmpPModgrad_row[c] = (double)(neon_norm[c]);
            }
            
            tmpP00 += 4;
            tmpP01 += 4;
            tmpP10 += 4;
            tmpP11 += 4;
            
            tmpPModgrad_row += 4;
        }
        
        for (; x < img_width - 1; x++) {
            
            int DA = *tmpP11 - *tmpP00;
            int BC = *tmpP01 - *tmpP10;
            int gx = DA + BC;
            int gy = DA - BC;

            double norm = sqrt((gx * gx + gy * gy) * 0.25);
            *tmpPModgrad_row = norm;
            
            tmpP00++;
            tmpP01++;
            tmpP10++;
            tmpP11++;
            
            tmpPModgrad_row++;
        }
    }
}

static void __testCvLoopLogic_acr(void (*inputFunc)(int img_width, int img_height, unsigned char *p_image, double *p_modgrad)) {
    
    int img_width = 960;
    int img_height = 1280;

    unsigned char *p_image = (unsigned char *)malloc(img_width * img_height);
    for (int i = 0; i < img_width * img_height; i++) {
        p_image[i] = i % 200;
    }
    double *p_modgrad = (double *)malloc(img_width * img_height * sizeof(double));
    
    double time0 = __curTimestame();
    int tmpRunTimes = 1 ;
    
    for (int i = 0; i < tmpRunTimes; i++) {
        inputFunc(img_width, img_height, p_image, p_modgrad);
    }
    
    double time1 = __curTimestame();
    float duration = time1 - time0;
    printf("执行 %d次 耗时 %.2fs, 每次耗时 %.2fms, 每秒执行 %.2f次   ",
           tmpRunTimes,
           duration,
           duration * 1000 / tmpRunTimes,
           tmpRunTimes / duration);
    
    double sum1 = 0.0f;
    
    for (int i = 0; i < img_width * img_height; i++) {
        sum1 += p_modgrad[i];
    }
    sum1 /= (img_width * img_height);
    
    printf("校准数据（用以测试算法优化后输出结果一致性） %.6f\n", sum1 * 1000);
}

void testCvLoopLogic_normal(void) {
    printf("【原始逻辑】\n");
    __testCvLoopLogic_acr(__testCvLoopLogic_normal);
}

void testCvLoopLogic_pointAdd(void) {
    printf("【指针自增长优化】\n");
    __testCvLoopLogic_acr(__testCvLoopLogic_pointAdd);
}

void testCvLoopLogic_neon(void) {
    printf("【Neon优化】\n");
    __testCvLoopLogic_acr(__testCvLoopLogic_neon);
}
