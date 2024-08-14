#include <common.cuh>

__global__ auto reduce_kernel(float const* a, float* sum, size_t n) -> void {
    __shared__ float local[BLOCK_DIM];
    unsigned int tid = threadIdx.x;
    unsigned int i = blockDim.x * blockIdx.x + threadIdx.x;
    local[tid] = a[i];
    __syncthreads();

    for (unsigned int stride = blockDim.x / 2; stride > 0; stride >>= 1) {
        if (tid < stride) {
            local[tid] += local[tid + stride];
        }
        __syncthreads();
    }

    if (tid == 0) sum[blockIdx.x] = local[tid];
}