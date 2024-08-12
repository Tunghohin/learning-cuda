#include <cstdio>
#include <common.cuh>

__global__ auto print_hello() -> void {
    ::printf("Hello!");
}

// auto main() -> int {
//     print_hello<<<1, 1>>>();
// }