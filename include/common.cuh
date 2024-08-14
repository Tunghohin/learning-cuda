#pragma once

#include <cuda.h>
#include <cstdio>

constexpr size_t GRID_DIM = 128;
constexpr size_t BLOCK_DIM = 256;
constexpr size_t N = 1024;
constexpr size_t M = 1024;
constexpr size_t K = 1024;

__global__ auto print_hello() -> void;

__host__ auto add_cpu(float const* a, float const* b, float* out, size_t n) -> void;

__global__ auto add_kernel(float const* a, float const* b, float* out, size_t n) -> void;

__global__ auto reduce_kernel(float const* a, float* sum, size_t n) -> void;

auto matmul_init_data(float** A_h, float** B_h, float** C_h, float** A_d, float** B_d, float** C_d) -> void;

auto matmul_cpu(float* a, float* b, float* c, size_t M, size_t K, size_t N) -> void;