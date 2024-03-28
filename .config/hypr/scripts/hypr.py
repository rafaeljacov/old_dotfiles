#!/usr/bin/env python3
import os
import sys
import socket
import subprocess

# Script for getting active workspace/window

WORKSPACES = 6
HYPR_INSTANCE = os.getenv('HYPRLAND_INSTANCE_SIGNATURE')
SOCKET_PATH = f'/tmp/hypr/{HYPR_INSTANCE}/.socket2.sock'

def get_window_title():
    pass

def get_active_workspace(line):
    if line.find('workspace>>') == 0:
        active_ws = line[-1]
        print(active_ws)
        # Limit workspace
        if int(active_ws) > WORKSPACES:
            active_ws = WORKSPACES
            subprocess.run(['hyprctl', 'dispatch', 'workspace', str(WORKSPACES)])
        subprocess.run(['eww', 'update', f'active-ws={active_ws}'])

with socket.socket(socket.AF_UNIX) as client_socket:
        # Connect to the Unix domain socket
        client_socket.connect(SOCKET_PATH)

        # Receive data from the socket
        while True:
            data = client_socket.recv(1024)  # Adjust the buffer size as needed
            decoded_data = data.decode().strip().split('\n')  # Convert bytes to string and remove leading/trailing whitespace
            for line in decoded_data:
                if sys.argv[1] == '-a':
                    get_active_workspace(line)
