#include "submodule.h"

int subTest(int a) {
#ifdef DEMO_TEST
    printf("\n<%s:%d> DEMO TEST Function Called... %d \n\n", __func__, __LINE__, a);
#else
    printf("\n<%s:%d> Function Called... %d \n\n", __func__, __LINE__, a);
#endif
    return 1;
}
