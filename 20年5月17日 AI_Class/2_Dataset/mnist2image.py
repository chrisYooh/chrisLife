#coding: UTF-8

import os
import struct
import numpy as np
from PIL import Image

def create_dir(dir_path):
    isExists = os.path.exists(dir_path)
    if not isExists:
        os.mkdir(dir_path)
    
def mnistData2Image(imageDataFilePath, labelDataFilePath, tarImagePath, dumpNumber = 10):

    with open(imageDataFilePath, 'rb') as imgData:
        magic, num, rows, cols = struct.unpack('>IIII', imgData.read(16))
        images = np.fromfile(imgData, dtype=np.uint8).reshape(num, rows * cols)

    with open(labelDataFilePath, 'rb') as lbpath:
        magic, n = struct.unpack('>II', lbpath.read(8))
        labels = np.fromfile(lbpath, dtype=np.uint8)

    for i in range(dumpNumber):
        lb = labels[i]
        img_np = images[i].reshape(28, 28)
        img_pil = Image.fromarray(img_np)
        img_pil.save(tarImagePath + "/" + str(i).zfill(5) + "_" + str(lb) + ".jpeg")

    return images

# 训练数据转换图片
create_dir("./someTrainImages")
mnistData2Image("../1_MNIST/train-images-idx3-ubyte",
                "../1_MNIST/train-labels-idx1-ubyte",
                "./someTrainImages",
                300)

# 测试数据转换图片
create_dir("./someTestImages");
mnistData2Image("../1_MNIST/t10k-images-idx3-ubyte",
                "../1_MNIST/t10k-labels-idx1-ubyte",
                "./someTestImages",
                300)

print("图片导出已完成");
