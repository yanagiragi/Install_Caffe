import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import caffe

caffe.set_mode_cpu()
net = caffe.Net('conv.prototxt', caffe.TEST)

print net.blobs['conv'].data.shape

im = np.array(Image.open('examples/images/cat_gray.jpg'))
im_input = im[np.newaxis, np.newaxis, :, :]
net.blobs['data'].reshape(*im_input.shape)
net.blobs['data'].data[...] = im_input

net.forward()

net.save('mymodel.caffemodel')
