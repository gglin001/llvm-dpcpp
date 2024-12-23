# git clone -n --depth=1 --filter=tree:0 -b sycl git@github.com:intel/llvm.git llvm-dpcpp
git clone -n --depth=1 --filter=tree:0 -b allen/sycl git@github.com:gglin001/llvm-dpcpp.git

pushd llvm-dpcpp
git sparse-checkout set --no-cone \
  /.ci /.github /buildbot /clang /cmake /devops /libclc /libdevice \
  /llvm-spirv /llvm /opencl /sycl-jit /sycl /third-party \
  /xpti /xptifw \
  /_demos '/*.*'

# optional
git sparse-checkout add \
  '!/llvm/test' '!/clang/test'

git sparse-checkout add \
  '/llvm/test/CodeGen/SPIRV'

# optional
git sparse-checkout add \
  '/lld' '/libunwind'

# optional
git sparse-checkout add \
  '/sysroot'

# optional
# replace `llvm-spirv` with `SPIRV-LLVM-Translator`
git sparse-checkout add \
  '!/llvm-spirv'
mkdir -p llvm-spirv

git sparse-checkout list
git checkout
popd
