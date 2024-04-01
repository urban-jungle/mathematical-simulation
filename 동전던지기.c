/* 동국대학교 2019112110 이정민 */
//동전던지기(binary distribution)의 정규화 simulation
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int flap();

int main(){
    int head = 0;
    int tale = 0;
    int n = 10000;
    float head_p = 0;
    float tale_p = 0; //probability
    float head_e = 0; 
    float tale_e = 0; //expectation
    float head_v = 0; 
    float tale_v = 0; //variance
    srand(time(NULL));
    
    for(int i = 0; i<n; i++){
        if(flap())
        { //if flap() = 1
            head++;
        }
        else
        {
            tale++;
        }
    }
    head_p = (float)head/n;
    tale_p = (float)tale/n;
    head_e = (float) n * head_p;
    tale_e = (float) n * tale_p;
    head_v = (float) n * head_p * (1 - head_p);
    tale_v = (float) n * tale_p * (1 - tale_p);

    
    printf("head: %d\ntale: %d\n", head, tale);
    printf("probability of head: %f\nprobability of tale: %f\n", head_p, tale_p);
    printf("expectation of head: %f\nexpectation of tale: %f\n", head_e, tale_e);
    printf("variance of head: %f\nvariance of tale: %f\n", head_v, tale_v);

    return 0;
}

int flap(){
    return rand() % 2; //0,1 난수 생성
}