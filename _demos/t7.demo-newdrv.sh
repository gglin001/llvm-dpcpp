# sycl/test/native_cpu/vector-add.cpp

###############################################################################

DIR=_demos/t7.demo-newdrv && mkdir -p $DIR
PPWD=$PWD && pushd $DIR
args=(
  -fsycl
  -fsycl-targets=spir64
  # -fsycl-targets=spirv64
  # -fsycl-targets=native_cpu
  #
  -fuse-ld=lld
  #
  # -isystem $PPWD/build-sycl/include
  # -L$PPWD/build-sycl/lib
  #
  # -fsycl-device-only
  -fno-sycl-use-footer
  #
  -O0
  # -O1
  # -O2
  # -O3
  #
  # -v
  -save-temps=obj
  # -fsycl-dump-device-code=.
  #
  # -g
  # -Xspirv-translator --spirv-debug-info-version=ocl-100
  # -Xspirv-translator -spirv-ext=-all
  #
  --offload-new-driver
  --offload-link
  #
  -o main
  $PPWD/sycl/test/native_cpu/vector-add.cpp
)
clang++ "${args[@]}" 2>&1 | tee build.log
# SYCL_DEVICELIB_NO_FALLBACK=1 \
#   clang++ "${args[@]}" 2>&1 | tee build.log
popd

exit

###############################################################################

DIR=_demos/t7.demo-newdrv && mkdir -p $DIR
find $DIR/*.spv -print0 | xargs -0 -I{} spirv-dis {} -o {}asm

###############################################################################
