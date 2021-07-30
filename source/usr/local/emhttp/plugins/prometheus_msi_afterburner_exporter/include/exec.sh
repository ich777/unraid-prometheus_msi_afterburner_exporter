#!/bin/bash

function get_msi_hostname(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "msi_hostname=" | cut -d '=' -f2-)"
}

function get_msi_port(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "msi_port=" | cut -d '=' -f2-)"
}

function get_msi_username(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "msi_username=" | cut -d '=' -f2-)"
}

function get_msi_password(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "msi_password=" | cut -d '=' -f2-)"
}

function get_exporter_address(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "export-listen-address=" | cut -d '=' -f2-)"
}

function get_exporter_endpoint(){
echo -n "$(cat /boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg | grep "export-metrics-endpoint=" | cut -d '=' -f2-)"
}

function change_msi_settings(){
sed -i "/msi_hostname=/c\msi_hostname=${1}" "/boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg"
sed -i "/msi_port=/c\msi_port=${2}" "/boot/config/plugins/prometheus_msi_afterburner_exporter/settings.cfg"
if [ ! -z "$(pgrep -f prometheus_afterburner_exporter_init.sh)" ]; then
  kill $(pgrep -f prometheus_afterburner_exporter_init.sh)
fi
kill $(pidof prometheus_afterburner_exporter)
echo -n "$(echo "/usr/bin/prometheus_afterburner_exporter -host=$1 -port=$2 -username=$3 -password=$4 -listen-address=$5 -metrics-endpoint=$6" | at now)"
}

function get_status(){
if [ ! -z "$(pgrep -f prometheus_afterburner_exporter_init.sh)" ]; then
  echo -e "starting"
elif [ ! -z "$(pidof prometheus_afterburner_exporter)" ]; then
  echo -e "running"
else
  echo "stopped"
fi
}

function start(){
echo -n "$(echo "/usr/bin/prometheus_afterburner_exporter -host=$1 -port=$2 -username=$3 -password=$4 -listen-address=$5 -metrics-endpoint=$6" | at now)"
}

function stop_exporter(){
echo -n "$(kill $(pidof prometheus_afterburner_exporter))"
}

$@
