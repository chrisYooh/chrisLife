# -*- coding: utf-8 -*-

# 抓取洞察卡顿数据，快速整理需要的讯息
import os
import logging
import sys
import time
import BKSpider.BKSpider as BKSpider

outPath = sys.path[0].strip() + "/output_BK/"

if __name__ == '__main__':

    # 创建输出目录
    if False == os.path.exists(outPath):
        os.mkdir(outPath)


    bkSpider = BKSpider.BKSpider(outPath)
    bkSpider.process()

    # 当前 & 7日前时间戳
    # BaseConfig.curTimestamp = int(time.time())
    # BaseConfig.sevenDayBeforeTimestamp = BaseConfig.curTimestamp - 3600 * 24 * 7

    # print("使用前记得先使用Chrome浏览器登录洞察系统刷新Cookie\n")
    # print("筛选条件：")
    # print("* 时间：最近7日")
    # print("* 应用版本: ", appVersion_new, " & ", appVersion_old)
    # print("* 卡顿时间范围: ", BaseConfig.hangTimeMin, "~", BaseConfig.hangTimeMax, "\n")
    
    # 创建输出目录
    # if False == os.path.exists(outpath):
    #     os.mkdir(outpath)
    #
    # hangSpider_old = HangSpider.HangSpider(appVersion_old, outpath)
    # hangSpider_new = HangSpider.HangSpider(appVersion_new, outpath)
    # comparer = HangComparer.HangComparer(outpath)
    # try:
    #
    #     print("* 一、旧版本卡顿问题分析")
    #     hangSpider_old.process()
    #     print("\n")
    #
    #     print("* 二、新版本卡顿问题分析")
    #     hangSpider_new.process()
    #     print("\n")
    #
    #     print("* 三、卡顿问题对比分析")
    #     comparer.process(hangSpider_new, hangSpider_old)
    #     print("\n")
    #
    # except Exception as e:
    #     logging.exception(e)
    #
    # print("处理完成")
