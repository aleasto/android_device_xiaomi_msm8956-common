#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e -u -o pipefail

# Required!
export VENDOR="xiaomi"
export DEVICE="kenzo"
export DEVICE_COMMON="msm8956-common"
export DEVICE_BRINGUP_YEAR=2016

MY_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

${MY_DIR}/../extract-files.sh $@

LINEAGE_ROOT=$(readlink -f "${MY_DIR}/../../../..")
BLOB_ROOT="${LINEAGE_ROOT}/vendor/${VENDOR}/${DEVICE}/proprietary"

# Blob fixups
for fixup in $(find "${MY_DIR}/proprietary-files-fixups/" -name '*.sh'); do
	blob_name=$(basename "${fixup}" | sed -e 's|\(.*\).sh|\1|g' -e 's|#|/|g')
	echo "Fixing up ${blob_name}"
	${fixup} "${BLOB_ROOT}/${blob_name}"
done
