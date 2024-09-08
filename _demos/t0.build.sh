###############################################################################

python buildbot/configure.py --use-lld --native_cpu \
  --cmake_opt "FETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"

python buildbot/compile.py

###############################################################################

python buildbot/configure.py --use-lld --native_cpu \
  --cmake_opt "FETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_linux"

python buildbot/compile.py

###############################################################################

python buildbot/configure.py \
  --use-lld \
  --host-target "host;RISCV;AArch64" \
  --native_cpu

python buildbot/compile.py

###############################################################################
