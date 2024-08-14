#include <common.cuh>
#include <new.h>
#include <chrono>
#include <sstream>

auto main() -> int {
    // C = AB
    float* A_h = nullptr;
    float* B_h = nullptr;
    float* C_h = nullptr;
    float* A_d = nullptr;
    float* B_d = nullptr;
    float* C_d = nullptr;

    matmul_init_data(&A_h, &B_h, &C_h, &A_d, &B_d, &C_d);
    matmul_cpu(A_h, B_h, C_h, M, K, N);
    for (int i = 0; i < 20; i++) {
        for (int j = 0; j < 20; j++) {
            ::printf("%f, ", C_h[i * M + j]);
        }
        ::printf("\n");
    }  
}