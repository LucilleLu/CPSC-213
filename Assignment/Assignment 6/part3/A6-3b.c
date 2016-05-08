//
//  main.c
//  A6-3b
//
//  Created by 陆修远 on 16/3/8.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.
//

#include <stdio.h>

int x[8] = {1, 2, 3, -1, -2, 0, 184, 340057058};
int y[8] = {0, 0, 0, 0, 0, 0, 0, 0};

int foo (int b) {
    int d = 0;
    while (b != 0) {
        int c = b & 0x80000000;
        if (c != 0){
            d++;
        }
        b = b * 2;
    }
    return d;
}


int main() {
    int i = 8;
    while (i != 0) {
        i--;
        int a = x[i];
        y[i] = foo(a);
    }
    for (int i = 0; i < 8; i++)
        printf("%d\n", x[i]);
    for (int i = 0; i < 8; i++)
        printf("%d\n", y[i]);
}
