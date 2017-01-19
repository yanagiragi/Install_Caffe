# Note : this note is for CPU_ONLY, so no entries about install cuda and cuDNN

# update remote list
sudo apt-get update

# For Ubuntu
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev

# install ATLAS 
sudo apt-get install libatlas-base-dev

# Ubuntu 14.04 dependencies
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev

git clone https://github.com/BVLC/caffe.git
cd caffe

cp Makefile.config.example Makefile.config

# Open Makefile.config
# cancel omit of CPU_ONLY := 1
# modify INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial/

mkdir build # if not exists
cd build
cmake -D CPU_ONLY=ON ..
cd ../

sudo make clean
sudo make all -j2
sudo make test
sudo make runtest # check if you see "PASSED!" 

# if compile errors with hdf5.h : No such file or Directory
sudo apt-get install libhdf5-dev

# if last step still don't works
cd /usr/lib/x86_64-linux-gnu/
sudo ln -s libhdf5_serial.so.8.0.2 libhdf5.so
sudo ln -s libhdf5_serial_hl.so.8.0.2 libhdf5_hl.so
cd -

# For Python
sudo apt-get install python2.7 # I use python2.7
sudo make pycaffe
cd python/
for req in $(cat requirements.txt); do pip install $req; done

# if "No module named skimage.io" error appears when import caffe in python
pip install -U scikit-image

# check if it works
# python
# >>> import caffe
# >>> print caffe.__version__