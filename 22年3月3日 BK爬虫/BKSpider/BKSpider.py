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

        # 输出信息
        self.writeHouseCsvFile(self.outPath, self.houseList, "房源列表_静安二手房")

    def writeHouseCsvFile(self, basePath, itemList, fileName):

        file_name = ("%s_%d.csv" % (fileName, len(itemList)))
        file_path = basePath + '/' + file_name
        f = open(file_path, 'w')

        # 写标题
        f.write("类型,区域,房屋大小,总价,平方价,房名,概述,关键标签,详情链接\n")

        # 写内容
        for tmpItem in itemList:
            itemStr = ("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"" % (
                tmpItem.type,
                tmpItem.region,
                "待抽离",
                tmpItem.price,
                tmpItem.unitPrice,
                tmpItem.houseName,
                tmpItem.houseSummary,
                tmpItem.houseMainTags,
                tmpItem.detailUrl
            ))
            f.write(itemStr + "\n")

        f.close()





