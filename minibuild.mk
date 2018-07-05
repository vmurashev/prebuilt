# How-to:
# To build and collect binararies in zip file
# just run the following command from this directory:
#
#    python -m minibuild --pass
#
# Build results:
#     prebuilt-macosx.zip
#     prebuilt-linux.zip
#     prebuilt-windows.zip
#
# P.S.
#    On MacOSX:  clang is enough
#    On Linux:   crosstools must be configured properly in ~/x-tools
#    On Windows: MinGW is supposed to be in C:\mingw-w64

#pragma build

#pragma os:linux toolset module=mingw package='~/x-tools/x86_64-w64-mingw32' prefix=x86_64-w64-mingw32- arch=x86,x86_64

#pragma os:linux toolset module=xtools package='~/x-tools/i686-unknown-linux-gnu'        prefix=i686-unknown-linux-gnu-        arch=x86
#pragma os:linux toolset module=xtools package='~/x-tools/x86_64-unknown-linux-gnu'      prefix=x86_64-unknown-linux-gnu-      arch=x86_64
#pragma os:linux toolset module=xtools package='~/x-tools/arm-unknown-linux-gnueabi'     prefix=arm-unknown-linux-gnueabi-     arch=arm
#pragma os:linux toolset module=xtools package='~/x-tools/aarch64-unknown-linux-gnueabi' prefix=aarch64-unknown-linux-gnueabi- arch=arm64

#pragma os:macosx toolset module=clang

#pragma os:windows toolset module=mingw package='C:\mingw-w64\i686-5.4.0-win32-dwarf-rt_v5-rev0\mingw32' arch=x86
#pragma os:windows toolset module=mingw package='C:\mingw-w64\x86_64-5.4.0-win32-seh-rt_v5-rev0\mingw64' arch=x86_64

# MacOSX
#pragma os:macosx pass cmdline='--model clang-macosx-x86_64 --directory prebuilt'
#pragma os:macosx pass interpreter=1  cmdline='pack_libs_and_headers.py \
# --abi x86_64 --directory output/obj/prebuilt/clang-macosx-x86_64/release \
# --zipname prebuilt-macosx.zip'

# Linux
#pragma os:linux pass cmdline='--model gcc-xt-linux-x86_64 --directory prebuilt'
#pragma os:linux pass cmdline='--model gcc-xt-linux-x86    --directory prebuilt'
#pragma os:linux pass cmdline='--model gcc-xt-linux-arm    --directory prebuilt'
#pragma os:linux pass cmdline='--model gcc-xt-linux-arm64  --directory prebuilt'
#pragma os:linux pass interpreter=1  cmdline='pack_libs_and_headers.py \
# --abi x86_64 x86 arm arm64 --directory \
# output/obj/prebuilt/gcc-xt-linux-x86_64/release \
# output/obj/prebuilt/gcc-xt-linux-x86/release \
# output/obj/prebuilt/gcc-xt-linux-arm/release \
# output/obj/prebuilt/gcc-xt-linux-arm64/release \
# --zipname prebuilt-linux.zip'

# Windows
#pragma os:windows pass cmdline='--model mingw-win32 --directory prebuilt'
#pragma os:windows pass cmdline='--model mingw-win64 --directory prebuilt'
#pragma os:windows pass interpreter=1  cmdline='pack_libs_and_headers.py \
# --abi x86 x86_64 --directory \
# output/obj/prebuilt/mingw-win32/release \
# output/obj/prebuilt/mingw-win64/release \
# --zipname prebuilt-windows.zip'
