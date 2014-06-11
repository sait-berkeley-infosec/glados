#!/bin/bash -e
# Break Things!
# NWOLD SMASH.
# Automates the process of fetching and translating
# LDAP dumps.
ROOT="/opt/glados/audits"
JAIL="/srv/sftpjail/home/audit"
RESULTS="results-$(date +%F).jtr"
JOHN="/opt/jtr"

echo "NWOLD SMASH!"
if [ -f $JAIL/*.ldif ]
then
    echo "Dump files found!"
    mkdir -p $ROOT/tmp
    # Move all LDAP dumps from the jail to the dump folder.
    mv $JAIL/*.ldif $ROOT/dumps/
    # Translate each file and append the results to a text file.
    for file in $ROOT/dumps/*.ldif
    do
        echo "Translating ${file}..."
        $ROOT/bin/translate.sh ${file} >> $ROOT/tmp/$RESULTS
    done
    #"$JOHN/run/john" "$ROOT/tmp/$RESULTS" PUT MORE COMMAND LINE STUFF HERE
fi
