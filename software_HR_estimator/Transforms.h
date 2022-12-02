//
// Created by wenhan on 2022/5/16.
//

#ifndef HRESTIMATOR_TRANSFORMS_H
#define HRESTIMATOR_TRANSFORMS_H


class Transforms {
public:
    static void diff(const float *inputs, float *outputs, int inputSize);

    static void rect(const float *inputs, float *outputs, int inputSize);

    static void inte(const float *inputs, float *outputs, int inputSize, int width, float *thr);

    static void pulse(const float *inputs, int *outputs, int inputSize, float thr);

    static int count_pulse(const int *inputs, int inputSize, int *firstPos, int *lastPos);


};


#endif //HRESTIMATOR_TRANSFORMS_H
