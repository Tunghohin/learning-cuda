// main.cpp
// main.cpp

#include <algorithm>
#include <exception>
#include <type_traits>
#include <iostream>
#include <cstdio>
#include <cuda_runtime.h>
#include <helper_cuda.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/universal_vector.h>
#include <thrust/for_each.h>
#include <thrust/generate.h>
#include <thrust/iterator/counting_iterator.h>
#include <numeric>
#include <ranges>
#include <concepts>

#define DEVTID blockDim.x * blockIdx.x + threadIdx.x

auto main() -> int {
    // thrust::universal_vector<int> a;
    return 0;
}