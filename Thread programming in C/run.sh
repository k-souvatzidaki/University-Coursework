#!/bin/bash
gcc -Wall -pthread tickets.h tickets.c && ./a.out 100 1000
