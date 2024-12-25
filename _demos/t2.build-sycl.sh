###############################################################################

ln -s $PWD/sycl/CMakePresets.json $PWD/llvm/CMakePresets.json

###############################################################################

cmake --preset linux -S$PWD/llvm -B$PWD/build

cmake --build $PWD/build --target all
# cmake --build $PWD/build --target distribution

cmake --build $PWD/build --target help >_demos/cmake.target.help.log

###############################################################################

cmake --preset sycl -S$PWD/llvm -B$PWD/build-sycl

# cmake --build $PWD/build-sycl --target all
cmake --build $PWD/build-sycl --target libsycldevice
cmake --build $PWD/build-sycl --target libsycl.so
cmake --build $PWD/build-sycl --target libsycl-preview.so

cmake --build $PWD/build-sycl --target help >_demos/cmake.sycl.target.help.log

###############################################################################

# TODO: can we use `-sycl-device-library-location` in CMD ?

# find build-sycl/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} echo {}
find build-sycl/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/

###############################################################################
