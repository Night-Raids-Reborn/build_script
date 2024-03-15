rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init -u https://github.com/Project-PixelStar/manifest -b 14 --git-lfs --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault

# Do remove here before repo sync.
rm -rf hardware
rm -rf vendor
rm -rf system
rm -rf kernel
rm -rf device
rm -rf packages
rm -rf prebuilts/clang/host/linux-x86
rm -rf prebuilts
rm -rf out/host

# Clone our local manifest.
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 14-n-common .repo/local_manifests

# Let's sync!
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# Do remove here after repo sync.
rm -rf hardware/xiaomi
rm -rf packages/resources/devicesettings
rm -rf packages/apps/Settings
rm -rf vendor/pixelstar
rm -rf device/pixelstar/sepolicy
rm -rf build/make

# Do clone here after repo sync.
git clone https://github.com/Night-Raids-Reborn/hardware_xiaomi -b udc hardware/xiaomi
git clone https://github.com/PixelExperience/packages_resources_devicesettings -b fourteen packages/resources/devicesettings

#Fork
git clone https://github.com/Night-Raids-Reborn/pixelstar_packages_apps_Settings -b 14 packages/apps/Settings
git clone https://github.com/Night-Raids-Reborn/vendor_pixelstar -b 14 vendor/pixelstar
git clone https://github.com/Night-Raids-Reborn/device_pixelstar_sepolicy -b 14 device/pixelstar/sepolicy
git clone https://github.com/Night-Raids-Reborn/build_pixelstar -b 14 build/make
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
. build/envsetup.sh
lunch pixelstar_citrus-userdebug
mka bacon

# Let's start build for lime!
. build/envsetup.sh
lunch pixelstar_lime-userdebug
mka bacon
