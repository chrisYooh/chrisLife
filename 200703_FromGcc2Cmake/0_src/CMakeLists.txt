# cmake最低版本约定
cmake_minimum_required(VERSION 2.8)

# 工程名称
project(main)

# 宏开关
option(DT "Demo Test Switch" OFF)
if(DT)
add_definitions("-DDEMO_TEST=1")
endif()

# include目录
include_directories(./include)

# 子模块文件目录
add_subdirectory(./submodule)

# 查找当前文件夹源文件
aux_source_directory(. SRCS)

# 生成可执行文件
add_executable(main ${SRCS})

# 可执行文件链接静态库
target_link_libraries(main submodule)
