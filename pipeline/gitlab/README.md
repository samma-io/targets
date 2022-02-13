# Gitlab 

This is a demo project showing how you can deploy scanner into the cluster



## Req
- Gitlab
- Kubernets cluster
- Samma Operator installed
- Gitlab Runners has access to the Kubernetes cluster


## Install
Add the folder into your own repo in gitlab. Then alter the gitlab CI file to match your settings


```
image: docker:19.03.13


#
#
#  Bellow is i guess i dont know the gitlab settings so you need to alter bellow to match your gitlab 
#

variables:
  DOCKER_HOST: tcp://docker:2375
  DOCKER_TLS_CERTDIR: ""
  DOCKER_DRIVER: overlay2


services:
  - docker:19.03.13-dind
build_docker_helm-kubectl:
  stage: deploy
  image: sammascanner/pipeline
  script:
  - | 
    #Lets genereate the targets
    ./addScanner.sh
    #Lets add the scanners in the deploy folder
    #kubectl apply -f deploy/
```


## Docker used
To run the commands you need a docker container that exec the commands.
That docker need to have the correct tools.

Here we use the docker provide by samma.

*If you want to build your own see docker repo one folder up.*


## Usage
Alter the file targets.csv and add the targets you want to scan


```
10.100.0.1|'nmap'
10.100.0.2|'nmap'
10.100.0.3|'nmap'
10.100.0.4|'nmap,tsunami'
```



## Extend
If you need to functions update the addScanner.sh script 


```
#!/bin/bash
#
# Bash script that from a target.csv file adds scanners to the cluster
#
#
INPUT=targets.cvs
OLDIFS=$IFS
IFS='|'
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read target scanner
do
	name=${target//[.]/-}
	export "TARGET=$target"
	export "SCANNER=$scanner"
	export "NAME=$name"
	echo "Generte Scanner file for $name using scanners $scanner and target $target"
	envsubst '${TARGET} ${SCANNER} ${NAME}' < tpl/scanner.tpl > deploy/scanner-$name.yaml

done < $INPUT
IFS=$OLDIFS
```
