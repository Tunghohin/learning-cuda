#include <common.cuh>

// C = AB, the shape of A is (n, k), the shape of B is (k, m), so the shape of C is (n, m)
auto matmul_init_data(float** A_h, float** B_h, float** C_h, float** A_d, float** B_d, float** C_d) -> void {
    *A_h = (float*)malloc(N * K * sizeof(float));
    *B_h = (float*)malloc(K * M * sizeof(float));
    *C_h = (float*)malloc(N * M * sizeof(float));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < K; j++) {
            (*A_h)[i * K + j] = (float)(i % 10);
        }
    }
    for (int i = 0; i < K; i++) {
        for (int j = 0; j < M; j++) {
            (*B_h)[i * M + j] = (float)(j % 10);
        }
    }
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            (*C_h)[i * M + j] = 0.0f;
        }
    }  
    
    cudaMalloc(A_d, N * K * sizeof(float));
    cudaMalloc(B_d, K * M * sizeof(float));
    cudaMalloc(C_d, N * M * sizeof(float));
    cudaMemcpy(*A_d, *A_h, N * K * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(*B_d, *B_h, K * M * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(*C_d, *C_h, N * M * sizeof(float), cudaMemcpyHostToDevice);
}

auto matmul_cpu(float* a, float* b, float* c, size_t M, size_t K, size_t N) -> void {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            float tmp = 0.0f;
            for (int s = 0; s < K; s++) {
                tmp += a[i * K + s] * b[s * N + j];
            }
            c[i * N + j] = tmp;
        }
    }
}

// __global__ auto matmul_kernel(float* a, float* b, float* c, size_t M, size_t K, size_t N) -> void {
//     int row = blockDim.x * blockIdx.x + threadIdx.x;
//     int col = blockDim.y * blockIdx.y + threadIdx.y;
// }