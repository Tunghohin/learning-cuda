#include <common.cuh>
#include <new.h>
#include <chrono>

constexpr size_t N = 1000000;
float* a_h;
float* b_h; 
float* out_h;
float* a_d;
float* b_d;
float* out_d;

auto main() -> int {
    a_h = (float*)malloc(N * sizeof(float));
    b_h = (float*)malloc(N * sizeof(float));
    out_h = (float*)malloc(N * sizeof(float));

    cudaMalloc(&a_d, N * sizeof(float));
    cudaMalloc(&b_d, N * sizeof(float));
    cudaMalloc(&out_d, N * sizeof(float));

    print_hello<<<1, 1>>>();

    auto now = std::chrono::high_resolution_clock::now();
    auto now_h = std::chrono::high_resolution_clock::now();


    now = std::chrono::high_resolution_clock::now();
    auto now_d = std::chrono::high_resolution_clock::now();
}