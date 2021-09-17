#!/bin/bash
sleep ${7}s
echo "prometheus_afterburner_exporter -host=${1} -port=${2} -username=${3} -password=${4} -listen-address=${5} -metrics-endpoint=${6}" | at now
