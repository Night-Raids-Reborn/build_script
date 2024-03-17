rm -rf .repo/local_manifests

# Do repo init for rom that we want to build.
repo init -u https://github.com/SuperiorExtended/manifest -b UDC --git-lfs --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault

# Do remove here before repo sync.
rm -rf prebuilts/clang/host/linux-x86
rm -rf out/host

# Clone our local manifest.
git clone https://github.com/Night-Raids-Reborn/local_manifest --depth 1 -b 14-n-common .repo/local_manifests

# Let's sync!
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# Do remove here after repo sync.
rm -rf packages/resources/devicesettings

# Do clone here after repo sync.
git clone https://github.com/PixelExperience/packages_resources_devicesettings -b fourteen packages/resources/devicesettings
    
# Define timezone
export TZ=Asia/Jakarta

# Let's start build!
. build/envsetup.sh
lunch superior_citrus-userdebug
mka bacon
