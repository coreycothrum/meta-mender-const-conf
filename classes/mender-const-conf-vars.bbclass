################################################################################
MENDER/CONST_CONF_DOCKER_IMG_DATA_DIR   ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/conf.d/docker/images"
MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/conf.d/hostnamed"
MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR  ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/conf.d/networkd"
MENDER/CONST_CONF_RSYSLOG_CONF_DATA_DIR  ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/conf.d/rsyslog"

################################################################################
MENDER/CONST_CONF_SSL_CONF_DATA_DIR      ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/ssl"
MENDER/CONST_CONF_SSL_CONF_SYS__DIR      ?= "${sysconfdir}/ssl"
MENDER/CONST_CONF_SSL_SELF_CERT_NAME     ?= "self_ca"

################################################################################
MENDER/CONST_CONF_SSH__CONF_DATA_DIR     ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/ssh"
MENDER/CONST_CONF_SSHD_CONF_DATA_DIR     ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/sshd"
MENDER/CONST_CONF_SSH__CONF_SYS__DIR     ?= "${localstatedir}/run/ssh"
MENDER/CONST_CONF_SSHD_CONF_SYS__DIR     ?= "${localstatedir}/run/sshd"

################################################################################
MENDER/CONST_CONF_JOURNALD_LOG_SYS__DIR  ?= "${localstatedir}/log/journal"
MENDER/CONST_CONF_JOURNALD_LOG_DATA_DIR  ?= "${MENDER_DATA_PART_MOUNT_LOCATION}/log/journal"
################################################################################
#FIXME - this should be in mender-core
MENDER_DATA_PART_MOUNT_LOCATION           = "/data"
################################################################################
