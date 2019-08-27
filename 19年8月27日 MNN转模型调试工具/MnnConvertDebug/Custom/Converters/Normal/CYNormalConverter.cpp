//
//  CYNormalConverter.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "CYConverterPch.h"
#include "CYNormalConverter.hpp"

#define __BREAK_TAG             3000
#define __MANUAL_TAG            3000

#pragma mark - 网络输入

static bool __custom_set_inputs(std::unique_ptr<MNN::NetT>& netT, std::map<std::string, int> &tensorsName) {
    return false;
}

#pragma mark - 节点转换 & 生成

static int __custom_convert_op(std::unique_ptr<MNN::NetT>& netT,                                   // 目标合成网络
                               std::map<std::string, int> &tensorsName,                            // 目标tensor列表
                               std::map<std::string, const onnx::TensorProto*> &all_weight,        // 所有权重输入
                               const ::onnx::NodeProto& onnxNode,                                  // 当前处理onnxNode节点
                               int nodeIndex                                                       // 单签索引
) {
    
    std::cout << "【操作转换】索引：" << nodeIndex << " 名称：" << onnxNode.output(0)<< " 类型：" << onnxNode.op_type() << std::endl;
    
    // 中止转换逻辑
    if (nodeIndex > __BREAK_TAG) {
        return -1;
    }
    
    // 获取节点名称
    //    const auto& name = onnxNode.output(0);
    
    // 全人工处理逻辑
    if (nodeIndex <= __MANUAL_TAG) {
        return 0;
    } else {
        return 2;
    }
}

/* 人工节点连接
 * Return 0:自动链接；1:人工链接
 */
static bool __custom_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, std::string &name) {
    return false;
}

/* 人工输出节点设置
 * Return 0:扔需要自动设置；1:不需要自动设置
 */
static bool __custom_set_outputs(std::unique_ptr<MNN::NetT>& netT) {
    return false;
}

int cyOnnx2MNNNet_normal(const std::string inputModel, const std::string bizCode, std::unique_ptr<MNN::NetT>& netT) {
#include "CYCustomConverterFrame.code"
}
