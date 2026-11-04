openwrt-php-nginx
=================

## Releases
You can find the prebuilt-ipks [here](https://fantastic-packages.github.io/releases/)

## Build

```shell
# Take the x86_64 platform as an example
tar xjf openwrt-sdk-21.02.3-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
# Go to the SDK root dir
cd OpenWrt-sdk-*-x86_64_*
# First run to generate a .config file
make menuconfig
./scripts/feeds update -a
./scripts/feeds install -a
# Get Makefile
git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/openwrt-php-nginx.git package/php-nginx
pushd package/php-nginx
umask 022
git checkout
popd
# Select the package Network -> php-nginx
make menuconfig
# Start compiling
make package/php-nginx/compile V=99
```

## License

- This project is licensed under the MIT license
