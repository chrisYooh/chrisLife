//
//  CYMnnJsonDump.cpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include "flatbuffers/idl.h"
#include "flatbuffers/minireflect.h"
#include "flatbuffers/util.h"
#include "MNN_generated.h"

#include "CYMnnJsonDump.hpp"

void cyMnnDumpJson(const char *model_path, const char *json_path, bool dump_weight) {
    
    std::ifstream inputFile(model_path, std::ios::binary);
    inputFile.seekg(0, std::ios::end);
    auto size = inputFile.tellg();
    inputFile.seekg(0, std::ios::beg);
    
    char* buffer = new char[size];
    
    inputFile.read((char*)buffer, size);
    std::ofstream output(json_path);
    
    if (false == dump_weight) {
        
        printf("Dont't add convweight\n");
        auto netT = MNN::UnPackNet((void*)buffer);
        for (int i = 0; i < netT->oplists.size(); ++i) {
            auto type     = netT->oplists[i]->main.type;
            auto& opParam = netT->oplists[i];
            if (type == MNN::OpParameter::OpParameter_Blob) {
                auto blobT = opParam->main.AsBlob();
                blobT->float32s.clear();
                blobT->int8s.clear();
            }
            else if (type == MNN::OpParameter::OpParameter_Convolution2D) {
                opParam->main.AsConvolution2D()->weight.clear();
                opParam->main.AsConvolution2D()->bias.clear();
            } else if (type == MNN::OpParameter::OpParameter_MatMul) {
                opParam->main.AsMatMul()->weight.clear();
                opParam->main.AsMatMul()->bias.clear();
            } else if (type == MNN::OpParameter::OpParameter_PRelu) {
                opParam->main.AsPRelu()->slope.clear();
            } 
        }
        flatbuffers::FlatBufferBuilder newBuilder(1024);
        auto root = MNN::Net::Pack(newBuilder, netT.get());
        MNN::FinishNetBuffer(newBuilder, root);
        {
            auto content = newBuilder.GetBufferPointer();
            auto s       = flatbuffers::FlatBufferToString((const uint8_t*)content, MNN::NetTypeTable());
            output << s;
        }
    } else {
        auto s = flatbuffers::FlatBufferToString((const uint8_t*)buffer, MNN::NetTypeTable());
        output << s;
    }
    
    delete[] buffer;
}
