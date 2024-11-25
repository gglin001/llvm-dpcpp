###############################################################################

# build sycl-toolchain
python buildbot/compile.py -t sycl-toolchain
# python buildbot/compile.py -t install-sycl-toolchain

# list targets
cmake --build build --target help

# build all
cmake --build build --target all
# optional install
cmake --build build --target install

###############################################################################

# OSX
# NATIVECPU_USE_OCK=ON

# args=(
#   buildbot/configure.py
#   --use-lld
#   --native_cpu
#   --host-target="host;RISCV;AArch64"
#   --cmake-opt="-DCMAKE_C_COMPILER=/usr/bin/clang"
#   --cmake-opt="-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
#   --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
#   --cmake-opt="-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
#   --cmake-opt="-DFETCHCONTENT_UPDATES_DISCONNECTED=ON"
#   --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
#   --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
#   --cmake-opt="-DNATIVECPU_USE_OCK=ON"
# )
# python "${args[@]}"

###############################################################################

# OSX
# just opencl, no native_cpu, no level_zero

args=(
  buildbot/configure.py
  --use-lld
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DCMAKE_C_COMPILER=/usr/bin/clang"
  --cmake-opt="-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
  # --cmake-opt="-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
  --cmake-opt="-DFETCHCONTENT_UPDATES_DISCONNECTED=ON"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --cmake-opt="-DSYCL_ENABLE_BACKENDS=opencl"
  --llvm-external-projects="lld"
)
python "${args[@]}"

###############################################################################

# NATIVECPU_USE_OCK=ON

# args=(
#   buildbot/configure.py
#   --use-lld
#   --native_cpu
#   --host-target="host;RISCV;AArch64"
#   --cmake-opt="-DCMAKE_C_COMPILER=/usr/bin/clang"
#   --cmake-opt="-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
#   --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
#   --cmake-opt="-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
#   --cmake-opt="-DFETCHCONTENT_UPDATES_DISCONNECTED=ON"
#   --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
#   --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
#   --cmake-opt="-DNATIVECPU_USE_OCK=ON"
# )
# python "${args[@]}"

###############################################################################

# just opencl, no native_cpu, no level_zero

args=(
  buildbot/configure.py
  --use-lld
  --host-target="host;RISCV;AArch64;NVPTX;AMDGPU"
  --cmake-opt="-DCMAKE_C_COMPILER=/usr/bin/clang"
  --cmake-opt="-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
  # --cmake-opt="-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
  --cmake-opt="-DFETCHCONTENT_UPDATES_DISCONNECTED=ON"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --cmake-opt="-DSYCL_ENABLE_BACKENDS=opencl"
  --llvm-external-projects="lld;mlir"
)
python "${args[@]}"

###############################################################################

# DEBUG
# just opencl, no native_cpu, no level_zero

args=(
  buildbot/configure.py
  --use-lld
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DCMAKE_C_COMPILER=/usr/bin/clang"
  --cmake-opt="-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux_debug"
  # --cmake-opt="-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
  --cmake-opt="-DFETCHCONTENT_UPDATES_DISCONNECTED=ON"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --cmake-opt="-DSYCL_ENABLE_BACKENDS=opencl"
  --build-type=Debug
  --obj-dir=build_debug
)
python "${args[@]}"

# only libsycl.so for debug
cmake --build build_debug --target libsycl.so
# deps:
# libur_loader.so
# libur_adapter_opencl.so
# libumf.so

# python buildbot/compile.py --obj-dir build_debug -t sycl-toolchain
# cmake --build build_debug --target all
# cmake --build build_debug --target install

###############################################################################
