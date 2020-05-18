#coding: UTF-8

import os
import sys
import torch
import struct
import numpy as np

from importlib import import_module

def create_dir(dir_path):
    isExists = os.path.exists(dir_path)
    if not isExists:
        os.mkdir(dir_path)
    
def load_model():
    sys.path.append("../3_NeuralNetwork")
    module = import_module("net")
    model = module.Net()
    return model

def load_data(trainingDataFilePath, trainingLabelFilePath):

    with open(trainingDataFilePath, 'rb') as imgData:
        magic, num, rows, cols = struct.unpack('>IIII', imgData.read(16))
        tdatas = np.fromfile(imgData, dtype=np.uint8).reshape(num, rows * cols)

    with open(trainingLabelFilePath, 'rb') as lbpath:
        magic, n = struct.unpack('>II', lbpath.read(8))
        tlabels = np.fromfile(lbpath, dtype=np.uint8)

    tdatas_tensor = torch.from_numpy(tdatas).reshape(num, 1, rows, cols).float()
    tlabels_tensor = torch.from_numpy(tlabels).long()

    return tdatas_tensor, tlabels_tensor

def batch_train_one_epock(model, batch_num, train_data, train_label, loss_func, optimizer):

    model.train()

    train_loss = 0.
    train_acc = 0.
    loop_num = int(len(train_data) / batch_num)

    for i in range(loop_num):

        # 1 获取 训练数据 & 训练Label
        batch_input = train_data[i * batch_num: ((i + 1) * batch_num)]
        batch_label = train_label[i * batch_num: ((i + 1) * batch_num)]

        # 2 执行推理
        batch_out = model(batch_input)

        # 3 计算模型损失
        batch_loss = loss_func(batch_out, batch_label)
        train_loss += batch_loss.data

        # 4 模型推理准确值累加（用以计算准确率）
        pred = torch.max(batch_out, 1)[1]
        train_correct = (pred == batch_label).sum()
        train_acc += train_correct.data

        # 5 适时打印信息
        if i % 10 == 0:
            print("第", epoch + 1, "轮，已训练", i * batch_num, "项，该批Loss：", np.around(batch_loss.data.numpy(), decimals=6));

        # 6 反馈更新权重
        optimizer.zero_grad()
        batch_loss.backward()
        optimizer.step()

    train_num = loop_num * batch_num
    return train_loss, train_acc, train_num

def batch_test(model, batch_num, test_data, test_label, loss_func, optimizer):

    model.eval()

    eval_loss = 0.
    eval_acc = 0.
    loop_num = int(len(test_data) / batch_num)

    for i in range(loop_num):

        # 1 获取 训练数据 & 训练Label
        batch_input = test_data[i * batch_num: ((i + 1) * batch_num)]
        batch_label = test_label[i * batch_num: ((i + 1) * batch_num)]

        # 2 执行推理
        batch_out = model(batch_input)

        # 3 计算模型损失
        batch_loss = loss_func(batch_out, batch_label)
        eval_loss += batch_loss.data
        # print(np.around(eval_loss.data.numpy(), decimals=3));

        # 4 模型推理准确值累加（用以计算准确率）
        pred = torch.max(batch_out, 1)[1]
        num_correct = (pred == batch_label).sum()
        eval_acc += num_correct.data

    test_num = loop_num * batch_num
    return eval_loss, eval_acc, test_num


# 1 加载模型
model = load_model();

# 2 加载训练数据
train_data, train_label = load_data("../1_MNIST/train-images-idx3-ubyte",
                                     "../1_MNIST/train-labels-idx1-ubyte")

# 3 加载测试数据
test_data, test_label = load_data("../1_MNIST/t10k-images-idx3-ubyte",
                                  "../1_MNIST/t10k-labels-idx1-ubyte")

optimizer = torch.optim.Adam(model.parameters())
loss_func = torch.nn.CrossEntropyLoss()

# 4 训练10轮

for epoch in range(10):

    print('epoch {} stated'.format(epoch + 1))

    # 单轮训练
    train_loss, train_acc, train_num = batch_train_one_epock(model, 64, train_data, train_label, loss_func, optimizer)
    print('Train Loss: {:.6f}, Acc: {:.6f}'.format(train_loss / train_num, train_acc.float() / train_num))

    # 每轮测试准确率
    test_loss, test_acc, test_num = batch_test(model, 64, test_data, test_label, loss_func, optimizer)
    print('Test Loss: {:.6f}, Acc: {:.6f}'.format(test_loss / test_num, test_acc.float() / test_num))

    # 每轮保存模型
    create_dir("./Milestone")
    torch.save(model.state_dict(), "./Milestone/weight_epoch_" + str(epoch + 1) + ".pth")

    print('epoch {} finished'.format(epoch + 1))

