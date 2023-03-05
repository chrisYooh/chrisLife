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

    # 关注列表
    concernList = []

    def __init__(self, outPath):
        self.requests = requests.Session()
        self.outPath = outPath
        self.houseList = []

    def process(self):

        # 请求基础信息
        print("Step1: 请求数据信息...")
        # 不加 %252F 时候筛选有问题，会选出不符合筛选条件的内容
        areaArray = ["%252Fjingan%252F",
                     "%252Fxuhui%252F",
                     "%252Fhuangpu%252F",
                     "%252Fputuo%252F"]
        for tmpArea in areaArray:
            tmpList = self.requestHouseList(tmpArea)
            self.houseList.extend(tmpList)

        # 信息排序（大小 > 总价 > 单价）
        self.houseList.sort(key=lambda houseItem: houseItem.price, reverse=False)
        self.houseList.sort(key=lambda houseItem: houseItem.houseSize, reverse=True)
        self.houseList.sort(key=lambda houseItem: houseItem.unitPrice, reverse=False)

        # 抽取关注信息
        self.concernList = self.extractConcernList(self.houseList)

        # 输出信息
        self.writeHouseCsvFile(self.outPath, self.houseList, "房源列表_静安二手房")
        self.writeHouseCsvFile(self.outPath, self.concernList, "房源列表_静安关注")

    def requestHouseList(self, inputArea):

        itemList = []
        tmpPage = 1
        while True:
            tmpUrl = (TemplateAPI.houstListUrl % {'inputArea': inputArea, "inputPage":str(tmpPage) })
            response = self.requests.get(tmpUrl, timeout=10, verify=False)
            # response_data = json.loads(response.text)
            # if response_data['code'] != 200:
            #     print("数据请求出错")
            #     return

            # 模型话列表信息
            response_data = json.loads(response.text)
            houseDataList = response_data["data"]["data"]["getErShouFangList"]["list"]
            tmpItemList = self.houstListFromDataList(houseDataList, inputArea)
            itemList.extend(tmpItemList)

            # 循环请求迭代
            print("完成请求 第 %d 页数据, 共计 %d 条" % (tmpPage, len(tmpItemList)))

            tmpPage = tmpPage + 1;
            if len(tmpItemList) == 0:
                break
            if tmpPage > 50:
                break

        return itemList

    def houstListFromDataList(self, dataList, area):

        tmpList = []
        for tmpDataDic in dataList:
            tmpHouse = BKHouseItem.BKHouseItem()
            tmpHouse.setUp(tmpDataDic, "二手房", area)
            tmpList.append(tmpHouse)
        return tmpList

    def extractConcernList(self, itemList):

        tmpList = []
        for tmpItem in itemList:
            if tmpItem.price < 600 or tmpItem.price > 800:
                continue
            if tmpItem.houseSize < 60:
                continue
            tmpList.append(tmpItem)
        return tmpList

    def writeHouseCsvFile(self, basePath, itemList, fileName):

        file_name = ("%s_%d.csv" % (fileName, len(itemList)))
        file_path = basePath + '/' + file_name
        f = open(file_path, 'w')

        # 写标题
        f.write("状态,区域,户型,平方价,总价,大小,朝向,小区,关键标签,房名,详情链接,概述\n")

        # 写内容
        for tmpItem in itemList:
            itemStr = ("%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"" % (
                tmpItem.houseStatus,
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





