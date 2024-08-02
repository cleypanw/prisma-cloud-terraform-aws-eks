#!/bin/bash

pc_twistlock_end_point_url=$1
pc_token=$2
pc_console_url=$3

curl -s --location ${pc_twistlock_end_point_url}/api/v32.07/defenders/daemonset.yaml --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'x-redlock-auth: '${pc_token}'' --data '{
   "orchestration": "container",
   "consoleAddr": "'${pc_console_url}'",
   "containerRuntime": "containerd",
   "namespace": "twistlock"
}' -o daemonset.yaml