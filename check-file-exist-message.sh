#!/bin/bash

#set this bundle name and then generate tar file.
export TARGET_TAR_NAME='cluster-essentials-bundle'
export TARGET_TAR_VERSION=1.2.0
export bundle_sha="registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:e00f33b92d418f49b1af79f42cb13d6765f1c8c731f4528dfff8343af042dc3e"

echo "TARGET_TAR_NAME: $TARGET_TAR_NAME"
echo "TARGET_TAR_VERSION: $TARGET_TAR_VERSION"
echo "BUNDLE: $bundle_sha"
#condition of generation...
function echo_found() {
  message=${1:-"skipping"}
  echo -e "\033[1;32mfound\033[0m, $message"
}

function echo_notfound() {
  message=${1:-"creating"}
  echo -e "\033[1;32mnot found\033[0m, $message"
}

# check and download tar file.
export file=$TARGET_TAR_NAME-$TARGET_TAR_VERSION.tar
echo "target file name: $file"

if [ -f "$file" ]; then
  echo_found "file exist,skipping generate tar file."
else
  echo_notfound "generating tar..."
  imgpkg copy \
      -b $bundle_sha \
      --to-tar $file \
      --include-non-distributable-layers
fi
