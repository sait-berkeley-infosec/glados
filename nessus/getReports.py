#!/usr/local/bin/python
"""
Import ajaska's Nessus API and use it to grab reports from
our Nessus instance and then store them in a reasonable fashion.

USAGE:
    NESSUS_HOST=hostname NESSUS_USER=username NESSUS_PW=password \
            python getReports.py
"""
from nessusapi.session import * # Import the whole API.
import os # Needed for environment variables

if __name__ == '__main__':
    # Get all the environment variables
    nessus_host = os.getenv('NESSUS_HOST')
    nessus_user = os.getenv('NESSUS_USER')
    nessus_pw = os.getenv('NESSUS_PW')
    nessus_port = os.getenv('NESSUS_PORT', '8834')

    # Create the session
    session = Session(nessus_user, nessus_pw, nessus_host, nessus_port)

    """
    Get a list of every report available to us. Out of a certain timespan,
    go ahead and check which reports available are currently cached on the
    host. If they are not, then we should download and organize them.
    If a cached report is out of the timespan, then we should remove it from the host.
    """

    # Finally, close out of the session.
    session.close
