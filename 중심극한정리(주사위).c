/* 동국대학교 2019112110 이정민 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 주사위 굴리기 함수
int roll_dice() {
    return (rand() % 6) + 1;
}

// 샘플링 함수: 주사위를 n번 굴려 평균을 계산
double sample_average(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += roll_dice();
    }
    return (double)sum / n;
}

int main() {
    int num_trials = 10000;  // 시뮬레이션 횟수
    int sample_size = 30;    // 샘플 크기

    srand(time(NULL));  // 난수 생성기 초기화

    // 결과를 저장할 배열
    double averages[num_trials];

    // 시뮬레이션 실행
    for (int i = 0; i < num_trials; i++) {
        averages[i] = sample_average(sample_size);
    }

    // 결과 출력 (예시로 처음 10개만 출력)
    printf("Sample averages (first 10):\n");
    for (int i = 0; i < 10; i++) {
        printf("%.2f ", averages[i]);
    }

    return 0;
}