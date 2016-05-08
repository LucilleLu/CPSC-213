//
//  main.c
//  p1
//
//  Created by Xiuyuan Lu on 16/2/9.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct c{
    struct d* d1;
    struct d* d2;
};

struct d{
    int a;
    int b;
};


int main(int argc, const char * argv[]) {
    struct c* s = (struct c*) malloc(sizeof (struct c));
    struct c d0 = *s;
    struct d* d1 = malloc(sizeof (struct d));
    struct d* d2 = malloc(sizeof (struct d));
    d0.d1 = d1;
    d0.d2 = d2;
    d1 -> a = 1;
    d1 -> b = 2;
    d2 -> a = 3;
    d2 -> b = 4;
    d2 -> a = d1 -> b;
    d1 -> a = d2 -> b;
    printf ("%d\n",d1->a);
    printf ("%d\n",d1->b);
    printf ("%d\n",d2->a);
    printf ("%d\n",d2->b);
}
