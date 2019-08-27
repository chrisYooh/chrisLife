//
//  main.m
//  MNNConverterDebug
//
//  Created by Chris Yang on 2019/7/19.
//  Copyright © 2019 Chris. All rights reserved.
//

#include "cli.hpp"

#include "MNN_generated.h"
#include "addBizCode.hpp"
#include "caffeConverter.hpp"
#include "optimizer.hpp"
#include "writeFb.hpp"

#define __ONNX_MODEL_PATH       "/Users/chris/Documents/WorkingCopys/GitHub/Chris_Life/19年8月27日 MNN转模型调试工具/MnnConvertDebug/TestModel/model.onnx"
#define __MNN_MODEL_PATH        "/Users/chris/Documents/WorkingCopys/GitHub/Chris_Life/19年8月27日 MNN转模型调试工具/MnnConvertDebug/TestModel/model.mnn"

int onnx2MNNNet(const std::string inputModel, const std::string bizCode, std::unique_ptr<MNN::NetT>& netT);

int main(int argc, char *argv[]) {
    
    /* 1 参数模拟 */
    int tmp_argc = 9;
    char * tmp_argv[20];
    for (int i = 0; i < 20; i++) {
        tmp_argv[i] = (char *)malloc(256);
    }
    strcpy(tmp_argv[0], "./MNNConvert");
    strcpy(tmp_argv[1], "-f");
    strcpy(tmp_argv[2], "ONNX");
    strcpy(tmp_argv[3], "--modelFile");
    strcpy(tmp_argv[4], __ONNX_MODEL_PATH);
    strcpy(tmp_argv[5], "--MNNModel");
    strcpy(tmp_argv[6], __MNN_MODEL_PATH);
    strcpy(tmp_argv[7], "--bizCode");
    strcpy(tmp_argv[8], "MNN");
    
    /* 2 参数解析 */
    modelConfig modelPath;
    Cli::initializeMNNConvertArgs(modelPath, tmp_argc, (char **)tmp_argv);
    Cli::printProjectBanner();
    
    /* 3 模型转换 onnx --> mnn */
    std::cout << "Start to Convert Other Model Format To MNN Model..." << std::endl;
    std::unique_ptr<MNN::NetT> netT = std::unique_ptr<MNN::NetT>(new MNN::NetT());
    onnx2MNNNet(modelPath.modelFile, modelPath.bizCode, netT);
    
    /* 4 模型优化 */
    std::cout << "Start to Optimize the MNN Net..." << std::endl;
    std::unique_ptr<MNN::NetT> newNet = optimizeNet(netT);
    writeFb(newNet, modelPath.MNNModel, modelPath.benchmarkModel);
    std::cout << "Converted Done!" << std::endl;
    
    /* 5 模型结构Dump */
//    std::string model_path = "/Users/chris/Documents/WorkingCopys/GitHub/Chris_Mnn/custom/iOS/models/m_10001/m_10001.mnn";
//    std::string json_path = "/Users/chris/Documents/WorkingCopys/GitHub/Chris_Mnn/custom/iOS/models/m_10001/m_10001.json";
//    std::string jweight_path = "/Users/chris/Documents/WorkingCopys/GitHub/Chris_Mnn/custom/iOS/models/m_10001/m_10001_weight.mnn";
//    gmDumpJson(model_path.c_str(), json_path.c_str(), false);
//    gmDumpJson(model_path.c_str(), jweight_path.c_str(), true);
    
    return 0;
}
