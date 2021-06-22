# Copyright (C) 2022 PixysOS Project
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

# -----------------------------------------------------------------
# SuperiorOS OTA update package

ifneq ($(BUILD_WITH_COLORS),0)
    include $(TOP_DIR)vendor/superior/build/core/colors.mk
endif

SUPERIOR_TARGET_UPDATEPACKAGE := $(PRODUCT_OUT)/$(SUPERIOR_VERSION)-updateimages.zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: updatepackage superior-fastboot
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_UPDATE_PACKAGE_TARGET) $(SUPERIOR_TARGET_UPDATEPACKAGE)
	$(hide) $(SHA256) $(SUPERIOR_TARGET_UPDATEPACKAGE) > $(SUPERIOR_TARGET_UPDATEPACKAGE).sha256sum
	@echo -e ${CL_BLU}"                                                                                   "${CL_BLU}
	@echo -e ${CL_BLU}"███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗ ██████╗ ██████╗      ██████╗ ███████╗ "${CL_BLU}
	@echo -e ${CL_BLU}"██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║██╔═══██╗██╔══██╗    ██╔═══██╗██╔════╝ "${CL_BLU}
	@echo -e ${CL_BLU}"███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║██║   ██║██████╔╝    ██║   ██║███████╗ "${CL_BLU}
	@echo -e ${CL_BLU}"╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██╔══██╗    ██║   ██║╚════██║ "${CL_BLU}
	@echo -e ${CL_BLU}"███████║╚██████╔╝██║     ███████╗██║  ██║██║╚██████╔╝██║  ██║    ╚██████╔╝███████║ "${CL_BLU}
	@echo -e ${CL_BLU}"╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝     ╚═════╝ ╚══════╝ "${CL_BLU}
	@echo -e ${CL_BLU}"                                                                                   "${CL_BLU}
	@echo -e ${CL_RED}"                  Your fastboot package is ready to be flashed!                    "${CL_RST}
	@echo -e ${CL_CYN}"================================-Package Details-===================================${CL_RST}
	@echo -e ${CL_CYN}"Zip            : "${CL_MAG} $(SUPERIOR_TARGET_UPDATEPACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"MD5            : "${CL_MAG}" $(shell cat $(SUPERIOR_TARGET_UPDATEPACKAGE).sha256sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size           : "${CL_MAG}" $(shell du -hs $(SUPERIOR_TARGET_UPDATEPACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size(in bytes) : "${CL_MAG}" $(shell wc -c $(SUPERIOR_TARGET_UPDATEPACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"==================================================================================="${CL_RST}
	@echo -e ""

superior-fastboot: updatepackage