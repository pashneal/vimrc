##############################################################
# Run this script to initialize the vim on UNIX like systems
############################################################

import subprocess
subprocess.call(["vim", "+PlugInstall"]) # Install plugins from repos
subprocess.call(["python3", "plugged/YouCompleteMe/install.py"]) # Install YCM with all flags (default)

