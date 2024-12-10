#define SIZE 10

#include <stdio.h>

int main(int argc, char **argv)
{
    float elements[SIZE] = {7, 2, 5, 11, 4, 6, 1, 1, 8, 3};
    float sum = 0.0;
    for (int i = 0; i < SIZE; i++)
        sum += elements[i];
    float avg = sum / SIZE;
    printf("Average is %.2f", avg);
    return 0;
}
