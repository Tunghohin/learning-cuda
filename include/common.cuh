#pragma once

#include <cuda.h>
#include <cstdio>

constexpr size_t GRID_DIM = 128;
constexpr size_t BLOCK_DIM = 256;
constexpr size_t N = 1024 * 1024 * 32;

__global__ auto print_hello() -> void;

__host__ auto add_cpu(float const* a, float const* b, float* out, size_t n) -> void;

__global__ auto add_kernel(float const* a, float const* b, float* out, size_t n) -> void;

__global__ auto reduce(float const* a, float* sum, size_t n) -> void;