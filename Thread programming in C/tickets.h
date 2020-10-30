#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>

#define Ntel 8
#define Ncash 4
#define Nseat 10
#define NzoneA 5
#define NzoneB 10
#define NzoneC 10
#define PzoneA 0.2
#define PzoneB 0.4
#define PzoneC 0.4
#define CzoneA 30
#define CzoneB 25
#define CzoneC 20
#define Nseatlow 1
#define Nseathigh 5
#define tseatlow 5
#define tseathigh 10
#define tcashlow 2
#define tcashhigh 4
#define Pcardsucces 0.9

void * customer(void* tid);

int prob(double px,double py,double pz);

