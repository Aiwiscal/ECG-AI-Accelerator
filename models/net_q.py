# -*- coding: utf-8 -*-
# @Author   : WenHan
import numpy as np
import models.layers as layers


def rescale_data_2d(data, shift_bits, upper_bound):
    data_rescale = np.zeros_like(data)
    for i in range(data.shape[0]):
        for j in range(data.shape[1]):
            data_rescale[i, j] = (int(data[i, j]) >> shift_bits)
            if data_rescale[i, j] > upper_bound:
                data_rescale[i, j] = upper_bound
            elif data_rescale[i, j] < -upper_bound:
                data_rescale[i, j] = -upper_bound
            else:
                pass
    return data_rescale


class QMyFuseModel(object):
    def __init__(self, params_path):
        self.conv0_kernels = np.load(params_path + "conv1d_kernel_0_q.npy")
        self.conv0_bias = np.zeros(self.conv0_kernels.shape[-1])

        self.conv1_kernels = np.load(params_path + "conv1d_1_kernel_0_q.npy")
        self.conv1_bias = np.zeros(self.conv1_kernels.shape[-1])

        self.conv2_kernels = np.load(params_path + "conv1d_2_kernel_0_q.npy")
        self.conv2_bias = np.zeros(self.conv2_kernels.shape[-1])

        self.conv3_kernels = np.load(params_path + "conv1d_3_kernel_0_q.npy")
        self.conv3_bias = np.zeros(self.conv3_kernels.shape[-1])

        self.dense_weights = np.load(params_path + "dense_kernel_0_q.npy")
        self.dense_bias = np.load(params_path + "dense_bias_0_q.npy")

        self.conv0_outputs = None
        self.relu0_outputs = None
        self.mp0_outputs = None

        self.conv1_outputs = None
        self.relu1_outputs = None
        self.mp1_outputs = None

        self.conv2_outputs = None
        self.relu2_outputs = None
        self.mp2_outputs = None

        self.conv3_outputs = None
        self.relu3_outputs = None
        self.mp3_outputs = None

        self.flat_outputs = None
        self.dense_outputs = None

    def predict(self, data):
        self.conv0_outputs = layers.conv_1d(data, self.conv0_kernels, self.conv0_bias, 1, 2)
        self.conv0_outputs = rescale_data_2d(self.conv0_outputs, 8, 127)
        self.relu0_outputs = layers.relu(self.conv0_outputs)
        self.mp0_outputs = layers.max_pool(self.relu0_outputs, 5, 5)

        self.conv1_outputs = layers.conv_1d(self.mp0_outputs, self.conv1_kernels, self.conv1_bias, 1, 2)
        self.conv1_outputs = rescale_data_2d(self.conv1_outputs, 7, 127)
        self.relu1_outputs = layers.relu(self.conv1_outputs)
        self.mp1_outputs = layers.max_pool(self.relu1_outputs, 5, 5)

        self.conv2_outputs = layers.conv_1d(self.mp1_outputs, self.conv2_kernels, self.conv2_bias, 1, 2)
        self.conv2_outputs = rescale_data_2d(self.conv2_outputs, 7, 127)
        self.relu2_outputs = layers.relu(self.conv2_outputs)
        self.mp2_outputs = layers.max_pool(self.relu2_outputs, 5, 5)

        self.conv3_outputs = layers.conv_1d(self.mp2_outputs, self.conv3_kernels, self.conv3_bias, 1, 2)
        self.conv3_outputs = rescale_data_2d(self.conv3_outputs, 7, 127)
        self.relu3_outputs = layers.relu(self.conv3_outputs)
        self.mp3_outputs = layers.max_pool(self.relu3_outputs, 5, 5)

        self.flat_outputs = layers.flatten(self.mp3_outputs)
        self.dense_outputs = layers.dense(self.flat_outputs, self.dense_weights, self.dense_bias)

        return np.expand_dims(self.dense_outputs, axis=0)
