//
//  CYConvertLinker.hpp
//  MnnConvertDebug
//
//  Created by Chris Yang on 2019/8/27.
//  Copyright © 2019 Chris. All rights reserved.
//

#ifndef CYConvertLinker_hpp
#define CYConvertLinker_hpp

#include <map>
#include "MNN_generated.h"

/* **************************************** OP INSERT ****************************************** */

/* 快捷Op插入 */
/* 强设变量：
 * netT, MNNOp、tensorsName
 */
#define CY_INSERT_OP(name) \
do { \
    cy_insert_op(netT, MNNOp, tensorsName, name); \
} while(0)

/* Op插入：将一个转换 OpT 数据插入到 网络 */
void cy_insert_op(std::unique_ptr<MNN::NetT>& netT,
                  MNN::OpT* MNNOp,
                  std::map<std::string, int> &tensorsName,
                  const std::string name);

/* **************************************** Tensor Link **************************************** */

/* 快捷连接 */
/* 强设变量：
 * name, op、tensorName
 */
#define CY_TENSOR_LINK_0(name_output) \
do { \
    if (name == name_output) { \
        cy_tensor_link(op, tensorsName, (char *)name_output); \
        return true; \
    } \
} while(0)

#define CY_TENSOR_LINK_1(name_output, name_input1) \
do { \
    if (name == name_output) { \
        cy_tensor_link(op, tensorsName, (char *)name_output, (char *)name_input1); \
        return true; \
    } \
} while(0)

#define CY_TENSOR_LINK_2(name_output, name_input1, name_input2) \
do { \
    if (name == name_output) { \
        cy_tensor_link(op, tensorsName, (char *)name_output, (char *)name_input1, (char *)name_input2); \
        return true; \
    } \
} while(0)

#define CY_TENSOR_LINK_3(name_output, name_input1, name_input2, name_input3) \
do { \
    if (name == name_output) { \
        cy_tensor_link(op, tensorsName, (char *)name_output, (char *)name_input1, (char *)name_input2, (char *)name_input3); \
        return true; \
    } \
} while(0)

/* 单输出连接 */
void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output);

/* 1输入1输出连接 */
void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input);

/* 2输入1输出连接 */
void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input1, char *input2);

/* 3输入1输出连接 */
void cy_tensor_link(std::unique_ptr<MNN::OpT> &op, std::map<std::string, int> &tensorsName, char *output, char *input1, char *input2, char *input3);

#endif /* CYConvertLinker_hpp */
