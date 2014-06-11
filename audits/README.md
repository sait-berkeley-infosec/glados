Password Audits
===============

Couple of scripts designed to go through and crack passwords.

1. LDAP -> JTR translator (DONE!)
2. Cronjob examples
3. Testing script
4. Notifier

At a designated time, the cronjob runs the translator and then JTR on the resulting script. Cleans up after itself.

Sysadmin Side
=============

glados is set up using jailkit. The user 'audit' can connect through one-line commands. SCP works really well for this.
