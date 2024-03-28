#!/usr/bin/env python3

import sys
import subprocess

def switch_ws(workspace):
    subprocess.run(['hyprctl', 'dispatch', 'workspace', workspace])
    subprocess.run(['eww', 'update', f'active-ws={workspace}'])

if sys.argv[1] == '-s':
    switch_ws(sys.argv[2])
