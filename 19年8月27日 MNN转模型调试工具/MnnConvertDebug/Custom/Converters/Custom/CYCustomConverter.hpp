//
//  CYCustomConverter.hpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#ifndef CYCustomConverter_hpp
#define CYCustomConverter_hpp

#include <stdio.h>

int cyOnnx2MNNNet_custom(const std::string inputModel, const std::string bizCode, std::unique_ptr<MNN::NetT>& netT);

#endif /* CYCustomConverter_hpp */
