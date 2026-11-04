# openwrt-chinadns-ng

## Releases
You can find the prebuilt-ipks [here](https://fantastic-packages.github.io/packages/) 

## Build

```shell
# Take the x86_64 platform as an example
tar xjf openwrt-sdk-22.03.5-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
# Go to the SDK root dir
cd OpenWrt-sdk-*-x86_64_*
# First run to generate a .config file
make menuconfig
./scripts/feeds update -a
./scripts/feeds install -a
# Get Makefile
git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/openwrt-chinadns-ng.git package/chinadns-ng
pushd package/chinadns-ng
umask 022
git checkout
popd
# Select the package Network -> chinadns-ng
make menuconfig
# Start compiling
make package/chinadns-ng/compile V=99
```
