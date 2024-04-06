/* 동국대학교 2019112110 이정민 */
#include <stdio.h>
#include <math.h>

double normalCDF(double x, double mean, double stddev) {
    return 0.5 * (1 + erf((x - mean) / (stddev * sqrt(2))));
}

int main() {
    // B(100, 0.4)의 근사 정규분포의 평균과 표준편차
    double mean = 100 * 0.4;
    double stddev = sqrt(100 * 0.4 * 0.6);

    // 50 이상 성공할 확률 계산
    double probability = 1 - normalCDF(50.5, mean, stddev);

    printf("실제 확률: %f\n", probability);

    return 0;
}