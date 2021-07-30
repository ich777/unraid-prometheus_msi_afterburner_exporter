#!/bin/bash
((count = 200))
while [[ $count -ne 0 ]] ; do
    ping -c 1 $1 -q
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))
    fi
    ((count = count - 1))
done

if [[ $rc -eq 0 ]] ; then
    echo "prometheus_afterburner_exporter -host=${1} -port=${2} -username=${3} -password=${4} -listen-address=${5} -metrics-endpoint=${6} 2>/dev/null" | at now
    echo running
else
    echo stopped
fi
