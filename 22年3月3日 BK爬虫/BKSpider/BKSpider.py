# -*- coding: utf-8 -*-

import os
import shutil
import requests
import json

import BKSpider.TemplateAPI as TemplateAPI
import BKSpider.BKHouseItem as BKHouseItem

class BKSpider:

    # 输出路径
    outPath = ""

    # 房源列表
    houseList = []

    def __init__(self, outPath):
        self.requests = requests.Session()
        self.outPath = outPath
        self.houseList = []

    def process(self):

        # 请求基础信息
        print("Step1: 请求数据信息...")
        response = self.requests.get(TemplateAPI.jingan_get, timeout=100, verify=False)
        response_data = json.loads(response.text)
        houseDataList = response_data["data"]["data"]["getErShouFangList"]["list"]

        # 填充房源列表
        print("Step2: 填充房源列表...")
        for tmpDataDic in houseDataList:
            tmpHouse = BKHouseItem.BKHouseItem()
            tmpHouse.setUp(tmpDataDic, "二手房", "静安")
            self.houseList.append(tmpHouse)

        # 信息排序（大小 > 总价 > 单价）
        self.houseList.sort(key=lambda houseItem: houseItem.price, reverse=False)
        self.houseList.sort(key=lambda houseItem: houseItem.houseSize, reverse=True)
        self.houseList.sort(key=lambda houseItem: houseItem.unitPrice, reverse=False)

        # 输出信息
        self.writeHouseCsvFile(self.outPath, self.houseList, "房源列表_静安二手房")

    def writeHouseCsvFile(self, basePath, itemList, fileName):

        file_name = ("%s_%d.csv" % (fileName, len(itemList)))
        file_path = basePath + '/' + file_name
        f = open(file_path, 'w')

        # 写标题
        f.write("区域,户型,平方价,总价,大小,朝向,小区,关键标签,房名,详情链接,概述\n")

        # 写内容
        for tmpItem in itemList:
            itemStr = ("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"" % (
                tmpItem.region,
                tmpItem.houseType,
                str(tmpItem.unitPrice) + "元/平",
                str(tmpItem.price) + "万",
                str(tmpItem.houseSize) + "m²",                                
                tmpItem.houseOrientation,
                tmpItem.houseCommunity,
                tmpItem.houseMainTags,
                tmpItem.houseName,
                tmpItem.detailUrl,
                tmpItem.houseSummary
            ))
            f.write(itemStr + "\n")

        f.close()





