#include <stdio.h>
#include <string.h>

int main(){
    char input[1000];
    printf("Array: ");
    fgets(input, sizeof(input), stdin);
    int n = 1;
    for (int i = 0; input[i] != '\0'; i++){
        if (input[i] == ',') {
            n ++;
        }
    }
    char *in = strtok(input, ",");
    int arr[n];
    for (int i = 0; i < n; i++){
        sscanf(in, "%d", &arr[i]);
        in = strtok(NULL, ",");
    }
    int min = arr[0];
    for (int i = 1; i < n; i++){
        if (arr[i] < min){
            min = arr[i];
        }
    }
    printf("Min element is: %d", min);

    return 0;
}