# -*- coding: utf-8 -*-
# @Author   : WenHan
import numpy as np


def conv_1d(data, filters, bias, stride, pad):
    input_size = data.shape[0]
    input_channels = data.shape[-1]
    filter_length = filters.shape[0]
    output_channels = filters.shape[-1]
    output_size = round((input_size - filter_length + 2 * pad) / stride + 1)
    outputs = np.zeros([output_size, output_channels])
    for i in range(output_channels):
        ker = filters[:, :, i]
        b = bias[i]
        for j in range(output_size):
            tmp = b
            for k in range(input_channels):
                for m in range(filter_length):
                    h = j * stride + m - pad
                    if 0 <= h < input_size:
                        tmp += data[:, k][h] * ker[:, k][m]
            outputs[j, i] = tmp
    return outputs


def bn(data, alpha, eta):
    outputs = np.zeros_like(data)
    for i in range(data.shape[1]):
        outputs[:, i] = alpha[i] * data[:, i] + eta[i]
    return outputs


def max_pool(data, pool_size, stride):
    input_size = data.shape[0]
    channels = data.shape[-1]
    output_size = input_size // stride
    outputs = np.zeros([output_size, channels])
    for i in range(channels):
        for j in range(output_size):
            k = stride * j
            outputs[j, i] = np.max(data[k:(k+pool_size), i])
    return outputs


def flatten(data):
    return data.flatten(order="C")


def relu(data):
    return (data > 0).astype(np.int) * data


def relu_q1(data):
    return (data > -17).astype(np.int) * data


def gap(data):
    return np.mean(data, axis=0)


def gap_q(data):
    return np.sum(data, axis=0)


def dense(data, weights, bias):
    return np.matmul(data, weights) + bias
