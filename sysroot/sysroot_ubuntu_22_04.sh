###############################################################################

args=(
  -v $PWD:/work
  -w /work
  ubuntu:22.04
)
docker run --rm -it "${args[@]}"

###############################################################################

apt update

apt install --no-install-recommends libc-dev
apt install --no-install-recommends libstdc++-11-dev

###############################################################################

mkdir -p sysroot/aarch64-unknown-linux-gnu
mkdir -p sysroot/aarch64-unknown-linux-gnu/lib

cp -r /usr/include sysroot/aarch64-unknown-linux-gnu/
cp -r /lib/gcc sysroot/aarch64-unknown-linux-gnu/lib/
cp -r /lib/aarch64-linux-gnu sysroot/aarch64-unknown-linux-gnu/lib/
cp /lib/ld-linux-aarch64.so.1 sysroot/aarch64-unknown-linux-gnu/lib/

mkdir -p sysroot/aarch64-unknown-linux-gnu/usr/lib/aarch64-linux-gnu
cp /usr/lib/aarch64-linux-gnu/libc_nonshared.a sysroot/aarch64-unknown-linux-gnu/usr/lib/aarch64-linux-gnu/

###############################################################################
