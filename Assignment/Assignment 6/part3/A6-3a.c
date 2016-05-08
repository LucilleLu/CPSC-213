//
//  main.c
//  A6-3a
//
//  Created by 陆修远 on 16/3/8.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.
//

#include <stdio.h>

int z[10];
int* v = z;


void foo(int c, int d) {
    v[d] = v[d] + c;
}

int main() {
    int a = 1;
    int b = 2;
    foo(3, 4);
    foo(a, b);
    for (int i=0; i<10; i++){
        printf("%d\n",v[i]);
    }
}
