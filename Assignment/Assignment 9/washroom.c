#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#ifdef VERBOSE
#define VERBOSE_PRINT(S, ...) printf (S, ##__VA_ARGS__);
#else
#define VERBOSE_PRINT(S, ...) ;
#endif

#define MAX_OCCUPANCY      3
#define NUM_ITERATIONS     100
#define NUM_PEOPLE         20
#define FAIR_WAITING_COUNT 4

/**
 * You might find these declarations useful.
 */
enum Sex {MALE = 0, FEMALE = 1};
const static enum Sex otherSex [] = {FEMALE, MALE};

struct Washroom {
    // TODO
    int insideNum;
    int malesInsideNum;
    int femalesInsideNum;
    int sex;
    int waiting[2];
    uthread_mutex_t mx;
    uthread_cond_t femaleQ;
    uthread_cond_t maleQ;
};

struct Washroom* createWashroom() {
    struct Washroom* washroom = malloc (sizeof (struct Washroom));
    // TODO
    washroom->insideNum = 0;
    washroom->malesInsideNum = 0;
    washroom->femalesInsideNum = 0;
    washroom->sex = 0;
    washroom->waiting[0] = 0;
    washroom->waiting[1] = 0;
    washroom->mx = uthread_mutex_create();
    washroom->femaleQ = uthread_cond_create(washroom->mx);
    washroom->maleQ = uthread_cond_create(washroom->mx);
    return washroom;
}

#define WAITING_HISTOGRAM_SIZE (NUM_ITERATIONS * NUM_PEOPLE)
int             entryTicker;  // incremented with each entry
int             waitingHistogram         [WAITING_HISTOGRAM_SIZE];
int             waitingHistogramOverflow;
uthread_mutex_t waitingHistogrammutex;
int             occupancyHistogram       [2] [MAX_OCCUPANCY + 1];

void recordWaitingTime (int waitingTime) {
    uthread_mutex_lock (waitingHistogrammutex);
    if (waitingTime < WAITING_HISTOGRAM_SIZE)
        waitingHistogram [waitingTime] ++;
    else
        waitingHistogramOverflow ++;
    uthread_mutex_unlock (waitingHistogrammutex);
}

void enterWashroom (struct Washroom* washroom, enum Sex Sex) {
    // TODO
    uthread_mutex_lock (washroom->mx);
    int waitingTime = entryTicker;
    while (washroom->sex != Sex || washroom->insideNum == MAX_OCCUPANCY) {
        if (Sex == 0) {
            washroom->waiting[0]++;
            uthread_cond_wait (washroom->maleQ);
        } else {
            washroom->waiting[1]++;
            uthread_cond_wait (washroom->femaleQ);
        }
    }
    
    washroom->insideNum++;
    if (washroom->waiting[Sex] != 0) {
        washroom->waiting[Sex]--;
    }
    occupancyHistogram[washroom->sex][washroom->insideNum]++;
    entryTicker++;
    recordWaitingTime(entryTicker - waitingTime);
    uthread_mutex_unlock (washroom->mx);
}

void leaveWashroom (struct Washroom* washroom) {
    // TODO
    uthread_mutex_lock(washroom->mx);
    
    washroom->insideNum--;
    
    if (washroom->insideNum == 0 && washroom->waiting[otherSex[washroom->sex]] > 0) {
        //washroom is empty and other gender is waiting
        
        washroom->sex = otherSex[washroom->sex];
        
        if (washroom->sex == 0) {
            for (int i = 0; i < MAX_OCCUPANCY; i++) {
                uthread_cond_signal (washroom->maleQ);
            }
        } else {
            for (int i = 0; i < MAX_OCCUPANCY; i++) {
                uthread_cond_signal (washroom->femaleQ);
            }
        }
    } else {
        if (washroom->sex == 0) {
            uthread_cond_signal (washroom->maleQ);
        } else {
            uthread_cond_signal (washroom->femaleQ);
        }
    }
//    if (washroom->insideNum == 0 && washroom->waiting[otherSex[washroom->sex]] > 0) {
//        washroom->sex = otherSex[washroom->sex];
//    }
//    
//    if (washroom->sex == 0) {
//        for (int i = 0; i < MAX_OCCUPANCY; i++) {
//            uthread_cond_signal (washroom->maleQ);
//        }
//    } else {
//        for (int i = 0; i < MAX_OCCUPANCY; i++) {
//            uthread_cond_signal (washroom->femaleQ);
//        }
//    }
    uthread_mutex_unlock(washroom->mx);
}



//
// TODO
// You will probably need to create some additional produres etc.
//

void* person (void* w) {
    struct Washroom* washroom = (struct Washroom*) w;
    
    enum Sex sex = otherSex[random() % 2];
    
    for (int i = 0; i < NUM_ITERATIONS; i++) {
        if (sex == 1) {
            enterWashroom(washroom, 1);
        } else {
            enterWashroom(washroom, 0);
        }
        
        for (int j = 0; j < NUM_PEOPLE; j++) {
            uthread_yield();
        }
        
        leaveWashroom(washroom);
        
        for (int z = 0; z < NUM_PEOPLE; z++) {
            uthread_yield();
        }
    }
    return NULL;
}


int main (int argc, char** argv) {
    uthread_init (1);
    struct Washroom* washroom = createWashroom();
    uthread_t        pt [NUM_PEOPLE];
    waitingHistogrammutex = uthread_mutex_create ();
    
    // TODO
    
    for (int i=0; i< NUM_PEOPLE; i++) {
        pt[i] = uthread_create(person, washroom);
    }
    
    for (int i = 0; i < NUM_PEOPLE; i++) {
        uthread_join(pt[i],0);
    }
    
    printf ("Times with 1 male    %d\n", occupancyHistogram [MALE]   [1]);
    printf ("Times with 2 males   %d\n", occupancyHistogram [MALE]   [2]);
    printf ("Times with 3 males   %d\n", occupancyHistogram [MALE]   [3]);
    printf ("Times with 1 female  %d\n", occupancyHistogram [FEMALE] [1]);
    printf ("Times with 2 females %d\n", occupancyHistogram [FEMALE] [2]);
    printf ("Times with 3 females %d\n", occupancyHistogram [FEMALE] [3]);
    printf ("Waiting Histogram\n");
    for (int i=0; i<WAITING_HISTOGRAM_SIZE; i++)
        if (waitingHistogram [i])
            printf ("  Number of times people waited for %d %s to enter: %d\n", i, i==1?"person":"people", waitingHistogram [i]);
    if (waitingHistogramOverflow)
        printf ("  Number of times people waited more than %d entries: %d\n", WAITING_HISTOGRAM_SIZE, waitingHistogramOverflow);
}