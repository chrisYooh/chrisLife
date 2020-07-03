#include "submodule.h"

int subTest(int a) {
    printf("\n<%s:%d> Function Called... %d \n\n", __func__, __LINE__, a);
    return 1;
}
