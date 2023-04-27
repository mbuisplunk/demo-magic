#!/usr/bin/env bash

#################################
# include the -=magic=-
# you can pass command line args
#
# example:
# to disable simulated typing
# . ../demo-magic.sh -d
#
# pass -h to see all options
#################################
. ../demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

# text color
# DEMO_CMD_COLOR=$BLACK

# hide the evidence
clear

# enters interactive mode and allows newly typed command to be executed
cmd

pe "cd /home/ubuntu" 
pe "git clone https://github.com/leungsteve/realtime_enrichment.git"
pe "cd realtime_enrichment/otel_yamls"
pe "python3 -m venv rtapp-workshop"
pe "source rtapp-workshop/bin/activate"
pe "helm repo add bitnami https://charts.bitnami.com/bitnami"
pe "helm install kafka --set replicaCount=3 --set metrics.jmx.enabled=true --set metrics.kafka.enabled=true  --set deleteTopicEnable=true bitnami/kafka"
pe "helm install mongodb --set metrics.enabled=true bitnami/mongodb --set global.namespaceOverride=default --set auth.rootUser=root --set auth.rootPassword=splunk --set auth.enabled=false --version 12.1.31"
pe "helm list"
pe "kubectl get pods"
pei "cat kafka.values.yaml"
pei "cat mongodb.values.yaml"
pei "cat zookeeper.values.yaml"
pe "cd /home/ubuntu/realtime_enrichment/otel_yamls/"
pe "helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart"
pe "helm repo update"
pe "helm install --set provider=' ' --set distro=' ' --set splunkObservability.accessToken=$ACCESS_TOKEN --set clusterName=$clusterName --set splunkObservability.realm=$REALM --set otelCollector.enabled='false' --set splunkObservability.logsEnabled='true' --set gateway.enabled='false' --values kafka.values.yaml --values mongodb.values.yaml --values zookeeper.values.yaml --values alwayson.values.yaml --values k3slogs.yaml --generate-name splunk-otel-collector-chart/splunk-otel-collector"
pe "helm list"
pe "kubectl get pods"

# enters interactive mode and allows newly typed command to be executed
cmd

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
