# -*- coding: utf-8 -*-

# cityCode：310000-上海
# condition：
#  静安： %252Fjingan%252F
#  徐汇： %252Fxuhui%252F
#  黄埔： %252huangpu%252F
#  普陀： %252putuo%252F

# a3/a4 - 70~90 / 90~110
# su1 - 近地铁
# 朝向：f5-南北，f2-南，f1-东，f3-西
# 楼层：c1-低，c2-中
# 电梯：ie1-无电梯
# 类型：板楼-bt2，板塔结合-bt3
# 房龄：y1-5年内，y2-10年内，y3-15年内，y4-20年内，y5-20年以上
houstListUrl = "https://m.ke.com/liverpool/api/ershoufang/getList?cityId=310000&condition=%(inputArea)sbp600ep800l2l3a3a4su1f5f2f1f3c1c2ie1bt2bt3&curPage=%(inputPage)s"
# houstListUrl = "https://m.ke.com/liverpool/api/ershoufang/getList?cityId=310000&condition=%(inputArea)s&curPage=%(inputPage)s"



# https://m.ke.com/liverpool/api/ershoufang/getList?cityId=310000&condition=%252Fjingan%252F&curPage=20
