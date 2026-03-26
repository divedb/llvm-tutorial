cmake_minimum_required(VERSION 3.20)
project(l_compiler LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

add_executable(lc src/main.cpp)

target_include_directories(lc SYSTEM PRIVATE ${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

llvm_map_components_to_libnames(LLVM_LIBS
  Core
  IRReader
  MC
  Support
  Target
  TargetParser
  CodeGen
)

target_link_libraries(lc PRIVATE ${LLVM_LIBS})
