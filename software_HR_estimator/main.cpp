#include <iostream>
#include <ctime>
#include "Transforms.h"
#include "sample.h"
float *diffOut = new float [sampleLength-1];
float *rectOut = new float [sampleLength-1];
float *inteOut = new float [sampleLength-1];
int *pulseOut = new int [sampleLength-1];
void clearUp();
int main() {
    clock_t startTime, endTime;
    int cnt = 0;
    int hr = 0;
    clock_t totalTime = 0;
    for (int j = 0; j < 10; ++j){
        for (int i = 0; i < 2; ++i) {
            startTime = clock();
            Transforms::diff(sample, diffOut, sampleLength);
            Transforms::rect(diffOut, rectOut, sampleLength-1);
            float thr = 0.0f;
            Transforms::inte(rectOut, inteOut, sampleLength-1, 16, &thr);
            Transforms::pulse(inteOut, pulseOut, sampleLength-1, thr);
            int firstPos = 0;
            int lastPos = 0;
            cnt = Transforms::count_pulse(pulseOut, sampleLength - 1, &firstPos, &lastPos);
            hr = 60*250*(cnt-1)/(lastPos-firstPos);
            endTime = clock();
        }
        totalTime += (endTime-startTime);
    }

    std::cout << "beat count: " << cnt << " ~ heart rate: " << hr << std::endl;
    std::cout << "average time: " << (((double)(totalTime)) / CLOCKS_PER_SEC) * 100 << " ms." << std::endl;
    clearUp();
    return 0;
}

void clearUp(){
    delete [] diffOut;
    delete [] rectOut;
    delete [] inteOut;
    delete [] pulseOut;
}
