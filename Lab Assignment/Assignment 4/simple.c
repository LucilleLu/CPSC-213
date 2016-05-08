//
//  simple.c
//  simple
//
//  Created by 陆修远 on 16/2/1.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.

#include <stdlib.h>
#include <stdio.h>
void foo (char* s) {
    printf ("%s World\n", s);
}
int main (int argc, char** argv) {
    foo ("Hello");
}