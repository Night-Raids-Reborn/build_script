rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init -u https://github.com/AfterLifePrjkt13/android_manifest.git -b LTS --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault

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
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 13-n .repo/local_manifests

# Let's sync!
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# Do remove here after repo sync.
rm -rf packages/resources/devicesettings
rm -rf vendor/qcom/opensource/vibrator

# Do clone here after repo sync.
git clone https://github.com/PixelExperience/packages_resources_devicesettings -b thirteen packages/resources/devicesettings
git clone https://github.com/Night-Raids-Reborn/android_vendor_qcom_opensource_vibrator -b thirteen vendor/qcom/opensource/vibrator
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
. build/envsetup.sh
lunch afterlife_citrus-userdebug
m afterlife
