# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=OSS Kernel | ROSEMARY
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=rosemary
device.name2=rosemary_p
device.name3=secret
device.name4=maltose
supported.versions=12-16
'; } # end properties

# shell variables
block="/dev/block/bootdevice/by-name/boot";
is_slot_device=auto;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions / ownership for included ramdisk files
set_perm_recursive 0 0 750 750 "$ramdisk/*";
set_perm_recursive 0 0 750 750 "$ramdisk/init*" "$ramdisk/sbin";

# Apply Image & dtbo
mv kernels/Image.gz-dtb Image.gz-dtb;

## AnyKernel install
dump_boot;

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d "$ramdisk/overlay" ]; then rm -rf "$ramdisk/overlay"; fi

write_boot;
## end install
