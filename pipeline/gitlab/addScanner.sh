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