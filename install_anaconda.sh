# ANNACONDA
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc
conda update --all

conda update -n base -c defaults conda

echo "Please restart your terminal to complete the installation"

