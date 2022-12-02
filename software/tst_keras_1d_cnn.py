# -*- coding: utf-8 -*-
# @Author   : WenHan

import numpy as np
from tensorflow import keras
from sklearn.metrics import accuracy_score, f1_score, confusion_matrix
import time

if __name__ == '__main__':
    test_x = np.load("../test_data/test_x_3.npy")
    test_y = np.load("../test_data/test_y_3.npy")

    model = keras.models.load_model("../model_files/1d_cnn.h5")
    model.summary()
    tic = time.time()
    test_y_ = model.predict(test_x, batch_size=1)
    toc = time.time()
    print("average time: ", (toc-tic) / test_x.shape[0])
    y = test_y
    y_ = np.argmax(test_y_, axis=1)
    conf_mat = confusion_matrix(y, y_)
    acc = accuracy_score(y, y_)
    f1 = f1_score(y, y_, average="macro")
    print("\n acc: ", acc)
    print("f1 macro: ", f1)
    print("confusion matrix: \n", conf_mat)

"""
acc:  0.9323626115547206
f1 macro:  0.9227968544114553
confusion matrix: 
 [[368  68   3  11]
 [ 16 446   2   5]
 [  9   4 792   3]
 [  8   9   6 379]]
 
"""