//
//  CYOpConverter_Base.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "onnxOpConverter.hpp"

#include "CYOpConverter_Base.hpp"

MNN::OpT * cy_convert_op(const ::onnx::NodeProto& onnxNode,
                         std::map<std::string, const onnx::TensorProto*> &initializers) {
    
    /* 操作参数提取 */
    std::vector<const onnx::TensorProto*> opInitializers;
    for (int k = 0; k < onnxNode.input_size(); ++k) {
        const auto& inputName = onnxNode.input(k);
        const auto it         = initializers.find(inputName);
        if (it != initializers.end()) {
            opInitializers.push_back(it->second);
        }
    }
    
    MNN::OpT* MNNOp = cy_convert_op(onnxNode, opInitializers);
    
    return MNNOp;
}

MNN::OpT * cy_convert_op(const ::onnx::NodeProto& onnxNode, std::vector<const onnx::TensorProto*> &opInitializers) {
    
    /* 构建转换器 */
    const auto& opType   = onnxNode.op_type();
    auto opConverter = onnxOpConverterSuit::get()->search(opType);
    
    /* 构建转换节点 */
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = onnxNode.output(0);
    MNNOp->type      = opConverter->opType();
    MNNOp->main.type = opConverter->type();
    
    /* 转换模型 */
    opConverter->run(MNNOp, &onnxNode, opInitializers);
    
    return MNNOp;
}
