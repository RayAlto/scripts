# RA-Scripts

RayAlto's Stupid Scripts

## Shell

### [Waydroid Patch](./shell/waydroid.patch.sh)

A patch makes gaming on waydroid possible (e.g. BlueArchive global version).

## CMake

### [TargetDefineRelativeFile](./cmake/TargetDefineRelativeFile.cmake)

A stupid CMake module to add a relative path version of the `__FILE__` macro named `__REL_FILE__` to all source files of the target.

## Python

### [pip.upgrade.all](./python/pip.upgrade.all)

A stupid scripy to upgrade all pip packages

### [grim.slurp.tesseract.chi_sim](./python/grim.slurp.tesseract.chi_sim)

调用 `grim -g "$(slurp)" - | tesseract - - -l eng+chi_sim` 并处理结果中多余的空格和 `\n` （比如汉字之间不需要空格，中英连接处、英文单词间则需要空格）

### [mklicense](./python/mklicense)

A stupid license generator

### [hypr-toggle-monitors](./python/hypr.toggle.monitors)

A stupid python script to toggle all monitors in [Hyprland](https://hyprland.org)

### [tachiyomi-sort-images](./python/tachiyomi-sort-images)

A stupid python script to rename all files (excluding directories) with index numbers. Used by me to organize manually-downloaded galleries from exhentai that I put in [TachiyomiSY](https://github.com/jobobby04/tachiyomisy)

### [expand-directories](./python/expand-directory)

A stupid python script to expand directory structure

### [vefiry](./python/verify)

A stupid python script to verify if image/video/zip file is broken

### [do-not-sleep](./python/do-not-sleep)

A stupid python script to prevent strange storage device from sleep

### [swaylock.blur](./python/swaylock.blur)

A stupid python script to run swaylock with gaussian blurred screenshot
