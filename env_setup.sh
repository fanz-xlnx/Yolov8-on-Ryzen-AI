#echo "Install all the python dependencies using pip"
#pip install --trusted-host xcdpython.xilinx.com -r requirements_ptq.txt
#cd code/
#python setup.py develop

apt-get install software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get install gcc-4.9
apt-get upgrade libstdc++6
pip install ultralytics pycocotools
