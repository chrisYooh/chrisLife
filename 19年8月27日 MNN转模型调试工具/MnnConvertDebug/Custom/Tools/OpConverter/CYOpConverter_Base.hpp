//
//  CYOpConverter_Base.hpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#ifndef CYOpConverter_Base_hpp
#define CYOpConverter_Base_hpp

#include <map>
#include "MNN_generated.h"
#include "OnnxTmpGraph.hpp"

/* 单节点转换 */
MNN::OpT * cy_convert_op(const ::onnx::NodeProto& onnxNode, std::map<std::string, const onnx::TensorProto*> &initializers);

/* 单节点转换 - 自定义转换参数 */
MNN::OpT * cy_convert_op(const ::onnx::NodeProto& onnxNode, std::vector<const onnx::TensorProto*> &opInitializers);

#endif /* CYOpConverter_Base_hpp */
