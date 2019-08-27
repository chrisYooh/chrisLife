//
//  CYOpCreater.hpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#ifndef CYOpCreater_hpp
#define CYOpCreater_hpp

#include <map>
#include "MNN_generated.h"

MNN::OpT * cy_create_op_binary(std::string name, MNN::BinaryOpOperation opType);
MNN::OpT * cy_create_op_constant(std::string name, std::vector<int> shape, void *data);
MNN::OpT * cy_create_op_gather(std::string name, int axis);
MNN::OpT * cy_create_op_gather_indices(std::string name, std::vector<int> confv);
MNN::OpT * cy_create_op_input(std::string name, std::vector<int> confv);

MNN::OpT * cy_create_op_normalize(std::string name, int scale_num);
MNN::OpT * cy_create_op_permute(std::string name, std::vector<int> confv);
MNN::OpT * cy_create_op_reducesum(std::string name, std::vector<int> confv);
MNN::OpT * cy_create_op_reshape(std::string name, std::vector<int> confv);
MNN::OpT * cy_create_op_shape(std::string name);
MNN::OpT * cy_create_op_slice(std::string name, int axis, std::vector<int> confv);
MNN::OpT * cy_create_op_softmax(std::string name, int axis);
MNN::OpT * cy_create_op_squeeze(std::string name, std::vector<int> confv);

MNN::OpT * cy_create_op_tile(std::string name);
MNN::OpT * cy_create_op_tile_conig(std::string name, std::vector<int> confv);
MNN::OpT * cy_create_op_unsqueeze(std::string name, std::vector<int> confv);

#endif /* CYOpCreater_hpp */
