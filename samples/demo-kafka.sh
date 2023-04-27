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

# put your demo awesomeness here
if [ ! -d "stuff" ]; then
  pe "mkdir stuff"
fi

pe "cd "
pe "cd /home/ubuntu" 
pe "git clone https://github.com/leungsteve/realtime_enrichment.git"
pe "cd realtime_enrichment/otel_yamls"
pe "python3 -m venv rtapp-workshop"
pe "source rtapp-workshop/bin/activate"

# print and execute: cd stuff
pe "helm repo add bitnami https://charts.bitnami.com/bitnami"

# ctl + c support: ctl + c to stop long-running process and continue demo
pe "helm install kafka --set replicaCount=3 --set metrics.jmx.enabled=true --set metrics.kafka.enabled=true  --set deleteTopicEnable=true bitnami/kafka"

# print and execute: echo 'hello world' > file.txt
pe "helm install mongodb --set metrics.enabled=true bitnami/mongodb --set global.namespaceOverride=default --set auth.rootUser=root --set auth.rootPassword=splunk --set auth.enabled=false --version 12.1.31"

pe "helm list"

pe "kubectl get pods"

# wait max 3 seconds until user presses
PROMPT_TIMEOUT=3
wait

# print and execute immediately: ls -l
pei "ls -l"
# print and execute immediately: cat file.txt
pei "cat file.txt"

# and reset it to manual mode to wait until user presses enter
PROMPT_TIMEOUT=0

# print only
p "cat \"something you want to pretend to run\""

# run command behind
cd .. && rm -rf stuff

# enters interactive mode and allows newly typed command to be executed
cmd

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
