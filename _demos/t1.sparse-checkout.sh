# git clone -n --depth=1 --filter=tree:0 -b sycl git@github.com:intel/llvm.git llvm-dpcpp
git clone -n --depth=1 --filter=tree:0 -b allen/sycl git@github.com:gglin001/llvm-dpcpp.git

pushd llvm-dpcpp
git sparse-checkout set --no-cone \
  /buildbot /clang /cmake /devops /libclc /llvm /llvm-spirv /opencl /sycl /sycl-fusion /xpti /xptifw \
  /_demos /libdevice

git sparse-checkout list
git checkout
popd
