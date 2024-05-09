# ANNACONDA
#wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
#export PATH=~/anaconda3/bin:$PATH
#conda init
#source ~/.bashrc
#conda update --all
#
#conda update -n base -c defaults conda
#
#echo "Please restart your terminal to complete the installation"

# MINICONDA
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod 700 Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b

echo "export PATH=~/miniconda3/bin:$PATH" >> ~/.bashrc

echo "Please restart your terminal to complete the installation"
