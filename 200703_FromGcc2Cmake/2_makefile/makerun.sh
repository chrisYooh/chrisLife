SCRIPT_DIR=$(cd `dirname $0`; pwd)
SRC_DIR="${SCRIPT_DIR}/../0_src"
SUBMOULE_DIR="${SRC_DIR}/submodule"

cp Makefile_src ${SRC_DIR}/Makefile
cp Makefile_submodule ${SUBMOULE_DIR}/Makefile
cd ${SRC_DIR} && make all

cd ${SCRIPT_DIR}
cp ${SRC_DIR}/main ./
./main
