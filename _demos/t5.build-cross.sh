###############################################################################

cmake --preset osx_allen -S$PWD/llvm -B$PWD/build

cmake --build $PWD/build --target all
# cmake --build $PWD/build --target distribution

cmake --build $PWD/build --target help >_demos/cmake.target.help.log

###############################################################################

cmake --preset cross_allen -S$PWD/llvm -B$PWD/build-cross

# cmake --build $PWD/build-cross --target all
cmake --build $PWD/build-cross --target libsycldevice
cmake --build $PWD/build-cross --target libsycl.so

cmake --build $PWD/build-cross --target help >_demos/cmake.build-cross.log

###############################################################################

# find build-cross/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} echo {}
find build-cross/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-cross/lib/{} $PWD/build/lib/

###############################################################################
