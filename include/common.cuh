#pragma once

#include <cuda.h>

__global__ auto print_hello() -> void;

__host__ auto add_cpu(float* a, float* b, float* out, size_t n) -> void;

__global__ auto add_kernel(float* a, float* b, float* out, size_t n) -> void;