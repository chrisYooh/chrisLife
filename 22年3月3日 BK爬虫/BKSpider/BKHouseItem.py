# -*- coding: utf-8 -*-

class BKHouseItem:

    type = "二手房"  # 类型：二手房/
    region = "" # 区域，如：静安
    price = ""  # 房屋价格，如：1150万
    houseType = ""  # 户型，如：3室1厅
    houseSize = ""  # 房子大小，如：147.47m²
    houseOrientation = "" # 朝向，如：南 北
    houseCommunity = "" # 小区
    unitPrice = ""  # 每平单价，如：77,982元/平
    houseName = ""  # 房子名称，如：内环内地铁口+04年电梯房+东边套全明+70年产权
    houseSummary = ""  # 房子概述，如：3室1厅/147.47m²/南 北/博苑公寓
    houseMainTags = ""  # 房子关键标签
    detailUrl = ""          # 详情链接，如：https://m.ke.com/sh/ershoufang/107106527756.html?fb_expo_id=684836234597564419
    recommendReason = ""    # 推荐理由

    cityId = ""             # 城市ID，如：310000
    cityName = ""           # 城市名，如：上海

    houseCode = ""          # 房子ID
    # houseTags = ""          # bangdanTitle，如：3室1厅/147.47m²/博苑公寓
    housePicUrl = ""        # 房子图片
    houseStatus = ""        # 房子状态，如：1（在售？）

    recoDesc = ""           # 小区描述？

    resblockId = ""         # 区域ID，如：5011000015192
    resblockName = ""       # 区域名称，如：

    delegateId = ""         # 代理人ID
    delegateName = ""       # 代理人名称

    def __init__(self):
        type = "二手房"

    def setUp(self, dataDic, houseType, region):

        self.type = houseType
        self.region = region

        self.houseSummary = dataDic["desc"]
        infoList = self.houseSummary.split("/")
        self.houseType = infoList[0]
        self.houseSize = infoList[1]
        self.houseOrientation = infoList[2]
        self.houseCommunity = infoList[3]

        self.price = dataDic["totalPrice"]
        self.unitPrice = dataDic["unitPrice"]
        self.houseName = dataDic["title"]


        colorTags = dataDic["colorTags"]
        if colorTags != None:
            self.houseMainTags = ""
            for tmpDic in colorTags:
                self.houseMainTags = self.houseMainTags + tmpDic["title"] + " "

        self.detailUrl = dataDic["jumpUrl"]

        # 次要信息
        self.cityId = dataDic["cityId"]
        self.cityName = ""
        self.houseCode = dataDic["houseCode"]
        self.housePicUrl = dataDic["listPictureUrl"]
        self.houseStatus = dataDic["houseStatus"]
        self.recoDesc = dataDic["recoDesc"]
        self.resblockId = dataDic["resblockId"]
        self.resblockName = ""
        self.delegateId = dataDic["delegateId"]
        self.delegateName = ""

