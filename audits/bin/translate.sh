#!/usr/bin/awk -f
# Translator Shell Script
# Takes an LDAP dump and looks for two provided
# columns: the username and the password.
# Returns a list of all usernames and passwords
# so that John the Ripper can read it.
BEGIN {
    username="^uid:.*$";
    password="^userPassword:.*$";
    shell="^loginShell:.*$";
    cur_user = "nil";
    cur_pass = "nil";
    cur_shell = "nil";
    OFS=":";
    badShells["/usr/local/rescomp/sbin/badpassword"] = 1;
    badShells["/sbin/nologin"] = 1;
    badShells["/home/relay/bin/noshell"] = 1;
    badShells["/usr/sbin/nologin"] = 1;
    badShells["nil"] = 1;
}
{
    if ($0 ~ username) {
        if (cur_user == "nil") {
            cur_user = $2;
        } else {
            if (cur_user != "nil" && cur_pass != "nil" && !(cur_shell in badShells)) {
                print cur_user, cur_pass;
            }
            cur_user = $2;
            cur_pass = "nil";
            cur_shell = "nil";
        }
    }
    if ($0 ~ password) {
        cmd = "echo "$2" | base64 --decode";
        cmd | getline cur_pass;
        close(cmd);
    }
    if ($0 ~ shell) {
        cur_shell = $2;
    }
}
