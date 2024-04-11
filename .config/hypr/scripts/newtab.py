#!/usr/bin/env python

import subprocess
import json

output = subprocess.check_output(['hyprctl', 'activewindow', '-j'])
activewindow = json.loads(output)

if activewindow['class'] == 'firefox':
    subprocess.run(['firefox', '~/MiniYAGS/index.html'])
