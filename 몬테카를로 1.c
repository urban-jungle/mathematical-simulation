/* 동국대학교 2019112110 이정민 */
#include <stdio.h>
#include <stdlib.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <time.h>

int main() {
    srand(time(NULL));

    double d = 10; // 평행선 간격
    double L = 200; // 바늘의 길이
    int n = 100000; // 시행 횟수
    int crossings = 0; // 바늘이 선과 교차하는 횟수
    double math_result = 0;

    for (int i = 0; i < n; i++) {
        // 랜덤으로 초기 위치와 각도 설정
        double length = (double)rand() / RAND_MAX * d/2; //초기 좌표(0~1)
        double theta = (double)rand() / RAND_MAX * M_PI; //초기 위치에 대한 랜덤한 각도(0~pi)

        // 바늘이 선과 교차하는지 확인
        if((L/2) * sin(theta) >= length){
            crossings++;
        }
    }
    math_result = (2*L) / (d*M_PI);

    // 확률 계산
    double p = (double)crossings / n;

    printf("실행 횟수: %d\n", n);
    printf("교차 횟수: %d\n", crossings);
    printf("실제 확률: %lf\n", p);
    printf("수학적 확률값: %lf\n", math_result);

    return 0;
}