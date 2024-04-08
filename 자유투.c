/* 동국대학교 2019112110 이정민 */
//자유투(binary distribution, 성공할 확률은 0.4를 넘지 않음) uniform distribution 정규화 simulation
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double free_throw();

int main(){
    int n = 100;
    int success = 0;
    int failure = 0;
    float success_p, failure_p, success_e, failure_e, success_v, failure_v;

    srand(time(NULL));

    for(int i = 0; i < n; i++){
        if(free_throw() <= 0.4){
            success++;
        }
        else{
            failure++;
        }
    }
    success_p = (float)success / n;
    failure_p = (float)failure / n;
    success_e = (float) n * success_p;
    failure_e = (float) n * failure_p;
    success_v = (float) n * success_p * (1 - success_p);
    failure_v = (float) n * failure_p * (1 - failure_p);

    printf("probability of success: %f\nprobability of failure: %f\n", success_p, failure_p);
    printf("expectation of success: %f\nexpectation of failure: %f\n", success_e, failure_e);
    printf("variance of success: %f\nvariance of failure: %f\n", success_v, failure_v);

    return 0;
}

double free_throw(){
    return (float) rand() / RAND_MAX;
}