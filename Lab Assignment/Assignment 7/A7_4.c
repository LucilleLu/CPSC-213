//
//  main.c
//  A7_4
//
//  Created by 陆修远 on 16/3/18.
//  Copyright © 2016年 Xiuyuan Lu. All rights reserved.
//

#include <stdio.h>

int a;
int b;
int c;
int result;

int foo(int a, int b, int c){
    switch (a) {
        case 10:
            c = c + b;
            break;
        case 12:
            c = b - c;
            break;
        case 14:
            if (b > c){
                c = 1;
            } else {
                c = 0;
            };
            break;
        case 16:
            if (c > b){
                c = 1;
            } else {
                c = 0;
            };
            break;
        case 18:
            if (c == b){
                c = 1;
            } else {
                c = 0;
            };
            break;
            
        default:
            c = 0;
            break;
    }
    return c;
}

int main(int argc, const char * argv[]) {
    result = foo(a, b, c);
}
