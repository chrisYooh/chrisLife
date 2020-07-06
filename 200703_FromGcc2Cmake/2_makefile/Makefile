CC      = gcc
CPP     = g++
RM      = rm -rf

## debug flag
DBG_ENABLE   = 1

## source file path
SRC_PATH   := .

## target exec file name
TARGET     := test

## get all source files
SRCS         += $(wildcard $(SRC_PATH)/*.c)

## all .o based on all .c
OBJS        := $(SRCS:.c=.o)


## need libs, add at here
LIBS := pthread

## used headers  file path
INCLUDE_PATH := .

## used include librarys file path
LIBRARY_PATH := /lib

## debug for debug info, when use gdb to debug
ifeq (1, ${DBG_ENABLE})
	CFLAGS += -D_DEBUG -O0 -g -DDEBUG=1
endif

## get all include path
CFLAGS  += $(foreach dir, $(INCLUDE_PATH), -I$(dir))

## get all library path
LDFLAGS += $(foreach lib, $(LIBRARY_PATH), -L$(lib))

## get all librarys
LDFLAGS += $(foreach lib, $(LIBS), -l$(lib))

# 说明
explain:
	@echo "此篇为Makefile的基本使用说明，真正的Makefile一般放置在源文件同级目录中"
	@echo "执行 make demo_print 查看基本信息示例"
	@echo "执行 make all 进行编译"
	@echo "执行 make test 测试结果"
	@echo "执行 make clean 清理编译"
	
# 打印变量信息
demo_print:
	@echo "CC: "${CC}
	@echo "CPP: "${CPP}
	@echo "RM: "${RM}
	@echo "DBG_ENABLE: "${DBG_ENABLE}
	@echo "SRC_PATH: "${SRC_PATH}
	@echo "SRCS: "${SRCS}
	@echo "OBJS: "${OBJS}
	@echo "LIBS: "${LIBS}
	@echo "INCLUDE_PATH: "${INCLUDE_PATH}
	@echo "LIBRARY_PATH: "${LIBRARY_PATH}
	@echo "CFLAGS: "${CFLAGS}
	@echo "LDFLAGS: "${LDFLAGS}
	@echo "LDFLAGS: "${LDFLAGS}
	
	@echo
	@echo "编译当前目录示例"
	@echo $(CC) -c $(CFLAGS) $(SRCS)
	@echo $(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)
	@echo $(RM) $(OBJS)

all:
	cp ./Makefile_src ../0_src/Makefile
	cp ./Makefile_submodule ../0_src/submodule/Makefile
	cd ../0_src && make all
	cp ../0_src/main ./
	./main
	
clean:
	cd ../0_src && make clean
	
	rm -rf ../0_src/Makefile
	rm -rf ../0_src/submodule/Makefile
	rm -rf ./main
