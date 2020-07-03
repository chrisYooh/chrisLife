SCRIPT_DIR=$(cd `dirname $0`; pwd)
SRC_DIR="${SCRIPT_DIR}/../0_src"
SUBMOULE_DIR="${SRC_DIR}/submodule"
INCLUDE_DIR="${SRC_DIR}/include"
BUILD_DIR="${SCRIPT_DIR}/build"

rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}

# 1 生成subModel的二进制文件（.o)
gcc ${SUBMOULE_DIR}/submodule.c \
-c \
-I ${INCLUDE_DIR} \
-o ${BUILD_DIR}/submodule.o

# 2 生成main的二进制文件（.o）
gcc ${SRC_DIR}/main.c \
-c \
-I ${INCLUDE_DIR} \
-o ${BUILD_DIR}/main.o

# 3 链接二进制文件
gcc ${BUILD_DIR}/submodule.o \
${BUILD_DIR}/main.o \
-o ${BUILD_DIR}/main

# 4 执行可执行文件
${BUILD_DIR}/main

