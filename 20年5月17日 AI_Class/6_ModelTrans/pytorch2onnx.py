#coding: UTF-8

import os
import sys
import torch
import onnx

from torch.autograd import Variable
from importlib import import_module

sys.path.append("../3_NeuralNetwork")

# NET
module = import_module("net");
net = module.Net()
weight_info = torch.load("../4_Forward/model_weight.pth", map_location="cpu");
net.load_state_dict(weight_info);
net.eval();

# INPUT
input = Variable(torch.randn(1, 1, 28, 28));

# CONVERTER
torch_out = torch.onnx.export(net, input, "./model.onnx", export_params=True, verbose=True)

# CHECK
onnx_model = onnx.load("./model.onnx")
onnx.checker.check_model(onnx_model)


