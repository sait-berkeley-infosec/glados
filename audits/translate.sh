#!/usr/bin/awk -f
# Translator Shell Script
# Takes an LDAP dump and looks for two provided
# columns: the username and the password.
# Returns a list of all usernames and passwords
# so that John the Ripper can read it.
BEGIN {
    username="^uid:.*$";
    password="^userPassword:.*$";
    cur_user = "nil";
    cur_pass = "nil";
    OFS=":";
}
{
    if ($0 ~ username) {
        if (cur_user == "nil") {
            cur_user = $2;
        } else {
            cur_user = "nil";
            cur_pass = "nil";
        }
    }
    if ($0 ~ password) {
        cmd = "echo "$2" | base64 --decode";
        cmd | getline cur_pass;
        close(cmd);
        print cur_user, cur_pass;
        cur_user = "nil";
        cur_pass = "nil";
    }
}
