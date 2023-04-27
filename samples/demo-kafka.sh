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

#Need to run export commands and local docker registry
touch /etc/containers/registries.conf.d/myregistry1.conf 

echo "[[registry]]
location = "localhost:8000"
insecure = true" > /etc/containers/registries.conf.d/myregistry.conf

pe "cd /home/ubuntu" 
pe "git clone https://github.com/leungsteve/realtime_enrichment.git"
pe "cd realtime_enrichment/otel_yamls"
pe "helm repo add bitnami https://charts.bitnami.com/bitnami"
pe "helm install kafka --set replicaCount=3 --set metrics.jmx.enabled=true --set metrics.kafka.enabled=true  --set deleteTopicEnable=true bitnami/kafka"
pe "helm install mongodb --set metrics.enabled=true bitnami/mongodb --set global.namespaceOverride=default --set auth.rootUser=root --set auth.rootPassword=splunk --set auth.enabled=false --version 12.1.31"
pe "helm list"
pe "kubectl get pods"
pe "cat kafka.values.yaml"
pe "cat mongodb.values.yaml"
pe "cat zookeeper.values.yaml"
pe "helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart"
pe "helm repo update"
pe "helm install --set provider=' ' --set distro=' ' --set splunkObservability.accessToken=$ACCESS_TOKEN --set clusterName=$clusterName --set splunkObservability.realm=$REALM --set otelCollector.enabled='false' --set splunkObservability.logsEnabled='true' --set gateway.enabled='false' --values kafka.values.yaml --values mongodb.values.yaml --values zookeeper.values.yaml --values alwayson.values.yaml --values k3slogs.yaml --generate-name splunk-otel-collector-chart/splunk-otel-collector"
pe "helm list"
pe "kubectl get pods"

pe "cd /home/ubuntu/realtime_enrichment/flask_apps/review/"
pe "cat review.py"
pe "cd /home/ubuntu/realtime_enrichment/workshop/flask_apps_start/review/"
pe "pip freeze"
pe "pip install -r requirements.txt"
pe "pip freeze"
#pe "python3 review.py"
pe "cat Dockerfile"
pe "docker build -f Dockerfile -t localhost:8000/review:0.01 ."
pe "docker push localhost:8000/review:0.01"
pe "curl -s http://localhost:8000/v2/_catalog"
pe "cat review.deployment.yaml"
pe "cat review.service.yaml"
pe "kubectl apply -f review.service.yaml -f review.deployment.yaml"
pe "kubectl get deployments"
pe "kubectl get services"
pe "curl localhost:30000"
pe "curl localhost:30000/get_review"
pe "cd ../../flask_apps_finish/review"
pe "cat Dockerfile"
pe "docker build -f Dockerfile.review -t localhost:8000/review-splkotel:0.01 ."
pe "docker push localhost:8000/review-splkotel:0.01"
pe "curl -s http://localhost:8000/v2/_catalog"
pe "cat review.deployment.yaml"
pe "kubectl apply -f review.deployment.yaml"
pe "kubectl get pods"
pei "curl localhost:30000/get_review"
pei "curl localhost:30000/get_review"
pei "curl localhost:30000/get_review"

# enters interactive mode and allows newly typed command to be executed
cmd

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
