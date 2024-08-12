cmake_minimum_required(VERSION 3.20)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(WIN32)
    add_definitions(-DNOMINMAX -D_USE_MATH_DEFINES)
    SET(GUI_TYPE WIN32)
    set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=-*,readability-*)
    set(CMAKE_TOOLCHAIN_FILE "~/vcpkg/scripts/buildsystems/vcpkg.cmake")
    set(QT_QPA_PLATFORM_PLUGIN_PATH "C:/Users/MSN/vcpkg/installed/x64-windows/Qt6/plugins/platforms")
    set(VCPKG_TARGET_TRIPLET "x64-windows")
    include(${CMAKE_TOOLCHAIN_FILE})
    set(CUDA_SEPARABLE_COMPILATION ON)
    set(CMAKE_CUDA_ARCHITECTURES 61;86)
endif()

if(UNIX AND NOT APPLE)
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_CREATE_STATIC_LIBRARY ON)

project(test-cuda LANGUAGES CXX CUDA)

# message("Project version: ${PROJECT_VERSION}")
find_package(fmt REQUIRED)
set(SPDLOG_FMT_EXTERNAL ON)
find_package(CUDA REQUIRED)

file(GLOB_RECURSE DEPS CONFIGURE_DEPENDS ./src/*.cpp ./include/*.h ./build/*.h)
file(GLOB_RECURSE CUDASRC CONFIGURE_DEPENDS ./src/*.cu)
file(GLOB_RECURSE LIBSRC CONFIGURE_DEPENDS ./include/*.cpp)

add_executable(${PROJECT_NAME} ${LIBSRC} ${DEPS} ${CUDASRC})

target_compile_options(test-cuda PRIVATE
    $<$<COMPILE_LANGUAGE:CUDA>:--expt-relaxed-constexpr>
    $<$<COMPILE_LANGUAGE:CUDA>:--extended-lambda>
)

target_link_libraries(${PROJECT_NAME} PRIVATE  
    fmt::fmt
)
target_include_directories(${PROJECT_NAME} PRIVATE
    include
    fmt::fmt
    ${CMAKE_BINARY_DIR}
)