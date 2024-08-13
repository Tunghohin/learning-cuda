#include <cstdio>
#include <common.cuh>

__global__ auto print_hello() -> void {
    ::printf("tid: %d, bid: %d: Hello!\n", threadIdx.x, blockIdx.x);
}

// auto main() -> int {
//     print_hello<<<1, 1>>>();
// }