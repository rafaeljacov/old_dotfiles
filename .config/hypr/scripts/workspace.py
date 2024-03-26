#!/usr/bin/env python3

import sys
import subprocess

def switch_ws(workspace):
    # To be implemented
    if workspace[0] == 'r':
        if workspace[1] == '+':
            pass
        elif workspace[1] == '-':
            pass

    subprocess.run(['hyprctl', 'dispatch', 'workspace', workspace])
    subprocess.run(['eww', 'update', f'active-ws={workspace}'])

def moveto_ws(workspace):
    subprocess.run(['hyprctl', 'dispatch', 'movetoworkspace', workspace])
    subprocess.run(['eww', 'update', f'active-ws={workspace}'])


if sys.argv[1] == '-s':
    switch_ws(sys.argv[2])
elif sys.argv[1] == '-m':
    moveto_ws(sys.argv[2])
