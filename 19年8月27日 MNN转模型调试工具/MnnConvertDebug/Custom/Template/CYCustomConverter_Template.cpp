//
//  CYCustomConverter_Template.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "CYConverterPch.h"
#include "CYCustomConverter_Template.hpp"

// 超过该节点，直接中断转换（在某些操作之后的转换存在问题时候通过修改该参数测试没有问题的操作执行）
#define __BREAK_TAG             3000

// 超过该节点，之后的转换不进行自动转换（针对手工修改对应网络结构的场景）
#define __MANUAL_TAG            150

// 输入节点
#define __KEY_INPUT             "0"

#define __KEY_MANUAL            "CY1"
#define __KEY_JUMP              "CY2"

#pragma mark - 网络输入

/* 设置网络输入
 * 返回值：
 * false: 使用转换自动设置的网络输入，
 * true: 手动于函数设置网络输入，跳过转换自动设置的网络输入
 */
static bool __custom_set_inputs(std::unique_ptr<MNN::NetT>& netT, std::map<std::string, int> &tensorsName) {
    return false;
}

#pragma mark - 节点转换 & 生成

/* 生成转换节点（一个MNN::OpT结构）
 * 1. 可以通过CYOpCreater.hpp 中封号的函数直接生成
 * 2. 可以通过CYOpConverter_Base.hpp 中的转换函数转换生成
 * 3. 可以如下面的实例手写定制化的节点（“硬”节点）
 */
static MNN::OpT * __create_op_xxx(const ::onnx::NodeProto& onnxNode, std::map<std::string, const onnx::TensorProto*> &all_weight) {
    
    /* Converter */
    auto opConverter = onnxOpConverterSuit::get()->search("Gemm");
    
    /* Weight */
    std::vector<const onnx::TensorProto*> opInitializers;
    for (int k = 0; k < onnxNode.input_size(); ++k) {
        const auto& inputName = onnxNode.input(k);
        const auto it         = all_weight.find(inputName);
        if (it != all_weight.end()) {
            opInitializers.push_back(it->second);
        }
    }
    
    /* Mnn Op */
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = onnxNode.output(0);
    MNNOp->type      = opConverter->opType();
    MNNOp->main.type = opConverter->type();
    
    /* Convert */
    opConverter->run(MNNOp, &onnxNode, opInitializers);
    
    return MNNOp;
}

/* 人工节点转换
 * Return
 *   0  : 自动转换（不进行人工操作，直接通过框架自动转换）；
 *   1  : 人工转换（手动生成节点，该onnxNode不再进行框架自动转换）;
 *   2  : 跳过节点（人工未处理，该onnxNode不再进行框架自动转换）;
 *  -1  : 中止转换（跳出节点生成循环，不再进行后续节点转换）；
 */
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
    const auto& name = onnxNode.output(0);
    
//    /* 示例1：
//     * 特定节点手动转换，返回 1
//     */
//    if (name == __KEY_MANUAL) {
//        MNN::OpT* MNNOp = __create_op_xxx(onnxNode, all_weight);
//        CY_INSERT_OP(__KEY_MANUAL);
//        return 1;
//    }
//
//    /* 示例2：
//     * 特定节点不进行转换，直接跳过，返回 2
//     */
//    if (name == __KEY_JUMP) {
//        return 2;
//    }

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

int gmOnnx2MNNNet_au39(const std::string inputModel, const std::string bizCode, std::unique_ptr<MNN::NetT>& netT) {
#include "CYCustomConverterFrame.code"
}
