#!/bin/bash -e
# Break Things!
# NWOLD SMASH.
# Automates the process of fetching and translating
# LDAP dumps.
ROOT="/opt/glados/audits"
JAIL="/srv/sftpjail/home/audit"
RESULTS="results-$(date +%F).jtr"
JOHN="/opt/jtr"
WORDLIST="/words.lst"
NEW=0
DUMPS=0

echo "NWOLD SMASH!"
if [ -f $JAIL/*.ldif ]
then
    NEW=1
fi
if [ -f $ROOT/dumps/*.ldif ]
then
    DUMPS=1
fi
if [ $NEW==1 ] || [ $DUMPS==1 ]
then
    echo "Dump files found!"
    mkdir -p $ROOT/tmp
    # Move all LDAP dumps from the jail to the dump folder.
    if [ "$NEW" -gt "1" ]
    then
        mv $JAIL/*.ldif $ROOT/dumps/
    fi
    # Translate each file and append the results to a text file.
    for file in $ROOT/dumps/*.ldif
    do
        echo "Translating ${file}..."
        $ROOT/bin/translate.sh ${file} >> $ROOT/tmp/$RESULTS
    done
    $JOHN/run/john --wordlist=$ROOT/$WORDLIST --rules $ROOT/tmp/$RESULTS
    $JOHN/run/john --show $ROOT/tmp/$RESULTS
fi
