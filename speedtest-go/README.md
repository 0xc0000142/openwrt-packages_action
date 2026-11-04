# openwrt-speedtest-go

## Releases
You can find the prebuilt-ipks [here](https://fantastic-packages.github.io/releases/) 

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
git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/openwrt-speedtest-go.git package/speedtest-go
pushd package/speedtest-go
umask 022
git checkout
popd
# Select the package Network -> speedtest-go
make menuconfig
# Start compiling
make package/speedtest-go/compile V=99
```
