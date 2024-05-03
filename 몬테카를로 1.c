/* �������б� 2019112110 ������ */
#include <stdio.h>
#include <stdlib.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <time.h>

int main() {
    srand(time(NULL));

    double d = 10; // ���༱ ����
    double L = 200; // �ٴ��� ����
    int n = 100000; // ���� Ƚ��
    int crossings = 0; // �ٴ��� ���� �����ϴ� Ƚ��
    double math_result = 0;

    for (int i = 0; i < n; i++) {
        // �������� �ʱ� ��ġ�� ���� ����
        double length = (double)rand() / RAND_MAX * d/2; //�ʱ� ��ǥ(0~1)
        double theta = (double)rand() / RAND_MAX * M_PI; //�ʱ� ��ġ�� ���� ������ ����(0~pi)

        // �ٴ��� ���� �����ϴ��� Ȯ��
        if((L/2) * sin(theta) >= length){
            crossings++;
        }
    }
    math_result = (2*L) / (d*M_PI);

    // Ȯ�� ���
    double p = (double)crossings / n;

    printf("���� Ƚ��: %d\n", n);
    printf("���� Ƚ��: %d\n", crossings);
    printf("���� Ȯ��: %lf\n", p);
    printf("������ Ȯ����: %lf\n", math_result);

    return 0;
}