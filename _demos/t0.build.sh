###############################################################################

# build all
cmake --build build --target all

###############################################################################

# OSX
# NATIVECPU_USE_OCK=ON

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=ON"
)
python "${args[@]}"

python buildbot/compile.py -t sycl-toolchain

###############################################################################

# OSX
# just opencl, no native_cpu, no level_zero

args=(
  buildbot/configure.py
  --use-lld
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --cmake-opt="-DSYCL_ENABLE_BACKENDS=opencl"
)
python "${args[@]}"

python buildbot/compile.py -t sycl-toolchain

###############################################################################

# NATIVECPU_USE_OCK=ON

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=ON"
)
python "${args[@]}"

python buildbot/compile.py -t sycl-toolchain

###############################################################################

# NATIVECPU_USE_OCK=OFF

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --llvm-external-projects="lld"
)
python "${args[@]}"

python buildbot/compile.py -t sycl-toolchain

###############################################################################

# just opencl, no native_cpu, no level_zero

args=(
  buildbot/configure.py
  --use-lld
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
  --cmake-opt="-DNATIVECPU_USE_OCK=OFF"
  --cmake-opt="-DSYCL_ENABLE_BACKENDS=opencl"
  --llvm-external-projects="lld"
)
python "${args[@]}"

python buildbot/compile.py -t sycl-toolchain

###############################################################################
