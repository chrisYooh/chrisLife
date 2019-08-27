//
//  CYConvertLinker.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "CYConvertLinker.hpp"

void cy_insert_op(std::unique_ptr<MNN::NetT>& netT,
                  MNN::OpT* MNNOp,
                  std::map<std::string, int> &tensorsName,
                  const std::string name) {
    
    if (MNNOp->main.type == MNN::OpParameter_NONE || MNNOp->main.value != nullptr) {
        netT->oplists.emplace_back(MNNOp);
        netT->tensorName.push_back(name);
        tensorsName.insert(std::make_pair(name, tensorsName.size()));
    }
}

void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output) {
    const auto it = tensorsName.find(output);
    op->outputIndexes.push_back(it->second);
}

void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input) {
    cy_tensor_link(op, tensorsName, output);
    auto it = tensorsName.find(input);
    op->inputIndexes.emplace_back(it->second);
}

void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input1, char *input2) {
    cy_tensor_link(op, tensorsName, output, input1);
    auto it = tensorsName.find(input2);
    op->inputIndexes.emplace_back(it->second);
}

void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input1, char *input2, char *input3) {
    cy_tensor_link(op, tensorsName, output, input1, input2);
    auto it = tensorsName.find(input3);
    op->inputIndexes.emplace_back(it->second);
}
