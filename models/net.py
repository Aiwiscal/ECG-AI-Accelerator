# -*- coding: utf-8 -*-
# @Author   : WenHan
from tensorflow import keras


# The architecture of the proposed 1-D CNN.

def build_net(input_shape, n_feature_maps, nb_classes):
    inputs = keras.layers.Input(shape=input_shape)
    x = keras.layers.Conv1D(filters=n_feature_maps, kernel_size=5, strides=1, padding='same', use_bias=False)(inputs)
    x = keras.layers.ReLU()(x)
    x = keras.layers.MaxPooling1D(pool_size=5, strides=5)(x)

    x = keras.layers.Conv1D(filters=n_feature_maps * 2, kernel_size=5, strides=1, padding='same', use_bias=False)(x)
    x = keras.layers.ReLU()(x)
    x = keras.layers.MaxPooling1D(pool_size=5, strides=5)(x)

    x = keras.layers.Conv1D(filters=n_feature_maps * 2, kernel_size=5, strides=1, padding='same', use_bias=False)(x)
    x = keras.layers.ReLU()(x)
    x = keras.layers.MaxPooling1D(pool_size=5, strides=5)(x)

    x = keras.layers.Conv1D(filters=n_feature_maps * 4, kernel_size=5, strides=1, padding='same', use_bias=False)(x)
    x = keras.layers.ReLU()(x)
    x = keras.layers.MaxPooling1D(pool_size=5, strides=5)(x)

    feature = keras.layers.Flatten()(x)
    outputs = keras.layers.Dense(nb_classes, activation='softmax')(feature)

    return inputs, outputs, feature


if __name__ == '__main__':
    my_inputs, my_outputs, _ = build_net([2500, 1], 4, 4)
    model = keras.models.Model(inputs=my_inputs, outputs=my_outputs)
    model.summary()
