##############################################################
# Run this script to initialize the vim on UNIX like systems
############################################################
import subprocess
subprocess.call(["vim", "+PlugInstall"]) # Install plugins from repos
subprocess.call(["sudo", "apt-get", "install", "cmake"]) # Install cmake
subprocess.call(["sudo", "apt-get", "install", "fzf"]) # Install fuzzy finder
subprocess.call(["sudo", "apt-get", "install", "ripgrep"]) # Install ripgrep
subprocess.call(["python3", "plugged/YouCompleteMe/install.py"]) # Install YCM with all flags (default)

