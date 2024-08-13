#include <common.cuh>
#include <new.h>
#include <chrono>
#include <sstream>

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
    for (size_t i = 0; i < N; i++) {
        a_h[i] = b_h[i] = 1.0f;
        out_h[i] = 0;
    }

    cudaMalloc(&a_d, N * sizeof(float));
    cudaMalloc(&b_d, N * sizeof(float));
    cudaMalloc(&out_d, N * sizeof(float));
    cudaMemcpy(a_d, a_h, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(b_d, b_h, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(out_d, out_h, N * sizeof(float), cudaMemcpyHostToDevice);


    auto now = std::chrono::high_resolution_clock::now();
    // for (int i = 0; i < 100000; i++) {
    //     add_cpu(a_h, b_h, out_h, N);
    // }
    auto now_h = std::chrono::high_resolution_clock::now();
    std::stringstream ss;
    // ss << std::chrono::duration_cast<std::chrono::milliseconds>(now_h - now) << std::endl;

    now = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < 30000; i++) {
        sum<<<GRID_DIM, BLOCK_DIM>>>(a_d, out_d, N);
        cudaDeviceSynchronize();
    }
    cudaDeviceSynchronize();
    auto now_d = std::chrono::high_resolution_clock::now();
    ss << std::chrono::duration_cast<std::chrono::milliseconds>(now_d - now) << std::endl;
    ::printf("%s", ss.str().c_str());

    auto ret = 0.0f;
    cudaMemset(out_d, 0, N * sizeof(float));
    sum<<<GRID_DIM, BLOCK_DIM>>>(a_d, out_d, N);
    cudaDeviceSynchronize();
    cudaMemcpy(out_h, out_d, N * sizeof(float), cudaMemcpyDeviceToHost);
    for (size_t i = 0; i < BLOCK_DIM; i++) ret += out_h[i];
    ::printf("%f", ret);
}