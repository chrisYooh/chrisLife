# cmake最低版本约定
cmake_minimum_required(VERSION 2.8)

# include目录
include_directories(../include)

# 查找当前文件夹源文件
aux_source_directory(. SRCS)

# 生成静态链接库
add_library(submodule ${SRCS})
