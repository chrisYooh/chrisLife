# coding: UTF-8

import torch
import torch.nn as nn
import numpy as np

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.full_connect = nn.Linear(25, 10)

    def forward(self, x):
        out = self.full_connect(x);
        return out;

def load_train_data():
    tdatas_tensor = torch.from_numpy(train_array).float()
    tlabels_tensor = torch.from_numpy(train_label).long()
    return tdatas_tensor, tlabels_tensor


def load_test_data():
    tdatas_tensor = torch.from_numpy(test_array).float()
    tlabels_tensor = torch.from_numpy(test_label).long()
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
        # print("第", epoch + 1, "轮，已训练", i * batch_num, "项，该批Loss：", np.around(batch_loss.data.numpy(), decimals=6));

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

# 训练集
train_array = np.array( \
    [[0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0], \
     [0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0], \
     [0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0], \
     [0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0], \
     [0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0], \
     [0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0], \
     [0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0], \
     [0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0], \
     [0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0], \
     [0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0], \
     # [1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0], \
     # [0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0], \
     # [0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0] \
     ])

# 训练集标注
train_label = np.array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9 \
                           # , 5, 5, 5
                       ])

# 测试集
test_array = np.array( \
    [[1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0], \
     [0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0], \
     [0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0]])

# 测试集标注
test_label = np.array([5, 5, 5]);

# 1 加载模型
model = Net();

# 2 加载训练数据
train_data = torch.from_numpy(train_array).float()
train_label = torch.from_numpy(train_label).long()

# 3 加载测试数据
test_data = torch.from_numpy(test_array).float()
test_label = torch.from_numpy(test_label).long()

# 4 设置训练策略
optimizer = torch.optim.Adam(model.parameters())
loss_func = torch.nn.CrossEntropyLoss()

# 5 训练300轮
for epoch in range(300):

    # 单轮训练
    train_loss, train_acc, train_num = batch_train_one_epock(model, 1, train_data, train_label, loss_func, optimizer)
    print('第', epoch + 1, '轮 ', 'Train Loss: {:.6f}, Acc: {:.6f}'.format(train_loss / train_num, train_acc.float() / train_num))

    # 每轮测试准确率
    test_loss, test_acc, test_num = batch_test(model, 1, test_data, test_label, loss_func, optimizer)
    print('第', epoch + 1, '轮 ', 'Test Loss: {:.6f}, Acc: {:.6f}'.format(test_loss / test_num, test_acc.float() / test_num))

#    print(model.state_dict())

