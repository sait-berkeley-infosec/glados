#!/usr/bin/python
# Break Things!
# NWOLD SMASH BASH.

import os
import sys
import subprocess

#### Variables
ROOT = "/opt/glados/audits"
JAIL = "/srv/sftpjail/home/audit"
RESULTS = "results.jtr"
CRACKED = "cracked.txt"
JOHN = "/opt/jtr"
WORDLIST = "words.lst"
DEBUG = False

for arg in sys.argv:
    if "debug" in arg:
        DEBUG = True

print "NWOLD SMAAAAAAAASH!"
subprocess.call(["mkdir", "-p", "%s/tmp" % ROOT])

if os.listdir(JAIL):
    print "New dump files found!"
    subprocess.call(["mv", "%s/*" % JAIL, "%s/dumps/" % ROOT])    

dumps = os.listdir("%s/dumps/" % ROOT)
if dumps:
    print "I can't read this garbage!"
    for f in dumps:
        print "Translating %s..." % f
        subprocess.call(["%s/bin/translate.sh" % ROOT, f,
            ">>", "%s/tmp/%s" % (ROOT, RESULTS)])
    if not DEBUG:
        print "Sic 'em, John!"
        subprocess.call(["%s/run/john" % JOHN, "--wordlist=%s/%s" % (ROOT, WORDLIST),
            "--rules", "$s/tmp/$s" % (ROOT, RESULTS)])
    else:
        print "...Where'd my dog go?! [DEBUG]"
    subprocess.call(["%s/run/john" % JOHN, "--show", "%s/tmp/%s" % (ROOT, RESULTS),
        ">", "%s/tmp/%s" (ROOT, RESULTS)])
else:
    print "Nothing to see here..."
print "DONE."
