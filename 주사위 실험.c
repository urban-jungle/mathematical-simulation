/* 동국대학교 2019112110 이정민 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    int diceRolls[7] = {0}; // 배열 인덱스 1-6까지 각 숫자가 나온 횟수를 저장
    int roll;
    srand(time(NULL)); // 난수 생성기 초기화

    for (int i = 0; i < 6000; i++) {
        roll = rand() % 6 + 1; // 1과 6 사이의 난수 생성
        diceRolls[roll]++;
    }

    // 결과 출력
    for (int i = 1; i <= 6; i++) {
        printf("%d: %d\n", i, diceRolls[i]);
    }

    return 0;
}