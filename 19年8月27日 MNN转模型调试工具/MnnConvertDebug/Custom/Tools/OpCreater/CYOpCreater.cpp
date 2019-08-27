//
//  CYOpCreater.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "CYOpCreater.hpp"

#pragma mark - B

MNN::OpT * cy_create_op_binary(std::string name, MNN::BinaryOpOperation opType) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_BinaryOp;
    MNNOp->main.type = MNN::OpParameter_BinaryOp;
    
    auto param = new MNN::BinaryOpT;
    MNNOp->main.value = param;
    
    param->opType = opType;
    param->T = MNN::DataType_DT_FLOAT;
    
    return MNNOp;
}

#pragma mark - C

MNN::OpT * cy_create_op_constant(std::string name, std::vector<int> shape, void *data) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Const;
    MNNOp->main.type = MNN::OpParameter_Blob;
    
    auto param = new MNN::BlobT;
    MNNOp->main.value = param;
    
    /* 维度 */
    int dim_size = (int)shape.size();
    int data_length = 1;
    param->dims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->dims[i] = shape[i];
        data_length *= shape[i];
    }
    
    /* 数据 */
    param->dataType   = MNN::DataType_DT_FLOAT;
    param->dataFormat = MNN::MNN_DATA_FORMAT_NCHW;
    param->float32s.resize(data_length);
    ::memcpy(param->float32s.data(), data, data_length * sizeof(float));
    
    return MNNOp;
}

#pragma mark - G

MNN::OpT * cy_create_op_gather(std::string name, int axis) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Gather;
    MNNOp->main.type = MNN::OpParameter_Gather;
    
    auto param  = new MNN::GatherT;
    MNNOp->main.value = param;
    param->axis = axis;
    
    return MNNOp;
}

MNN::OpT * cy_create_op_gather_indices(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Const;
    MNNOp->main.type = MNN::OpParameter_Blob;
    auto param = new MNN::BlobT;
    MNNOp->main.value = param;
    
    param->dataType   = MNN::DataType_DT_INT32;
    param->dataFormat = MNN::MNN_DATA_FORMAT_NCHW;
    
    int dim_size = (int)(confv.size());
    param->dims.resize(1);
    param->dims[0] = dim_size;
    param->int32s.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->int32s.data()[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - I

MNN::OpT * cy_create_op_input(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Input;
    MNNOp->main.type = MNN::OpParameter_Input;
    
    auto param = new MNN::InputT;
    MNNOp->main.value = param;
    
    param->dtype   = MNN::DataType_DT_FLOAT;
    param->dformat = MNN::MNN_DATA_FORMAT_NC4HW4;
    
    int dim_size = (int)(confv.size());
    param->dims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->dims[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - N

MNN::OpT * cy_create_op_normalize(std::string name, int scale_num) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Normalize;
    MNNOp->main.type = MNN::OpParameter_Normalize;
    
    auto param = new MNN::NormalizeT;
    MNNOp->main.value = param;
    
    param->acrossSpatial = 0;
    param->channelShared = 0;
    param->eps           = 0.00001f;
    for (int i = 0; i < scale_num; ++i) {
        param->scale.push_back(1);
    }
    
    return MNNOp;
}

#pragma mark - P

MNN::OpT * cy_create_op_permute(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Permute;
    MNNOp->main.type = MNN::OpParameter_Permute;
    
    auto param = new MNN::PermuteT;
    MNNOp->main.value = param;
    
    int dim_size = (int)(confv.size());
    param->dims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->dims[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - R

MNN::OpT * cy_create_op_reducesum(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Reduction;
    MNNOp->main.type = MNN::OpParameter_ReductionParam;
    
    auto param = new MNN::ReductionParamT;
    MNNOp->main.value = param;
    
    param->operation = MNN::ReductionType_SUM;
    param->dType     = MNN::DataType_DT_FLOAT;
    param->keepDims = false;
    
    int dim_size = (int)(confv.size());
    param->dim.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->dim[i] = confv[i];
    }
    
    return MNNOp;
}

MNN::OpT * cy_create_op_reshape(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Reshape;
    MNNOp->main.type = MNN::OpParameter_Reshape;
    
    auto param      = new MNN::ReshapeT;
    MNNOp->main.value = param;
    
    param->dimType  = MNN::MNN_DATA_FORMAT_NCHW;
    
    int dim_size = (int)(confv.size());
    param->dims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->dims[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - S

MNN::OpT * cy_create_op_shape(std::string name) {
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Shape;
    MNNOp->main.type = MNN::OpParameter_NONE;
    MNNOp->main.value = nullptr;
    return MNNOp;
}

MNN::OpT * cy_create_op_slice(std::string name, int axis, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Slice;
    MNNOp->main.type = MNN::OpParameter_Slice;
    
    auto param = new MNN::SliceT;
    MNNOp->main.value = param;
    
    param->axis = axis;
    param->slicePoints = confv;
    param->sourceType = MNN::NetSource_CAFFE;
    
    return MNNOp;
}

MNN::OpT * cy_create_op_softmax(std::string name, int axis) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Softmax;
    MNNOp->main.type = MNN::OpParameter_Axis;
    
    auto param = new MNN::AxisT;
    MNNOp->main.value = param;
    param->axis = axis;
    
    return MNNOp;
}

MNN::OpT * cy_create_op_squeeze(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Squeeze;
    MNNOp->main.type = MNN::OpParameter_SqueezeParam;
    
    auto param = new MNN::SqueezeParamT;
    MNNOp->main.value = param;
    
    int dim_size = (int)(confv.size());
    param->squeezeDims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->squeezeDims[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - T

MNN::OpT * cy_create_op_tile(std::string name) {
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Tile;
    MNNOp->main.type = MNN::OpParameter_NONE;
    MNNOp->main.value = nullptr;
    return MNNOp;
}

MNN::OpT * cy_create_op_tile_conig(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Const;
    MNNOp->main.type = MNN::OpParameter_Blob;
    auto param = new MNN::BlobT;
    MNNOp->main.value = param;
    
    param->dataType   = MNN::DataType_DT_INT32;
    param->dataFormat = MNN::MNN_DATA_FORMAT_NCHW;
    
    int dim_size = (int)(confv.size());
    param->dims.resize(1);
    param->dims[0] = dim_size;
    param->int32s.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->int32s.data()[i] = confv[i];
    }
    
    return MNNOp;
}

#pragma mark - U

MNN::OpT * cy_create_op_unsqueeze(std::string name, std::vector<int> confv) {
    
    MNN::OpT* MNNOp  = new MNN::OpT;
    MNNOp->name      = name;
    MNNOp->type      = MNN::OpType_Unsqueeze;
    MNNOp->main.type = MNN::OpParameter_SqueezeParam;
    
    auto param = new MNN::SqueezeParamT;
    MNNOp->main.value = param;
    
    int dim_size = (int)(confv.size());
    param->squeezeDims.resize(dim_size);
    for (int i = 0; i < dim_size; i++) {
        param->squeezeDims[i] = confv[i];
    }
    
    return MNNOp;
}
