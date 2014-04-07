#!/usr/bin/env python

import os
import sys

from supervisor import childutils

def main():
    while 1:
        headers, payload = childutils.listener.wait()
        if headers['eventname'].startswith('PROCESS_STATE_RUNNING'):
            pheaders, pdata = childutils.eventdata(payload+'\n')
            if pheaders['processname'] == "postgresql":
                os.system("sh /root/postgres-configure.sh")
                break

        childutils.listener.ok()

if __name__ == '__main__':
    main()
