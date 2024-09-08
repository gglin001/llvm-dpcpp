###############################################################################

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
)
python "${args[@]}"

python buildbot/compile.py

###############################################################################

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"
  --cmake-opt="-DLLVM_INCLUDE_TESTS=OFF"
  --cmake-opt="-DSYCL_INCLUDE_TESTS=OFF"
)
python "${args[@]}"

python buildbot/compile.py

###############################################################################
