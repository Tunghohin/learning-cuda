#include <common.cuh>
#include <new.h>
#include <chrono>
#include <sstream>

auto main() -> int {
    float* a_h;
    float* out_h;
    float* a_d;
    float* out_d;

    a_h = (float*)malloc(N * sizeof(float));
    for (size_t i = 0; i < N; i++) {
        a_h[i] = 1.0f;
    }
    cudaMalloc(&a_d, N * sizeof(float));
    cudaMemcpy(a_d, a_h, N * sizeof(float), cudaMemcpyHostToDevice);

    out_h = (float*)malloc((N / BLOCK_DIM) * sizeof(float)); 
    for (size_t i = 0; i < (N / BLOCK_DIM); i++) {
        out_h[i] = 0.0f;
    };
    cudaMalloc(&out_d, (N / BLOCK_DIM) * sizeof(float));
    cudaMemcpy(out_d, out_h, N * sizeof(float), cudaMemcpyHostToDevice);

    auto now = std::chrono::high_resolution_clock::now();
    for (auto round = 0; round < 100; round++) {
        double ret_cpu = 0.0f;
        for (size_t i = 0; i < N; i++) {
            ret_cpu += a_h[i];
        }
        if (round == 99) [[unlikely]] ::printf("%f\n", ret_cpu);
    }
    auto now_after = std::chrono::high_resolution_clock::now();
    auto dur = std::chrono::duration_cast<std::chrono::milliseconds>(now_after - now).count();
    ::printf("%lldms\n", dur);

    now = std::chrono::high_resolution_clock::now();
    for (auto round = 0; round < 100; round++) {
        dim3 grid(N / BLOCK_DIM, 1);
        dim3 block(BLOCK_DIM, 1);
        reduce<<<grid, block>>>(a_d, out_d, N);
        cudaMemcpy(out_h, out_d, (N / BLOCK_DIM) * sizeof(float), cudaMemcpyDeviceToHost);
        double ret_cuda = 0.0f;
        for (size_t i = 0; i < (N / BLOCK_DIM); i++) ret_cuda += out_h[i];
        if (round == 99) [[unlikely]] ::printf("%f\n", ret_cuda);
    }
    now_after = std::chrono::high_resolution_clock::now();
    dur = std::chrono::duration_cast<std::chrono::milliseconds>(now_after - now).count();
    ::printf("%lldms\n", dur);
}