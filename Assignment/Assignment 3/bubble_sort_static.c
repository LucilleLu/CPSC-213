//
//  main.c
//  bubble_sort_static
//
//  Created by 陆修远 on 16/1/26.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>

int val[4];

void sort (int n) {
    int t;
    for (int i=n-1; i>0; i--)
        for (int j=i-1; j>=0; j--)
            if (val[i] < val[j]) {
                t = val[i];
                val[i] = val[j];
                val[j] = t;
            }
}

int main (int argc, char** argv) {
    char* ep;
    int   n;
    n = argc - 1;
    if (n > 4) {
        fprintf (stderr, "Static limit of 4 numbers\n");
        return -1;
    }
    for (int i=0; i<n; i++) {
        val[i] = (int)strtol (argv[i+1], &ep, 10);
        if (*ep) {
            fprintf (stderr, "Argument %d is not a number\n", i);
            return -1;
        }
    }
    sort (n);
    for (int i=0; i<n; i++)
        printf ("%d\n", val[i]);
}