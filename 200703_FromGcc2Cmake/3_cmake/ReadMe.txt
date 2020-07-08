CMakeList.txt能做的事情无非如下几件：

1 编译配置：
编译目标：可执行文件、静态库、动态库
add_executable()
add_library([libname] STATIC [files])
add_library([libname] SHARED [files])

全局宏
add_definitions("-DAAA=aaa")

头文件查找路径
include_directories(./include)

子模块查找路径
add_subdirectory(./submodule)

添加库依赖
target_link_libraries(main submodule)

2 操作
条件判定
option()
if()-else()-endif()

信息输出
message(STATUS "")

其他操作
option()
set()
list()
install()

Cmake install()