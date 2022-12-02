//
// Created by wenhan on 2022/5/16.
//

#include "Transforms.h"

void Transforms::diff(const float *inputs, float *outputs, int inputSize) {
    for (int i = 1; i < inputSize; ++i) {
        outputs[i-1] = inputs[i] - inputs[i-1];
    }
}

void Transforms::rect(const float *inputs, float *outputs, int inputSize) {
    for (int i = 0; i < inputSize; ++i) {
        outputs[i] = (inputs[i] < 0)?-inputs[i]:inputs[i];
    }
}

void Transforms::inte(const float *inputs, float *outputs, int inputSize, int width, float *thr) {
    float tempThr = 0.0f;
    for (int i = 0; i < inputSize; ++i) {
        int startIdx = (i < width)?0:(i-width);
        int endIdx = startIdx + width;
        float s = 0.0f;
        for (int j = startIdx; j < endIdx; ++j) {
            s += inputs[j];
        }
        outputs[i] = s;
        tempThr = (tempThr < 0.375f*s)?(0.375f*s):tempThr;
    }
    *thr = tempThr;
}

void Transforms::pulse(const float *inputs, int *outputs, int inputSize, float thr) {
    for (int i = 0; i < inputSize; ++i) {
        outputs[i] = (inputs[i] >= thr)?1:0;
    }
}

int Transforms::count_pulse(const int *inputs, int inputSize, int *firstPos, int *lastPos) {
    int preState = 0;
    int distCnt = 60;
    int cnt = 0;
    for (int i = 0; i < inputSize; ++i) {
        if (preState == 0 && inputs[i] == 1){
            if (distCnt >= 60){
                if (cnt == 0){
                    *firstPos = i;
                }
                cnt++;
                *lastPos = i;
                distCnt = 0;
            }
        }
        distCnt++;
        preState = inputs[i];
    }
    return cnt;
}
