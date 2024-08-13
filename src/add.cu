#include <common.cuh>

__host__ auto add_cpu(float const* a, float const* b, float* out, size_t n) -> void {
    for (int i = 0; i < n; i++) {
        out[i] = a[i] + b[i];
    }
}

__global__ auto add_kernel(float const* a, float const* b, float* out, size_t n) -> void {
    for (auto i = blockIdx.x * blockDim.x + threadIdx.x; i < n; i += blockDim.x * gridDim.x) {
        out[i] = a[i] + b[i];
    }
}