PRODUCT_BRAND ?= aosp

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Pyxis.ogg \
    ro.config.notification_sound=Merope.ogg \
    ro.config.alarm_alert=Scandium.ogg

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Input Method
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/app/GooglePinyinIME.apk:system/app/GooglePinyinIME.apk \
    vendor/aosp/prebuilt/common/lib/libgnustl_shared.so:system/lib/libgnustl_shared.so \
    vendor/aosp/prebuilt/common/lib/libhwr.so:system/lib/libhwr.so \
    vendor/aosp/prebuilt/common/lib/libjni_delight.so:system/lib/libjni_delight.so \
    vendor/aosp/prebuilt/common/lib/libjni_googlepinyinime_latinime_5.so:system/lib/libjni_googlepinyinime_latinime_5.so \
    vendor/aosp/prebuilt/common/lib/libjni_hmm_shared_engine.so:system/lib/libjni_hmm_shared_engine.so \
    vendor/aosp/prebuilt/common/lib/libpinyin_data_bundle.so:system/lib/libpinyin_data_bundle.so

# Extra packages
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/app/RootExplorer.apk:system/app/RootExplorer.apk \
    vendor/aosp/prebuilt/common/app/Sweep2Wake.apk:system/app/Sweep2Wake.apk

# Required packages
PRODUCT_PACKAGES += \
    LatinIME \
    Superuser \
    su

# Optional packages
PRODUCT_PACKAGES += \
    AndroidTerm \
    EVToolbox

# Backup Transport
PRODUCT_PACKAGE_OVERLAYS += vendor/aosp/overlay/common

# Disable strict mode
ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.disable=true

# Version Info
PRODUCT_VERSION_MAJOR = 3
PRODUCT_VERSION_MINOR = 2
PRODUCT_VERSION_MAINTENANCE = 0

# Allow overriding p1/2 etc from commandline
ifneq "" "$(DEVICE_VERSION_OVERRIDE)"
  PRODUCT_VERSION_EXTRA = $(DEVICE_VERSION_OVERRIDE)
else
  PRODUCT_VERSION_EXTRA = $(PRODUCT_VERSION_DEVICE_SPECIFIC)
endif

ifeq ($(NIGHTLY_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-nightly-$(shell date +%Y.%m.%d)
else ifeq ($(TESTING_BUILD),true)
  ROM_VERSION := $(TARGET_PRODUCT)-testing-$(shell date +%Y.%m.%d)
else
  ROM_VERSION := $(TARGET_PRODUCT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_EXTRA)-$(PRODUCT_CODENAME)
endif

ROM_VERSION := $(shell echo ${ROM_VERSION} | tr [:upper:] [:lower:])

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.romversion=$(ROM_VERSION)
