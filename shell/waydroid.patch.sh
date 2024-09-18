#!/usr/bin/env bash
#
# source (Github @qwerty12356-wart):
#   - patch for libhoudini: https://github.com/waydroid/waydroid/issues/788#issuecomment-2162386712
#   - patch for libndk_translation: https://github.com/waydroid/waydroid/issues/788#issuecomment-2167334937

if ! command -v xxd > /dev/null; then
  echo 'xxd not fount, please install vim or tinyxxd'
  exit 1
fi

if [ "$EUID" != 0 ]; then
  echo 'Please run with root.' >&2
  exit 1
fi

HOUDINI_SKIP=0x100000
NDK_SKIP=0x101000

HOUDINI_PATH="/var/lib/waydroid/overlay/system/lib64/libhoudini.so"
NDK_PATH="/var/lib/waydroid/overlay/system/lib64/libndk_translation.so"

function check_hex() {
# file path, ghidra offset, hex to check, skip offset (0x100000 for libhoudini, 0x101000 for libndk_translation)
curr_val="$(od $1 --skip-bytes=$(($2 - $4)) --read-bytes=$((${#3} / 2)) --endian=little -t x1 -An file | sed 's/ //g')"
if [ "$curr_val" = "$3" ]; then
  return 0
else
  return 1
fi
}

function patch_hex() {
# file path, ghidra offset, original hex, new hex, skip offset
file_offset=$(($2 - $5))
if check_hex $1 $2 $3 $5; then
  hexinbin=$(printf $4 | xxd -r -p)
  echo -n $hexinbin | dd of=$1 seek=$file_offset bs=1 conv=notrunc;
  echo "Patched $1 at $file_offset with new hex $4"
elif check_hex $1 $2 $4 $5; then
  echo "Already patched"
else
  echo "Hex mismatch!"
fi
}

if [ -f $HOUDINI_PATH ]; then
  echo "Processing $HOUDINI_PATH..."
  patch_hex $HOUDINI_PATH 0x4062a5 48b8fbffffff 48b8ffffffff $HOUDINI_SKIP
  patch_hex $HOUDINI_PATH 0x4099d6 83e0fb 83e0ff $HOUDINI_SKIP
  patch_hex $HOUDINI_PATH 0x409b42 e8892feeff 9090909090 $HOUDINI_SKIP
fi

if [ -f $NDK_PATH ]; then
  echo "Processing $NDK_PATH..."
  patch_hex $NDK_PATH 0x307dd1 83e2fa 83e2ff $NDK_SKIP
  patch_hex $NDK_PATH 0x307cd6 83e2fa 83e2ff $NDK_SKIP
fi
