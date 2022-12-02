# -*- coding: utf-8 -*-
# @Author   : WenHan
import numpy as np
from models.net_q import QMyFuseModel
from sklearn.metrics import accuracy_score, f1_score, confusion_matrix
from tqdm import tqdm


if __name__ == '__main__':
    model = QMyFuseModel("../model_files/1d_cnn_q/")

    test_x = np.load("../test_data/test_x_3_q.npy")
    test_y = np.load("../test_data/test_y_3.npy")
    test_y_list_ = list()

    for i in tqdm(range(test_x.shape[0])):
        sample_x = test_x[i]
        sample_y_ = model.predict(sample_x)
        test_y_list_.append(sample_y_)
    test_y_ = np.concatenate(test_y_list_, axis=0)
    y_true = test_y
    y_pred = np.argmax(test_y_, axis=1)
    acc = accuracy_score(y_true, y_pred)
    f1 = f1_score(y_true, y_pred, average="macro")
    conf_mat = confusion_matrix(y_true, y_pred)
    print("--------------------------------------")
    print("acc = ", acc)
    print("f1-macro = ", f1)
    print("conf_mat: \n", conf_mat)

"""
acc =  0.9295443870361673
f1-macro =  0.9205189680871515
conf_mat: 
 [[391  45   2  12]
 [ 33 427   2   7]
 [ 14   4 785   5]
 [ 12   8   6 376]]
"""