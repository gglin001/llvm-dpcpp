###############################################################################

args=(
  buildbot/configure.py
  --use-lld
  --native_cpu
  --host-target="host;RISCV;AArch64"
  --cmake-opt="-DFETCHCONTENT_BASE_DIR=$PWD/_demos/_deps_osx"
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
)
python "${args[@]}"

python buildbot/compile.py

###############################################################################
