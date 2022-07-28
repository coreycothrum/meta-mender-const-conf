FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += "systemd-hostnamed-watcher"

SRC_URI        += "                                                         \
                    file://systemd-hostnamed.service.conf                   \
                  "
FILES:${PN}    += "                                                         \
                    ${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/*           \
                    ${systemd_unitdir}/system/systemd-hostnamed.service.d/* \
                  "

do_install:append() {
  echo "overlay \
${sysconfdir}/systemd/network overlay defaults,nofail,lowerdir=${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}:\
${sysconfdir}/systemd/network,\
x-systemd.requires=${MENDER_DATA_PART_MOUNT_LOCATION},x-systemd.requires=/ \
0 0" \
>> ${D}${sysconfdir}/fstab

  install -d                                                ${D}${systemd_unitdir}/system/systemd-hostnamed.service.d/
  install -m 0644 ${WORKDIR}/systemd-hostnamed.service.conf ${D}${systemd_unitdir}/system/systemd-hostnamed.service.d/

  install -d                                 ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}
  mv              ${D}${sysconfdir}/hostname ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname
  ln      -rs                                ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname ${D}${sysconfdir}/hostname
}
