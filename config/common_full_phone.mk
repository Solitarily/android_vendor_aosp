# Inherit common stuff
$(call inherit-product, vendor/aosp/config/common.mk)
$(call inherit-product, vendor/aosp/config/common_full.mk)

PRODUCT_PACKAGES += \
    Mms \
    Torch \
    CellBroadcastReceiver

